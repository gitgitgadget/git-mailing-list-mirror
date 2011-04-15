From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 04/11] gitweb.js: Extract and improve datetime handling
Date: Fri, 15 Apr 2011 16:43:58 +0200
Message-ID: <1302878645-458-5-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGV-0002G9-8N
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab1DOOoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:44:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43845 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1DOOoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:38 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2304119wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/Yw7+WX6/3SFrOqo3Jk8NK7ak228KvoPPWo0SBl0hbY=;
        b=Ib77IvIHRBHO6ecgF7dLjwNfjuy0l4h/xF/XJeb37ehr8reesiL0P0pqnrms7s9VI4
         P17bEXjO9kOgd+Jgd/PK1tNihUDT/cKx2ZNkEvFvideKtCqh5mZjJ7bmwn7yS/bnTjco
         VKx9qAgOeO1eyALkO6G6NY8gmBdexd2Dg7G64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oGnhPkrafVG6qCJ2CJMDYqg79TJWMur1EaXKzQFnIcIG1iiLGDn4HK8cDOwHWFrYDX
         4QoBmAAsmZ8M0yhKPmu3PqfvdlfRiKBti24YMmh6cCY4IZ7r6MptSQM8eqXy32tJ4tL0
         uHtjXSZGmaTzFovS3S2mBXBR09Sq871T0Wt2A=
Received: by 10.216.171.133 with SMTP id r5mr7745870wel.91.1302878677239;
        Fri, 15 Apr 2011 07:44:37 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.35
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171602>

Move formatDateISOLocal(epoch, timezone) function (and also helper
timezoneOffset(timezoneInfo) function it requires) from common-lib.js to
datetime.js

Add new functions:
* localTimezoneOffset - to get browser timezone offset in seconds
* localTimezoneInfo   - to get browser timezone in '(+|-)HHMM' format
* formatTimezoneInfo - turn offset in hours and minutes into '(+|-)HHMM'
* parseRFC2822Date - to parse RFC-2822 dates that gitweb uses into epoch
* formatDateRFC2882 - like formatDateISOLocal, only RFC-2822 format

All those functions are meant to be used in future commit
'gitweb: javascript ability to adjust time based on timezone'

