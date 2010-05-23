From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv3 GSoC] git-instaweb: Configure it to work with new gitweb structure
Date: Sun, 23 May 2010 13:02:48 +0530
Message-ID: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	normalperson@yhbt.net, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun May 23 09:36:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG5j7-0002MO-Gl
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 09:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0EWHdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 03:33:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:65278 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0EWHdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 03:33:08 -0400
Received: by pxi18 with SMTP id 18so1018766pxi.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3JXf2rZD+Ej52x8nvB4yB8rNRmSshGt364at3JvB+Nw=;
        b=bA3bB5Cnr3q4S8XYI9bDq/WaP0tTtcI7Ry8lPJRUIJZq4Speyc5+y9RjuOVoBZnr/q
         IQ8w5Ig9jraV/SP7ii2m7U+cyIC7oI2YIEBFXwvUqvZYIJi6kX/Y8sMPHyoQgeIR3elX
         4Z5N6/E7fj0etb9ng3pkF6YFn6BcDevKGDM5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BTX3dL6dIi9ro2LS5TYsno09h3hOttp3e+cbF8kfph01/3AWC0Lp5uXHz9SCuA1w71
         0KB6rBGRG1pST51ItZkNaB5gmvmyu16wNnDfIIGO1hy350L6FDsTCS+yGts9gAHnkbpu
         JeYTDG2Dt9dcITBETlof0NvdKSKuvJqHr/1Ok=
Received: by 10.114.164.37 with SMTP id m37mr3398100wae.39.1274599985074;
        Sun, 23 May 2010 00:33:05 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id c1sm26317986wam.19.2010.05.23.00.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 00:33:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.18.g74211d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147554>

git-instaweb in its current form (re)creates gitweb.cgi and
(some of) required static files in $GIT_DIR/gitweb/ directory.
Splitting gitweb would make it difficult for git-instaweb to
continue with this method.

Use the instaweb.gitwebdir config variable to point git-instaweb script
to a global directory which contains gitweb files as server root
and the httpd.conf along with server logs and pid go into
'$(GIT_DIR)/gitweb' directory.

While at it, change apache2 configuration to use the same access log
and error log files as the rest of web servers supported by
git-instaweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---

This patch is based on 'jn/gitweb-install' in the next branch by Jakub Nareski
and my previous 2 patches:
* gitweb: Move static files into seperate subdirectory
 http://article.gmane.org/gmane.comp.version-control.git/147321
* gitweb: Set default destination directory for installing gitweb in Makefile
 http://article.gmane.org/gmane.comp.version-control.git/147160

 Makefile        |   11 ++------
 git-instaweb.sh |   71 ++++++++++++++++++++----------------------------------
 2 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index caf2f64..9161172 100644
--- a/Makefile
+++ b/Makefile
@@ -1426,6 +1426,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_SQ = $(subst ','\'',$(htmldir))
 prefix_SQ = $(subst ','\'',$(prefix))
+gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -1592,15 +1593,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
-	    -e '/@@GITWEB_CGI@@/d' \
-	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
-	    -e '/@@GITWEB_CSS@@/d' \
-	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
-	    -e '/@@GITWEB_JS@@/d' \
+	    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
-            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -1972,6 +1966,7 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C gitweb gitwebdir=$(gitwebdir_SQ) install
 endif
 ifndef NO_PYTHON
 	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..b3e9192 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -24,6 +24,7 @@ restart        restart the web server
 fqgitdir="$GIT_DIR"
 local="$(git config --bool --get instaweb.local)"
 httpd="$(git config --get instaweb.httpd)"
+root="$(git config --get instaweb.gitwebdir)"
 port=$(git config --get instaweb.port)
 module_path="$(git config --get instaweb.modulepath)"
 
@@ -34,6 +35,9 @@ conf="$GIT_DIR/gitweb/httpd.conf"
 # if installed, it doesn't need further configuration (module_path)
 test -z "$httpd" && httpd='lighttpd -f'
 
+# Default is @@GITWEBDIR@@
+test -z "$root" && root='@@GITWEBDIR@@'
+
 # any untaken local port will do...
 test -z "$port" && port=1234
 
