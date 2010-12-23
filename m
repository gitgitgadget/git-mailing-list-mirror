From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] lib-git-svn.sh: Move web-server handling code into separate
 function
Date: Thu, 23 Dec 2010 19:03:47 +0000
Message-ID: <4D139D13.1030900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 20:07:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVqVX-0005YC-44
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 20:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab0LWTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 14:07:15 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:35347 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266Ab0LWTHO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 14:07:14 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PVqVN-0004fz-WP; Thu, 23 Dec 2010 19:07:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164136>


This library file is currently sourced by 57 test files, of which
only four may (optionally) start a web-server in order to access
the svn repo via an http url, rather than a file url.

In addition to isolating the current web-server handling code from
the majority of tests, in a new prepare_httpd function, we also
add some error checking and reporting code to validate the apache
installation. Only those tests which attempt to start the web-
server, by calling start_httpd, will execute this code.

Note that it is important for start_httpd to return an error
indication, if prepare_httpd fails, so that the failure to use
the web-server, as requested by the user, should not go unnoticed.
(Unless the svnrepo variable is set to an http url at the end of
start_httpd, the remaining tests will use file urls, without
comment.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Sorry for taking so long on this, I've been somewhat busy this week.

This is the patch I promised, except that I decided not to squash
all of the previous lib-git-svn.sh patches. This replaces the
"lib-git-svn.sh: Add check for mis-configured web server variables"
patch in the rj/maint-test-fixes branch. (ie. patches #4 and #5, but
not #3, from the original series)

Hope that makes sense! :-P

ATB,
Ramsay Jones

 t/lib-git-svn.sh |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 919d45a..199f22c 100644
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
@@ -81,6 +80,11 @@ then
 			break
 		fi
 	done
+	if test -z "$SVN_HTTPD_PATH"
+	then
+		echo >&2 '*** error: Apache not found'
+		return 1
+	fi
 	for d in \
 		"$SVN_HTTPD_MODULE_PATH" \
 		/usr/lib/apache2/modules \
@@ -92,20 +96,18 @@ then
 			break
 		fi
 	done
-fi
-
-start_httpd () {
-	repo_base_path="$1"
-	if test -z "$SVN_HTTPD_PORT"
+	if test -z "$SVN_HTTPD_MODULE_PATH"
 	then
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
@@ -122,12 +124,24 @@ LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
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
