From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix http-push test
Date: Mon,  7 Jul 2008 21:02:37 +0200
Message-ID: <1215457357-24279-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 07 21:03:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFw02-0007Qx-7e
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 21:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021AbYGGTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755464AbYGGTCr
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 15:02:47 -0400
Received: from vuizook.err.no ([194.24.252.247]:48305 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbYGGTCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 15:02:47 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KFvyt-0004vw-8B; Mon, 07 Jul 2008 21:02:42 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KFvyv-0006K1-CN; Mon, 07 Jul 2008 21:02:37 +0200
X-Mailer: git-send-email 1.5.6.GIT
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=NORMAL_HTTP_TO_IP,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87642>

http-push test has been broken by 4a7aaccd adding a space character
in the place where the test is being run.
---

 Note that the 4th test doesn't pass because of the new git clone, that
 creates the clone with packed-refs instead of refs/heads/master that
 push is requiring. But this also means push was already broken with
 repositories with packed-refs.

 t/lib-httpd.sh       |   18 ++++++++++--------
 t/t5540-http-push.sh |    2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a5c4436..dc473df 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -45,22 +45,22 @@ else
 	error "Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
-HTTPD_PARA="-d $HTTPD_ROOT_PATH -f $TEST_PATH/apache.conf"
+HTTPD_PARA=""
 
 prepare_httpd() {
-	mkdir -p $HTTPD_DOCUMENT_ROOT_PATH
+	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 
-	ln -s $LIB_HTTPD_MODULE_PATH $HTTPD_ROOT_PATH/modules
+	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
 	if test -n "$LIB_HTTPD_SSL"
 	then
 		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
 
 		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
-			-config $TEST_PATH/ssl.cnf \
+			-config "$TEST_PATH/ssl.cnf" \
 			-new -x509 -nodes \
-			-out $HTTPD_ROOT_PATH/httpd.pem \
-			-keyout $HTTPD_ROOT_PATH/httpd.pem
+			-out "$HTTPD_ROOT_PATH/httpd.pem" \
+			-keyout "$HTTPD_ROOT_PATH/httpd.pem"
 		GIT_SSL_NO_VERIFY=t
 		export GIT_SSL_NO_VERIFY
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
@@ -86,12 +86,14 @@ start_httpd() {
 
 	trap 'stop_httpd; die' exit
 
-	"$LIB_HTTPD_PATH" $HTTPD_PARA \
+	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
+		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
 		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
 }
 
 stop_httpd() {
 	trap 'die' exit
 
-	"$LIB_HTTPD_PATH" $HTTPD_PARA -k stop
+	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
+		-f "$TEST_PATH/apache.conf" -k stop
 }
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f15dd03..6cd8b45 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup remote repository' '
 	git --bare update-server-info &&
 	chmod +x hooks/post-update &&
 	cd - &&
-	mv test_repo.git $HTTPD_DOCUMENT_ROOT_PATH
+	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
 
 test_expect_success 'clone remote repository' '
-- 
1.5.6.2.220.g44701
