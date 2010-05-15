From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global server root and projects list
Date: Sun, 16 May 2010 01:28:39 +0530
Message-ID: <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 21:59:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODNW4-0003IZ-Iw
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 21:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0EOT7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 15:59:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53653 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0EOT7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 15:59:14 -0400
Received: by pvh1 with SMTP id 1so1095797pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hermj352zgPY0Hswuxzc3J7AezFknFVar2orETy+Cqc=;
        b=v1N0bry02zPbts8USInUSsuisZMRnaEYm22a6tvYe/5qSUCp3+AP10tz8DJ53U/QmJ
         kABG6FHAJ+KVgnOypSeJ5r7adjEnLKof6rParo3pzfiJZT16lesGrg1kqvnRMtUXvalM
         /4jL/YxCb91Qb1nn3LPn0WpAMen6I3GSdkC2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ERpSRggKXiq+kLFdFyc2Pb+sKEKTesgrYusJ5eV4lnj0WmHy17JLIdPufYegkL3yu5
         IflsQ2PhKVKQQoL0JrTUzTETf/pqozb1M6uwqFtB2UyRhGLz7W0deiqOrdCTxBtPeDEC
         gRbDd8v95mAe9tTQegdE6jCr5VjMmA+aplD6I=
Received: by 10.114.186.37 with SMTP id j37mr2537122waf.122.1273953553767;
        Sat, 15 May 2010 12:59:13 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id v13sm32432688wav.14.2010.05.15.12.59.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 12:59:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.16.g5d405c.dirty
In-Reply-To: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147161>

git-instaweb in its current form (re)creates gitweb.cgi and
(some of) required static files in $GIT_DIR/gitweb/ directory for
each repository it is ran. Splitting gitweb would make it difficult
for git-instaweb to continue with this method.

Use the instaweb.root config variable to point git-instaweb script
to a global directory which contains gitweb files as server root
and the httpd.conf along with server logs and pid go into
'$(HOME)/.gitweb' directory.

As there is no need to call git-instaweb in every git repository,
configure gitweb to get $projects_list from file '$(HOME)/.gitweb/list'
and $projectroot is ''

Example of ~/.gitweb/list:
home%2Fpavan%2Fgit%2F.git Linus+Torvalds
home%2Fpavan%2Fgsoc%2F.git Pavan+Kumar+Sunkara

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 Makefile        |    9 +----
 git-instaweb.sh |  100 ++++++++++++++++++-------------------------------------
 2 files changed, 34 insertions(+), 75 deletions(-)

diff --git a/Makefile b/Makefile
index caf2f64..1e9fb77 100644
--- a/Makefile
+++ b/Makefile
@@ -1592,15 +1592,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
-	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
-	    -e '/@@GITWEB_CGI@@/d' \
-	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
-	    -e '/@@GITWEB_CSS@@/d' \
-	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
-	    -e '/@@GITWEB_JS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
-            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -1972,6 +1964,7 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C gitweb gitwebdir=$(gitwebdir) GITWEB_LIST=$(HOME)/.gitweb/list GITWEB_PROJECTROOT='' install
 endif
 ifndef NO_PYTHON
 	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..4aaacbb 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -19,21 +19,30 @@ start          start the web server
 restart        restart the web server
 "
 
+# This must be capable of running outside of git directory, so
+# the vanilla git-sh-setup should not be used.
+NONGIT_OK=Yes
 . git-sh-setup
 
-fqgitdir="$GIT_DIR"
+fqgitdir="$HOME/.gitweb"
 local="$(git config --bool --get instaweb.local)"
 httpd="$(git config --get instaweb.httpd)"
+root="$(git config --get instaweb.root)" 
 port=$(git config --get instaweb.port)
 module_path="$(git config --get instaweb.modulepath)"
 
-conf="$GIT_DIR/gitweb/httpd.conf"
+mkdir -p "$fqgitdir/tmp"
+test ! -w "$fqgitdir/list" && touch "$fqgitdir/list"
+conf="$fqgitdir/httpd.conf"
 
 # Defaults:
 
 # if installed, it doesn't need further configuration (module_path)
 test -z "$httpd" && httpd='lighttpd -f'
 
+# Default is /usr/share/gitweb
+test -z "$root" && root='/usr/share/gitweb'
+
 # any untaken local port will do...
 test -z "$port" && port=1234
 
@@ -56,8 +65,8 @@ resolve_full_httpd () {
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
 		# in addition, we may have generated a server script
-		# in $fqgitdir/gitweb.
-		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
+		# in $fqgitdir.
+		for i in /usr/local/sbin /usr/sbin "$fqgitdir"
 		do
 			if test -x "$i/$httpd_only"
 			then
@@ -85,7 +94,7 @@ start_httpd () {
 	case "$httpd" in
 	*mongoose*)
 		#The mongoose server doesn't have a daemon mode so we'll have to fork it
-		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
+		$full_httpd "$conf" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=$!
 
@@ -99,7 +108,7 @@ $pid
 EOF
 		;;
 	*)
