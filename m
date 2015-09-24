From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t5561: get rid of racy appending to logfile
Date: Thu, 24 Sep 2015 20:12:22 +0200
Message-ID: <1443118342-3856-1-git-send-email-s-beyer@gmx.net>
References: <20150924014541.GB6442@sigill.intra.peff.net>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 20:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfB2D-0001J6-VB
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 20:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbbIXSOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 14:14:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:65264 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774AbbIXSOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 14:14:15 -0400
Received: from fermat.fritz.box ([92.76.227.98]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MQ33z-1ZkNxX3aJ1-005G3C; Thu, 24 Sep 2015 20:14:12
 +0200
X-Mailer: git-send-email 2.6.0.rc3.dirty
In-Reply-To: <20150924014541.GB6442@sigill.intra.peff.net>
X-Provags-ID: V03:K0:x+CvT7el7LwII8XTZDIJQZOs0LGUT4N2Nj7Htqkxky31Auah/Xw
 4iKviCFkwayt/jBugSHPO/Z5KXO4uPQhNtVlbBD9AefvDTJb1N2jEyOrOieKe7xVvLAqDAe
 FkqG0F4mrl0wjw7gDGBjwmrnedbszQei3wlBoK/5S9obeX9Fcds4EyKU3hzGOSpyjSARWIb
 kfq2i/TuKJPfvhWyeIXhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UaqPXZVLzU0=:uIcD8WlkaNglV4pWahlIRa
 59oisiK/NmD5XbIQamIgGZfx3fP9ETyawCta6POr6A+dF8cF6RrM5JBj3zT7GgNwNGhyn76H+
 e8GoqGk2XyEPJqT6ZWAA+2ohBZphej/NXDd4qnFZ2ginw7FPBf29nv3/3RkWNnI/aKVq5vGl8
 VuwDsTPx1ABStkvUWHhL2aLDSuHA9twCh7tSK+ZFUcuTzO1kz6Ti40wZHMrsPRTQUWx6IsA64
 aYmKeCKVjAiJnmbqQ83Vt+EvjHzyykzSLeB56b54lov41rVZnAz5oN+8reL8elpeqwapNUpVq
 NV7dth0BIMVFg29Vj4SH4r84wDnmu5Hd5ZMpparAaPPe77AS7dkovLB0vKaCcpkwRnQ2pum//
 RM2H5gsIMrdIr2xYIfDD5EHgBwGm8uy9GiwNdBu/qClSHS73z1kvZmZyufS9dmUsQbLdkm6Bz
 95MwGzVPNWRh/m4DX5R26wGfHzcSbqmarwbFfsohMh+VdXruIJjkimAeLP7vkD9ijEPoComyC
 9lC7nVU6ZJ++6XUqVNrFANcw5DUz06xtPueApSMVBob0hslaLJe1oPOl+kJxnY/qlkzFWG5nF
 /GCIIUUjshOZR9NCewqYaFrN6cNKz+JIMfgDv0ZHFAk4K2hqlSM/vSxh5Kun2z6gBCyEypvQE
 MqaiuYdtnUTKYwOLk1PTgSGZ+Yf40yaBZgc627257Yq5WK6majsN6qAO+lOQowUNd1QPQAOcd
 43UBIuN6oD3xb2o/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278552>

The definition of log_div() appended information to the web server's
logfile to make the test more readable. However, log_div() was called
right after a request is served (which is done by git-http-backend);
the web server waits for the git-http-backend process to exit before
it writes to the log file. When the duration between serving a request
and exiting was long, the log_div() output was written before the last
request's log, and the test failed. (This duration could become
especially long for PROFILE=GEN builds.)

