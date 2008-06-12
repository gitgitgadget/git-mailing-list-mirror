From: Flavio Poletti <flavio@polettix.it>
Subject: [PATCH v2] git-instaweb: Enhanced auto-discovery of httpd and call conventions. Removed backticks.
Date: Thu, 12 Jun 2008 11:59:19 +0200
Message-ID: <1213264759-5264-1-git-send-email-flavio@polettix.it>
References: <1213235480-21925-1-git-send-email-flavio@polettix.it>
Cc: normalperson@yhbt.net, Flavio Poletti <flavio@polettix.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 12:15:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6jpo-00054y-8m
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 12:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbYFLKOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 06:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbYFLKOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 06:14:09 -0400
Received: from [195.130.249.251] ([195.130.249.251]:56929 "HELO desantix.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1754313AbYFLKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 06:14:08 -0400
Received: (qmail 24996 invoked by uid 511); 12 Jun 2008 10:12:45 -0000
Received: from localhost.localdomain (127.0.0.1)
  by localhost.localdomain with SMTP; 12 Jun 2008 10:12:45 -0000
X-Mailer: git-send-email 1.5.5.3
In-Reply-To: <1213235480-21925-1-git-send-email-flavio@polettix.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84739>

This patch allows calling:

   git-instaweb -d apache2

and have the script Do The Right Thing. In particular, the auto-discovery
mechanism has been extended in order to be used for module listing as
well, and the call convention is that if the daemon is apache2/lighttpd
and the parameter to the "-d" option does not end by "-f", the "-f" is
added to the end of the option itself.

Changed all backticks to $( ... ) as per Documentation/CodingGuidelines:

   For shell scripts specifically (not exhaustive):

      - We prefer $( ... ) for command substitution; unlike ``, it
         properly nests.  It should have been the way Bourne spelled
         it from day one, but unfortunately isn't.

The rationale is that the POSIX shell does support $( ... ), and git
does make use of it rather extensively. (Thanks to Jakub Narebski for
pointing this out).

Signed-off-by: Flavio Poletti <flavio@polettix.it>
---
Following Jakub's observation about backticks, I sanitised the whole
script to use $( ... ) instead of backticks. I hope that bundling it
with the proposed patch can be acceptable in this case; if not, I can
produce two different patches and send them separately.

Cheers,

   Flavio.
 git-instaweb.sh |   46 +++++++++++++++++++++++++++++++---------------
 1 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6f91c8f..ec22344 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -22,10 +22,10 @@ restart        restart the web server
 . git-sh-setup
 
 fqgitdir="$GIT_DIR"
-local="`git config --bool --get instaweb.local`"
-httpd="`git config --get instaweb.httpd`"
-port=`git config --get instaweb.port`
-module_path="`git config --get instaweb.modulepath`"
+local="$(git config --bool --get instaweb.local)"
+httpd="$(git config --get instaweb.httpd)"
+port=$(git config --get instaweb.port)
+module_path="$(git config --get instaweb.modulepath)"
 
 conf="$GIT_DIR/gitweb/httpd.conf"
 
@@ -37,11 +37,23 @@ test -z "$httpd" && httpd='lighttpd -f'
 # any untaken local port will do...
 test -z "$port" && port=1234
 
-start_httpd () {
-	httpd_only="`echo $httpd | cut -f1 -d' '`"
+resolve_httpd () {
+	local_httpd=$1
+
+	case "$local_httpd" in
+	*apache2*|*lighttpd*)
+		# ensure that the apache2/lighttpd command ends with "-f"
+		if ! echo "$local_httpd" | grep -- '-f *$' >/dev/null 2>&1
+		then
+			local_httpd="$local_httpd -f"
+		fi
+		;;
+	esac
+
+	httpd_only="$(echo $local_httpd | cut -f1 -d' ')"
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
 	then
-		$httpd "$fqgitdir/gitweb/httpd.conf"
+		echo $local_httpd
 	else
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
@@ -51,16 +63,19 @@ start_httpd () {
 		do
 			if test -x "$i/$httpd_only"
 			then
-				# don't quote $httpd, there can be
-				# arguments to it (-f)
-				$i/$httpd "$fqgitdir/gitweb/httpd.conf"
+				echo $i/$local_httpd
 				return
 			fi
 		done
-		echo "$httpd_only not found. Install $httpd_only or use" \
+		echo >&2 "$httpd_only not found. Install $httpd_only or use" \
 		     "--httpd to specify another http daemon."
 		exit 1
 	fi
+}
+
+start_httpd () {
+	# don't quote $httpd, there can be arguments to it (-f)
+	$httpd "$fqgitdir/gitweb/httpd.conf"
 	if test $? != 0; then
 		echo "Could not execute http daemon $httpd."
 		exit 1
@@ -68,9 +83,10 @@ start_httpd () {
 }
 
 stop_httpd () {
-	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
+	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
 }
 
+httpd=$(resolve_httpd "$httpd")
 while test $# != 0
 do
 	case "$1" in
@@ -92,7 +108,7 @@ do
 		;;
 	-d|--httpd)
 		shift
-		httpd="$1"
+		httpd=$(resolve_httpd "$1")
 		;;
 	-b|--browser)
 		shift
@@ -116,7 +132,7 @@ do
 done
 
 mkdir -p "$GIT_DIR/gitweb/tmp"
-GIT_EXEC_PATH="`git --exec-path`"
+GIT_EXEC_PATH="$(git --exec-path)"
 GIT_DIR="$fqgitdir"
 export GIT_EXEC_PATH GIT_DIR
 
@@ -215,7 +231,7 @@ PerlPassEnv GIT_EXEC_DIR
 EOF
 	else
 		# plain-old CGI
-		list_mods=`echo "$httpd" | sed "s/-f$/-l/"`
+		list_mods=$(echo "$httpd" | sed "s/-f$/-l/")
 		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
-- 
1.5.5.3