-		$full_httpd "$fqgitdir/gitweb/httpd.conf"
+		$full_httpd "$conf"
 		if test $? != 0; then
 			echo "Could not execute http daemon $httpd."
 			exit 1
@@ -156,15 +165,9 @@ do
 	shift
 done
 
-mkdir -p "$GIT_DIR/gitweb/tmp"
-GIT_EXEC_PATH="$(git --exec-path)"
-GIT_DIR="$fqgitdir"
-export GIT_EXEC_PATH GIT_DIR
-
-
 webrick_conf () {
 	# generate a standalone server script in $fqgitdir/gitweb.
-	cat >"$fqgitdir/gitweb/$httpd.rb" <<EOF
+	cat >"$fqgitdir/$httpd.rb" <<EOF
 require 'webrick'
 require 'yaml'
 options = YAML::load_file(ARGV[0])
@@ -184,15 +187,15 @@ EOF
 	# which assumes _ruby_ is in the user's $PATH. that's _one_
 	# portable way to run ruby, which could be installed anywhere,
 	# really.
-	cat >"$fqgitdir/gitweb/$httpd" <<EOF
+	cat >"$fqgitdir/$httpd" <<EOF
 #!/bin/sh
-exec ruby "$fqgitdir/gitweb/$httpd.rb" \$*
+exec ruby "$fqgitdir/$httpd.rb" \$*
 EOF
-	chmod +x "$fqgitdir/gitweb/$httpd"
+	chmod +x "$fqgitdir/$httpd"
 
 	cat >"$conf" <<EOF
 :Port: $port
-:DocumentRoot: "$fqgitdir/gitweb"
+:DocumentRoot: "$root"
 :DirectoryIndex: ["gitweb.cgi"]
 :PidFile: "$fqgitdir/pid"
 EOF
@@ -201,16 +204,16 @@ EOF
 
 lighttpd_conf () {
 	cat > "$conf" <<EOF
-server.document-root = "$fqgitdir/gitweb"
+server.document-root = "$root"
 server.port = $port
 server.modules = ( "mod_setenv", "mod_cgi" )
 server.indexfiles = ( "gitweb.cgi" )
 server.pid-file = "$fqgitdir/pid"
-server.errorlog = "$fqgitdir/gitweb/error.log"
+server.errorlog = "$fqgitdir/error.log"
 
 # to enable, add "mod_access", "mod_accesslog" to server.modules
 # variable above and uncomment this
-#accesslog.filename = "$fqgitdir/gitweb/access.log"
+#accesslog.filename = "$fqgitdir/access.log"
 
 setenv.add-environment = ( "PATH" => env.PATH )
 
@@ -277,14 +280,15 @@ EOF
 
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
+ErrorLog "$fqgitdir/error.log"
+CustomLog "$fqgitdir/access.log" combined
 PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
@@ -303,13 +307,11 @@ EOF
 	# check to see if Dennis Stosberg's mod_perl compatibility patch
 	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
 	if test -f "$module_path/mod_perl.so" &&
-	   sane_grep 'MOD_PERL' "$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
+	   sane_grep 'MOD_PERL' "$root/gitweb.cgi" >/dev/null
 	then
 		# favor mod_perl if available
 		cat >> "$conf" <<EOF
 LoadModule perl_module $module_path/mod_perl.so
-PerlPassEnv GIT_DIR
-PerlPassEnv GIT_EXEC_DIR
 <Location /gitweb.cgi>
 	SetHandler perl-script
 	PerlResponseHandler ModPerl::Registry
@@ -353,15 +355,15 @@ mongoose_conf() {
 # For detailed description of every option, visit
 # http://code.google.com/p/mongoose/wiki/MongooseManual
 
-root		$fqgitdir/gitweb
+root		$root
 ports		$port
 index_files	gitweb.cgi
-#ssl_cert	$fqgitdir/gitweb/ssl_cert.pem
-error_log	$fqgitdir/gitweb/error.log
-access_log	$fqgitdir/gitweb/access.log
+#ssl_cert	$fqgitdir/ssl_cert.pem
+error_log	$fqgitdir/error.log
+access_log	$fqgitdir/access.log
 
 #cgi setup
-cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
+cgi_env		PATH=$PATH
 cgi_interp	$PERL
 cgi_ext		cgi,pl
 
@@ -370,42 +372,6 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
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
-}
-
-gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
-gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
-gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
-
 case "$httpd" in
 *lighttpd*)
 	lighttpd_conf
-- 
1.7.1.16.g5d405c.dirty