To get rid of this behavior, we should not change the logfile at all.
This commit removes log_div() and its calls. The additional information
is kept in the test (for readability reasons) but filtered out before
comparing it to the actual logfile.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Okay Peff, I added the information to the commit message (in my own
 words). Past tense for the situation before the patch, present tense
 for the situation after (hope that's right but should not be too
 important).

 I also used your proposed grep line because it is probably more robust.

 t/t5560-http-backend-noserver.sh |  4 ----
 t/t5561-http-backend.sh          |  8 +-------
 t/t556x_common                   | 12 ------------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index aa73eea..9fafcf1 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -44,10 +44,6 @@ POST() {
 	test_cmp exp act
 }
 
-log_div() {
-	return 0
-}
-
 . "$TEST_DIRECTORY"/t556x_common
 
 expect_aliased() {
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 19afe96..73dcb29 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -29,15 +29,9 @@ POST() {
 	test_cmp exp act
 }
 
-log_div() {
-	echo >>"$HTTPD_ROOT_PATH"/access.log
-	echo "###  $1" >>"$HTTPD_ROOT_PATH"/access.log
-	echo "###" >>"$HTTPD_ROOT_PATH"/access.log
-}
-
 . "$TEST_DIRECTORY"/t556x_common
 
-cat >exp <<EOF
+grep '^[^#]' >exp <<EOF
 
 ###  refs/heads/master
 ###
diff --git a/t/t556x_common b/t/t556x_common
index 82926cf..359fcfe 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -52,21 +52,17 @@ get_static_files() {
 SMART=smart
 GIT_HTTP_EXPORT_ALL=1 && export GIT_HTTP_EXPORT_ALL
 test_expect_success 'direct refs/heads/master not found' '
-	log_div "refs/heads/master" &&
 	GET refs/heads/master "404 Not Found"
 '
 test_expect_success 'static file is ok' '
-	log_div "getanyfile default" &&
 	get_static_files "200 OK"
 '
 SMART=smart_noexport
 unset GIT_HTTP_EXPORT_ALL
 test_expect_success 'no export by default' '
-	log_div "no git-daemon-export-ok" &&
 	get_static_files "404 Not Found"
 '
 test_expect_success 'export if git-daemon-export-ok' '
-	log_div "git-daemon-export-ok" &&
         (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	 touch git-daemon-export-ok
 	) &&
@@ -75,47 +71,39 @@ test_expect_success 'export if git-daemon-export-ok' '
 SMART=smart
 GIT_HTTP_EXPORT_ALL=1 && export GIT_HTTP_EXPORT_ALL
 test_expect_success 'static file if http.getanyfile true is ok' '
-	log_div "getanyfile true" &&
 	config http.getanyfile true &&
 	get_static_files "200 OK"
 '
 test_expect_success 'static file if http.getanyfile false fails' '
-	log_div "getanyfile false" &&
 	config http.getanyfile false &&
 	get_static_files "403 Forbidden"
 '
 
 test_expect_success 'http.uploadpack default enabled' '
-	log_div "uploadpack default" &&
 	GET info/refs?service=git-upload-pack "200 OK"  &&
 	POST git-upload-pack 0000 "200 OK"
 '
 test_expect_success 'http.uploadpack true' '
-	log_div "uploadpack true" &&
 	config http.uploadpack true &&
 	GET info/refs?service=git-upload-pack "200 OK" &&
 	POST git-upload-pack 0000 "200 OK"
 '
 test_expect_success 'http.uploadpack false' '
-	log_div "uploadpack false" &&
 	config http.uploadpack false &&
 	GET info/refs?service=git-upload-pack "403 Forbidden" &&
 	POST git-upload-pack 0000 "403 Forbidden"
 '
 
 test_expect_success 'http.receivepack default disabled' '
-	log_div "receivepack default" &&
 	GET info/refs?service=git-receive-pack "403 Forbidden"  &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
 test_expect_success 'http.receivepack true' '
-	log_div "receivepack true" &&
 	config http.receivepack true &&
 	GET info/refs?service=git-receive-pack "200 OK" &&
 	POST git-receive-pack 0000 "200 OK"
 '
 test_expect_success 'http.receivepack false' '
-	log_div "receivepack false" &&
 	config http.receivepack false &&
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
-- 
2.6.0.rc3.dirty
