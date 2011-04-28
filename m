From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12/13] gitweb.js: Add UI for selecting common timezone to display dates
Date: Thu, 28 Apr 2011 21:04:10 +0200
Message-ID: <1304017451-12283-13-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWt-0003bl-Ld
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435Ab1D1TFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:05:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396Ab1D1TFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:05:00 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=53RWhQ9jEiXz95FnCMJKuRkI7AJpfZ0sm7SMcAxmLb4=;
        b=s1nVTdjJlSL8Jfki/n1Af0SN4bXXlHk9SUiBjW3UkoK0Oz+Z1beDzZOCRL8M3qQqa9
         A9M52eswYQNmHz5KeotJhUBkM6+8olZuI702oVzsuQ8cMzjb8zGzCLJybbLHajL8mScx
         UAznLtWpqVjbc7+e3cUBT8pzjyfMif5N2j/zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HPIhyI0fA6zEUa2VM7jmXctyTIYHqVuIFzrLaC8Djdyg2RCo+aWctQaRnt9xYzVMKj
         u+eihfDwEVJIjkgkLdW/TyKR+pJimem8V4Z3qRjnodYmcwiGPqIsKYTrKVKJG+Yzfdak
         DUUS5mulVR3cX0+61N4TZle67qK8x+BXIFsQg=
Received: by 10.227.140.67 with SMTP id h3mr3900361wbu.80.1304017499918;
        Thu, 28 Apr 2011 12:04:59 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.57
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172395>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This will modify HTML, add CSS rules and add DOM event handlers so
that clicking on any date (the common part, not the localtime part)
will display a drop down menu to choose the timezone to change to.

Currently menu displays only the following timezones:

  utc
  local
  -1200
  -1100
  ...
  +1100
  +1200
  +1300
  +1400

In timezone selection menu each timezone is +1hr to the previous.  The
code is capable of handling fractional timezones, but those have not
been added to the menu.

All changes are saved to a cookie, so page changes and closing /
reopening browser retains the last known timezone setting used.

[jn: Changed from innerHTML to DOM, moved to event delegation for
onclick to trigger menu, added close button and cookie refreshing]

Helped-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from v2 version:
~~~~~~~~~~~~~~~~~~~~~~~~
* Removed setting of .onblur handler for timezone SELECT element, as
  this (probably) caused problems in Chromium / Google Chrome.  Namely,
  timezone selection didn't work in (at least) Chromium 6.0.472.62 (59676)
  and Google Chrome 10.0.648.204:

    Uncaught Error: NOT_FOUND_ERR: DOM Exception 8
      removeChangeTZForm
      /gitweb-static/gitweb.js:785
    onTZFormChange

    line 785: var removed = container.removeChild(popup);

  Using debugger from Google Chrome I found that somehow container
  becomes DocumentFragment instead of 'span.datetime' element...

  Without this line (deleted in this patch from v2 version)

    select.onblur = closeTZFormHandler(documentFragment, tzClassName);

  in createChangeTZForm() function, just below setting select.onchange,
  it works correctly in those browsers.

  This change was send as

     [PATCHv3 10/11] gitweb.js: Add UI for selecting common timezone to display dates
     http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171632

* Just in case we now use safer

     popup.parentNode.removeChild(popup);

  form rather than

     container.removeChild(popup);

  where somehow container === popup.parentNode assertion got broken in
  Chrome / Chromium.

  This recommendation comes from "Professional JavaScript for Web
  Developers" book by Nicholas C. Zakas.


Changes from J.H. patch:
~~~~~~~~~~~~~~~~~~~~~~~~
* In J.H. patch to display timezone menu you had to click small "+"
  beside date, that was added for each date using JavaScript.

  In this patch to display timezone menu you have to click anywhere
  on date, as hinted by title='Click to change timezone' added to
  those elements via JavaScript, and link-like view on :hover
  via CSS added with JavaScript.

* In J.H. patch clicking on "+" was handled with setting onclick for
  each such element:

    <span onclick="clickDate(event.target);" title="+">+</span>

  once for each date (but only for 'log' view there are many dates).

  In this patch clicking on dates is handled via event delegation
  (event capturing for 'document').

