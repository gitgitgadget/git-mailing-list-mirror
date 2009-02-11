From: Luciano Miguel Ferreira Rocha <luciano@eurotux.com>
Subject: [PATCH 1/1] git-instaweb: support for apache2/lighttpd by other
	names
Date: Wed, 11 Feb 2009 18:40:29 +0000
Message-ID: <20090211184029.GB1127@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK2A-0005RI-Kf
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbZBKSkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757071AbZBKSki
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:38 -0500
Received: from os.eurotux.com ([216.75.63.6]:43586 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266AbZBKSkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:36 -0500
Received: (qmail 11239 invoked from network); 11 Feb 2009 18:40:33 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 11 Feb 2009 18:40:33 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109485>

Some distributions include the Apache httpd server as just "httpd", but
specifying the option --httpd=httpd doesn't work, as git-instaweb uses
the program name to detect the type of server used.

Now the output if $httpd -v is used to also detect the server type.

Remove also the hard-coded path to apache2 modules, use apache2's
compilation options.

Signed-off-by: Luciano M. F. Rocha <luciano@eurotux.com>
---
 git-instaweb.sh |  137 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 79 insertions(+), 58 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 0843372..8c5aeb2 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -31,53 +31,84 @@ conf="$GIT_DIR/gitweb/httpd.conf"
 
 # Defaults:
 
-# if installed, it doesn't need further configuration (module_path)
-test -z "$httpd" && httpd='lighttpd -f'
-
 # any untaken local port will do...
 test -z "$port" && port=1234
 
-resolve_full_httpd () {
-	case "$httpd" in
-	*apache2*|*lighttpd*)
-		# ensure that the apache2/lighttpd command ends with "-f"
-		if ! echo "$httpd" | grep -- '-f *$' >/dev/null 2>&1
-		then
-			httpd="$httpd -f"
-		fi
-		;;
-	esac
+# add sbin directories to path, usually not done for normal users
+PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
 
-	httpd_only="$(echo $httpd | cut -f1 -d' ')"
-	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
-	then
-		full_httpd=$httpd
-	else
-		# many httpds are installed in /usr/sbin or /usr/local/sbin
-		# these days and those are not in most users $PATHs
-		# in addition, we may have generated a server script
-		# in $fqgitdir/gitweb.
-		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
-		do
-			if test -x "$i/$httpd_only"
-			then
-				full_httpd=$i/$httpd
-				return
-			fi
-		done
-
-		echo >&2 "$httpd_only not found. Install $httpd_only or use" \
-		     "--httpd to specify another httpd daemon."
-		exit 1
-	fi
-}
+# in addition, we may have generated a server script in $fqgitdir/gitweb.
+PATH=$PATH:"$fqgitdir/gitweb"
+
+# search for a server if not defined
+if test -z "$httpd"; then
+	for httpd in lighttpd apache2 httpd; do
+		type $httpd >/dev/null 2>&1 && break
+		httpd=
+	done
+fi
+
+# can't proceed without a server
+if test -z "$httpd"; then
+	echo >&2 "No HTTP server found, specify and/or install one."
+	exit 1
+fi
+
+# check if server can be executed
+httpd_only="$(echo $httpd | cut -f1 -d' ')"
+if ! type $httpd_only >/dev/null 2>&1; then
+	echo >&2 "$httpd_only not found. Install $httpd_only or use" \
+	     "--httpd to specify another httpd daemon."
+fi
+
+# add option -f?
+uses_opt_f=
+
+# configuration generator
+confgenerator=
+
+case "$httpd" in
+*lighttpd*)
+	confgenerator=lighttpd_conf
+	uses_opt_f=1
+	;;
+*apache2*)
+	confgenerator=apache2_conf
+	uses_opt_f=1
+	;;
+webrick)
+	confgenerator=webrick_conf
+	;;
+*)
+	# deduce from server version string
+	case "$($httpd_only -v 2>/dev/null)" in
+		*Apache/2.*)
+			confgenerator=apache2_conf
+			uses_opt_f=1
+			;;
+		*lighttpd*)
+			confgenerator=lighttpd_conf
+			uses_opt_f=1
+			;;
+		*)
+			echo >&2 "Unknown httpd specified: $httpd"
+			exit 1
+			;;
+	esac
+esac
 
 start_httpd () {
 	# here $httpd should have a meaningful value
-	resolve_full_httpd
 
-	# don't quote $full_httpd, there can be arguments to it (-f)
-	$full_httpd "$fqgitdir/gitweb/httpd.conf"
+	# ensure that the apache2/lighttpd command ends with "-f"
+	if test -n "$uses_opt_f" &&
+		! echo "$httpd" | grep -- '-f *$' >/dev/null 2>&1
+	then
+		httpd="$httpd -f"
+	fi
+
+	# don't quote $httpd, there can be arguments to it (-f)
+	$httpd "$fqgitdir/gitweb/httpd.conf"
 	if test $? != 0; then
 		echo "Could not execute http daemon $httpd."
 		exit 1
@@ -189,7 +220,13 @@ EOF
 }
 
 apache2_conf () {
-	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	if test -z "$module_path"; then
+		# get module path from binary
+		module_path=$(
+			eval $($httpd_only -V | sed -n -e '/ -D.*=/s/.*-D//p')
+			echo $HTTPD_ROOT/modules
+		)
+	fi
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
@@ -232,8 +269,7 @@ PerlPassEnv GIT_EXEC_DIR
 EOF
 	else
 		# plain-old CGI
-		resolve_full_httpd
-		list_mods=$(echo "$full_httpd" | sed "s/-f$/-l/")
+		list_mods=$(echo "$httpd" | sed "s/-f$/-l/")
 		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
@@ -271,22 +307,7 @@ EOFGITWEB
 gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
 gitweb_css "$GIT_DIR/gitweb/gitweb.css"
 
-case "$httpd" in
-*lighttpd*)
-	lighttpd_conf
-	;;
-*apache2*)
-	apache2_conf
-	;;
-webrick)
-	webrick_conf
-	;;
-*)
-	echo "Unknown httpd specified: $httpd"
-	exit 1
-	;;
-esac
-
+eval $confgenerator
 start_httpd
 url=http://127.0.0.1:$port
 
-- 
1.6.2.rc0.36.g86413.dirty
