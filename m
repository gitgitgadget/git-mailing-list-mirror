From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] t5561: get rid of racy appending to logfile
Date: Thu, 24 Sep 2015 02:20:17 +0200
Message-ID: <1443054017-8312-1-git-send-email-s-beyer@gmx.net>
References: <20150923232443.GA21755@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 02:22:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeuIi-00074V-UO
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 02:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbbIXAWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 20:22:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:49286 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578AbbIXAWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 20:22:12 -0400
Received: from fermat.fritz.box ([92.76.227.98]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MAloF-1Zp7h62IGJ-00Bs4A; Thu, 24 Sep 2015 02:22:07
 +0200
X-Mailer: git-send-email 2.6.0.rc3.dirty
In-Reply-To: <20150923232443.GA21755@sigill.intra.peff.net>
X-Provags-ID: V03:K0:aW95iOMkFIiIJvqazIZjpwnVyVRLP6fWAOQMZhR/e49aMGWckzX
 X5T2wrlIvKouyYPhsAQJi9a8GBqLzTMWLxCQYzGvfPmnYTdux8YA7Yt/OV0QkYLTnB/I7kG
 HFWziQcYmUKWbxIu8fltds2ZrI3ALzhOepl4iMM6syJzwb3FpCsadO0rEpvT1KOgYJnGuyb
 rZXLQYIlXPz89PmNNhdNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mk3dp4L8xc8=:QFpUamcTmay11UNKn3M+g0
 34seJszCpTgHPqTDoNNJSAaR15fhPUpqrbtd6W9sKGzCNFpDP6nSFdXt28DV7LJl1iL8kEJhn
 a8tuJOs40TbmtoJolmjC9Xka7gDyZFfKO3Cm9Kp/D1PlX7dx7VsK2OlT5F4fp9+c1rDejI2RF
 LbhtOqvUqFu7PNr2Sh9zDzyBM21Iluc9rsWn92ElVwSr8S7K/EN34kzzdOeHb9j3nXM1jbhsR
 ODl7GAgylgodHETWqUNKcTkXcZgXHqjDS7eg8wNEdm8oQOy/z9Cp06tSnXw4YMJGY16ButKIk
 cHs6uSqHOB9aLPkvCLDNz7NDtZtqig/eW7QKxy+zrSmoo2iaw0dGrVF4YIw9poQECI0T/aVl2
 xSREcc7aJBC9ysXb9UlnlN5gxSg4V6uLMMDmIYPHZ2svgtPI8601xNAr3lLC51MkS0LEpLyXN
 jvS+xD3FnCLCxIoSockKxR+D62zDxkDwy+4uInekTs+pFNZYri9IcYCV5yhR2sRiLarra06uG
 fuguigoVZr4EpYLa1g0G7SRUevd2AQZOHdKWBrv75GnafJVAsH5AzJfUJBCCov7da36NJP4Rb
 lMnCSnKqkcOit2ueYkpng4tff4TFTG7itpj0T+b7ujJ/kFlQxaHC9kfsjoi57kPEvOFNDxdeW
 wA7CE3GZZferl5eWoHaSsD+AK7jtRa1Wq2qR5mKilKkznU2tOcBDITk5gWp7fwHFMokPJZwcp
 abdWP5Bmk0j56UhE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278524>

The definition of log_div() appended information to the web server's
logfile to make the test more readable. However, it could happen that
this information is written before the web server writes its log line
(this consistently happens with a PROFILE=GEN build), and hence the
test failed.

To get rid of this behavior, the logfile is not touched at all. This
commit removes log_div() and its calls. The readability-improving
information is kept in the test but filtered out before comparing
it to the actual logfile.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
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
index 19afe96..b870410 100755
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
+grep -e '^[GP]' >exp <<EOF
 
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
