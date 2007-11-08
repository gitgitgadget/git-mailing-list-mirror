From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] instaweb: Minor cleanups and fixes for potential problems
Date: Fri, 9 Nov 2007 00:21:42 +0100
Message-ID: <20071108232142.GA5082@diku.dk>
References: <20071108154940.GA20988@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIa8-0000rr-3A
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbXKIBWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbXKIBWc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:22:32 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:57836 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbXKIBWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:22:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 4282F19BB53;
	Fri,  9 Nov 2007 00:21:44 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16001-16; Fri,  9 Nov 2007 00:21:42 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 54CC119BB47;
	Fri,  9 Nov 2007 00:21:42 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1C7FD6E0084; Fri,  9 Nov 2007 00:21:21 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 3B0235B8001; Fri,  9 Nov 2007 00:21:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071108154940.GA20988@diku.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64104>

Fix path quoting and test of empty values that some shells do not like.
Remove duplicate check and setting of $browser.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 git-instaweb.sh |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

 Here is a new version that has some more fixes so that git-instaweb now
 runs from inside a repository with spaces in the path.

diff --git a/git-instaweb.sh b/git-instaweb.sh
index f05884c..375f2f3 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -27,7 +27,7 @@ browser="`git config --get instaweb.browser`"
 port=`git config --get instaweb.port`
 module_path="`git config --get instaweb.modulepath`"
 
-conf=$GIT_DIR/gitweb/httpd.conf
+conf="$GIT_DIR/gitweb/httpd.conf"
 
 # Defaults:
 
@@ -44,7 +44,7 @@ start_httpd () {
 	httpd_only="`echo $httpd | cut -f1 -d' '`"
 	if case "$httpd_only" in /*) : ;; *) which $httpd_only >/dev/null;; esac
 	then
-		$httpd $fqgitdir/gitweb/httpd.conf
+		$httpd "$fqgitdir/gitweb/httpd.conf"
 	else
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
@@ -158,7 +158,7 @@ EOF
 :DirectoryIndex: ["gitweb.cgi"]
 :PidFile: "$fqgitdir/pid"
 EOF
-	test "$local" = true && echo ':BindAddress: "127.0.0.1"' >> "$conf"
+	test x"$local" = xtrue && echo ':BindAddress: "127.0.0.1"' >> "$conf"
 }
 
 lighttpd_conf () {
@@ -171,14 +171,14 @@ server.pid-file = "$fqgitdir/pid"
 cgi.assign = ( ".cgi" => "" )
 mimetype.assign = ( ".css" => "text/css" )
 EOF
-	test "$local" = true && echo 'server.bind = "127.0.0.1"' >> "$conf"
+	test x"$local" = xtrue && echo 'server.bind = "127.0.0.1"' >> "$conf"
 }
 
 apache2_conf () {
 	test -z "$module_path" && module_path=/usr/lib/apache2/modules
 	mkdir -p "$GIT_DIR/gitweb/logs"
 	bind=
-	test "$local" = true && bind='127.0.0.1:'
+	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > $fqgitdir/mime.types
 	cat > "$conf" <<EOF
 ServerName "git-instaweb"
@@ -231,7 +231,7 @@ EOF
 }
 
 script='
-s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'`dirname $fqgitdir`'";#
+s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'$(dirname "$fqgitdir")'";#
 s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#
 s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#
 s#\(my\|our\) $git_temp =.*#\1 $git_temp = "'$fqgitdir/gitweb/tmp'";#'
@@ -251,8 +251,8 @@ gitweb_css () {
 EOFGITWEB
 }
 
-gitweb_cgi $GIT_DIR/gitweb/gitweb.cgi
-gitweb_css $GIT_DIR/gitweb/gitweb.css
+gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
+gitweb_css "$GIT_DIR/gitweb/gitweb.css"
 
 case "$httpd" in
 *lighttpd*)
@@ -271,6 +271,5 @@ webrick)
 esac
 
 start_httpd
-test -z "$browser" && browser=echo
 url=http://127.0.0.1:$port
-$browser $url || echo $url
+"$browser" $url || echo $url
-- 
1.5.3.5.1623.gabaff-dirty

-- 
Jonas Fonseca
