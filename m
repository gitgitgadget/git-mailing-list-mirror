From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH RFC 2/2] Smart-http tests: Test http-backend without curl or a webserver
Date: Wed, 30 Dec 2009 13:59:02 -0500
Message-ID: <1262199542-73876-2-git-send-email-tarmigan+git@gmail.com>
References: <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com>
 <1262199542-73876-1-git-send-email-tarmigan+git@gmail.com>
Cc: spearce@spearce.org, gitster@pobox.com,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 19:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ3le-0007rt-HV
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 19:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZL3S7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 13:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbZL3S7Y
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 13:59:24 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:41542 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbZL3S7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 13:59:23 -0500
Received: by qw-out-2122.google.com with SMTP id 8so1183958qwh.37
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0xzjye3F3pR6LjJtgaYdOqVvjjksBJB0xXFDGsdIISU=;
        b=i/7D3I3ar6bJO8n3w1IAQapps1bazpmWLJmA+EPXDgGjVkx0F5F2hinvwlGz4hoNfl
         +vtwa/x8+2foQpefrTOK0DGbRz5rDT7y5yDJqmHgRKPGo4+5WteJWiSAqSbsu20RF+oS
         Tc4V7p+ZQBABZOGvbK3HixN22hnGRLjgasVU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=A0rS6LyqL2YVy8n4l0rAe6gRxUOHqpDhImvwCcmpGjx5nqNUCgc5XqPsOML7j5B53R
         vR+AYNcx7ZW+DDEUt7gvliQjRSYQ2Txq4qITcGud26pkc1ysO6D+PpqyfoflSuNX4W4o
         g2HtGNe+lVPnjOP6pWZNgY4uQcSDPkSTJd0TM=
Received: by 10.224.127.40 with SMTP id e40mr244008qas.60.1262199562756;
        Wed, 30 Dec 2009 10:59:22 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 5sm37373683qwg.58.2009.12.30.10.59.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 10:59:21 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262199542-73876-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135915>

This reuses many of the tests from t5560 but runs those tests without curl
or a webserver.  This will hopefully increase the testing coverage for
http-backend because it does not require users to set GIT_TEST_HTTPD.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
In addition to the rebase, I fixed a bunch of bugs in this version.  I'm
still leaving this as RFC as there may be some more.

 t/t5561-http-backend-noserver.sh |   49 ++++++++++++++++++++++---------------
 t/t556x_common                   |    3 ++
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/t/t5561-http-backend-noserver.sh b/t/t5561-http-backend-noserver.sh
index 501b328..bda5029 100755
--- a/t/t5561-http-backend-noserver.sh
+++ b/t/t5561-http-backend-noserver.sh
@@ -5,40 +5,49 @@ test_description='test git-http-backend-noserver'
 
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
+    if [ $? -eq 1 ];
+    then
+	printf "Status: 200 OK\r\n" > act
+    fi
+    printf "Status: $2\r\n" > exp &&
+    test_cmp exp act
 }
 
 POST() {
-    return 0
+    REQUEST_METHOD="POST" \
+    CONTENT_TYPE="application/x-$1-request" \
+    run_backend 0 "/repo.git/$1" "$2" &&
+    grep "Status" act.out >act
+    if [ $? -eq 1 ];
+    then
+	printf "Status: 200 OK\r\n" > act
+    fi
+    printf "Status: $3\r\n" > exp &&
+    test_cmp exp act
 }
 
-logdiv() {
+log_div() {
     return 0
 }
 
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
diff --git a/t/t556x_common b/t/t556x_common
index 1b4921c..be024e5 100755
--- a/t/t556x_common
+++ b/t/t556x_common
@@ -50,6 +50,7 @@ get_static_files() {
 }
 
 SMART=smart
+export GIT_HTTP_EXPORT_ALL=1
 test_expect_success 'direct refs/heads/master not found' '
 	log_div "refs/heads/master"
 	GET refs/heads/master "404 Not Found"
@@ -59,6 +60,7 @@ test_expect_success 'static file is ok' '
 	get_static_files "200 OK"
 '
 SMART=smart_noexport
+unset GIT_HTTP_EXPORT_ALL
 test_expect_success 'no export by default' '
 	log_div "no git-daemon-export-ok"
 	get_static_files "404 Not Found"
@@ -71,6 +73,7 @@ test_expect_success 'export if git-daemon-export-ok' '
         get_static_files "200 OK"
 '
 SMART=smart
+export GIT_HTTP_EXPORT_ALL=1
 test_expect_success 'static file if http.getanyfile true is ok' '
 	log_div "getanyfile true"
 	config http.getanyfile true &&
-- 
1.6.6