* In J.H. patch timezone menu was generated from scratch on each
  click on unopened "+" (which changed to "-" and handled closing)
  by setting target.innerHTML to string generated by concatenation.

  In this patch timezone menu is generated once on page load, and
  only attached on clicking on date.  This menu is generated using
  DOM methods rather than innerHTML -- this is because my ancient
  browser (Mozilla 1.17.12 Gecko/20050923) considers innerHTML
  non-standard with strict mode (XHTML + application/xhtml+xml).

* In J.H. patch to remove timezone menu without selection you had to
  click on "-" (turning it again into "+").

  In this patch to remove timezone menu you had to click '[x]' button
  marked with title='(click on this box to close)'.

* In J.H. patch timezone menu was composed of table.  In this patch it
  is simply <div> element.

* Beside name of cookie, also cookie expiration time (in days) is
  passed from gitweb.perl down to JavaScript code by the way of
  onloadTZSetup argument(s).

On one hand side with current code is hopefully easier to understand
code flow.  On the other hand it uses much more advanced features of
JavaScript: DOM (mainly DOM HTML, with bits of CSS, Style and Core),
event delegation, closures, absolute positioning / visual model.

 gitweb/gitweb.perl                  |    3 +-
 gitweb/static/gitweb.css            |   33 ++++
 gitweb/static/js/adjust-timezone.js |  298 +++++++++++++++++++++++++++++++++--
 gitweb/static/js/lib/common-lib.js  |   27 +++-
 4 files changed, 345 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6651946..b1e80ef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3738,7 +3738,8 @@ sub git_footer_html {
 		      (gitweb_check_feature('javascript-actions') ?
 		      qq!	fixLinks();\n! : '').
 		      # last parameter to onloadTZSetup must be CSS class used by format_timestamp_html
-		      qq!	onloadTZSetup('local', 'gitweb_tz', 'datetime');\n!.
+		      qq!	var tz_cookie = { name: 'gitweb_tz', expires: 14, path: '/' };\n!. # in days
+		      qq!	onloadTZSetup('local', tz_cookie, 'datetime');\n!.
 		      qq!};\n!.
 		      qq!</script>\n!;
 	}
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 79d7eeb..8dd0935 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -579,6 +579,39 @@ div.remote {
 	display: inline-block;
 }
 
+/* JavaScript-based timezone manipulation */
+
+.popup { /* timezone selection UI */
+	position: absolute;
+	/* "top: 0; right: 0;" would be better, if not for bugs in browsers */
+	top: 0; left: 0;
+	border: 1px solid;
+	padding: 2px;
+	background-color: #f0f0f0;
+	font-style: normal;
+	color: #000000;
+	cursor: auto;
+}
+
+.close-button { /* close timezone selection UI without selecting */
+	/* float doesn't work within absolutely positioned container,
+	 * if width of container is not set explicitly */
+	/* float: right; */
+	position: absolute;
+	top: 0px; right: 0px;
+	border:  1px solid green;
+	margin:  1px 1px 1px 1px;
+	padding-bottom: 2px;
+	width:     12px;
+	height:    10px;
+	font-size:  9px;
+	font-weight: bold;
+	text-align: center;
+	background-color: #fff0f0;
+	cursor: pointer;
+}
+
+
 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
 
 /* Highlighting theme definition: */
diff --git a/gitweb/static/js/adjust-timezone.js b/gitweb/static/js/adjust-timezone.js
index 1577d78..0c67779 100644
--- a/gitweb/static/js/adjust-timezone.js
+++ b/gitweb/static/js/adjust-timezone.js
@@ -7,34 +7,51 @@
  */
 
 /**
- * Get common timezone and adjust dates to use this common timezone.
+ * Get common timezone, add UI for changing timezones, and adjust
+ * dates to use requested common timezone.
  *
  * This function is called during onload event (added to window.onload).
  *
  * @param {String} tzDefault: default timezone, if there is no cookie
- * @param {String} tzCookieName: name of cookie to store timezone
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzCookieInfo.name: name of cookie to store timezone
  * @param {String} tzClassName: denotes elements with date to be adjusted
  */
