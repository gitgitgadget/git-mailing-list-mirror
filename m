From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/3] git-instaweb: Don't assume Apache executable is named apache2
Date: Wed, 30 Jun 2010 07:29:08 -0500
Message-ID: <1277900948-16375-1-git-send-email-dpmcgee@gmail.com>
References: <20100630073153.GA25218@dcvr.yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 14:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTwPr-0002QE-Di
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 14:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453Ab0F3M3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 08:29:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63291 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0F3M3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 08:29:15 -0400
Received: by iwn7 with SMTP id 7so805918iwn.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GSB+KebT1qqayh17CaI9jiLrekfg0vcxj2XsAP48/XM=;
        b=w7ytSUzYNPDj7ld8vKAh2+uTM8bqZqcpq4UIkykEUrjnVLzlU+bSm6+j5Siwq+7cPP
         PphnorocrRmt3h28vYCd/vSUZozdNgNdnSDz70HaR8tJ4xQGx2rE3/aMNSbW+uHLkIbw
         Z5o7pgQb74dz+nIDPj9FdKasdIbFp/b8c8X+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TcrspXZR14NxbVNjJjaPRkMURrxVPX8ZpGK6ouCQYLEyxPu2uAe19RjWp7Sng15X5k
         Xju+5JTyEELUr+vYwDkiR+lqgQ5G7EobVbXdYHV4Qf7hkKj66PqwKMjwDBMnLAUrWBJb
         N4VCJo4vVcqNL2NyKerp5h2uqV+6Qn22SnMXw=
Received: by 10.42.9.3 with SMTP id k3mr2790529ick.32.1277900955007;
        Wed, 30 Jun 2010 05:29:15 -0700 (PDT)
Received: from localhost (adsl-76-193-181-63.dsl.chcgil.sbcglobal.net [76.193.181.63])
        by mx.google.com with ESMTPS id u6sm4482141ibu.0.2010.06.30.05.29.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 05:29:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <20100630073153.GA25218@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149956>

On Arch Linux, we keep the original 'httpd' name for the exectuable and
don't rename it or the path to the modules. Remove some of these assumptions
and add the httpd name in where it may be required. Finally, make some
slight style adjustments to the code we are touching to make it fit the
style of the rest of the script.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Style cleanups as suggested by Eric, at least to the parts of the code I
touched.

-Dan

 git-instaweb.sh |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1d349b8..b7342e2 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -43,7 +43,8 @@ test -z "$port" && port=1234
 
 resolve_full_httpd () {
 	case "$httpd" in
-	*apache2*|*lighttpd*)
+	*apache2*|*lighttpd*|*httpd*)
+		# yes, *httpd* covers *lighttpd* above, but it is there for clarity
 		# ensure that the apache2/lighttpd command ends with "-f"
 		if ! echo "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
 		then
@@ -300,7 +301,13 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	if test -z "$module_path"
+	then
+		test -d "/usr/lib/httpd/modules" &&
+			module_path="/usr/lib/httpd/modules"
+		test -d "/usr/lib/apache2/modules" &&
+			module_path="/usr/lib/apache2/modules"
+	fi
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
@@ -314,8 +321,10 @@ PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
 
-	for mod in mime dir env log_config; do
-		if test -e $module_path/mod_${mod}.so; then
+	for mod in mime dir env log_config
+	do
+		if test -e $module_path/mod_${mod}.so
+		then
 			echo "LoadModule ${mod}_module " \
 			     "$module_path/mod_${mod}.so" >> "$conf"
 		fi
@@ -563,7 +572,7 @@ case "$httpd" in
 *lighttpd*)
 	lighttpd_conf
 	;;
-*apache2*)
+*apache2*|*httpd*)
 	apache2_conf
 	;;
 webrick)
-- 
1.7.1
