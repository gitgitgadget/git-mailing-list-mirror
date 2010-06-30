From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/3] git-instaweb: Don't assume Apache executable is named apache2
Date: Tue, 29 Jun 2010 21:45:00 -0500
Message-ID: <1277865900-25044-3-git-send-email-dpmcgee@gmail.com>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 04:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTnIt-0007N6-Iz
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab0F3CpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:45:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60666 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0F3CpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:45:17 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so365968iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 19:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gbZZavlZImDwr3WmfwOdkXl6XTkJmL7rSUYAapPzzq0=;
        b=IPis9z6KXzP1820XZKFuYYyj5EYuws2QOfypDuJBUAXyiinVtEDCGvjmOnAR0f6WZ3
         G9HcQ7GkpQ+wW0KFks9jPuy0wQuLkhvUygkc1HXojueIKA72P7YOuy1t/gXDsTxq9wdP
         9GwYVfTCifBhpdMLexfA/Vk5qD3eansdO7a4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WIM/ZOoTfXyuXTgEnVbFoLyAz2CXNwQJ/cnYq7q909DaoFQEGIp2lqEC2loNgaAXAg
         9b/XtwA0mT3I+6zEtzMzwEqrfjvMNQt83o6uV3ePWwOmm7dLw3doi6NL7/C9lQ4YeLTD
         ANJk5kRC8QOCnIPGHUYSL8Woyj5igaBDiajCU=
Received: by 10.231.176.75 with SMTP id bd11mr8481311ibb.22.1277865917490;
        Tue, 29 Jun 2010 19:45:17 -0700 (PDT)
Received: from localhost (adsl-76-193-181-63.dsl.chcgil.sbcglobal.net [76.193.181.63])
        by mx.google.com with ESMTPS id u6sm2298510ibu.0.2010.06.29.19.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 19:45:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149940>

On Arch Linux, we keep the original 'httpd' name for the exectuable and
don't rename it or the path to the modules. Remove some of these assumptions
and add the httpd name in where it may be required.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-instaweb.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1d349b8..d0091f2 100755
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
@@ -300,7 +301,10 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	if test -z "$module_path"; then
+		test -d "/usr/lib/httpd/modules" && module_path="/usr/lib/httpd/modules"
+		test -d "/usr/lib/apache2/modules" && module_path="/usr/lib/apache2/modules"
+	fi
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
@@ -563,7 +567,7 @@ case "$httpd" in
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
