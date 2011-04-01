From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Fix parsing of negative fractional timezones
	in JavaScript
Date: Fri, 01 Apr 2011 21:06:28 +0200
Message-ID: <20110401190239.9686.12000.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 21:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5jgj-0001uu-An
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab1DATHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 15:07:08 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43770 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab1DATHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 15:07:07 -0400
Received: by wwk4 with SMTP id 4so890128wwk.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=fzbFmklJVn5Re1Nq2/N5M8YYv0cvyl7i/W8ig1pOmeA=;
        b=gA57iozAfKQP01BTSgGtqobrF5R/RdsfW/i9P7BgEnUV6r4GxAjK7sUR845ZDjSJ1u
         aeGQTzQG1PG9eIoUHfg3AkAgat2v/93OO4G90TECxydgUWvmC+AGdGm4J3eLQVj7+imD
         vAcDrRlQnWMlQwPu0QlfU2dwn8ToCGBFdx7x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=aLO4Kl2/879TVCs3bhWs9cPVBL1t7/JFUIRCO8c7hqAAWL4OaYvb1lx6up4X9niuoD
         cZh9ecH7VkrMKwOezErLm+BprGq6WkoLtyba2vL9rZyIbSNUNZGOLKLHlwQCHLkQ9+9R
         mk6L/HVJInp2a09AWEiKBJtnjWDOt58Tb7+KE=
Received: by 10.227.169.76 with SMTP id x12mr4455836wby.155.1301684825472;
        Fri, 01 Apr 2011 12:07:05 -0700 (PDT)
Received: from localhost.localdomain (abvl248.neoplus.adsl.tpnet.pl [83.8.209.248])
        by mx.google.com with ESMTPS id bs4sm1441783wbb.18.2011.04.01.12.07.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 12:07:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p31J6SMD009735;
	Fri, 1 Apr 2011 21:06:43 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170606>

Extract converting numerical timezone in the form of '(+|-)HHMM' to
timezoneOffset function, and fix parsing of negative fractional
timezones.

This is used to format timestamps in 'blame_incremental' view; this
complements commit 2b1e172 (gitweb: Fix handling of fractional
timezones in parse_date, 2011-03-25).

Now

  gitweb.cgi/git.git/blame_incremental/3fe5489:/contrib/gitview/gitview#l853

and

  gitweb.cgi/git.git/blame/3fe5489:/contrib/gitview/gitview#l853

show the same correct time in author's local timezone in title
(on mouseover) [Aneesh Kumar K.V, 2006-02-24 00:59:42 +0530].

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was send earlier as part 3/3 of 

  "[PATCH/RFC 0/3] gitweb: Split gitweb.js, improve JavaScript"
  Message-Id: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/170021/focus=170024

It is now send separately as standalone patch, and is not held hostage
to accepting series that splits gitweb JavaScript file.

 gitweb/static/gitweb.js |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/gitweb/static/gitweb.js b/gitweb/static/gitweb.js
index 9c66928..40ec084 100644
--- a/gitweb/static/gitweb.js
+++ b/gitweb/static/gitweb.js
@@ -399,7 +399,24 @@ function fixColorsAndGroups() {
  * used to extract hours and minutes from timezone info, e.g '-0900'
  * @constant
  */
-var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
+var tzRe = /^([+-])([0-9][0-9])([0-9][0-9])$/;
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
@@ -408,14 +425,11 @@ var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
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
