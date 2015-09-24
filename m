From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t5561: get rid of racy appending to logfile
Date: Fri, 25 Sep 2015 01:31:33 +0200
Message-ID: <1443137493-2648-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 25 01:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfG1u-0002gV-2K
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 01:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbbIXXeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 19:34:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:51164 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbbIXXeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 19:34:16 -0400
Received: from fermat.fritz.box ([88.71.231.156]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lp8h6-1aHdi40gvU-00epnY; Fri, 25 Sep 2015 01:34:12
 +0200
X-Mailer: git-send-email 2.6.0.rc3.dirty
X-Provags-ID: V03:K0:qE2WBogR468RGBbjumWwlhucQ7i5XhLBXs7lujdXcCr0f0d1M8H
 Sg9i4qPQLWi/035yAuJmntxoVvXff+WEffkuLCXHsfvSPhzKmHD72jVUZbLMw1M+tnGTC6e
 tUAzqTQ471wDQ9B+y4Kuq8MVXskJwAdRhu1AGmhQepiiAreWWSK8fr8QDL8eTszuEdFYMxM
 dj+f2JN/BPCG6Md2mzsEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uplopvUBJKM=:lq9K5ZXq3hFcKRkGjTCvun
 e6+eL4cv9ob8gqRXom1VH0vJW4pTFG8WB9cgYPQs+reCgd2y8XlfmKYReJc4nGNgclqDBIcoz
 2sfpqa9gutDGEZtExOjE9HKCO2zY8LGITIQURn5fbGXJfrOHz7e/ePcst21GXdEZ4W7rbwwku
 8O58H2aQmThuR7tUNaq+n9t89T6K+ULT28eWjvLtPPJ5ONT0XwN5tcAA5Qg5YO6reWbhqNcMK
 8UqD9VGwiuU64p8cpaBk7Xbg0+CVlVMbOmJOEBhS8Cn/HH96n4wZizoRgALLF2QlEiM0GFOez
 3DMNc2DeaIPA8Hl3+2wfPl//Kmy/0uzIjIykfnxX2iu1a2XRSobbhX2zxHaBpqyILO3orw33d
 sjpNqIRqZAtVTXU9O65TcI9u66W2gJscpB3qYN4d8V4S3DkqkNhsGnBwSWrPPLaB29se7T29G
 1mLOodaEOEyyb1vprTaotmgnFb1ZtL0k1X5OMmMPyNv87BiqoasKpaZHEA90QqmX8hJVLLG7m
 QB1N0ci6+xIeFm2o1ircnaPEv0KrYt8BG1CCgsZMK+pddoo5y+D/h5Zg2yHhfOuSUg7fx6gAy
 t+cNswrIYY8yMPl9S1tlHS2ihepIieQGd2Hz3y9+TbsJy8CspNj3Racrmq2O3FEI3gvCdjO1j
 HR0mz9ITWWioGOVv4L4W2MM9mPc2iEo2C2na6akiW8fJ4pWh//99JW3qX+ndPLyW9E0B9+pYo
 uumNFePcB7Ik87/V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278635>

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
Acked-by: Jeff King <peff@peff.net>
---

 SubmittingPatches says that when there is consensus the patch has to
 be resent to Junio and cc'ed to the list. Here it is (although I
 don't know if there is consensus, but, hey, it's a rather trivial patch,
 so it should be okay).
 See http://git.661346.n2.nabble.com/t5561-failing-after-make-PROFILE-GEN-td7640150.html
 for the original thread.
 Compared to the last version, I only added the Acked-by line.

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
