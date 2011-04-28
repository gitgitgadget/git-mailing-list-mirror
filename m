From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 07/13] gitweb.js: Introduce code to handle cookies from JavaScript
Date: Thu, 28 Apr 2011 21:04:05 +0200
Message-ID: <1304017451-12283-8-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWa-0003Nk-03
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428Ab1D1TE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54592 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396Ab1D1TEv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:51 -0400
Received: by wya21 with SMTP id 21so2331045wya.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=H4qyeiag67zDvIDlRFRpMWIerKGeLbgSJQAZtnmKzNs=;
        b=jZW6EmrUqjtAiaN8+chGbyi7+dkP8xTL61rFJUT2TNkn8Z8UHAh8B9JzhohUHSMhh5
         i+FrL4tPnpjbUvFFYIKcNdYpfvK2Yj2riYBi+C0u14GzkQr89XUtGxFrZGcBTbmdMaF9
         VQAoQRby6gn3/7Qytwfs5ztK60t3L6Ail/Ywg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R2YG0K+ZCt4NesAhzal9D5RftZpQ15xvcVhrcvgv0+267WkgFNu7pNVU5EgSkrNCnC
         uwGajGUpmlkk9Ky+t+5iQ7SeVl7EtsALh9vFsL04L1DVKCgsKMSh9jJTtVIApN+ia4mg
         joBlCEhpRrXSrGkFGc0wxRAGX9DxvJi2Q3yXM=
Received: by 10.227.179.207 with SMTP id br15mr2034881wbb.191.1304017490334;
        Thu, 28 Apr 2011 12:04:50 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.48
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172388>

Introduced gitweb/static/js/cookies.js file provides functions for
setting, getting and deleting cookies.

Code taken from subsection "Cookies in JavaScript" of "Professional
JavaScript for Web Developers" by Nicholas C. Zakas and from cookie
plugin for jQuery (dual licensed under the MIT and GPL licenses).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.


Instead of setCookieExp and setCookie (with different behaviors) in
J.H. patch, use single setCookie function.  The code in this patch
consistently assumes that the name of cookie doesn't need to be
escaped, and that value of cookie needs to escaped / unescaped
(using encodeURIComponent rather than deprecated escape).

Because remembering which positional parameter (beyond name and value
of cookie) corresponds to which cookie attribute often requires
checking the code, follow convention used in jQery cookie plugin of
using object literal to implement "named parameters".  I think that it
makes setCookie API more clear and easier to use.

Note that J.H.'s gitweb/static/js/cookies.js had a few errors and
gotchas in its implementation:

 * setCookie() didn't escape value of cookie, as it should, but
   perhaps it was not used at all (but then, why it is there?);
   also the values stored doesn't really need escaping.

 * setCookie() wrapped value of cookie in doublequotes '"' for
   some reason; getCookie() doesn't unwrap it.
 
 * setCookieExp() created malformed cookie (though if browsers are
   lenient, it could work in some browsers): it is '; expires=<date>',
   not just ';<date>'

 * getCookie() didn't unescape name of cookie, though setCookieExp()
   did escape it.  It didn't matter for cookie used by gitweb.
   In this patch we assume that names doesn't need to be escaped.

 gitweb/Makefile                 |    1 +
 gitweb/static/js/lib/cookies.js |  114 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/static/js/lib/cookies.js

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 403265a..7dd1dee 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -118,6 +118,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # then the rest of files; js/gitweb.js should be last (if it exists)
 GITWEB_JSLIB_FILES += static/js/lib/common-lib.js
 GITWEB_JSLIB_FILES += static/js/lib/datetime.js
+GITWEB_JSLIB_FILES += static/js/lib/cookies.js
 GITWEB_JSLIB_FILES += static/js/javascript-detection.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
