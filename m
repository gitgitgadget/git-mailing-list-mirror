From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Dec 2010, #05; Thu, 16)
Date: Sat, 18 Dec 2010 22:00:26 +0000
Message-ID: <4D0D2EFA.7060106@ramsay1.demon.co.uk>
References: <7vk4j8kfwy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 23:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU4yp-0006M6-7b
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 23:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0LRWKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 17:10:12 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:33580 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab0LRWKL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Dec 2010 17:10:11 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PU4yD-0005Wp-dx; Sat, 18 Dec 2010 22:10:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vk4j8kfwy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163943>

Junio C Hamano wrote:
> 
> --------------------------------------------------
> [New Topics]
> 
> * rj/maint-difftool-cygwin-workaround (2010-12-14) 1 commit
>  - difftool: Fix failure on Cygwin
> 
> * rj/maint-test-fixes (2010-12-14) 5 commits
>  - t9501-*.sh: Fix a test failure on Cygwin
>  - lib-git-svn.sh: Add check for mis-configured web server variables

This lib-git-svn.sh patch (above) has a quite serious fault :(

I'm very annoyed with myself, because I was trying so hard to be
conservative and safe! :-P

The original branch containing these lib-git-svn.sh patches (#3-5 in the
original series) had another commit with the highly informative commit
message: WIP. I could not remember what this commit was about, or if it
was complete (but I thought not), so I didn't send it along with the
others ... Well, this evening I remembered what it was about, along
with the fact that it fixed a problem with the above and that I had
intended to squash all of these patches into one.

The problem with the above is this: because lib-git-svn.sh is sourced
by 57 test files, only four of which even remotely care about using
apache, if SVN_HTTPD_PORT is set and your apache install cannot be
found, then *all* 57 tests will be skipped.

Sorry about that ...

I've added a diff of the additional commit below (well, I changed a
couple of "test ! -e" to "test ! -f", given your comment on patch
04/14) so you can see that the fix will involve moving the code used
to check your apache installation into a separate function which will
only be called from start_httpd; ie only tests that want to use the
web-server will execute this code.

I'll send a proper patch soon. Again, I must apologize for messing up!

ATB,
Ramsay Jones

--- >8 ---
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 5acc0ec..d48fe6b 100644
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
+		echo >&2 'Apache not found'
+		return 1
 	fi
 	for d in \
 		"$SVN_HTTPD_MODULE_PATH" \
@@ -99,10 +98,15 @@ then
 	done
 	if test -z "$SVN_HTTPD_MODULE_PATH"
 	then
-		skip_all='skipping git svn tests, Apache module dir not found'
-		test_done
+		echo >&2 'Apache module dir not found'
+		return 1
 	fi
-fi
+	if test ! -f "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
+	then
+		echo >&2 'Apache module "mod_dav_svn.so" not found'
+		return 1
+	fi
+}
 
 start_httpd () {
 	repo_base_path="$1"
@@ -111,11 +115,9 @@ start_httpd () {
 		echo >&2 'SVN_HTTPD_PORT is not defined!'
 		return
 	fi
-	if test ! -e "$SVN_HTTPD_MODULE_PATH/mod_dav_svn.so"
-	then
-		echo >&2 'Apache module "mod_dav_svn.so" not found'
-		return 1
-	fi
+
+	prepare_httpd || return 1
+
 	if test -z "$repo_base_path"
 	then
 		repo_base_path=svn
@@ -143,7 +145,7 @@ EOF
 
 stop_httpd () {
 	test -z "$SVN_HTTPD_PORT" && return
-	test ! -e "$GIT_DIR/httpd.conf" && return
+	test ! -f "$GIT_DIR/httpd.conf" && return
 	"$SVN_HTTPD_PATH" -f "$GIT_DIR"/httpd.conf -k stop
 }
 
--- 8< ---