@@ -57,7 +61,7 @@ resolve_full_httpd () {
 		# these days and those are not in most users $PATHs
 		# in addition, we may have generated a server script
 		# in $fqgitdir/gitweb.
-		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
+		for i in /usr/local/sbin /usr/sbin "$root" "$fqgitdir/gitweb"
 		do
 			if test -x "$i/$httpd_only"
 			then
@@ -159,8 +163,8 @@ done
 mkdir -p "$GIT_DIR/gitweb/tmp"
 GIT_EXEC_PATH="$(git --exec-path)"
 GIT_DIR="$fqgitdir"
-export GIT_EXEC_PATH GIT_DIR
-
+GITWEB_CONFIG="$fqgitdir/gitweb/gitweb_config.perl"
+export GIT_EXEC_PATH GIT_DIR GITWEB_CONFIG
 
 webrick_conf () {
 	# generate a standalone server script in $fqgitdir/gitweb.
@@ -192,7 +196,7 @@ EOF
 
 	cat >"$conf" <<EOF
 :Port: $port
-:DocumentRoot: "$fqgitdir/gitweb"
+:DocumentRoot: "$root"
 :DirectoryIndex: ["gitweb.cgi"]
 :PidFile: "$fqgitdir/pid"
 EOF
@@ -201,7 +205,7 @@ EOF
 
 lighttpd_conf () {
 	cat > "$conf" <<EOF
-server.document-root = "$fqgitdir/gitweb"
+server.document-root = "$root"
 server.port = $port
 server.modules = ( "mod_setenv", "mod_cgi" )
 server.indexfiles = ( "gitweb.cgi" )
@@ -212,7 +216,7 @@ server.errorlog = "$fqgitdir/gitweb/error.log"
 # variable above and uncomment this
 #accesslog.filename = "$fqgitdir/gitweb/access.log"
 
-setenv.add-environment = ( "PATH" => env.PATH )
+setenv.add-environment = ( "PATH" => env.PATH, "GITWEB_CONFIG" => env.GITWEB_CONFIG )
 
 cgi.assign = ( ".cgi" => "" )
 
@@ -277,14 +281,15 @@ EOF
 
 apache2_conf () {
 	test -z "$module_path" && module_path=/usr/lib/apache2/modules
-	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
 	cat > "$conf" <<EOF
 ServerName "git-instaweb"
-ServerRoot "$fqgitdir/gitweb"
-DocumentRoot "$fqgitdir/gitweb"
+ServerRoot "$root"
+DocumentRoot "$root"
+ErrorLog "$fqgitdir/gitweb/error.log"
+CustomLog "$fqgitdir/gitweb/access.log" combined
 PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
@@ -303,13 +308,14 @@ EOF
 	# check to see if Dennis Stosberg's mod_perl compatibility patch
 	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
 	if test -f "$module_path/mod_perl.so" &&
-	   sane_grep 'MOD_PERL' "$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
+	   sane_grep 'MOD_PERL' "$root/gitweb.cgi" >/dev/null
 	then
 		# favor mod_perl if available
 		cat >> "$conf" <<EOF
 LoadModule perl_module $module_path/mod_perl.so
 PerlPassEnv GIT_DIR
 PerlPassEnv GIT_EXEC_DIR
+PerlPassEnv GITWEB_CONFIG
 <Location /gitweb.cgi>
 	SetHandler perl-script
 	PerlResponseHandler ModPerl::Registry
@@ -353,7 +359,7 @@ mongoose_conf() {
 # For detailed description of every option, visit
 # http://code.google.com/p/mongoose/wiki/MongooseManual
 
-root		$fqgitdir/gitweb
+root		$root
 ports		$port
 index_files	gitweb.cgi
 #ssl_cert	$fqgitdir/gitweb/ssl_cert.pem
@@ -361,7 +367,7 @@ error_log	$fqgitdir/gitweb/error.log
 access_log	$fqgitdir/gitweb/access.log
 
 #cgi setup
-cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
+cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH,GITWEB_CONFIG=$GITWEB_CONFIG
 cgi_interp	$PERL
 cgi_ext		cgi,pl
 
@@ -370,41 +376,16 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
 EOF
 }
 
-
-script='
-s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
-s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
-s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
-s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'
-
-gitweb_cgi () {
-	cat > "$1.tmp" <<\EOFGITWEB
-@@GITWEB_CGI@@
-EOFGITWEB
-	# Use the configured full path to perl to match the generated
-	# scripts' 'hashpling' line
-	"$PERL" -p -e "$script" "$1.tmp"  > "$1"
-	chmod +x "$1"
-	rm -f "$1.tmp"
-}
-
-gitweb_css () {
-	cat > "$1" <<\EOFGITWEB
-@@GITWEB_CSS@@
-
-EOFGITWEB
-}
-
-gitweb_js () {
-	cat > "$1" <<\EOFGITWEB
-@@GITWEB_JS@@
-
-EOFGITWEB
+gitweb_conf() {
+	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
+#!/usr/bin/perl
+our \$projectroot = "$(dirname "$fqgitdir")";
+our \$git_temp = "$fqgitdir/gitweb/tmp";
+our \$projects_list = \$projectroot;
+EOF
 }
 
-gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
-gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
-gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
+gitweb_conf
 
 case "$httpd" in
 *lighttpd*)
-- 
1.7.1.18.g74211d.dirty
