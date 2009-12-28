From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH RFC 2/2] Smart-http tests: Test http-backend without curl or a webserver
Date: Mon, 28 Dec 2009 17:04:59 -0500
Message-ID: <1262037899-16786-2-git-send-email-tarmigan+git@gmail.com>
References: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O . Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNjU-0000yM-5i
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZL1WFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 17:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZL1WFp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:05:45 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:40125 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZL1WFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 17:05:33 -0500
Received: by mail-qy0-f192.google.com with SMTP id 30so4971989qyk.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=lb+IlSh2bsneikmxwqXP4y2NZBqufd04TxUbwNAt3zk=;
        b=arir/9gCdz9wczVXORWKt4o/Kqv3rW/sIAUsvu9T7918UU1xFdJaxJGZSJ2DES6sXb
         0WUw7hJl18qzCa+DuwIVzGk4Aa840ZpTO87+c08ZcZZmJY8Ogh0sKZewP6+9ALTSWlhI
         6D295uaWmJjnfuA2Os3N989xY+4r2IV/DYOqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=CcuB0TlgUkwz8vacRCg19alTqWHU9dhEkZ0Y6PhdjIPsf4jbiaP8/u1PnOqNHkn+q+
         eN+uJGERvUiB54XJrGTacpXYOStElnTysYPifwXBhpXjJTAIKTunwpBejIK5zDZTq8Ic
         XSfTm8NHXjiamhebVaL0ky28oLgcmoFHx7V00=
Received: by 10.224.96.70 with SMTP id g6mr7834016qan.247.1262037932942;
        Mon, 28 Dec 2009 14:05:32 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 23sm10745696qyk.11.2009.12.28.14.05.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 14:05:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.62.g67314
In-Reply-To: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135767>

This reuses many of the tests from t5560 but runs those tests without curl
or a webserver.  This will hopefully increase the testing coverage for
http-backend because it does not require users to set GIT_TEST_HTTPD.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 t/t5561-http-backend-noserver.sh |   45 ++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/t/t5561-http-backend-noserver.sh b/t/t5561-http-backend-noserver.sh
index 501b328..6371e97 100755
--- a/t/t5561-http-backend-noserver.sh
+++ b/t/t5561-http-backend-noserver.sh
@@ -5,12 +5,35 @@ test_description='test git-http-backend-noserver'
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
 
+run_backend() {
+        echo "$3"| \
+        QUERY_STRING="${2#*\?}" \
+	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
+	PATH_INFO="${2%%\?*}" \
+	git http-backend >act.out 2>act.err
+}
+
 GET() {
-    return 0
+    REQUEST_METHOD="GET" \
+    run_backend 0 "/repo.git/$1" &&
+    grep "Status" act.out >act
+    if [ $? -ne 1 ];
+    then
+	printf "Status: $2\r\n" > exp &&
+	test_cmp exp act
+    fi
 }
 
 POST() {
-    return 0
+    REQUEST_METHOD="POST" \
+    CONTENT_TYPE="application/x-$1-request" \
+    run_backend 0 "/repo.git/$1" "$2" &&
+    grep "Status" act.out >act
+    if [ $? -ne 1 ];
+    then
+	printf "Status: $3\r\n" > exp &&
+	test_cmp exp act
+    fi
 }
 
 logdiv() {
@@ -19,26 +42,10 @@ logdiv() {
 
 . "$TEST_DIRECTORY"/t556x_common
 
-run_backend() {
-	REQUEST_METHOD=GET \
-	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
-	PATH_INFO="$2" \
-	git http-backend >act.out 2>act.err
-}
-
-path_info() {
-	if test $1 = 0; then
-		run_backend "$2"
-	else
-		test_must_fail run_backend "$2" &&
-		echo "fatal: '$2': aliased" >exp.err &&
-		test_cmp exp.err act.err
-	fi
-}
-
 test_expect_success 'http-backend blocks bad PATH_INFO' '
 	config http.getanyfile true &&
 
+	REQUEST_METHOD="GET" &&
 	run_backend 0 /repo.git/HEAD &&
 
 	run_backend 1 /repo.git/../HEAD &&
-- 
1.6.6.62.g67314
