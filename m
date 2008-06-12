From: "Flavio Poletti (polettix)" <flavio@polettix.it>
Subject: [PATCH] Enhanced auto-discovery of httpd location and call conventions.
Date: Thu, 12 Jun 2008 03:51:20 +0200
Message-ID: <1213235480-21925-1-git-send-email-flavio@polettix.it>
Cc: normalperson@yhbt.net,
	"Flavio Poletti (polettix)" <flavio@polettix.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 05:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6diz-0002Pp-PQ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 05:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYFLDmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 23:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbYFLDmw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 23:42:52 -0400
Received: from [195.130.249.251] ([195.130.249.251]:34553 "HELO desantix.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1752487AbYFLDmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 23:42:51 -0400
X-Greylist: delayed 3941 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jun 2008 23:42:51 EDT
Received: (qmail 22969 invoked by uid 511); 12 Jun 2008 02:04:45 -0000
Received: from localhost.localdomain (127.0.0.1)
  by localhost.localdomain with SMTP; 12 Jun 2008 02:04:45 -0000
X-Mailer: git-send-email 1.5.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84694>

This patch allows calling:

   git-instaweb -d apache2

and have the script Do The Right Thing. In particular, the auto-discovery
mechanism has been extended in order to be used for module listing as
well, and the call convention is that if the daemon is apache2/lighttpd
and the parameter to the "-d" option does not end by "-f", the "-f" is
added to the end of the option itself.

Another minor change is a substitution of a shell sub-call using "$()"
by means of backticks. In my understanding, plain /bin/sh does not support
"$()".

Signed-off-by: Flavio Poletti <flavio@polettix.it>
---
Hello,

   this is the first time I submit a patch here so please point me to the
right FM to Read if I've messed up with the standard submission
procedure at http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

Cheers,

   Flavio.

 git-instaweb.sh |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6f91c8f..cc9d4f3 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
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
+	httpd_only="`echo $local_httpd | cut -f1 -d' '`"
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
@@ -71,6 +86,7 @@ stop_httpd () {
 	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
 }
 
+httpd=`resolve_httpd "$httpd"`
 while test $# != 0
 do
 	case "$1" in
@@ -92,7 +108,7 @@ do
 		;;
 	-d|--httpd)
 		shift
-		httpd="$1"
+		httpd=`resolve_httpd "$1"`
 		;;
 	-b|--browser)
 		shift
@@ -228,7 +244,7 @@ EOF
 }
 
 script='
-s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
+s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'`dirname "$fqgitdir"`'";#;
 s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
 s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
 s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'
-- 
1.5.5.3