An alternative would be to use e.g. Datejs (http://www.datejs.com)
library.


While at it escape '-' in character class inside tzRe regexp, as
recommended by JSLint (http://www.jslint.com).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Unchanged from v1 version.

 gitweb/Makefile                    |    1 +
 gitweb/static/js/lib/common-lib.js |   51 -----------
 gitweb/static/js/lib/datetime.js   |  161 ++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 51 deletions(-)
 create mode 100644 gitweb/static/js/lib/datetime.js

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 0baa9df..403265a 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -117,6 +117,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # js/lib/common-lib.js should be always first, then js/lib/*.js,
 # then the rest of files; js/gitweb.js should be last (if it exists)
 GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
+GITWEB_JSLIB_FILES += static/js/lib/datetime.js
 GITWEB_JSLIB_FILES += static/js/javascript-detection.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index c45454e..d6b0c0d 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -89,57 +89,6 @@ function createRequestObject() {
 
 
 /* ............................................................ */
-/* time and data */
-
-/**
- * used to extract hours and minutes from timezone info, e.g '-0900'
- * @constant
- */
-var tzRe = /^([+-])([0-9][0-9])([0-9][0-9])$/;
-
-/**
- * convert numeric timezone +/-ZZZZ to offset from UTC in seconds
- *
- * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
- * @returns {Number} offset from UTC in seconds for timezone
- *
- * @globals tzRe
- */
-function timezoneOffset(timezoneInfo) {
-	var match = tzRe.exec(timezoneInfo);
-	var tz_sign = (match[1] === '-' ? -1 : +1);
-	var tz_hour = parseInt(match[2],10);
-	var tz_min  = parseInt(match[3],10);
-
-	return tz_sign*(((tz_hour*60) + tz_min)*60);
-}
-
-/**
- * return date in local time formatted in iso-8601 like format
- * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
- *
- * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
- * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
- * @returns {String} date in local time in iso-8601 like format
- */
-function formatDateISOLocal(epoch, timezoneInfo) {
-	// date corrected by timezone
-	var localDate = new Date(1000 * (epoch +
-		timezoneOffset(timezoneInfo)));
-	var localDateStr = // e.g. '2005-08-07'
-		localDate.getUTCFullYear()                 + '-' +
-		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
-		padLeft(localDate.getUTCDate(),    2, '0');
-	var localTimeStr = // e.g. '21:49:46'
-		padLeft(localDate.getUTCHours(),   2, '0') + ':' +
-		padLeft(localDate.getUTCMinutes(), 2, '0') + ':' +
-		padLeft(localDate.getUTCSeconds(), 2, '0');
-
-	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
-}
-
-
-/* ............................................................ */
 /* unquoting/unescaping filenames */
 
 /**#@+
diff --git a/gitweb/static/js/lib/datetime.js b/gitweb/static/js/lib/datetime.js
new file mode 100644
index 0000000..b3dcedb
--- /dev/null
+++ b/gitweb/static/js/lib/datetime.js
@@ -0,0 +1,161 @@
+// Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2011, Jakub Narebski <jnareb@gmail.com>
+
+/**
+ * @fileOverview Datetime manipulation: parsing and formatting
+ * @license GPLv2 or later
+ */
+
+
+/* ............................................................ */
+/* parsing and retrieving datetime related information */
+
+/**
+ * used to extract hours and minutes from timezone info, e.g '-0900'
+ * @constant
+ */
+var tzRe = /^([+\-])([0-9][0-9])([0-9][0-9])$/;
+
+/**
+ * convert numeric timezone +/-ZZZZ to offset from UTC in seconds
+ *
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @returns {Number} offset from UTC in seconds for timezone
+ *
+ * @globals tzRe
+ */
+function timezoneOffset(timezoneInfo) {
+	var match = tzRe.exec(timezoneInfo);
+	var tz_sign = (match[1] === '-' ? -1 : +1);
+	var tz_hour = parseInt(match[2],10);
+	var tz_min  = parseInt(match[3],10);
+
+	return tz_sign*(((tz_hour*60) + tz_min)*60);
+}
+
+/**
+ * return local (browser) timezone as offset from UTC in seconds
+ *
+ * @returns {Number} offset from UTC in seconds for local timezone
+ */
+function localTimezoneOffset() {
+	// getTimezoneOffset returns the time-zone offset from UTC,
+	// in _minutes_, for the current locale
+	return ((new Date()).getTimezoneOffset() * -60);
+}
+
+/**
+ * return local (browser) timezone as numeric timezone '(+|-)HHMM'
+ *
+ * @returns {String} locat timezone as -/+ZZZZ
+ */
+function localTimezoneInfo() {
+	var tzOffsetMinutes = (new Date()).getTimezoneOffset() * -1;
+
+	return formatTimezoneInfo(0, tzOffsetMinutes);
+}
+
+
+/**
+ * Parse RFC-2822 date into a Unix timestamp (into epoch)
+ *
+ * @param {String} date: date in RFC-2822 format, e.g. 'Thu, 21 Dec 2000 16:01:07 +0200'
+ * @returns {Number} epoch i.e. seconds since '00:00:00 1970-01-01 UTC'
+ */
+function parseRFC2822Date(date) {
+	// Date.parse accepts the IETF standard (RFC 1123 Section 5.2.14 and elsewhere)
+	// date syntax, which is defined in RFC 2822 (obsoletes RFC 822)
+	// and returns number of _milli_seconds since January 1, 1970, 00:00:00 UTC
+	return Date.parse(date) / 1000;
+}
+
+
+/* ............................................................ */
+/* formatting date */
+
+/**
+ * format timezone offset as numerical timezone '(+|-)HHMM' or '(+|-)HH:MM'
+ *
+ * @param {Number} hours:    offset in hours, e.g. 2 for '+0200'
+ * @param {Number} [minutes] offset in minutes, e.g. 30 for '-4030';
+ *                           it is split into hours if not 0 <= minutes < 60,
+ *                           for example 1200 would give '+0100';
+ *                           defaults to 0
+ * @param {String} [sep] separator between hours and minutes part,
+ *                       default is '', might be ':' for W3CDTF (rfc-3339)
+ * @returns {String} timezone in '(+|-)HHMM' or '(+|-)HH:MM' format
+ */
+function formatTimezoneInfo(hours, minutes, sep) {
+	minutes = minutes || 0; // to be able to use formatTimezoneInfo(hh)
+	sep = sep || ''; // default format is +/-ZZZZ
+
+	if (minutes < 0 || minutes > 59) {
+		hours = minutes > 0 ? Math.floor(minutes / 60) : Math.ceil(minutes / 60);
+		minutes = Math.abs(minutes - 60*hours); // sign of minutes is sign of hours
+		// NOTE: this works correctly because there is no UTC-00:30 timezone
+	}
+
+	var tzSign = hours >= 0 ? '+' : '-';
+	if (hours < 0) {
+		hours = -hours; // sign is stored in tzSign
+	}
+
+	return tzSign + padLeft(hours, 2, '0') + sep + padLeft(minutes, 2, '0');
+}
+
+/**
+ * return date in local time formatted in iso-8601 like format
+ * 'yyyy-mm-dd HH:MM:SS +/-ZZZZ' e.g. '2005-08-07 21:49:46 +0200'
+ *
+ * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @returns {String} date in local time in iso-8601 like format
+ */
+function formatDateISOLocal(epoch, timezoneInfo) {
+	// date corrected by timezone
+	var localDate = new Date(1000 * (epoch +
+		timezoneOffset(timezoneInfo)));
+	var localDateStr = // e.g. '2005-08-07'
+		localDate.getUTCFullYear()                 + '-' +
+		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
+		padLeft(localDate.getUTCDate(),    2, '0');
+	var localTimeStr = // e.g. '21:49:46'
+		padLeft(localDate.getUTCHours(),   2, '0') + ':' +
+		padLeft(localDate.getUTCMinutes(), 2, '0') + ':' +
+		padLeft(localDate.getUTCSeconds(), 2, '0');
+
+	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
+}
+
+/**
+ * return date in local time formatted in rfc-2822 format
+ * e.g. 'Thu, 21 Dec 2000 16:01:07 +0200'
+ *
+ * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
+ * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
+ * @param {Boolean} [padDay] e.g. 'Sun, 07 Aug' if true, 'Sun, 7 Aug' otherwise
+ * @returns {String} date in local time in rfc-2822 format
+ */
+function formatDateRFC2882(epoch, timezoneInfo, padDay) {
+	// A short textual representation of a month, three letters
+	var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
+	// A textual representation of a day, three letters
+	var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
+	// date corrected by timezone
+	var localDate = new Date(1000 * (epoch +
+		timezoneOffset(timezoneInfo)));
+	var localDateStr = // e.g. 'Sun, 7 Aug 2005' or 'Sun, 07 Aug 2005'
+		days[localDate.getUTCDay()] + ', ' +
+		(padDay ? padLeft(localDate.getUTCDate(),2,'0') : localDate.getUTCDate()) + ' ' +
+		months[localDate.getUTCMonth()] + ' ' +
+		localDate.getUTCFullYear();
+	var localTimeStr = // e.g. '21:49:46'
+		padLeft(localDate.getUTCHours(),   2, '0') + ':' +
+		padLeft(localDate.getUTCMinutes(), 2, '0') + ':' +
+		padLeft(localDate.getUTCSeconds(), 2, '0');
+
+	return localDateStr + ' ' + localTimeStr + ' ' + timezoneInfo;
+}
+
+/* end of datetime.js */
-- 
1.7.3