diff --git a/gitweb/static/js/lib/cookies.js b/gitweb/static/js/lib/cookies.js
new file mode 100644
index 0000000..72b51cd
--- /dev/null
+++ b/gitweb/static/js/lib/cookies.js
@@ -0,0 +1,114 @@
+/**
+ * @fileOverview Accessing cookies from JavaScript
+ * @license GPLv2 or later
+ */
+
+/*
+ * Based on subsection "Cookies in JavaScript" of "Professional
+ * JavaScript for Web Developers" by Nicholas C. Zakas and cookie
+ * plugin from jQuery (dual licensed under the MIT and GPL licenses)
+ */
+
+
+/**
+ * Create a cookie with the given name and value,
+ * and other optional parameters.
+ *
+ * @example
+ *   setCookie('foo', 'bar'); // will be deleted when browser exits
+ *   setCookie('foo', 'bar', { expires: new Date(Date.parse('Jan 1, 2012')) });
+ *   setCookie('foo', 'bar', { expires: 7 }); // 7 days = 1 week
+ *   setCookie('foo', 'bar', { expires: 14, path: '/' });
+ *
+ * @param {String} sName:    Unique name of a cookie (letters, numbers, underscores).
+ * @param {String} sValue:   The string value stored in a cookie.
+ * @param {Object} [options] An object literal containing key/value pairs
+ *                           to provide optional cookie attributes.
+ * @param {String|Number|Date} [options.expires] Either literal string to be used as cookie expires,
+ *                            or an integer specifying the expiration date from now on in days,
+ *                            or a Date object to be used as cookie expiration date.
+ *                            If a negative value is specified or a date in the past),
+ *                            the cookie will be deleted.
+ *                            If set to null or omitted, the cookie will be a session cookie
+ *                            and will not be retained when the the browser exits.
+ * @param {String} [options.path] Restrict access of a cookie to particular directory
+ *                               (default: path of page that created the cookie).
+ * @param {String} [options.domain] Override what web sites are allowed to access cookie
+ *                                  (default: domain of page that created the cookie).
+ * @param {Boolean} [options.secure] If true, the secure attribute of the cookie will be set
+ *                                   and the cookie would be accessible only from secure sites
+ *                                   (cookie transmission will require secure protocol like HTTPS).
+ */
+function setCookie(sName, sValue, options) {
+	options = options || {};
+	if (sValue === null) {
+		sValue = '';
+		option.expires = 'delete';
+	}
+
+	var sCookie = sName + '=' + encodeURIComponent(sValue);
+
+	if (options.expires) {
+		var oExpires = options.expires, sDate;
+		if (oExpires === 'delete') {
+			sDate = 'Thu, 01 Jan 1970 00:00:00 GMT';
+		} else if (typeof oExpires === 'string') {
+			sDate = oExpires;
+		} else {
+			var oDate;
+			if (typeof oExpires === 'number') {
+				oDate = new Date();
+				oDate.setTime(oDate.getTime() + (oExpires * 24 * 60 * 60 * 1000)); // days to ms
+			} else {
+				oDate = oExpires;
+			}
+			sDate = oDate.toGMTString();
+		}
+		sCookie += '; expires=' + sDate;
+	}
+
+	if (options.path) {
+		sCookie += '; path=' + (options.path);
+	}
+	if (options.domain) {
+		sCookie += '; domain=' + (options.domain);
+	}
+	if (options.secure) {
+		sCookie += '; secure';
+	}
+	document.cookie = sCookie;
+}
+
+/**
+ * Get the value of a cookie with the given name.
+ *
+ * @param {String} sName: Unique name of a cookie (letters, numbers, underscores)
+ * @returns {String|null} The string value stored in a cookie
+ */
+function getCookie(sName) {
+	var sRE = '(?:; )?' + sName + '=([^;]*);?';
+	var oRE = new RegExp(sRE);
+	if (oRE.test(document.cookie)) {
+		return decodeURIComponent(RegExp['$1']);
+	} else {
+		return null;
+	}
+}
+
+/**
+ * Delete cookie with given name
+ *
+ * @param {String} sName:    Unique name of a cookie (letters, numbers, underscores)
+ * @param {Object} [options] An object literal containing key/value pairs
+ *                           to provide optional cookie attributes.
+ * @param {String} [options.path]   Must be the same as when setting a cookie
+ * @param {String} [options.domain] Must be the same as when setting a cookie
+ */
+function deleteCookie(sName, options) {
+	options = options || {};
+	options.expires = 'delete';
+
+	setCookie(sName, '', options);
+}
+
+/* end of cookies.js */
-- 
1.7.3
