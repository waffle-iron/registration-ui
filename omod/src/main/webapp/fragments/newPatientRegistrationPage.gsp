<script type="text/javascript">
    var MODEL;
    var emrMessages = {};
    emrMessages["requiredField"] = "Required";

    jq(document).ready(function () {
		jq("input[name='paym_1']:radio").change(function () {
			var index = jq(this, '#simple-form-ui').val();
			var arrey = MODEL.payingCategory.split("|");
			var alley = "";
			
			if (index == 1){
				jq('#tasktitle').text('Paying Category');
				
				jq('#paying').attr('checked', 'checked').change();
				jq('#nonPaying').attr('checked', false).change();
				jq('#specialSchemes').attr('checked', false).change();
				
				arrey = MODEL.payingCategory.split("|");
				
			}
			else if (index == 2){
				jq('#tasktitle').text('Nonpaying Category');
				
				jq('#paying').attr('checked', false).change();
				jq('#nonPaying').attr('checked', 'checked').change();
				jq('#specialSchemes').attr('checked', false).change();
				
				arrey = MODEL.nonPayingCategory.split("|");
			}
			else {
				jq('#tasktitle').text('Special Schemes');
				
				jq('#paying').attr('checked', false).change();
				jq('#nonPaying').attr('checked', false).change();
				jq('#specialSchemes').attr('checked', 'checked').change();
				
				arrey = MODEL.specialScheme.split("|");
			}
			
			for (var i = 0; i < arrey.length-1; i++) {
				alley += "<label class='tasks-list-item'><input style='display:none!important' type='radio' name='paym_2' id='paym_20"+(i+1)+"' value='"+(i+1)+"' class='tasks-list-cb'> <span class='tasks-list-mark'></span> <span class='tasks-list-desc' id='ipaym_1" + (i+1) + "'>" + arrey[i].substr(0, arrey[i].indexOf(',')) + "</span> </label>";
			}
			
			jq('#paycatgs').html(alley.replace("CHILD LESS THAN 5 YEARS", "CHILD UNDER 5YRS"));
			
			if (typeof jq('input[name=paym_2]:checked', '#patientRegistrationForm').val() == 'undefined'){
				jq("#modesummary").attr("readonly", false);
				jq("#modesummary").attr("name", 'modesummary');
				jq("#modesummary").val("N/A");
				
				jq('#universitydiv').hide();
				jq('#university option').eq(0).prop('selected', true);
				
				jq('#summtitle1').text('Details');
				jq('#modesummary').attr("placeholder", "Enter Value");
			}
		});


        jq("#rooms1").on("change", function(){
            var nonPayingCategorySelected = jq("#nonPayingCategory").val();
            if(nonPayingCategorySelected === "CCC PATIENT" || nonPayingCategorySelected === "TB PATIENT"){
                nonPayingCategorySelection();
            }
        });
		
		jq("#paycatgs").on("change", "input[name='paym_2']:radio", function () {
			var select1 = jq('input[name=paym_1]:checked', '#patientRegistrationForm').val();
			var select2 = jq('input[name=paym_2]:checked', '#patientRegistrationForm').val();
			var select3 = '';
			
			if (select1 == 1) {
				jq('#payingCategory option').eq(select2).prop('selected', true);				
				jq('#nonPayingCategory option').eq(0).prop('selected', true);
				jq('#specialScheme option').eq(0).prop('selected', true);

				select3 = jq('#payingCategory :selected').val().toUpperCase();
				
				jq('#summ_pays').text('Paying / ' + jq('#payingCategory option:selected').text());
                payingCategorySelection();
			}
			else if (select1 == 2) {
				jq('#nonPayingCategory option').eq(select2).prop('selected', true);
				jq('#payingCategory option').eq(0).prop('selected', true);
				jq('#specialScheme option').eq(0).prop('selected', true);

				select3 = jq('#nonPayingCategory :selected').val().toUpperCase();
				
				jq('#summ_pays').text('Non-Paying / ' + jq('#nonPayingCategory option:selected').text());
                nonPayingCategorySelection();

			}
			else {
				jq('#specialScheme option').eq(select2).prop('selected', true);
				jq('#payingCategory option').eq(0).prop('selected', true);
				jq('#nonPayingCategory option').eq(0).prop('selected', true);
				
				select3 = jq('#specialScheme :selected').val().toUpperCase();
				
				jq('#summ_pays').text('Special Scheme / ' + jq('#specialScheme option:selected').text());
                payingCategorySelection();
			}
			
			if (select3.toUpperCase().indexOf("NHIF") >= 0){
				jq("#modesummary").attr("readonly", false);
				jq("#modesummary").attr("name", 'person.attribute.34');
				jq("#modesummary").val("");
				
				jq('#universitydiv').hide();
				jq('#university option').eq(0).prop('selected', true);
				
				jq('#summtitle1').text('NHIF Details');
				jq('#modesummary').attr("placeholder", "NHIF Number");
			}
			else if (select3.toUpperCase().indexOf("STUDENT SCHEME") >= 0){
				jq("#modesummary").attr("readonly", false);
				jq("#modesummary").attr("name", 'person.attribute.42');
				jq("#modesummary").val("");
				
				jq('#universitydiv').show();
				jq('#university option').eq(1).prop('selected', true);
				
				jq('#summtitle1').text('Student Details');
				jq('#modesummary').attr("placeholder", "Student Number");
			}
			else if (select3.toUpperCase().indexOf("WAIVER") >= 0){
				jq("#modesummary").attr("readonly", false);
				jq("#modesummary").attr("name", 'person.attribute.32');
				jq("#modesummary").val("");
				
				jq('#universitydiv').hide();
				jq('#university option').eq(0).prop('selected', true);
				
				jq('#summtitle1').text('Waiver Details');
				jq('#modesummary').attr("placeholder", "Waiver Number");
			}
			else {
				jq("#modesummary").attr("readonly", false);
				jq("#modesummary").attr("name", 'modesummary');
				jq("#modesummary").val("N/A");
				
				jq('#universitydiv').hide();
				jq('#university option').eq(0).prop('selected', true);
				
				jq('#summtitle1').text('Details');
				jq('#modesummary').attr("placeholder", "Enter Value");
			}

			jq('#summ_fees').text(jq('#selectedRegFeeValue').val() + '.00');
			
		});

        // Districts
        var _districts = new Array();
        var districts = "${districts}";
        <% districts.each { d -> %>
        _districts.push("${d}");
        <% } %>



        // Upazilas
        var _upazilas = new Array();
        var upazilas = "${upazilas}";
        <% upazilas.each { d -> %>
        _upazilas.push("${d}");
        <% } %>


        // Paying Category Map
        var _payingCategoryMap = new Array();
        var payingCategoryMap = "${payingCategoryMap}";
        <% payingCategoryMap.each { k, v -> %>
        _payingCategoryMap[${k}] = '${v}';
        <%}%>


        // NonPaying Category Map
        var _nonPayingCategoryMap = new Array();
        var nonPayingCategoryMap = "${nonPayingCategoryMap}";
        <% nonPayingCategoryMap.each { k, v -> %>
        _nonPayingCategoryMap[${k}] = '${v}';
        <%}%>

        // Special Scheme Map
        var _specialSchemeMap = new Array();
        var specialSchemeMap = "${specialSchemeMap}";
        <% specialSchemeMap.each { k, v -> %>
        _specialSchemeMap[${k}] = '${v}';
        <%}%>

        /**
         ** MODEL FROM CONTROLLER
         **/
        MODEL = {
            patientIdentifier: "${patientIdentifier}",
            counties: _districts,
            districts: _districts,
            upazilas: _upazilas,
            ////ghanshyam,16-dec-2013,3438 Remove the interdependency
            TRIAGE: "${TRIAGE}",
            OPDs: "${OPDs}",
            SPECIALCLINIC: "${SPECIALCLINIC}",
            payingCategory: "${payingCategory}",
            nonPayingCategory: "${nonPayingCategory}",
            specialScheme: "${specialScheme}",
            payingCategoryMap: _payingCategoryMap,
            nonPayingCategoryMap: _nonPayingCategoryMap,
            specialSchemeMap: _specialSchemeMap,
            universities: "${universities}",
            referredFrom: "${referralHospitals}",
            referralType: "${referralReasons}",
            TEMPORARYCAT: "${TEMPORARYCAT}",
            religions: "${religionList}"
        }

        jq("#modesummary").blur(function () {
            var select1 = jq('input[name=paym_1]:checked', '#patientRegistrationForm').val();
            var select2 = jq('input[name=paym_2]:checked', '#patientRegistrationForm').val();
            if (select1 == 2 && select2 == 1) {
                jq('input[name="person.attribute.34"]').val(jq("#modesummary").val());
            } else if (select1 == 3 && select2 == 1) {
                jq('input[name="person.attribute.42"]').val(jq("#modesummary").val());
            } else if (select1 == 3 && select2 == 2) {
                jq('input[name="person.attribute.32"]').val(jq("#modesummary").val());
            }
        });

        jq('input:text[id]').focus(function (event) {
            var checkboxID = jq(event.target).attr('id');
            jq('#' + checkboxID).removeClass("red-border");
        });

        jq('select').focus(function (event) {
            var checkboxID = jq(event.target).attr('id');
            jq('#' + checkboxID).removeClass("red-border");
        });

        jq('input:text[id]').focusout(function (event) {
            var arr = ["surName", "firstName", "birthdate", "patientRelativeName", "patientPostalAddress", "otherNationalityId", ""];
            var idd = jq(event.target).attr('id');

            if (jq.inArray(idd, arr) != -1) {
                if (jq('#' + idd).val().trim() == "") {
                    jq('#' + idd).addClass("red-border");
                }
                else {
                    jq('#' + idd).removeClass("red-border");
                }
            }
        });

        jq('input:text[id]').focusout(function (event) {
            var arr = ["firstName", "", "", "", "", ""];
            var idd = jq(event.target).attr('id');

            if (jq.inArray(idd, arr) != -1) {
                if (idd == 'firstName') {
                    jq('#summ_idnt').text(jq('#patientIdnts').val());
                    jq('#summ_name').text(jq('#surName').val() + ', ' + jq('#firstName').val());
                }
            }
        });

        jq('select').focusout(function (event) {
            var arr = ["patientGender", "paymode1", "legal1", "refer1", "rooms1", "relationshipType", "modetype1", "value4"];
            var idd = jq(event.target).attr('id');

            if (jq.inArray(idd, arr) != -1) {
                if (jq('#' + idd).val() == 0 || jq('#' + idd).val().trim() == "") {
                    jq('#' + idd).addClass("red-border");
                }
                else {
                    jq('#' + idd).removeClass("red-border");
                }

                if (idd == 'patientGender') {
                    jq('#summ_gend').text(jq('#patientGender option:selected').text());
                }
            }
        });

        jq(function () {
            jq("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
            jq("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
        });

        jq('#birthdate').datepicker({
            yearRange: 'c-100:c',
            maxDate: '0',
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true,
            constrainInput: false
        }).on("change", function (dateText) {
            jq("#birthdate").val(this.value);
            PAGE.checkBirthDate();
        });
		
		var county_array = String(MODEL.districts).substring(0,String(MODEL.districts).length).split(',');
		var county_strng = ",Select County|";
			
		for (var i=0; i < county_array.length; i++) {
			county_strng += county_array[i]+','+county_array[i]+'|'
		}
		
        MODEL.religions = ", |"
                + MODEL.religions;
        PAGE.fillOptions("#patientReligion", {
            data: MODEL.religions,
            delimiter: ",",
            optionDelimiter: "|"
        });
		
		MODEL.districts = county_strng;
		
        PAGE.fillOptions("#districts", {
            data: MODEL.districts,
			delimiter: ",",
            optionDelimiter: "|"
        });
		
		PAGE.fillOptions("#referredCounty", {
            data: MODEL.districts,
			delimiter: ",",
            optionDelimiter: "|"
        });
		
        jq("#districts").change();

        selectedDistrict = jq("#districts option:checked").val();
        selectedUpazila = jq("#upazilas option:checked").val();
        var loc = ('${location}');
        var districtArr = loc.split("@");
        for (var i = 0; i < districtArr.length; i++) {
            var dis = districtArr[i];
            var subcountyArr = dis.split("/");
            if (subcountyArr[0] == selectedDistrict) {
                for (var j = 1; j < subcountyArr.length; j++) {

                    var locationArr = subcountyArr[j].split(".");

                    if (locationArr[0] == selectedUpazila) {
                        var _locations = new Array();
                        for (var k = 1; k < locationArr.length; k++) {
                            _locations.push(locationArr[k]);

                            PAGE.fillOptions("#locations", {
                                data: _locations
                            });

                        }
                    }
                }
            }
        }
        ;
        
        PAGE.fillOptions("#payingCategory", {
            data: ", |" + MODEL.payingCategory,
            delimiter: ",",
            optionDelimiter: "|"
        });

        PAGE.fillOptions("#nonPayingCategory", {
            data: ", |" + MODEL.nonPayingCategory,
            delimiter: ",",
            optionDelimiter: "|"
        });

        PAGE.fillOptions("#specialScheme", {
            data: ", |" + MODEL.specialScheme,
            delimiter: ",",
            optionDelimiter: "|"
        });

        MODEL.universities = ", |"
                + MODEL.universities;
        PAGE.fillOptions("#university", {
            data: MODEL.universities,
            delimiter: ",",
            optionDelimiter: "|"
        });

        MODEL.TRIAGE = ",Select Type|"
                + MODEL.TRIAGE;
        PAGE.fillOptions("#triage", {
            data: MODEL.TRIAGE,
            delimiter: ",",
            optionDelimiter: "|"
        });
        MODEL.OPDs = ",Select Type|"
                + MODEL.OPDs;
        PAGE.fillOptions("#opdWard", {
            data: MODEL.OPDs,
            delimiter: ",",
            optionDelimiter: "|"
        });
        MODEL.SPECIALCLINIC = ",Select Type|"
                + MODEL.SPECIALCLINIC;
        PAGE.fillOptions("#specialClinic", {
            data: MODEL.SPECIALCLINIC,
            delimiter: ",",
            optionDelimiter: "|"
        });
        MODEL.TEMPORARYCAT = ",Select Case|"
                + MODEL.TEMPORARYCAT;
        PAGE.fillOptions("#mlc", {
            data: MODEL.TEMPORARYCAT,
            delimiter: ",",
            optionDelimiter: "|"
        });

        MODEL.referredFrom = ",Select Facility|"
                + MODEL.referredFrom;
        PAGE.fillOptions("#referredFrom", {
            data: MODEL.referredFrom,
            delimiter: ",",
            optionDelimiter: "|"
        });

        MODEL.referralType = ",Select Type|"
                + MODEL.referralType;
        PAGE.fillOptions("#referralType	", {
            data: MODEL.referralType,
            delimiter: ",",
            optionDelimiter: "|"
        });

        /* jq("#searchbox").showPatientSearchBox(
         {
         searchBoxView: hospitalName + "/registration",
         resultView: "/module/registration/patientsearch/"
         + hospitalName + "/findCreate",
         success: function (data) {
         PAGE.searchPatientSuccess(data);
         },
         beforeNewSearch: PAGE.searchPatientBefore
         });*/


        jq("#payingCategoryField").hide();
        jq("#nonPayingCategoryField").hide();
        jq("#specialSchemeCategoryField").hide();

        jq('#payingCategory option').eq(0).prop('selected', true);
        jq('#university option').eq(0).prop('selected', true);

        jq("#nhifNumberRow").hide();
        jq("#universityRow").hide();
        jq("#studentIdRow").hide();
        jq("#waiverNumberRow").hide();

        LoadLegalCases();
        LoadReferralCases();
        showOtherNationality();
        LoadPayCatg();
        LoadRoomsTypes();

        //stans
        jq("#otherNationality").hide();
        jq("#referredFromColumn").hide();
        jq("#referralTypeRow").hide();
        jq("#referralDescriptionRow").hide();
        jq("#triageField").hide();
        jq("#opdWardField").hide();
        jq("#specialClinicField").hide();
        jq("#fileNumberField").hide();

        // binding
        jq("#paying").click(function () {
            VALIDATORS.payingCheck();
        });
        jq("#nonPaying").click(function () {
            VALIDATORS.nonPayingCheck();
        });
        jq("#specialSchemes").click(function () {
            VALIDATORS.specialSchemeCheck();
        });

        jq("#mlcCaseYes").click(function () {
            VALIDATORS.mlcYesCheck();
        });

        jq("#mlcCaseNo").click(function () {
            VALIDATORS.mlcNoCheck();
        });

        jq("#referredYes").click(function () {
            VALIDATORS.referredYesCheck();
        });

        jq("#referredNo").click(function () {
            VALIDATORS.referredNoCheck();
        });

        jq("#triageRoom").click(function () {
            VALIDATORS.triageRoomCheck();
        });

        jq("#opdRoom").click(function () {
            VALIDATORS.opdRoomCheck();
        });

        jq("#specialClinicRoom").click(function () {
            VALIDATORS.specialClinicRoomCheck();
        });

        jq("#sameAddress").click(function () {
            VALIDATORS.copyaddress();
        });
		
		jq('input[name=paym_1][value="1"]').attr('checked', 'checked').change();
		jq('input[name=paym_1][value="1"]').attr('checked', false);
		
		jq('input[name=paym_2][value="1"]').attr('checked', false);
		
		jq('#university option').eq(0).prop('selected', true);
        //end of doc ready
    });

    /**
     ** FORM
     **/
    PAGE = {
        /** SUBMIT */
        submit: function () {

            // Capitalize fullname and relative name
//            relativeNameInCaptital = StringUtils.capitalize(jq("#patientRelativeName").val());
            relativeNameInCaptital = (jq("#patientRelativeName").val()).toUpperCase();
            jq("#patientRelativeName").val(relativeNameInCaptital);

            // Validate and submit
            if (this.validateRegisterForm()) {

                jq("#patientRegistrationForm").submit();

            }
        },

        checkNationalID: function () {
            nationalId = jq("#patientNationalId").val();
            jq.ajax({
                type: "GET",
                url: '${ ui.actionLink("registration", "registrationUtils", "main") }',
                dataType: "json",
                data: ({
                    nationalId: nationalId
                }),
                success: function (data) {
//                    jq("#divForNationalId").html(data);
                    validateNationalID(data);
                }
            });
        },

        checkPassportNumber: function () {
            passportNumber = jq("#passportNumber").val();
            jq.ajax({
                type: "GET",
                url: '${ ui.actionLink("registration", "registrationUtils", "main") }',
                dataType: "json",
                data: ({
                    passportNumber: passportNumber
                }),
                success: function (data) {
//                    jq("#divForpassportNumber").html(data);
                    validatePassportNumber(data);
                }
            });
        },

        /** VALIDATE BIRTHDATE */
        checkBirthDate: function () {
            var submitted = jq("#birthdate").val();
            jq.ajax({
                type: "GET",
                url: '${ ui.actionLink("registration", "registrationUtils", "processPatientBirthDate") }',
                dataType: "json",
                data: ({
                    birthdate: submitted
                }),
                success: function (data) {
                    if (data.datemodel.error == undefined) {
                        if (data.datemodel.estimated) {
							jq("#estimatedAge").html(data.datemodel.age + '<span> (Estimated)</span>');
                            jq("#birthdateEstimated").val("true")
                        } else {
							jq("#estimatedAge").html(data.datemodel.age);
                            jq("#birthdateEstimated").val("false");
                        }

                        jq("#summ_ages").html(data.datemodel.age.substr(1, 1000));
                        jq("#estimatedAgeInYear").val(data.datemodel.ageInYear);
                        jq("#birthdate").val(data.datemodel.birthdate);
                        jq("#calendar").val(data.datemodel.birthdate);

                    } else {
                        jq().toastmessage('showErrorToast', 'Age in wrong format');
                        jq("#birthdate").val("");
                        goto_previous_tab(5);
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError);
                }

            });
        },

        /** FILL OPTIONS INTO SELECT
         * option = {
		 * 		data: list of values or string
		 *		index: list of corresponding indexes
		 *		delimiter: seperator for value and label
		 *		optionDelimiter: seperator for options
		 * }
         */
        fillOptions: function (divId, option) {
            jq(divId).empty();
            if (option.delimiter == undefined) {
                if (option.index == undefined) {
                    jq.each(option.data, function (index, value) {
                        if (value.length > 0) {
                            jq(divId).append(
                                    "<option value='" + value + "'>" + value
                                    + "</option>");
                        }
                    });
                } else {
                    jq.each(option.data, function (index, value) {
                        if (value.length > 0) {
                            jq(divId).append(
                                    "<option value='" + option.index[index] + "'>"
                                    + value + "</option>");
                        }
                    });
                }
            } else {
                options = option.data.split(option.optionDelimiter);
                jq.each(options, function (index, value) {
                    values = value.split(option.delimiter);
                    optionValue = values[0];
                    optionLabel = values[1];
                    if (optionLabel != undefined) {
                        if (optionLabel.length > 0) {
                            jq(divId).append(
                                    "<option value='" + optionValue + "'>"
                                    + optionLabel + "</option>");
                        }
                    }
                });
            }
        },

        /** CHANGE DISTRICT */
        changeDistrict: function () {
			
			
            // get the list of upazilas
            upazilaList = "";
            selectedDistrict = jq("#districts option:checked").val();
			
			if (selectedDistrict === ""){
				jq('#upazilas').empty().append(jq("<option></option>").attr("value",'').text('Select Sub-County'));
				jq('#locations').empty().append(jq("<option></option>").attr("value",'').text('Select Ward'));
				
				return false
			}
			
            jq.each(MODEL.counties, function (index, value) {
                if (value == selectedDistrict) {
                    upazilaList = MODEL.upazilas[index];
                }
            });

            // fill upazilas into upazila dropdown
            this.fillOptions("#upazilas", {
                data: upazilaList.split(",")
            });


            selectedUpazila = jq("#upazilas option:checked").val();

            var loc = ('${location}');
            var districtArr = loc.split("@");
            for (var i = 0; i < districtArr.length; i++) {
                var dis = districtArr[i];
                var subcountyArr = dis.split("/");
                if (subcountyArr[0] == selectedDistrict) {
                    for (var j = 1; j < subcountyArr.length; j++) {

                        var locationArr = subcountyArr[j].split(".");

                        if (locationArr[0] == selectedUpazila) {
                            var _locations = new Array();
                            for (var k = 1; k < locationArr.length; k++) {
                                _locations.push(locationArr[k]);

                                PAGE.fillOptions("#locations", {
                                    data: _locations
                                });

                            }
                        }
                    }
                }
            }


        },

        /** CHANGE UPAZILA */
        changeUpazila: function () {
            selectedDistrict = jq("#districts option:checked").val();
            selectedUpazila = jq("#upazilas option:checked").val();
            var loc = ('${location}');
            var districtArr = loc.split("@");
            for (var i = 0; i < districtArr.length; i++) {
                var dis = districtArr[i];
                var subcountyArr = dis.split("/");
                if (subcountyArr[0] == selectedDistrict) {
                    for (var j = 1; j < subcountyArr.length; j++) {

                        var locationArr = subcountyArr[j].split(".");

                        if (locationArr[0] == selectedUpazila) {
                            var _locations = new Array();
                            for (var k = 1; k < locationArr.length; k++) {
                                _locations.push(locationArr[k]);

                                PAGE.fillOptions("#locations", {
                                    data: _locations
                                });

                            }
                        }
                    }
                }
            }
        },

        /** SHOW OR HIDE REFERRAL INFO */
        toogleReferralInfo: function (obj) {
            checkbox = jq(obj);
            if (checkbox.is(":checked")) {
                jq("#referralDiv").show();
            } else {
                jq("#referralDiv").hide();
            }
        },

        /** CALLBACK WHEN SEARCH PATIENT SUCCESSFULLY */
        searchPatientSuccess: function (data) {
            jq("#numberOfFoundPatients")
                    .html(
                    "Similar Patients: "
                    + data.totalRow
                    + "(<a href='javascript:PAGE.togglePatientResult();'>Show/Hide</a>)");
        },

        /** CALLBACK WHEN BEFORE SEARCHING PATIENT */
        searchPatientBefore: function (data) {
            jq("#numberOfFoundPatients")
                    .html(
                    "<center><img src='" + openmrsContextPath + "/moduleResources/hospitalcore/ajax-loader.gif" + "'/></center>");
            jq("#patientSearchResult").hide();
        },

        /** TOGGLE PATIENT RESULT */
        togglePatientResult: function () {
            jq("#patientSearchResult").toggle();
        },

        /** VALIDATE FORM */
        validateRegisterForm: function () {
            var i = 0;
            var tab1 = 0;
            var tab2 = 0;
            var tab3 = 0;
            var tab4 = 0;

            var select1 = jq('input[name=paym_1]:checked', '#patientRegistrationForm').val();
            var select2 = jq('input[name=paym_2]:checked', '#patientRegistrationForm').val();

            var str1 = '';


            //if (StringUtils.isBlank(jq("#firstName").val())) {
            if (!(jq("#firstName").val().trim())) {
                jq('#firstName').addClass("red-border");
                tab1++;
                i++;
            }
            else {
                value = jq("#firstName").val();
                value = value.substr(0, 1).toUpperCase() + value.substr(1);
                jq("#firstName").val(value);
                //if(/^[a-zA-Z0-9- ]*\$/.test(value) == false) {
                if (/^[a-zA-Z- ]*\$/.test(value) == false) {
                    jq('#firstName').addClass("red-border");
                    tab1++;
                    i++;
                }
                else {
                    jq('#firstName').removeClass("red-border");
                }
            }

//            if (!StringUtils.isBlank(jq("#otherName").val())) {
            if ((jq("#otherName").val())) {
                value = jq("#otherName").val();
                value = value.substr(0, 1).toUpperCase() + value.substr(1);
                jq("#otherName").val(value);
                //if(/^[a-zA-Z0-9- ]*\$/.test(value) == false) {
                if (/^[a-zA-Z- ]*\$/.test(value) == false) {
                    jq('#otherName').addClass("red-border");
                    tab1++;
                    i++;
                }
                else {
                    jq('#otherName').removeClass("red-border");
                }
            }

//            if (StringUtils.isBlank(jq("#surName").val())) {
            if (!(jq("#surName").val().trim())) {
                jq('#surName').addClass("red-border");
                tab1++;
                i++;
            }
            else {
                value = jq("#surName").val();
                value = value.substr(0, 1).toUpperCase() + value.substr(1);
                jq("#surName").val(value);
                //if(/^[a-zA-Z0-9- ]*\$/.test(value) == false) {
                if (/^[a-zA-Z- ]*\$/.test(value) == false) {
                    jq('#surName').addClass("red-border");
                    tab1++;
                    i++;
                }
                else {
                    jq('#surName').removeClass("red-border");
                }

            }


            if (!(jq("#birthdate").val().trim())) {
                jq('#birthdate').addClass("red-border");
                tab1++;
                i++;
            }
            else {
                jq('#birthdate').removeClass("red-border");
            }

            if (jq("#patientGender").val() == 0 || jq("#patientGender").val().trim() == "") {
                jq('#patientGender').addClass("red-border");
                i++;
                tab1++;
            }
            else if (select1 == 1 && select2 == 3 && jq("#patientGender").val() == "M") {
                str1 = 'The selected Scheme Doesnt Match the Gender Selected. ';
                jq('#patientGender').addClass("red-border");
                i++;
                tab1++;
            }
            else if (jq("#patientGender").val() == "M" && jq("#maritalStatus").val() == "Widow") {
                str1 = str1 + 'Widow marital status is only for Female. ';
                jq('#maritalStatus').addClass("red-border");
                i++;
                tab1++;
            }
            else if (jq("#patientGender").val() == "F" && jq("#maritalStatus").val() == "Widower") {
                str1 = str1 + 'Widower marital status is only for Male. ';
                jq('#maritalStatus').addClass("red-border");
                i++;
                tab1++;
            }
            else {
                jq('#patientGender').removeClass("red-border");
            }


            //TAB2
            if (!(jq("#patientPostalAddress").val().trim())) {
                jq('#patientPostalAddress').addClass("red-border");
                tab2++;
                i++;
            }
            else if (jq("#patientPostalAddress").val().length > 255) {
                str1 = str1 + 'Too much information provided for Physical Address. ';
                jq('#patientPostalAddress').addClass("red-border");
                tab2++;
                i++;
            }
            else {
                jq('#patientPostalAddress').removeClass("red-border");
            }

            if ((jq("#patientEmail").val().trim())) {
                var x = jq("#patientEmail").val();
                var regExpForEmail =
                <%= "/^([\\w-]+(?:\\.[\\w-]+)*)@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)\$/i;" %>
                if (regExpForEmail.test(x)) {
                    jq('#patientEmail').removeClass("red-border");
                }
                else {
                    str1 = str1 + "Please enter the patient's e-mail address in correct format. ";
                    jq('#patientEmail').addClass("red-border");
                    i++;
                    tab2++;
                }

            }

            //NOK HERE
            if (!(jq("#patientRelativeName").val().trim())) {
                jq('#patientRelativeName').addClass("red-border");
                i++;
                tab2++;
            }
            else {
                value = jq("#patientRelativeName").val();
                //value = value.substr(0, 1).toUpperCase() + value.substr(1);
                //jq("#patientRelativeName").val(value);
                if (<%= "/^[a-zA-Z- ]*\$/" %>.
                test(value) == false
            )
                {
                    jq('#patientRelativeName').addClass("red-border");
                    i++;
                    tab2++;
                }
            else
                {
                    jq('#patientRelativeName').removeClass("red-border");
                }
            }

            if (jq("#relationshipType").val() == 0 || jq("#relationshipType").val().trim() == "") {
                jq('#relationshipType').addClass("red-border");
                i++;
                tab2++;
            }
            else {
                jq('#relationshipType').removeClass("red-border");
            }

            if (jq("#relativePostalAddress").val().length > 255) {
                str1 = str1 + "Next of Kin Physical Address should not exceed more than 255 characters. ";
                jq('#relativePostalAddress').addClass("red-border");
                i++;
                tab2++;
            }
            else {
                jq('#relativePostalAddress').removeClass("red-border");
            }
			
            //TAB3
			if (!jq("input[name='paym_1']:checked").val() || !jq("input[name='paym_2']:checked").val()){
				str1 = str1 + "Kindly ensure the Payment Categories are properly filled. ";
                i++;
                tab3++;
			}

            if (jq("#legal1").val() == 0) {
                jq('#legal1').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#legal1').removeClass("red-border");
            }

            if ((jq("#legal1").val() == 1 && jq("#mlc").val().trim() == "") || jq('#mlc').val() == null) {
                jq('#mlc').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#mlc').removeClass("red-border");
            }

            if (jq("#refer1").val() == 0) {
                jq('#refer1').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#refer1').removeClass("red-border");
            }

            if ((jq("#refer1").val() == 1 && jq("#referredFrom").val().trim() == "") || jq('#referredFrom').val() == null) {
                jq('#referredFrom').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#referredFrom').removeClass("red-border");
            }

            if ((jq("#refer1").val() == 1 && jq("#referralType").val().trim() == "") || jq('#referralType').val() == null) {
                jq('#referralType').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#referralType').removeClass("red-border");
            }


            if (jq("#rooms1").val() == "") {
                jq('#rooms1').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#rooms1').removeClass("red-border");
            }


            if (jq("#rooms2").val() == 0 || jq("#rooms2").val() == "" || jq("#rooms2").val() == null) {
                jq('#rooms2').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#rooms2').removeClass("red-border");
            }

            if (jq("#rooms1").val() == 3 && jq("#rooms3").val().trim() == "") {
                jq('#rooms3').addClass("red-border");
                i++;
                tab3++;
            }
            else {
                jq('#rooms3').removeClass("red-border");
            }


            //submitNationalIDAndPassportNumber();
//            if (validateNationalIDAndPassportNumber()) {
//                return true;
//            }
//            else {
//                return false;
//            }


            if (i == 0) {
                return true;
            }
            else {
                var str0 = "<div id='form-verification-x' onclick='verification_close();'>&#215;</div><p>Please fill in correctly the fields marked with * and highlighted in red. Also ensure that date fields have been entered in specified format</p>"

                if (str1 != "") {
                    str0 = str0 + '<p><span style="color:#f00;"><i class="icon-quote-left" style="font-size: 18px">&nbsp;</i>Also Note: </span>' + str1 + '</p>'
                }

                jq('#form-verification-failed').html(str0);
                jq('#form-verification-failed').show();
                jq('html, body').animate({scrollTop: 100}, 'slow');
                return false;
            }
        }
    };


    /**
     ** VALIDATORS
     **/
    VALIDATORS = {

        /** CHECK WHEN PAYING CATEGORY IS SELECTED */
        payingCheck: function () {
            if (jq("#paying").is(':checked')) {
                jq("#nonPaying").removeAttr("checked");
                jq("#payingCategoryField").show();
                jq("#nonPayingCategory").val("");
                jq("#nonPayingCategoryField").hide();
                jq("#specialScheme").val("");
                jq("#specialSchemeCategoryField").hide();
                jq("#specialSchemes").removeAttr("checked");
                //jq("#selectedRegFeeValue").val(${initialRegFee});

                jq("#nhifNumberRow").hide();
                jq("#universityRow").hide();
                jq("#studentIdRow").hide();
                jq("#waiverNumberRow").hide();
            }
            else {
                jq("#payingCategoryField").hide();
            }
        },

        /** CHECK WHEN NONPAYING CATEGORY IS SELECTED */
        nonPayingCheck: function () {
            if (jq("#nonPaying").is(':checked')) {
                jq("#paying").removeAttr("checked");
                jq("#nonPayingCategoryField").show();
                jq("#specialSchemes").removeAttr("checked");
                jq("#payingCategory").val("");
                jq("#payingCategoryField").hide();
                jq("#specialScheme").val("");
                jq("#specialSchemeCategoryField").hide();
                //jq("#selectedRegFeeValue").val(0);

                var selectedNonPayingCategory = jq("#nonPayingCategory option:checked").val();
                //if(MODEL.nonPayingCategoryMap[selectedNonPayingCategory]==="NHIF CIVIL SERVANT"){
                if (selectedNonPayingCategory == "NHIF CIVIL SERVANT") {
                    jq("#nhifNumberRow").show();
                }
                else {
                    jq("#nhifNumberRow").hide();
                }

                jq("#universityRow").hide();
                jq("#studentIdRow").hide();
                jq("#waiverNumberRow").hide();
            }
            else {
                jq("#nonPayingCategoryField").hide();
                jq("#nhifNumberRow").hide();
            }
        },

        /** CHECK WHEN SPECIAL SCHEME CATEGORY IS SELECTED */
        specialSchemeCheck: function () {
            if (jq("#specialSchemes").is(':checked')) {
                jq("#paying").removeAttr("checked");
                jq("#payingCategory").val("");
                jq("#payingCategoryField").hide();
                jq("#nonPayingCategory").val("");
                jq("#nonPayingCategoryField").hide();
                jq("#nonPaying").removeAttr("checked");
                jq("#specialSchemeCategoryField").show();
                //jq("#selectedRegFeeValue").val(0);

                jq("#nhifNumberRow").hide();

                var selectedSpecialScheme = jq("#specialScheme option:checked").val();
                //if(MODEL.specialSchemeMap[selectedSpecialScheme]==="STUDENT SCHEME"){
                if (selectedSpecialScheme == "STUDENT SCHEME") {
                    jq("#universityRow").show();
                    jq("#studentIdRow").show();
                }
                else {
                    jq("#universityRow").hide();
                    jq("#studentIdRow").hide();
                }

                //if(MODEL.specialSchemeMap[selectedSpecialScheme]==="WAIVER CASE"){
                if (selectedSpecialScheme == "WAIVER CASE") {
                    jq("#waiverNumberRow").show();
                }
                else {
                    jq("#waiverNumberRow").hide();
                }
            }
            else {
                jq("#specialSchemeCategoryField").hide();
                jq("#universityRow").hide();
                jq("#studentIdRow").hide();
                jq("#waiverNumberRow").hide();
            }
        },

        mlcYesCheck: function () {
            if (jq("#mlcCaseYes").is(':checked')) {
                jq("#mlcCaseNo").removeAttr("checked");
                jq("#mlc").show();
            }
            else {
                jq("#mlc").hide();
            }
        },

        mlcNoCheck: function () {
            if (jq("#mlcCaseNo").is(':checked')) {
                jq("#mlcCaseYes").removeAttr("checked");
                jq("#mlc").hide();
            }
        },

        referredYesCheck: function () {
            if (jq("#referredYes").is(':checked')) {
                jq("#referredNo").removeAttr("checked");
                jq("#referredFromColumn").show();
                jq("#referralTypeRow").show();
                jq("#referralDescriptionRow").show();
            }
            else {
                jq("#referredFromColumn").hide();
                jq("#referralTypeRow").hide();
                jq("#referralDescriptionRow").hide();
            }
        },

        referredNoCheck: function () {
            if (jq("#referredNo").is(':checked')) {
                jq("#referredYes").removeAttr("checked");
                jq("#referredFromColumn").hide();
                jq("#referralTypeRow").hide();
                jq("#referralDescriptionRow").hide();
            }
        },

        triageRoomCheck: function () {
            if (jq("#triageRoom").is(':checked')) {
                jq("#opdRoom").removeAttr("checked");
                jq("#specialClinicRoom").removeAttr("checked");
                jq("#triageField").show();
                jq("#opdWard").val("");
                jq("#opdWardField").hide();
                jq("#specialClinic").val("");
                jq("#specialClinicField").hide();
                jq("#fileNumberField").hide();
            }
            else {
                jq("#triageField").hide();
            }
        },

        opdRoomCheck: function () {
            if (jq("#opdRoom").is(':checked')) {
                jq("#triageRoom").removeAttr("checked");
                jq("#specialClinicRoom").removeAttr("checked");
                jq("#triage").val("");
                jq("#triageField").hide();
                jq("#opdWardField").show();
                jq("#specialClinic").val("");
                jq("#specialClinicField").hide();
                jq("#fileNumberField").hide();
            }
            else {
                jq("#opdWardField").hide();
            }
        },

        specialClinicRoomCheck: function () {
            if (jq("#specialClinicRoom").is(':checked')) {
                jq("#triageRoom").removeAttr("checked");
                jq("#opdRoom").removeAttr("checked");
                jq("#triage").val("");
                jq("#triageField").hide();
                jq("#opdWard").val("");
                jq("#opdWardField").hide();
                jq("#specialClinicField").show();
                jq("#fileNumberField").show();
            }
            else {
                jq("#specialClinicField").hide();
                jq("#fileNumberField").hide();
            }
        },

        copyaddress: function () {
            if (jq("#sameAddress").is(':checked')) {
                jq("#relativePostalAddress").val(jq("#patientPostalAddress").val());

            }
            else {
                jq("#relativePostalAddress").val('');
            }
        },

        /*
         * Check patient gender
         */
        genderCheck: function () {

            jq("#patientRelativeNameSection").empty();
            if (jq("#patientGender").val() == "M") {
                jq("#patientRelativeNameSection")
                        .html(
                        '<input type="radio" name="person.attribute.15" value="Son of" checked="checked"/> Son of');
            } else if (jq("#patientGender").val() == "F") {
                jq("#patientRelativeNameSection")
                        .html(
                        '<input type="radio" name="person.attribute.15" value="Daughter of"/> Daughter of <input type="radio" name="person.attribute.15" value="Wife of"/> Wife of');
            }
        }

    };

    function showOtherNationality() {
        var optionValue = jq("#patientNation option:selected").text();
        if (optionValue == "Other") {
            jq("#otherNationality").show();
            jq('#otherNationalityId').removeClass("disabled");

        }
        else {
            jq("#otherNationality").hide();
            jq('#otherNationalityId').addClass("disabled");
        }
    }

    function submitNationalID() {
        PAGE.checkNationalID();
    }

    function validateNationalID(data) {

        if (data.nid == "1") {
            document.getElementById("nationalIdValidationMessage").innerHTML = "Patient already registered with this National ID";
            jq("#nationalIdValidationMessage").show();
            return false;
        }
        else {
            jq("#nationalIdValidationMessage").hide();
        }
    }


    function submitPassportNumber() {
        PAGE.checkPassportNumber();
    }

    function validatePassportNumber(data) {

        if (data.pnum == "1") {
            document.getElementById("passportNumberValidationMessage").innerHTML = "Patient already registered with this Passport Number";
            jq("#passportNumberValidationMessage").show();
            return false;
        }
        else {
            jq("#passportNumberValidationMessage").hide();
        }
    }

    function submitNationalIDAndPassportNumber() {
        PAGE.checkNationalIDAndPassportNumber();
    }


    function payingCategorySelection() {


        var select1 = jq('input[name=paym_1]:checked', '#patientRegistrationForm').val();
        var select2 = jq('input[name=paym_2]:checked', '#patientRegistrationForm').val();

        var selectedPayingCategory = jq("#payingCategory option:checked").val();
        //if(MODEL.payingCategoryMap[selectedPayingCategory]=="CHILD LESS THAN 5 YEARS"){
        var estAge = jq("#estimatedAgeInYear").val();	//come back here


        if (select1 == 1 && select2 == 2) {
            if (estAge < 6) {
                jq("#selectedRegFeeValue").val(${childLessThanFiveYearRegistrationFee});
            } else {
                jq().toastmessage('showErrorToast', 'Selected Scheme should be for child at 5 years and below');
                jq('input[name=paym_2][value="1"]').attr('checked', 'checked').change();
				return false;
            }
        }
        else {
            if (select1 == 1 && select2 == 3) {
                if (jq("#patientGender").val() == "M") {
                    jq().toastmessage('showErrorToast', 'This category is only valid for female');
                    jq('input[name=paym_2][value="1"]').attr('checked', 'checked').change();
					return false;
                }
            }

            if (select1 == 3) {
                var initialRegFee = parseInt('${initialRegFee}');
                var specialClinicRegFee = parseInt('${specialClinicRegFee}');
                var totalRegFee = initialRegFee + specialClinicRegFee;
                jq("#selectedRegFeeValue").val(totalRegFee);
            }
            else {
                jq("#selectedRegFeeValue").val(${initialRegFee});
            }
        }

        if (select1 == 1) {
            jq('#payingCategory option').eq(select2).prop('selected', true);
            jq('#nonPayingCategory option').eq(0).prop('selected', true);
            jq('#specialScheme option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Paying / ' + jq('#payingCategory option:selected').text());
        }
        else if (select1 == 2) {
            jq('#nonPayingCategory option').eq(select2).prop('selected', true);
            jq('#payingCategory option').eq(0).prop('selected', true);
            jq('#specialScheme option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Non-Paying / ' + jq('#nonPayingCategory option:selected').text());
        }
        else {
            jq('#specialScheme option').eq(select2).prop('selected', true);
            jq('#payingCategory option').eq(0).prop('selected', true);
            jq('#nonPayingCategory option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Special Scheme / ' + jq('#specialScheme option:selected').text());
        }
    }

    function nonPayingCategorySelection() {
        var selectedRoomToVisit = jq("#rooms1").val();
        var nonPayingCategorySelected = jq("#nonPayingCategory").val();
        var selectedNonPayingCategory = jq("#nonPayingCategory option:checked").val();
        //if(MODEL.nonPayingCategoryMap[selectedNonPayingCategory]=="NHIF CIVIL SERVANT"){
        if (selectedNonPayingCategory == "NHIF CIVIL SERVANT") {
            jq("#nhifNumberRow").show();
        }
        else {
            jq("#nhifNumberRow").hide();
        }

        if(selectedRoomToVisit === "3"){
            if(nonPayingCategorySelected === "CCC PATIENT" || nonPayingCategorySelected === "TB PATIENT"){
                jq("#selectedRegFeeValue").val(${specialClinicRegFee});
            }
        } else if (nonPayingCategorySelected === "CCC PATIENT" || nonPayingCategorySelected === "TB PATIENT"){
            jq("#selectedRegFeeValue").val(${initialRegFee});
        } else {
            jq("#selectedRegFeeValue").val(0);
        }

    }



    function specialSchemeSelection() {
        var selectedSpecialScheme = jq("#specialScheme option:checked").val();

        if (selectedSpecialScheme == "DELIVERY CASE") {
            if (jq("#patientGender").val() == "M") {
                alert("This category is only valid for female");
            }
        }

        //if(MODEL.specialSchemeMap[selectedSpecialScheme]=="STUDENT SCHEME"){
        if (selectedSpecialScheme == "STUDENT SCHEME") {
            jq("#universityRow").show();
            jq("#studentIdRow").show();
        }
        else {
            jq("#universityRow").hide();
            jq("#studentIdRow").hide();
        }

        //if(MODEL.specialSchemeMap[selectedSpecialScheme]=="WAIVER CASE"){
        if (selectedSpecialScheme == "WAIVER CASE") {
            jq("#waiverNumberRow").show();
        }
        else {
            jq("#waiverNumberRow").hide();
        }

        jq("#selectedRegFeeValue").val(0);
    }

    function triageRoomSelectionFor() {
        if (jq("#payingCategory").val() != " ") {
            var selectedPayingCategory = jq("#payingCategory option:checked").val();
            if (selectedPayingCategory == "CHILD LESS THAN 5 YEARS") {
                jq("#selectedRegFeeValue").val(${childLessThanFiveYearRegistrationFee});
            }
            else {
                jq("#selectedRegFeeValue").val(${initialRegFee});
            }
        }
        else if (jq("#nonPayingCategory").val() != " ") {
            jq("#selectedRegFeeValue").val(0);
        }
        else if (jq("#specialScheme").val() != " ") {
            jq("#selectedRegFeeValue").val(0);
        }
    }

    function opdRoomSelectionForReg() {

        if (jq("#payingCategory").val() != " ") {
            var selectedPayingCategory = jq("#payingCategory option:checked").val();
            if (selectedPayingCategory == "CHILD LESS THAN 5 YEARS") {
                jq("#selectedRegFeeValue").val(${childLessThanFiveYearRegistrationFee});
            }
            else {
                jq("#selectedRegFeeValue").val(${initialRegFee});
            }
        }
        else if (jq("#nonPayingCategory").val() != " ") {
            jq("#selectedRegFeeValue").val(0);
        }
        else if (jq("#specialScheme").val() != " ") {
            jq("#selectedRegFeeValue").val(0);
        }
    }

    function specialClinicSelectionForReg() {
        if (jq("#payingCategory").val() != " ") {
            var selectedPayingCategory = jq("#payingCategory option:checked").val();
            if (selectedPayingCategory == "CHILD LESS THAN 5 YEARS") {
                jq("#selectedRegFeeValue").val(${childLessThanFiveYearRegistrationFee});
            }
            else {
                var initialRegFee = parseInt('${initialRegFee}');
                var specialClinicRegFee = parseInt('${specialClinicRegFee}');
                var totalRegFee = initialRegFee + specialClinicRegFee;
                jq("#selectedRegFeeValue").val(totalRegFee);
            }
        }
        else if (jq("#nonPayingCategory").val() != " ") {
            var selectedNonPayingCategory = jq("#nonPayingCategory option:checked").val();
            if (selectedNonPayingCategory == "TB PATIENT" || selectedNonPayingCategory == "CCC PATIENT") {
                jq("#selectedRegFeeValue").val(${specialClinicRegFee});
            }
            else {
                jq("#selectedRegFeeValue").val(0);
            }
        }
        else if (jq("#specialScheme").val() != " ") {
            jq("#selectedRegFeeValue").val(0);
        }
    }
    function LoadPayCatg() {
        
    }

    function LoadPayCatgMode() {


        var select1 = jq('input[name=paym_1]:checked', '#patientRegistrationForm').val();
        var select2 = jq('input[name=paym_2]:checked', '#patientRegistrationForm').val();

        if ((select1 == 2) && (select2 == 1)) {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("");
			
            jq('#universitydiv').hide();
			jq('#university option').eq(0).prop('selected', true);
			
            jq('#summtitle1').text('NHIF Summary');
            jq('#modesummary').attr("placeholder", "NHIF Number");
        }
        else if ((select1 == 3) && (select2 == 1)) {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("");
			
            jq('#universitydiv').show();
			jq('#university option').eq(1).prop('selected', true);
			
            jq('#summtitle1').text('Student Summary');
            jq('#modesummary').attr("placeholder", "Student Number");
        }
        else if ((select1 == 3) && (select2 == 2)) {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("");
			
            jq('#universitydiv').hide();
			jq('#university option').eq(0).prop('selected', true);
			
            jq('#summtitle1').text('Waiver Summary');
            jq('#modesummary').attr("placeholder", "Waiver Number");
        }
        else {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("N/A");
			
            jq('#universitydiv').hide();
			jq('#university option').eq(0).prop('selected', true);
			
            jq('#summtitle1').text('Details');
            jq('#modesummary').attr("placeholder", "Enter Value");

        }

        if (select1 == 1) {
            jq('#payingCategory option').eq(select2).prop('selected', true);
            jq('#nonPayingCategory option').eq(0).prop('selected', true);
            jq('#specialScheme option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Paying / ' + jq('#payingCategory option:selected').text());
        }
        else if (select1 == 2) {
            jq('#nonPayingCategory option').eq(select2).prop('selected', true);
            jq('#payingCategory option').eq(0).prop('selected', true);
            jq('#specialScheme option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Non-Paying / ' + jq('#nonPayingCategory option:selected').text());
        }
        else {
            jq('#specialScheme option').eq(select2).prop('selected', true);
            jq('#payingCategory option').eq(0).prop('selected', true);
            jq('#nonPayingCategory option').eq(0).prop('selected', true);

            jq('#summ_pays').text('Special Scheme / ' + jq('#specialScheme option:selected').text());
        }

        payingCategorySelection();

        jq('#summ_fees').text(jq('#selectedRegFeeValue').val() + '.00');
    }

    function LoadPaymodes() {
        jq('#modetype1').empty();

        if (jq("#paymode1").val() == 1) {
            var myOptions = {1: 'GENERAL', 2: 'CHILD UNDER 5YRS', 3: 'EXPECTANT MOTHER'};

            var mySelect = jq('#modetype1');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });
        }
        else if (jq("#paymode1").val() == 2) {
            var myOptions = {4: 'PULSE', 5: 'CCC PATIENT', 6: 'TB PATIENT'};

            var mySelect = jq('#modetype1');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });
        }
        else if (jq("#paymode1").val() == 3) {
            var myOptions = {7: 'BLOOD OXYGEN SATURATION', 8: 'WAIVER CASE', 9: 'DELIVERY CASE'};

            var mySelect = jq('#modetype1');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });
        }
        else {
            var myOptions = {0: ''};

            var mySelect = jq('#modetype1');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });
        }

        LoadModeChange();
    }

    function LoadModeChange() {
        if (jq("#modetype1").val() == 8) {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("");
            jq('#forpaymode1').text('Waiver Number');
        }
        else {
            jq("#modesummary").attr("readonly", false);
            jq("#modesummary").val("N/A");
            jq('#forpaymode1').text('Summary');
        }
    }

    function LoadLegalCases() {
        jq('#mlc').empty();

        if (jq("#legal1").val() == 1) {
            PAGE.fillOptions("#mlc", {
                data: MODEL.TEMPORARYCAT,
                delimiter: ",",
                optionDelimiter: "|"
            });

            jq("#mlcCaseYes").attr('checked', 'checked');
            jq("#mlcCaseNo").attr('checked', false);
			jq('#formlc span').text('*');
        }
        else if (jq("#legal1").val() == 2) {
            var myOptions = {" ": 'N/A'};
            var mySelect = jq('#mlc');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            jq("#mlcCaseYes").attr('checked', false);
            jq("#mlcCaseNo").attr('checked', 'checked');
			jq('#formlc span').text('');
        }
		else {
            var myOptions = {" ": 'N/A'};
            var mySelect = jq('#mlc');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            jq("#mlcCaseYes").attr('checked', false);
            jq("#mlcCaseNo").attr('checked', false);
			jq('#formlc span').text('');
        }
    }
    function LoadReferralCases() {
        jq('#referredFrom').empty();
        jq('#referralType').empty();

        if (jq("#refer1").val() == 1) {
            PAGE.fillOptions("#referredFrom", {
                data: MODEL.referredFrom,
                delimiter: ",",
                optionDelimiter: "|"
            });

            jq("#referralDescription").attr("readonly", false);
            jq("#referralDescription").val("");

            PAGE.fillOptions("#referralType", {
                data: MODEL.referralType,
                delimiter: ",",
                optionDelimiter: "|"
            });

            jq("#referredYes").attr('checked', 'checked');
            jq("#referredNo").attr('checked', false);
			
            jq(".referraldiv").show();
			
			jq('#forReferralType span').text('*');
			jq('#forReferredFrom span').text('*');
			
            jq('#referralDescription').removeClass("disabled");
        }
		else if (jq("#refer1").val() == 2) {
			var myOptions = {" ": 'N/A'};
            var mySelect = jq('#referredFrom');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            mySelect = jq('#referralType');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            jq("#referralDescription").attr("readonly", true);
            jq("#referralDescription").val("N/A");

            jq(".referraldiv").hide();
			
			jq('#forReferralType span').text('');
			jq('#forReferredFrom span').text('');
			
            jq("#referredNo").attr('checked', 'checked');
            jq("#referredYes").attr('checked', false);
            jq('#referralDescription').addClass("disabled");
		}
        else {
            var myOptions = {" ": 'N/A'};
            var mySelect = jq('#referredFrom');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            mySelect = jq('#referralType');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            jq("#referralDescription").attr("readonly", true);
            jq("#referralDescription").val("N/A");

            jq(".referraldiv").hide();
			
            jq("#referredNo").attr('checked', false);
            jq("#referredYes").attr('checked', false);
            jq('#referralDescription').addClass("disabled");
        }
    }

    function LoadRoomsTypes() {
        jq('#rooms2').empty();
        if (jq("#rooms1").val() == 1) {
            PAGE.fillOptions("#rooms2", {
                data: MODEL.TRIAGE,
                delimiter: ",",
                optionDelimiter: "|"
            });
            jq("#rooms3").attr("readonly", true);
            jq("#rooms3").val("N/A");
            jq('#froom2').html('Triage Rooms<span>*</span>');

            jq("#triageRoom").attr('checked', 'checked');
            jq("#opdRoom").attr('checked', false);
            jq("#specialClinicRoom").attr('checked', false);
            jq('#referralDescription').removeClass("required");

            jq('#rooms3').hide();
            jq('#froom3').hide();
        }
        else if (jq("#rooms1").val() == 2) {
            PAGE.fillOptions("#rooms2", {
                data: MODEL.OPDs,
                delimiter: ",",
                optionDelimiter: "|"
            });

            jq("#rooms3").attr("readonly", true);
            jq("#rooms3").val("N/A");
            jq('#froom2').html('OPD Rooms<span>*</span>');

            jq("#triageRoom").attr('checked', false);
            jq("#opdRoom").attr('checked', 'checked');
            jq("#specialClinicRoom").attr('checked', false);
            jq('#referralDescription').removeClass("required");

            jq('#rooms3').hide();
            jq('#froom3').hide();
        }
        else if (jq("#rooms1").val() == 3) {
            PAGE.fillOptions("#rooms2", {
                data: MODEL.SPECIALCLINIC,
                delimiter: ",",
                optionDelimiter: "|"
            });

            jq("#rooms3").attr("readonly", false);
            jq("#rooms3").val("");
            jq('#froom2').html('Special Clinic<span>*</span>');

            jq("#triageRoom").attr('checked', false);
            jq("#opdRoom").attr('checked', false);
            jq("#specialClinicRoom").attr('checked', 'checked');
            jq('#referralDescription').addClass("required");

            jq('#rooms3').show();
            jq('#froom3').show();
        }
        else {
            var myOptions = {0: 'N/A'};
            var mySelect = jq('#rooms2');
            jq.each(myOptions, function (val, text) {
                mySelect.append(
                        jq('<option></option>').val(val).html(text)
                );
            });

            jq("#rooms3").attr("readonly", true);
            jq("#rooms3").val("N/A");

            jq("#triageRoom").attr('checked', false);
            jq("#opdRoom").attr('checked', false);
            jq("#specialClinicRoom").attr('checked', false);
            jq('#referralDescription').removeClass("required");

            jq('#rooms3').hide();
            jq('#froom3').hide();
        }
    }

    function verification_close() {
        jq('#form-verification-failed').hide();
    }
    ;

    function goto_next_tab(current_tab) {
        if (current_tab == 1) {
            var currents = '';

            while (jq(':focus') != jq('#patientPhoneNumber')) {
                if (currents == jq(':focus').attr('id')) {
                    NavigatorController.stepForward();
                    jq("#ui-datepicker-div").hide();
                    break;
                }
                else {
                    currents = jq(':focus').attr('id');
                }

                if (jq(':focus').attr('id') == 'patientPhoneNumber') {
                    jq("#ui-datepicker-div").hide();
                    break;
                }
                else {
                    NavigatorController.stepForward();
                }
            }
            // jq(':focus')

            //NavigatorController.getFieldById('passportNumber').select();

        }
        else if (current_tab == 2) {
            var currents = '';

            while (jq(':focus') != jq('#modesummary')) {
                if (currents == jq(':focus').attr('id')) {
                    NavigatorController.stepForward();
                    break;
                }
                else {
                    currents = jq(':focus').attr('id');
                }

                if (jq(':focus').attr('id') == 'modesummary') {
                    break;
                }
                else {
                    NavigatorController.stepForward();
                }
            }
        }
    }

    function goto_previous_tab(current_tab) {
        if (current_tab == 2) {
            while (jq(':focus') != jq('#passportNumber')) {
                if (jq(':focus').attr('id') == 'passportNumber' || jq(':focus').attr('id') == 'otherNationalityId') {
                    jq("#ui-datepicker-div").hide();
                    break;
                }
                else {
                    NavigatorController.stepBackward();
                }
            }
        }
        else if (current_tab == 3) {
            while (jq(':focus') != jq('#relativePostalAddress')) {
                if (jq(':focus').attr('id') == 'relativePostalAddress') {
                    jq("#ui-datepicker-div").hide();
                    break;
                }
                else {
                    NavigatorController.stepBackward();
                }
            }
        }
        else if (current_tab == 4) {
            jq('#rooms3').focus();

        }
        else if (current_tab == 5) {
            while (jq(':focus') != jq('#maritalStatus')) {
                if (jq(':focus').attr('id') == 'birthdate') {
                    jq("#ui-datepicker-div").hide();
                    break;
                }
                else {
                    NavigatorController.stepBackward();
                }
            }
        }
    }