-function onloadTZSetup(tzDefault, tzCookieName, tzClassName) {
-	var tzCookie = getCookie(tzCookieName);
-	var tz = tzCookie ? tzCookie : tzDefault;
+function onloadTZSetup(tzDefault, tzCookieInfo, tzClassName) {
+	var tzCookieTZ = getCookie(tzCookieInfo.name, tzCookieInfo);
+	var tz = tzDefault;
+
+	if (tzCookieTZ) {
+		// set timezone to value saved in a cookie
+		tz = tzCookieTZ;
+		// refresh cookie, so its expiration counts from last use of gitweb
+		setCookie(tzCookieInfo.name, tzCookieTZ, tzCookieInfo);
+	}
+
+	// add UI for changing timezone
+	addChangeTZ(tz, tzCookieInfo, tzClassName);
 
 	// server-side of gitweb produces datetime in UTC,
 	// so if tz is 'utc' there is no need for changes
-	if (tz !== 'utc') {
-		fixDatetimeTZ(tz, tzClassName);
-	}
+	var nochange = tz === 'utc';
+
+	// adjust dates to use specified common timezone
+	fixDatetimeTZ(tz, tzClassName, nochange);
 }
 
 
+/* ...................................................................... */
+/* Changing dates to use requested timezone */
+
 /**
  * Replace RFC-2822 dates contained in SPAN elements with tzClassName
  * CSS class with equivalent dates in given timezone.
  *
  * @param {String} tz: numeric timezone in '(-|+)HHMM' format, or 'utc', or 'local'
  * @param {String} tzClassName: specifies elements to be changed
+ * @param {Boolean} nochange: markup for timezone change, but don't change it
  */
-function fixDatetimeTZ(tz, tzClassName) {
+function fixDatetimeTZ(tz, tzClassName, nochange) {
 	// sanity check, method should be ensured by common-lib.js
 	if (!document.getElementsByClassName) {
 		return;
@@ -48,13 +65,266 @@ function fixDatetimeTZ(tz, tzClassName) {
 	for (var i = 0, len = classesFound.length; i < len; i++) {
 		var curElement = classesFound[i];
 
-		// we use *.firstChild.data (W3C DOM) instead of *.innerHTML
-		// as the latter doesn't always work everywhere in every browser
-		var epoch = parseRFC2822Date(curElement.firstChild.data);
-		var adjusted = formatDateRFC2882(epoch, tz);
+		curElement.title = 'Click to change timezone';
+		if (!nochange) {
+			// we use *.firstChild.data (W3C DOM) instead of *.innerHTML
+			// as the latter doesn't always work everywhere in every browser
+			var epoch = parseRFC2822Date(curElement.firstChild.data);
+			var adjusted = formatDateRFC2882(epoch, tz);
+
+			curElement.firstChild.data = adjusted;
+		}
+	}
+}
+
+
+/* ...................................................................... */
+/* Adding triggers, generating timezone menu, displaying and hiding */
+
+/**
+ * Adds triggers for UI to change common timezone used for dates in
+ * gitweb output: it marks up and/or creates item to click to invoke
+ * timezone change UI, creates timezone UI fragment to be attached,
+ * and installs appropriate onclick trigger (via event delegation).
+ *
+ * @param {String} tzSelected: pre-selected timezone,
+ *                             'utc' or 'local' or '(-|+)HHMM'
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzClassName: specifies elements to install trigger
+ */
+function addChangeTZ(tzSelected, tzCookieInfo, tzClassName) {
+	// make link to timezone UI discoverable
+	addCssRule('.'+tzClassName + ':hover',
+	           'text-decoration: underline; cursor: help;');
+
+	// create form for selecting timezone (to be saved in a cookie)
+	var tzSelectFragment = document.createDocumentFragment();
+	tzSelectFragment = createChangeTZForm(tzSelectFragment,
+	                                      tzSelected, tzCookieInfo, tzClassName);
+
+	// event delegation handler for timezone selection UI (clicking on entry)
+	// see http://www.nczonline.net/blog/2009/06/30/event-delegation-in-javascript/
+	// assumes that there is no existing document.onclick handler
+	document.onclick = function onclickHandler(event) {
+		//IE doesn't pass in the event object
+		event = event || window.event;
+
+		//IE uses srcElement as the target
+		var target = event.target || event.srcElement;
+
+		switch (target.className) {
+		case tzClassName:
+			// don't display timezone menu if it is already displayed
+			if (tzSelectFragment.childNodes.length > 0) {
+				displayChangeTZForm(target, tzSelectFragment);
+			}
+			break;
+		} // end switch
+	};
+}
+
+/**
+ * Create DocumentFragment with UI for changing common timezone in
+ * which dates are shown in.
+ *
+ * @param {DocumentFragment} documentFragment: where attach UI
+ * @param {String} tzSelected: default (pre-selected) timezone
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @returns {DocumentFragment}
+ */
+function createChangeTZForm(documentFragment, tzSelected, tzCookieInfo, tzClassName) {
+	var div = document.createElement("div");
+	div.className = 'popup';
+
+	/* '<div class="close-button" title="(click on this box to close)">X</div>' */
+	var closeButton = document.createElement('div');
+	closeButton.className = 'close-button';
+	closeButton.title = '(click on this box to close)';
+	closeButton.appendChild(document.createTextNode('X'));
+	closeButton.onclick = closeTZFormHandler(documentFragment, tzClassName);
+	div.appendChild(closeButton);
+
+	/* 'Select timezone: <br clear="all">' */
+	div.appendChild(document.createTextNode('Select timezone: '));
+	var br = document.createElement('br');
+	br.clear = 'all';
+	div.appendChild(br);
+
+	/* '<select name="tzoffset">
+	 *    ...
+	 *    <option value="-0700">UTC-07:00</option>
+	 *    <option value="-0600">UTC-06:00</option>
+	 *    ...
+	 *  </select>' */
+	var select = document.createElement("select");
+	select.name = "tzoffset";
+	//select.style.clear = 'all';
+	select.appendChild(generateTZOptions(tzSelected));
+	select.onchange = selectTZHandler(documentFragment, tzCookieInfo, tzClassName);
+	div.appendChild(select);
+
+	documentFragment.appendChild(div);
+
+	return documentFragment;
+}
+
+
+/**
+ * Hide (remove from DOM) timezone change UI, ensuring that it is not
+ * garbage collected and that it can be re-enabled later.
+ *
+ * @param {DocumentFragment} documentFragment: contains detached UI
+ * @param {HTMLSelectElement} target: select element inside of UI
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {DocumentFragment} documentFragment
+ */
+function removeChangeTZForm(documentFragment, target, tzClassName) {
+	// find containing element, where we appended timezone selection UI
+	// `target' is somewhere inside timezone menu
+	var container = target.parentNode, popup = target;
+	while (container &&
+	       container.className !== tzClassName) {
+		popup = container;
+		container = container.parentNode;
+	}
+	// safety check if we found correct container,
+	// and if it isn't deleted already
+	if (!container || !popup ||
+	    container.className !== tzClassName ||
+	    popup.className     !== 'popup') {
+		return documentFragment;
+	}
 
-		curElement.firstChild.data = adjusted;
+	// timezone selection UI was appended as last child
+	// see also displayChangeTZForm function
+	var removed = popup.parentNode.removeChild(popup);
+	if (documentFragment.firstChild !== removed) { // the only child
+		// re-append it so it would be available for next time
+		documentFragment.appendChild(removed);
 	}
+	// all of inline style was added by this script
+	// it is not really needed to remove it, but it is a good practice
+	container.removeAttribute('style');
+
+	return documentFragment;
+}
+
+
+/**
+ * Display UI for changing common timezone for dates in gitweb output.
+ * To be used from 'onclick' event handler.
+ *
+ * @param {HTMLElement} target: where to install/display UI
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ */
+function displayChangeTZForm(target, tzSelectFragment) {
+	// for absolute positioning to be related to target element
+	target.style.position = 'relative';
+	target.style.display = 'inline-block';
+
+	// show/display UI for changing timezone
+	target.appendChild(tzSelectFragment);
+}
+
+
+/* ...................................................................... */
+/* List of timezones for timezone selection menu */
+
+/**
+ * Generate list of timezones for creating timezone select UI
+ *
+ * @returns {Object[]} list of e.g. { value: '+0100', descr: 'GMT+01:00' }
+ */
+function generateTZList() {
+	var timezones = [
+		{ value: "utc",   descr: "UTC/GMT"},
+		{ value: "local", descr: "Local (per browser)"}
+	];
+
+	// generate all full hour timezones (no fractional timezones)
+	for (var x = -12, idx = timezones.length; x <= +14; x++, idx++) {
+		var hours = (x >= 0 ? '+' : '-') + padLeft(x >=0 ? x : -x, 2);
+		timezones[idx] = { value: hours + '00', descr: 'UTC' + hours + ':00'};
+		if (x === 0) {
+			timezones[idx].descr = 'UTC\u00B100:00'; // 'UTC&plusmn;00:00'
+		}
+	}
+
+	return timezones;
+}
+
+/**
+ * Generate <options> elements for timezone select UI
+ *
+ * @param {String} tzSelected: default timezone
+ * @returns {DocumentFragment} list of options elements to appendChild
+ */
+function generateTZOptions(tzSelected) {
+	var elems = document.createDocumentFragment();
+	var timezones = generateTZList();
+
+	for (var i = 0, len = timezones.length; i < len; i++) {
+		var tzone = timezones[i];
+		var option = document.createElement("option");
+		if (tzone.value === tzSelected) {
+			option.defaultSelected = true;
+		}
+		option.value = tzone.value;
+		option.appendChild(document.createTextNode(tzone.descr));
+
+		elems.appendChild(option);
+	}
+
+	return elems;
+}
+
+
+/* ...................................................................... */
+/* Event handlers and/or their generators */
+
+/**
+ * Create event handler that select timezone and closes timezone select UI.
+ * To be used as $('select[name="tzselect"]').onchange handler.
+ *
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ * @param {Object} tzCookieInfo: object literal with info about cookie to store timezone
+ * @param {String} tzCookieInfo.name: name of cookie to save result of selection
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {Function} event handler
+ */
+function selectTZHandler(tzSelectFragment, tzCookieInfo, tzClassName) {
+	//return function selectTZ(event) {
+	return function (event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		var selected = target.options.item(target.selectedIndex);
+		removeChangeTZForm(tzSelectFragment, target, tzClassName);
+
+		if (selected) {
+			selected.defaultSelected = true;
+			setCookie(tzCookieInfo.name, selected.value, tzCookieInfo);
+			fixDatetimeTZ(selected.value, tzClassName);
+		}
+	};
+}
+
+/**
+ * Create event handler that closes timezone select UI.
+ * To be used e.g. as $('.closebutton').onclick handler.
+ *
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {Function} event handler
+ */
+function closeTZFormHandler(tzSelectFragment, tzClassName) {
+	//return function closeTZForm(event) {
+	return function (event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		removeChangeTZForm(tzSelectFragment, target, tzClassName);
+	};
 }
 
 /* end of adjust-timezone.js */
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index b371391..018bbb7 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -64,7 +64,7 @@ function padLeft(input, width, ch) {
 
 
 /* ............................................................ */
-/* Ajax */
+/* Handling browser incompatibilities */
 
 /**
  * Create XMLHttpRequest object in cross-browser way
@@ -88,6 +88,31 @@ function createRequestObject() {
 }
 
 
+/**
+ * Insert rule giving specified STYLE to given SELECTOR at the end of
+ * first CSS stylesheet.
+ *
+ * @param {String} selector: CSS selector, e.g. '.class'
+ * @param {String} style: rule contents, e.g. 'background-color: red;'
+ */
+function addCssRule(selector, style) {
+	var stylesheet = document.styleSheets[0];
+
+	var theRules = [];
+	if (stylesheet.cssRules) {     // W3C way
+		theRules = stylesheet.cssRules;
+	} else if (stylesheet.rules) { // IE way
+		theRules = stylesheet.rules;
+	}
+
+	if (stylesheet.insertRule) {    // W3C way
+		stylesheet.insertRule(selector + ' { ' + style + ' }', theRules.length);
+	} else if (stylesheet.addRule) { // IE way
+		stylesheet.addRule(selector, style);
+	}
+}
+
+
 /* ............................................................ */
 /* Support for legacy browsers */
 
-- 
1.7.3
