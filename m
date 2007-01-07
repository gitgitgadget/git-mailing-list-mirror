From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2 (fixed)] instaweb: add support for nginx + FastCGI
Date: Sat, 6 Jan 2007 18:18:14 -0800
Message-ID: <20070107021814.GA21370@mayonaise.dyndns.org>
References: <11678969111362-git-send-email-normalperson@yhbt.net> <1167896979262-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 03:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Nc3-0007S4-I6
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbXAGCSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbXAGCSQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:18:16 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33682 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338AbXAGCSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:18:16 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6E49D7DC094;
	Sat,  6 Jan 2007 18:18:14 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 18:18:14 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <1167896979262-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36121>

nginx does not support regular CGI

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

Oops, the original patch returned -1 in use_fcgi() instead of 1,
which shells don't like :x

 Makefile        |    5 +++-
 git-instaweb.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 2b33a2a..05848f1 100644
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
index 08362f4..d712c0c 100755
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
+	return 1
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
1.5.0.rc0.gc26c8
