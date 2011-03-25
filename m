From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 3/3] gitweb: Fix parsing of negative fractional timezones in JavaScript
Date: Fri, 25 Mar 2011 22:46:26 +0100
Message-ID: <1301089586-8534-4-git-send-email-jnareb@gmail.com>
References: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 22:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Eqg-0003g1-FX
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084Ab1CYVq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:46:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50419 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab1CYVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:46:52 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so1471195wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=p6VSn3aNRv/19yoi8s+ICDlteqyCfNe4sk4LbpDLGPs=;
        b=KmYztwIM+UxmOoAeglUaCFIoWn6iIcdmYZKbvb/2trm5ehdLWmcU3fPN2IqJMfWiJX
         VHXHtW5l+ICVB7PA8xHz2SQ+ZoRSdNI2iXuHnHIZVcY+N3CvBCneGGOza9ez7HcJ0IAy
         wBsxQQUHNtTDJ23aic4shm0puoQBBBbcjcGV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XWEElm5/ePEQIE3m9RQoyaXSeWRKcP72sjwXovl50VYAsg8hVP604/mTiLBlDDj5Lc
         4URDxmX80BrJI8J5FBLLe9N7rMnsyZZ+9cqEWuEU1iOEMbFNZNnyb/Qjl7zv2AiZ1+f5
         64p+pH3hBQJWLBO+NUnIGjR+OtMwxI64mRrds=
Received: by 10.227.208.202 with SMTP id gd10mr1286302wbb.23.1301089612043;
        Fri, 25 Mar 2011 14:46:52 -0700 (PDT)
Received: from localhost.localdomain (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id g7sm647802wby.14.2011.03.25.14.46.50
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 14:46:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170024>

Extract converting numerical timezone in the form of '(+|-)HHMM' to
timezoneOffset function, and fix parsing of negative fractional
timezones.

This was used to format timestamps in 'blame_incremental' view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/static/js/common-lib.js |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/gitweb/static/js/common-lib.js b/gitweb/static/js/common-lib.js
index 33887d7..cc72d1e 100644
--- a/gitweb/static/js/common-lib.js
+++ b/gitweb/static/js/common-lib.js
@@ -87,7 +87,24 @@ function createRequestObject() {
  * used to extract hours and minutes from timezone info, e.g '-0900'
  * @constant
  */
-var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
+var tzRe = /^([-+])([0-9][0-9])([0-9][0-9])$/;
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
 
 /**
  * return date in local time formatted in iso-8601 like format
@@ -96,14 +113,11 @@ var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
  * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
  * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
  * @returns {String} date in local time in iso-8601 like format
- *
- * @globals tzRe
  */
 function formatDateISOLocal(epoch, timezoneInfo) {
-	var match = tzRe.exec(timezoneInfo);
 	// date corrected by timezone
 	var localDate = new Date(1000 * (epoch +
-		(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
+		timezoneOffset(timezoneInfo)));
 	var localDateStr = // e.g. '2005-08-07'
 		localDate.getUTCFullYear()                 + '-' +
 		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
-- 
1.7.3