</script>
<style>
.ui-tabs-vertical {
    width: 55em;
}

.ui-tabs-vertical .ui-tabs-nav {
    padding: .2em .1em .2em .2em;
    float: left;
    width: 12em;
}

.ui-tabs-vertical .ui-tabs-nav li {
    clear: left;
    width: 100%;
    border-bottom-width: 1px !important;
    border-right-width: 0 !important;
    margin: 0 -1px .2em 0;
}

.ui-tabs-vertical .ui-tabs-nav li a {
    display: block;
}

.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active {
    padding-bottom: 0;
    padding-right: .1em;
    border-right-width: 1px;
}

.ui-tabs-vertical .ui-tabs-panel {
    padding: 1em;
    float: right;
    width: 45em;
}

.red-border {
    border: 1px solid #f00 !important;
}

.myh2,
.tasks-list {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}

.tasks {
    font: 13px/20px 'Lucida Grande', Verdana, sans-serif;
    color: #404040;
    width: 100%;
    background: white;
    border: 1px solid #cdd3d7;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.tasks-header {
    position: relative;
    line-height: 24px;
    padding: 7px 15px;
    color: #5d6b6c;
    text-shadow: 0 1px rgba(255, 255, 255, 0.7);
    background: #f0f1f2;
    border-bottom: 1px solid #d1d1d1;
    border-radius: 3px 3px 0 0;
    background-image: -webkit-linear-gradient(top, #f5f7fd, #e6eaec);
    background-image: -moz-linear-gradient(top, #f5f7fd, #e6eaec);
    background-image: -o-linear-gradient(top, #f5f7fd, #e6eaec);
    background-image: linear-gradient(to bottom, #f5f7fd, #e6eaec);
    -webkit-box-shadow: inset 0 1px rgba(255, 255, 255, 0.5), 0 1px rgba(0, 0, 0, 0.03);
    box-shadow: inset 0 1px rgba(255, 255, 255, 0.5), 0 1px rgba(0, 0, 0, 0.03);
}

.tasks-title {
    line-height: inherit;
    font-size: 14px;
    font-weight: bold;
    color: inherit;
}

.tasks-lists {
	background: rgba(0, 0, 0, 0) url("../ms/uiframework/resource/registration/images/view_list.png") no-repeat scroll 3px 0 / 85% auto;
    position: absolute;
    top: 50%;
    right: 10px;
    margin-top: -11px;
    padding: 10px 4px;
    width: 19px;
    height: 3px;
    font: 0/0 serif;
    text-shadow: none;
    color: transparent;
}

.tasks-lists:before {
    display: block;
    height: 3px;
    background: #8c959d;
    border-radius: 1px;
    -webkit-box-shadow: 0 6px #8c959d, 0 -6px #8c959d;
    box-shadow: 0 6px #8c959d, 0 -6px #8c959d;
}

.tasks-list-item {
    display: block;
    line-height: 24px;
    padding: 5px 10px;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

.tasks-list-item + .tasks-list-item {
    border-top: 1px solid #f0f2f3;
}

.tasks-list-cb {
    display: none;
}

.tasks-list-mark {
    position: relative;
    display: inline-block;
    vertical-align: top;
    margin-right: 0px;
    width: 16px;
    height: 20px;
    border: 2px solid #c4cbd2;
    border-radius: 12px;
}

.tasks-list-mark:before {
    content: '';
    display: none;
    position: absolute;
    top: 50%;
    left: 50%;
    margin: -5px 0 0 -6px;
    height: 4px;
    width: 8px;
    border: solid #39ca74;
    border-width: 0 0 4px 4px;
    -webkit-transform: rotate(-45deg);
    -moz-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    -o-transform: rotate(-45deg);
    transform: rotate(-45deg);
}

.tasks-list-cb:checked ~ .tasks-list-mark {
    border-color: #39ca74;
}

.tasks-list-cb:checked ~ .tasks-list-mark:before {
    display: block;
}

.tasks-list-desc {
    font-weight: bold;
    color: #555;
}

.tasks-list-cb:checked ~ .tasks-list-desc {
    color: #34bf6e;
}

#form-verification-x {
    color: #f00;
    cursor: pointer;
    float: right;
    margin: -10px -22px 0;
}

.form-verifier-js {
    padding: 10px 30px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -ms-box-sizing: border-box;
    box-sizing: border-box;
    box-shadow: 0 11px 5px -10px rgba(0, 0, 0, 0.3);
    border: 1px solid #F00;
    margin-bottom: 15px;
    display: none;
}

.form-verifier-js p {
    padding-top: 5px;
    padding-bottom: 0px;
    margin-bottom: 5px;

}

.form-duplicate-js {
    padding: 1px 30px 1px 30px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -ms-box-sizing: border-box;
    box-sizing: border-box;
    box-shadow: 0 11px 5px -10px rgba(0, 0, 0, 0.3);
    border: 1px solid #F00;
    margin-bottom: 15px;
}

.form-duplicate-js p {
    padding-top: 5px;
    padding-bottom: 0px;
    margin-bottom: 5px;

}

.dashboard .info-section {
    margin: 0 5px 5px;
}

.dashboard .info-body li {
    padding-bottom: 2px;
}

.dashboard .info-body li span {
    margin-right: 10px;
}

.dashboard .info-body li small {

}

.dashboard .info-body li div {
    width: 150px;
    display: inline-block;
}

.addon {
	color: #f26522;
    display: inline-block;
    float: right;
    margin: 10px 0 0 190px;
    position: absolute;
}
</style>

<%
    ui.includeJavascript("uicommons", "navigator/validators.js", Integer.MAX_VALUE - 19)
    ui.includeJavascript("uicommons", "navigator/navigator.js", Integer.MAX_VALUE - 20)
    ui.includeJavascript("uicommons", "navigator/navigatorHandlers.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/navigatorModels.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/exitHandlers.js", Integer.MAX_VALUE - 22)
%>

<script>
    var NavigatorController
    jq(function () {
        NavigatorController = new KeyboardController();
    });
</script>

<div id="form-verification-failed" class="form-verifier-js">
    <p>Please fill correctly the fields marked with * and/or ensure that dates have been entered in specified format.</p>
</div>

<div id="content" class="container">
    <form class="simple-form-ui" id="patientRegistrationForm" method="post">

        <section id="charges-info2" style="width:74%">
            <span class="title">Patient Details</span>
            <fieldset class="no-confirmation">
                <legend>Demographics</legend>
				<h2 style="margin: 10px 0 0;">Patient Demographic Information</h2>
                

                <div class="onerow">
                    <div class="col4">
                        <label>First Name<span>*</span></label>
					</div>

                    <div class="col4">
						<label>Middle name<span></span></label>
					</div>

                    <div class="col4 last">
						<label>Third Name<span>*</span></label>
					</div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <field><input type="text" id="firstName" name="patient.firstName"
                                      class="required form-textbox1"/></field>
                    </div>
                    <div class="col4">
                        <field><input type="text" id="otherName" name="patient.otherName" class="form-textbox1"/></field>
                    </div>
                    <div class="col4 last">
                        <field><input type="text" id="surName" name="patient.surName" class="required form-textbox1"/></field>

                        <input type="hidden" id="selectedRegFeeValue" name="patient.registration.fee"/>
                        <input type="hidden" id="patientIdnts" name="patient.identifier" value="${patientIdentifier}"/>
                    </div>

                </div>

                <div class="onerow">
                    <div class="col4"><label>Gender<span>*</span></label></div>

                    <div class="col4"><label>Marital Status</label></div>

                    <div class="col4 last"><label>Age or D.O.B<span>*</span></label></div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="patientGender" name="patient.gender" class="required form-combo1">
                                    <option value=""></option>
                                    <option value="M">Male</option>
                                    <option value="F">Female</option>
                                </select>
                            </field>

                        </span>
                    </div>

                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="maritalStatus" name="person.attribute.26" class="form-combo1">
                                    <option value="Marital"></option>
                                    <option value="Single">Single</option>
                                    <option value="Married">Married</option>
                                    <option value="Divorced">Divorced</option>
                                    <option value="Widow">Widow</option>
                                    <option value="Widower">Widower</option>
                                    <option value="Separated">Separated</option>
                                </select>
                            </field>
                        </span>
                    </div>

                    <div class="col4 last">
                        <field>
                            <div class="addon"><i class="icon-calendar small">&nbsp;</i></div>
                            <input type="text" id="birthdate" name="patient.birthdate" class="required form-textbox1"/>
                        </field>
                    </div>
                </div>

                <div class="onerow">&nbsp;
                    <div class="col4"><label>Religion</label></div>

                    <div class="col4">&nbsp;
                        <input type="hidden" id="estimatedAgeInYear" name="estimatedAgeInYear"/>
                    </div>

                    <div class="col4 last">&nbsp;
                        <span id="estimatedAge"/>
                    </div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="patientReligion" name="person.attribute.${personAttributeReligion.id}"
                                        class="form-combo1">
                                </select>
                            </field>
                        </span>
                    </div>

                    <div class="col4">
                        &nbsp;
                    </div>

                    <div class="col4 last">
                        &nbsp;
                    </div>
                </div>

                <div class="onerow">
                    <div class="col4"><label>Nationality</label></div>

                    <div class="col4"><label>National ID:</label></div>

                    <div class="col4 last"><label>Passport No.</label></div>
                </div>


                <div class="onerow">
                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="patientNation" name="person.attribute.27" onchange="showOtherNationality();"
                                        class="form-combo1">
                                    <option value="Kenya">Kenya</option>
                                    <option value="East Africa">East Africa</option>
                                    <option value="Kenyan">Africa</option>
                                    <option value="Algeria">Algeria</option>
                                    <option value="Angola">Angola</option>
                                    <option value="Benin">Benin</option>
                                    <option value="Botswana">Botswana</option>
                                    <option value="Burkina Faso">Burkina Faso</option>
                                    <option value="Burundi">Burundi</option>
                                    <option value="Cameroon">Cameroon</option>
                                    <option value="Cape Verde">Cape Verde</option>
                                    <option value="Central African Republic">Central African Republic</option>
                                    <option value="Chad">Chad</option>
                                    <option value="Comoros">Comoros</option>
                                    <option value="Cote d'Ivoire">Cote d'Ivoire</option>
                                    <option value="Democratic Republic of Congo">Democratic Republic of Congo</option>
                                    <option value="Djibouti">Djibouti</option>
                                    <option value="Egypt">Egypt</option>
                                    <option value="Equatorial Guinea">Equatorial Guinea</option>
                                    <option value="Eritrea">Eritrea</option>
                                    <option value="Ethiopia">Ethiopia</option>
                                    <option value="Gabon">Gabon</option>
                                    <option value="Gambia">Gambia</option>
                                    <option value="Ghana">Ghana</option>
                                    <option value="Guinea">Guinea</option>
                                    <option value="Guinea-Bissau">Guinea-Bissau</option>
                                    <option value="Lesotho">Lesotho</option>
                                    <option value="Liberia">Liberia</option>
                                    <option value="Libya">Libya</option>
                                    <option value="Madagascar">Madagascar</option>
                                    <option value="Malawi">Malawi</option>
                                    <option value="Mali">Mali</option>
                                    <option value="Mauritania">Mauritania</option>
                                    <option value="Mauritius">Mauritius</option>
                                    <option value="Morocco">Morocco</option>
                                    <option value="Mozambique">Mozambique</option>
                                    <option value="Namibia">Namibia</option>
                                    <option value="Niger">Niger</option>
                                    <option value="Nigeria">Nigeria</option>
                                    <option value="Republic of Congo">Republic of Congo</option>
                                    <option value="Rwanda">Rwanda</option>
                                    <option value="Sao Tome and Principe">Sao Tome and Principe</option>
                                    <option value="Senegal">Senegal</option>
                                    <option value="Seychelles">Seychelles</option>
                                    <option value="Sierra Leone">Sierra Leone</option>
                                    <option value="Somalia">Somalia</option>
                                    <option value="South Africa">South Africa</option>
                                    <option value="South Sudan">South Sudan</option>
                                    <option value="Sudan">Sudan</option>
                                    <option value="Swaziland">Swaziland</option>
                                    <option value="Tanzania">Tanzania</option>
                                    <option value="Togo">Togo</option>
                                    <option value="Tunisia">Tunisia</option>
                                    <option value="Uganda">Uganda</option>
                                    <option value="Zambia">Zambia</option>
                                    <option value="Zimbabwe">Zimbabwe</option>
                                    <option value="Other">Other</option>
                                </select>
                            </field>
                        </span>
                    </div>

                    <div class="col4">
                        <field>
                            <input type="text" id="patientNationalId" name="person.attribute.20"
                                   onblur="submitNationalID();" class="form-textbox1"/>
                        </field>
                        <span type="text" style="color: red;" id="nationalIdValidationMessage"></span>

                        <div id="divForNationalId"></div>
                    </div>

                    <div class="col4 last">
                        <field>
                            <input type="text" id="passportNumber" name="person.attribute.38"
                                   onblur="submitPassportNumber();" class="form-textbox1"/>
                        </field>
                        <span style="color: red;" id="passportNumberValidationMessage"></span>

                        <div id="divForpassportNumber"></div>
                    </div>
                </div>

                <div class="onerow">
                    <div class="col4" style="padding-top: 5px;">
                        <span id="otherNationality">
                            <label for="otherNationalityId" style="margin:0px;">Specify Other</label>
                            <field><input type="text" id="otherNationalityId" name="person.attribute.39"
                                          placeholder="Please specify" class="form-textbox"/></field>

                        </span>
                    </div>

                    <div class="col4">&nbsp;</div>

                    <div class="col4 last">&nbsp;</div>
                </div>

                <div class="onerow" style="margin-top: 50px">
                    <a class="button confirm" style="float:right; display:inline-block;" onclick="goto_next_tab(1);">
                        <span>NEXT PAGE</span>
                    </a>
                </div>
           

                <div class="selectdiv" id="selected-diagnoses"></div>

            </fieldset>
            <fieldset style="min-width: 500px; width: auto" class="no-confirmation">
                <legend>Contact Info</legend>

                <h2 style="margin: 10px 0 0;">Patient Contact Information</h2>

                <div class="onerow">
                    <div class="col4"><label>Contact Number</label></div>

                    <div class="col4"><label>Email Address</label></div>

                    <div class="col4 last"><label>Physical Address <span>*</span></label></div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <field><input type="text" id="patientPhoneNumber" name="person.attribute.16"
                                      class="form-textbox1"/></field>
                    </div>

                    <div class="col4">
                        <field><input type="text" id="patientEmail" name="person.attribute.37" class="form-textbox1"/>
                        </field>
                    </div>

                    <div class="col4 last">
                        <field><input type="text" id="patientPostalAddress" name="patient.address.postalAddress"
                                      class="required form-textbox1" placeholder="Village /Estate /Landmark"/></field>
                    </div>
                </div>

                <div class="onerow">
                    <div class="col4"><label>County</label></div>

                    <div class="col4"><label>Sub-County</label></div>

                    <div class="col4 last"><label>Ward</label></div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="districts" name="patient.address.district" onChange="PAGE.changeDistrict();"
                                        class="form-combo1">
                                </select>
                            </field>
                        </span>
                    </div>

                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="upazilas" name="patient.address.upazila" onChange="PAGE.changeUpazila();"
                                        class="form-combo1"></select>
                            </field>
                        </span>

                    </div>

                    <div class="col4 last">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="locations" name="patient.address.location" class="form-combo1"></select>
                            </field>
                        </span>
                    </div>
                </div>

                
                <h2>&nbsp;</h2>

                <h2>Next of Kin / Informant Details</h2>

                <div class="onerow">
                    <div class="col4"><label>Full Names <span>*</span></label></div>

                    <div class="col4"><label>Relationship <span>*</span></label></div>

                    <div class="col4 last"><label>Telephone Number</label></div>
                </div>

                <div class="onerow">
                    <div class="col4">
                        <field><input type="text" id="patientRelativeName" name="person.attribute.8"
                                      class="required form-textbox1"/></field>
                    </div>

                    <div class="col4">
                        <span class="select-arrow" style="width: 100%">
                            <field>
                                <select id="relationshipType" name="person.attribute.15"
                                        class="required form-combo1">
                                    <option value=""></option>
                                    <option value="Parent">Parent</option>
                                    <option value="Spouse">Spouse</option>
                                    <option value="Guardian">Guardian</option>
                                    <option value="Friend">Friend</option>
                                    <option value="Other">Other</option>
                                </select>
                            </field>
                        </span>
                    </div>

                    <div class="col4 last">
						<field>
							<input type="text" id="patientTelephone" name="person.attribute.29"
									  class="form-textbox1"/>
						</field>
                    </div>
                </div>

                <div class="onerow" style="margin-top: 50px">
					<label style="margin-top: 0px">Physical Address</label>
					
					<field>
						<textarea type="text" id="relativePostalAddress" name="person.attribute.28"
								  class="form-textbox1" style="height: 80px; width: 700px;" placeholder="Village /Estate /Landmark"></textarea>
					</field>
				
					<field>
						<label><input id="sameAddress" type="checkbox" style="margin-top: 5px"/>Same as Patient</label>
					</field>
                </div>

                <div class="onerow" style="margin-top: 50px">
                    <a class="button task" onclick="goto_previous_tab(2);">
                        <span style="padding: 15px;">PREVIOUS</span>
                    </a>

                    <a class="button confirm" style="float:right; display:inline-block;" onclick="goto_next_tab(2);">
                        <span>NEXT PAGE</span>
                    </a>
                </div>
            </fieldset>

            <fieldset class="no-confirmation">
                <legend>Patient Category</legend>

                <div>
                    <h2>Patient Category</h2>

                    <div class="onerow">
                        <div class="col4">
                            <div class="tasks">
                                <header class="tasks-header">
                                    <span class="tasks-title">Patients Category</span>
                                    <a class="tasks-lists"></a>
                                </header>

                                <div class="tasks-list">
                                    <label class="tasks-list-item">
                                        <input style="display:none!important" type="radio" name="paym_1" value="1"
                                               class="tasks-list-cb">
                                        <span class="tasks-list-mark"></span>
                                        <span class="tasks-list-desc">PAYING</span>
                                    </label>
                                    <label class="tasks-list-item">
                                        <input style="display:none!important" type="radio" name="paym_1" value="2"
                                               class="tasks-list-cb">
                                        <span class="tasks-list-mark"></span>
                                        <span class="tasks-list-desc">NON-PAYING</span>
                                    </label>
                                    <label class="tasks-list-item">
                                        <input style="display:none!important" type="radio" name="paym_1" value="3"
                                               class="tasks-list-cb">
                                        <span class="tasks-list-mark"></span>
                                        <span class="tasks-list-desc">SPECIAL SCHEMES</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="col4">
                            <div class="tasks">
                                <header class="tasks-header">
                                    <span id="tasktitle" class="tasks-title">Paying Category</span>
                                    <a class="tasks-lists"></a>
                                </header>

                                <div class="tasks-list" id="paycatgs">
                                    
                                </div>
                            </div>
                        </div>

                        <div class="col4 last">
                            <div class="tasks">
                                <header class="tasks-header">
                                    <span id="summtitle1" class="tasks-title">Details</span>
                                    <input type="hidden" id="nhifNumber" name="person.attribute.34" />
                                    <input type="hidden" id="studentId" name="person.attribute.42" />
                                     <input type="hidden" id="waiverNumber" name="person.attribute.32" />
                                    <a class="tasks-lists"></a>
                                </header>
                            </div>

                            <span id="universitydiv" class="select-arrow" style="width: 100%">
                                <field><select style="width: 101%;" name="person.attribute.47"
                                               id="university">&nbsp;</select></field>
                            </span>

                            <field><input type="text" id="modesummary" name="modesummary" value="N/A"
                                          placeholder="WAIVER NUMBER" readonly="" style="width: 101%!important"/>
                            </field>
                        </div>
                    </div>

                    <h2>&nbsp;</h2>
                    <h2>Legal Information</h2>

                    <div class="onerow">
                        <div class="col4">
                            <label for="legal1" style="margin:0px;">Medical Legal Case<span>*</span></label>
                        </div>

                        <div class="col4">
                            <label id="formlc" for="mlc" style="margin:0px;">Case Description<span>*</span></label>
                        </div>

                        <div class="col4 last"></div>
                    </div>

                    <div class="onerow">
                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="legal1" name="legal1" onchange="LoadLegalCases();">
                                        <option value="0">Select Option</option>
                                        <option value="1">YES</option>
                                        <option value="2">NO</option>
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="mlc" name="patient.mlc">
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4 last"></div>
                    </div>
					
					<h2>&nbsp;</h2>
                    <h2>Referral Information</h2>

                    <div class="onerow">
                        <div class="col4">
                            <label for="refer1" style="margin:0px;">Patient Referred<span>*</span></label>
                        </div>

                        <div class="col4">
                            <label id="forReferralType" for="referralType" style="margin:0px;">Referral Type<span></span></label>
                        </div>

                        <div class="col4 last">
                            &nbsp;
                        </div>
                    </div>

                    <div class="onerow">
                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="refer1" name="refer1" onchange="LoadReferralCases();">
                                        <option value="0">Select Option</option>
                                        <option value="1">YES</option>
                                        <option value="2">NO</option>
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="referralType" name="patient.referred.reason">
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4 last">
                            &nbsp;
                        </div>
                    </div>
					
					 <div class="onerow referraldiv" style="margin-top:50px;">
                        <div class="col4">
                            <label for="refer1" style="margin:0px;">Referred From</label>
                        </div>

                        <div class="col4">
                            <label id="forReferredFrom" for="referredFrom" style="margin:0px;">Facility Type<span></span></label>
                        </div>

                        <div class="col4 last">
                            <label for="referralType" style="margin:0px;">Facility Name</label>
                        </div>
                    </div>
					
					<div class="onerow referraldiv">
                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="referredCounty" name="patient.referred.county">
                                        <option value="0">Select County</option>
                                       
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="referredFrom" name="patient.referred.from">
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4 last">
							<field>
								<input id="referredInstitute" name="patient.referred.facility" class="form-textbox1 focused" type="text" placeholder="Institution Name">
							</field>
                        </div>
                    </div>

                    <div class="onerow referraldiv" id="referraldiv" style="padding-top:-5px; display:none;">
                        <label for="referralDescription" style="margin-top:20px;">Comments</label>
                        <field><textarea type="text" id="referralDescription" name="patient.referred.description"
                                         value="N/A" placeholder="COMMENTS" readonly=""
                                         style="height: 80px; width: 700px;"></textarea></field>
                    </div>

                    <h2>&nbsp;</h2>

                    <h2>Room to Visit</h2>

                    <div class="onerow" style="margin-top:10px;">
                        <div class="col4">
                            <label for="rooms1" id="froom1" style="margin:0px;">Room to Visit<span>*</span></label>
                        </div>

                        <div class="col4">
                            <label for="rooms2" id="froom2" style="margin:0px;">Room Type<span>*</span></label>
                        </div>

                        <div class="col4 last">
                            <label for="rooms3" id="froom3" style="margin:0px;">File Number</label>
                        </div>
                    </div>

                    <div class="onerow">
                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="rooms1" name="rooms1" onchange="LoadRoomsTypes();"
                                            class="required form-combo1">
                                        <option value="">Select Room</option>
                                        <option value="1">TRIAGE ROOM</option>
                                        <option value="2">OPD ROOM</option>
                                        <option value="3">SPECIAL CLINIC</option>
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4">
                            <span class="select-arrow" style="width: 100%">
                                <field>
                                    <select id="rooms2" name="rooms2" class="required form-combo1">
                                    </select>
                                </field>
                            </span>
                        </div>

                        <div class="col4 last">
                            <field><input type="text" id="rooms3" name="rooms3" value="N/A" placeholder="FILE NUMBER"
                                          readonly=""/></field>
                        </div>
                    </div>

                    <div class="onerow" style="display:none!important;">
                        <div class="col4">
                            <input id="paying" type="checkbox" name="person.attribute.14" value="Paying"
                                   checked/> Paying
                        </div>

                        <div class="col4">
                            <input id="nonPaying" type="checkbox" name="person.attribute.14"
                                   value="Non-Paying"/> Non-Paying
                        </div>

                        <div class="col4 last">
                            <input id="specialSchemes" type="checkbox" name="person.attribute.14"
                                   value="Special Schemes"/> Special Schemes
                        </div>

                        <label><input type="checkbox" name="mlcCaseYes" id="mlcCaseYes">MLC Yes</label>
                        <label><input id="mlcCaseNo" type="checkbox" name="mlcCaseNo"/>MLC No</label>
						
                        <label><input id="referredYes" type="checkbox" name="referredYes"/>Refer Yes</label>
                        <label><input id="referredNo" type="checkbox" name="referredNo"/>Refer No</label>

                        <input id="triageRoom" type="checkbox" name="triageRoom"/>
                        <input id="opdRoom" type="checkbox" name="opdRoom"/>
                        <input id="specialClinicRoom" type="checkbox" name="specialClinicRoom"/>
                        <input id="birthdateEstimated" type="text" name="patient.birthdateEstimate"/>
						<input id="chiefdom" class="form-textbox1 focused" type="text" name="person.attribute.41">
                    </div>

                    <div class="onerow" style="display:none!important;">
                        <div class="col4">&nbsp;
                            <span id="payingCategoryField">
                                <span class="select-arrow" style="width: 100%">
                                    <select id="payingCategory" name="person.attribute.44"
                                            onchange="payingCategorySelection();"
                                            class="form-combo1" style="display:block!important"></select></span>
                            </span>

                        </div>

                        <div class="col4">&nbsp;
                            <span id="nonPayingCategoryField">
                                <span class="select-arrow" style="width: 100%">
                                    <select id="nonPayingCategory" name="person.attribute.45"
                                            onchange="nonPayingCategorySelection();"
                                            class="form-combo1" style="display:block!important"></select></span>
                            </span>

                        </div>

                        <div class="col4 last">&nbsp;
                            <span id="specialSchemeCategoryField">
                                <span class="select-arrow" style="width: 100%">
                                    <select id="specialScheme" name="person.attribute.46"
                                            onchange="specialSchemeSelection();"
                                            class="form-combo1" style="display:block!important"></select>
                                </span>

                            </span>
                        </div>
                    </div>


                    <div class="onerow" style="margin-top: 100px">
                        <a class="button task ui-tabs-anchor" onclick="goto_previous_tab(3);">
                            <span style="padding: 15px;">PREVIOUS</span>
                        </a>

                        <a class="button confirm" onclick="PAGE.submit();"
                           style="float:right; display:inline-block; margin-left: 5px;">
                            <span>FINISH</span>
                        </a>

                        <a class="button cancel" onclick="window.location.href = window.location.href"
                           style="float:right; display:inline-block;"/>
                        <span>RESET</span>
                    </a>
                    </div>

                </div>


                <p></p>
            </fieldset>
        </section>

        <div id="confirmation" style="width:74%; padding-top: 0px;">
            <span id="confirmation_label" class="title">Confirmation</span>

            <div class="dashboard onerow">
                <div class="info-section">
                    <div class="info-header">
                        <i class="icon-diagnosis"></i>

                        <h3>Patient Summary</h3>
                    </div>

                    <div class="info-body">
                        <ul>
                            <li><span class="status active"></span>

                                <div>Patient ID:</div>        <small id="summ_idnt">/</small></li>
                            <li><span class="status active"></span>

                                <div>Names:</div>            <small id="summ_name">/</small></li>
                            <li><span class="status active"></span>

                                <div>Age:</div>                <small id="summ_ages">/</small></li>
                            <li><span class="status active"></span>

                                <div>Gender:</div>            <small id="summ_gend">/</small></li>
                            <li><span class="status active"></span>

                                <div>Pay Category:</div>    <small id="summ_pays">/</small></li>
                            <li><span class="status active"></span>

                                <div>Registration Fee:</div>    <small id="summ_fees">/</small></li>
                        </ul>

                    </div>
                </div>
            </div>

            <div class="onerow" style="margin-top: 150px">
                <a class="button task ui-tabs-anchor" onclick="goto_previous_tab(4);">
                    <span style="padding: 15px;">PREVIOUS</span>
                </a>

                <a class="button confirm" onclick="PAGE.submit();"
                   style="float:right; display:inline-block; margin-left: 5px;">
                    <span>FINISH</span>
                </a>

                <a class="button cancel" onclick="window.location.href = window.location.href"
                   style="float:right; display:inline-block;"/>
                <span>RESET</span>
            </a>
            </div>
        </div>
    </form>
</div>
