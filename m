From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC 3/4] git-instaweb: Put httpd logs in a "$httpd_only" subdirectory
Date: Fri, 28 May 2010 11:55:51 +0530
Message-ID: <1275027952-5057-3-git-send-email-pavan.sss1991@gmail.com>
References: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, chriscool@tuxfamily.org, pasky@ucw.cz,
	jnareb@gmail.com
X-From: git-owner@vger.kernel.org Fri May 28 08:26:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHt1l-0002OT-Qf
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 08:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0E1G0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 02:26:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48237 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab0E1G0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 02:26:35 -0400
Received: by pvg11 with SMTP id 11so254013pvg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=a+EEs+kCDlAP1V5lYXUmMCoNjfCSSgEO0vV38Esbj7w=;
        b=MvwN6QtJZfoi5ESMnmzZw3M4fdDR+vB+s0vuxvVwtqlTb72CLXr4y1hxmscCdMaU0R
         7iAM8IDiBCSED7wDy/ni6AUl8RRa+OBDlgQvVD5MCwgskzKR+dGJZWtU74Z1sQGLWVgv
         f+7DH1ttBHBuxwQ/dfD1azSLr5HcgbM7ureC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nCRmn+DQXu1OT6FUI0dke6kcpa/+mXOZl9xE7ydzguWOMCYOGQIE/20pZlkljOuOzh
         q9NxgfAcwApxxtzecpt0+dFBPpmilWvRvQFur8b+4ZJgdap3Y94oD7gFBjTxYJQCFDoX
         yDajGL0njUmYUadhx9gYkX3MvnKzj0TWz4gCQ=
Received: by 10.141.105.21 with SMTP id h21mr8880619rvm.160.1275027994981;
        Thu, 27 May 2010 23:26:34 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id b10sm1802683rvn.3.2010.05.27.23.26.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 23:26:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.18.gf661c6.dirty
In-Reply-To: <1275027952-5057-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147914>

Resolve full httpd and create "$httpd_only" subdirectory before
writing httpd.conf so that error.log and access.log go into it.

While at it, change apache2 configuration to use logs in a
similiar fashion.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Petr Baudis <pasky@ucw.cz>
---
 git-instaweb.sh |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..f03465c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -206,11 +206,11 @@ server.port = $port
 server.modules = ( "mod_setenv", "mod_cgi" )
 server.indexfiles = ( "gitweb.cgi" )
 server.pid-file = "$fqgitdir/pid"
-server.errorlog = "$fqgitdir/gitweb/error.log"
+server.errorlog = "$fqgitdir/gitweb/$httpd_only/error.log"
 
 # to enable, add "mod_access", "mod_accesslog" to server.modules
 # variable above and uncomment this
-#accesslog.filename = "$fqgitdir/gitweb/access.log"
+#accesslog.filename = "$fqgitdir/gitweb/$httpd_only/access.log"
 
 setenv.add-environment = ( "PATH" => env.PATH )
 
@@ -277,7 +277,6 @@ EOF
 
 apache2_conf () {
 	test -z "$module_path" && module_path=/usr/lib/apache2/modules
-	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
@@ -285,6 +284,8 @@ apache2_conf () {
 ServerName "git-instaweb"
 ServerRoot "$fqgitdir/gitweb"
 DocumentRoot "$fqgitdir/gitweb"
+ErrorLog "$fqgitdir/gitweb/$httpd_only/error.log"
+CustomLog "$fqgitdir/gitweb/$httpd_only/access.log" combined
 PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
@@ -357,8 +358,8 @@ root		$fqgitdir/gitweb
 ports		$port
 index_files	gitweb.cgi
 #ssl_cert	$fqgitdir/gitweb/ssl_cert.pem
-error_log	$fqgitdir/gitweb/error.log
-access_log	$fqgitdir/gitweb/access.log
+error_log	$fqgitdir/gitweb/$httpd_only/error.log
+access_log	$fqgitdir/gitweb/$httpd_only/access.log
 
 #cgi setup
 cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
@@ -406,6 +407,9 @@ gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
 gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
 gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
 
+resolve_full_httpd
+mkdir -p "$fqgitdir/gitweb/$httpd_only"
+
 case "$httpd" in
 *lighttpd*)
 	lighttpd_conf
-- 
1.7.1.18.gf661c6.dirty
