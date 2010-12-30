From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] lib-git-svn.sh: Move web-server handling code into separate
 function
Date: Thu, 30 Dec 2010 19:44:48 +0000
Message-ID: <4D1CE130.9000006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 20:47:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYOSx-0006Bn-39
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 20:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab0L3TrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 14:47:08 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:59102 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755041Ab0L3TrG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Dec 2010 14:47:06 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PYOSm-0005Cc-cT; Thu, 30 Dec 2010 19:47:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164362>


This library file is currently sourced by 57 test files, of which
only four may (optionally) start a web-server in order to access
the svn repo via an http url, rather than a file url.

In addition to isolating the current web-server handling code from
the majority of tests, in a new prepare_httpd function, we also
add some more error checking and reporting code to validate the
apache installation. Only those tests which attempt to start the
web-server, by calling start_httpd, will execute this code.

Note that it is important for start_httpd to return an error
indication, if prepare_httpd fails, so that the failure to use
the web-server, as requested by the user, should not go unnoticed.
(Unless the svnrepo variable is set to an http url at the end of
start_httpd, the remaining tests will use file urls, without
comment.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I just noticed that you have already included the "lib-git-svn.sh:
Add check for mis-configured web server variables" patch (from the
rj/maint-test-fixes branch) into the master branch. This was still
in pu last time I looked! (And so the fix-up patch in my last e-mail
is no longer useful - sorry about that)

This patch is on top of master (as of a couple of days ago: 73e7b2e)
and addresses the fault with the above patch.

ATB,
Ramsay Jones

 t/lib-git-svn.sh |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 6a9d975..199f22c 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -68,8 +68,7 @@ svn_cmd () {
 	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
 }
 
-if test -n "$SVN_HTTPD_PORT"
-then
+prepare_httpd () {
 	for d in \
 		"$SVN_HTTPD_PATH" \
 		/usr/sbin/apache2 \
@@ -83,8 +82,8 @@ then
 	done
 	if test -z "$SVN_HTTPD_PATH"
 	then
-		skip_all='skipping git svn tests, Apache not found'
-		test_done
+		echo >&2 '*** error: Apache not found'
+		return 1
 	fi
 	for d in \
 		"$SVN_HTTPD_MODULE_PATH" \
@@ -99,23 +98,16 @@ then
 	done
 	if test -z "$SVN_HTTPD_MODULE_PATH"
 	then
-		skip_all='skipping git svn tests, Apache module dir not found'
-		test_done
-	fi
-fi
-
-start_httpd () {
-	repo_base_path="$1"
-	if test -z "$SVN_HTTPD_PORT"
-	then
-		echo >&2 'SVN_HTTPD_PORT is not defined!'
-		return
+		echo >&2 '*** error: Apache module dir not found'
+		return 1
 	fi
-	if test -z "$repo_base_path"
+	if test ! -f "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
 	then
-		repo_base_path=svn
+		echo >&2 '*** error: Apache module "mod_dav_svn" not found'
+		return 1
 	fi
 
+	repo_base_path="${1-svn}"
 	mkdir "$GIT_DIR"/logs
 
 	cat > "$GIT_DIR/httpd.conf" <<EOF
@@ -132,12 +124,24 @@ LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
 	SVNPath "$rawsvnrepo"
 </Location>
 EOF
+}
+
+start_httpd () {
+	if test -z "$SVN_HTTPD_PORT"
+	then
+		echo >&2 'SVN_HTTPD_PORT is not defined!'
+		return
+	fi
+
+	prepare_httpd "$1" || return 1
+
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k start
 	svnrepo="http://127.0.0.1:$SVN_HTTPD_PORT/$repo_base_path"
 }
 
 stop_httpd () {
 	test -z "$SVN_HTTPD_PORT" && return
+	test ! -f "$GIT_DIR/httpd.conf" && return
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
 }
 
-- 
1.7.3
