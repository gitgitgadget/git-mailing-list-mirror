From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] instaweb: add support for nginx + FastCGI
Date: Wed,  3 Jan 2007 23:49:38 -0800
Message-ID: <1167896979262-git-send-email-normalperson@yhbt.net>
References: <11678969111362-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 08:49:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2NM7-0007v7-Jk
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 08:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbXADHtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 02:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbXADHtm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 02:49:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60297 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932317AbXADHtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 02:49:41 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9F51F7DC099;
	Wed,  3 Jan 2007 23:49:39 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 23:49:39 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gcafca-dirty
In-Reply-To: <11678969111362-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35922>

nginx does not support regular CGI

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Makefile        |    5 +++-
 git-instaweb.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3e94def..893c7f2 100644
--- a/Makefile
+++ b/Makefile
@@ -690,7 +690,8 @@ gitweb/gitweb.fcgi: gitweb/gitweb-fcgi.perl
 	chmod +x $@+
 	mv $@+ $@
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css \
+              gitweb/gitweb.fcgi
 	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -699,6 +700,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_FCGI@@/r gitweb/gitweb.fcgi' \
+	    -e '/@@GITWEB_FCGI@@/d' \
 	    $@.sh > $@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 08362f4..dcd04fd 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -20,7 +20,7 @@ httpd="`git repo-config --get instaweb.httpd`"
 browser="`git repo-config --get instaweb.browser`"
 port=`git repo-config --get instaweb.port`
 module_path="`git repo-config --get instaweb.modulepath`"
-
+fcgi_pid_file="$fqgitdir"/gitweb/fcgi.pid
 conf=$GIT_DIR/gitweb/httpd.conf
 
 # Defaults:
@@ -34,7 +34,22 @@ test -z "$browser" && browser='firefox'
 # any untaken local port will do...
 test -z "$port" && port=1234
 
+use_fcgi () {
+	case "$httpd" in
+	*nginx*)
+		return 0
+		;;
+	esac
+	return -1
+}
+
 start_httpd () {
+	if use_fcgi; then
+		"$fqgitdir"/gitweb/gitweb.fcgi \
+		           --fcgi-socket="$fcgi_sock" \
+			   --cgi-bin="$fqgitdir/gitweb/gitweb.cgi" &
+		echo $! > "$fcgi_pid_file"
+	fi
 	httpd_only="`echo $httpd | cut -f1 -d' '`"
 	if test "`expr index $httpd_only /`" -eq '1' || \
 				which $httpd_only >/dev/null
@@ -61,6 +76,9 @@ start_httpd () {
 }
 
 stop_httpd () {
+	if use_fcgi; then
+		test -f "$fcgi_pid_file" && kill `cat "$fcgi_pid_file"`
+	fi
 	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
 }
 
@@ -138,7 +156,48 @@ mkdir -p "$GIT_DIR/gitweb/tmp"
 GIT_EXEC_PATH="`git --exec-path`"
 GIT_DIR="$fqgitdir"
 export GIT_EXEC_PATH GIT_DIR
+fcgi_sock="$fqgitdir/gitweb/fcgi.sock"
 
+nginx_conf () {
+	mkdir -p "$fqgitdir"/gitweb/logs
+	cat > "$conf" <<EOF
+pid $fqgitdir/pid;
+error_log $fqgitdir/gitweb/logs/error.log;
+events {
+	worker_connections 1024;
+}
+http {
+	access_log $fqgitdir/gitweb/logs/access.log;
+	types {
+		text/css css;
+	}
+	server {
+		listen $port;
+		root $fqgitdir/gitweb;
+		location = / {
+			fastcgi_pass unix:$fcgi_sock;
+			fastcgi_index gitweb.fcgi;
+			fastcgi_param QUERY_STRING \$query_string;
+			fastcgi_param REQUEST_METHOD \$request_method;
+			fastcgi_param CONTENT_TYPE \$content_type;
+			fastcgi_param CONTENT_LENGTH \$content_length;
+			fastcgi_param SCRIPT_NAME \$fastcgi_script_name;
+			fastcgi_param REQUEST_URI \$request_uri;
+			fastcgi_param DOCUMENT_URI \$document_uri;
+			fastcgi_param DOCUMENT_ROOT \$document_root;
+			fastcgi_param SERVER_PROTOCOL \$server_protocol;
+			fastcgi_param GATEWAY_INTERFACE CGI/1.1;
+			fastcgi_param SERVER_SOFTWARE nginx;
+			fastcgi_param REMOTE_ADDR \$remote_addr;
+			fastcgi_param REMOTE_PORT \$remote_port;
+			fastcgi_param SERVER_ADDR \$server_addr;
+			fastcgi_param SERVER_PORT \$server_port;
+			fastcgi_param SERVER_NAME \$server_name;
+		}
+	}
+}
+EOF
+}
 
 lighttpd_conf () {
 	cat > "$conf" <<EOF
@@ -230,8 +289,16 @@ gitweb_css () {
 EOFGITWEB
 }
 
+gitweb_fcgi () {
+	cat > "$1" <<\EOFGITWEB
+@@GITWEB_FCGI@@
+EOFGITWEB
+	chmod +x "$1"
+}
+
 gitweb_cgi $GIT_DIR/gitweb/gitweb.cgi
 gitweb_css $GIT_DIR/gitweb/gitweb.css
+gitweb_fcgi $GIT_DIR/gitweb/gitweb.fcgi
 
 case "$httpd" in
 *lighttpd*)
@@ -240,6 +307,9 @@ case "$httpd" in
 *apache2*)
 	apache2_conf
 	;;
+*nginx*)
+	nginx_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
-- 
1.5.0.rc0.gcafca-dirty
