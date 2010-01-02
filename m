From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v4 3/3] Smart-http tests: Test http-backend without curl or a webserver
Date: Sat,  2 Jan 2010 13:38:07 -0800
Message-ID: <1262468287-8629-3-git-send-email-tarmigan+git@gmail.com>
References: <20100102205928.GM6914@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:38:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBg7-0008GD-VC
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab0ABVi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436Ab0ABViY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:38:24 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46611 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0ABViW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:38:22 -0500
Received: by mail-gx0-f211.google.com with SMTP id 3so1824960gxk.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=fr9IeU/3NQmFjRwp0wl3y2EYlFRYrZSyqDwxYtHgv9M=;
        b=Q8MVQruqAzBYtF62wdWzqruVIaEm8h1kuZVfDgmIdBtJj1r/nKkRD0L5RnZcz5X5WH
         FLd0z0FZslkVjdNsTlAoy0ynwDjpe4HPDf6l/pIfkbws7phh4ixSG0WXCBrV0435RGeV
         2+85/qlvmXcBlQTUELBbrChvhHBYwNoz6ENw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=ksyoUbRWHWrUKIxFrDSiuS3fvwfxR3y1Ld+8l6xedx4XoqAQg78j5dsYmlwRSlTemg
         cup4JiCxtrRT7NT8kOWLDXjex/a55Tg71iErJ1QpzD01HSYmsJIa2xA53UBhb/zu2kYf
         s6n+fYgc6E6y7lWrBMlBz0eTblNoJI+GqNCi4=
Received: by 10.151.95.1 with SMTP id x1mr31383871ybl.221.1262468302085;
        Sat, 02 Jan 2010 13:38:22 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 5sm6538971yxg.10.2010.01.02.13.38.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:38:20 -0800 (PST)
X-Mailer: git-send-email 1.6.6.236.gc56f3
In-Reply-To: <20100102205928.GM6914@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136056>

This reuses many of the tests from the old t5560 but runs those tests
without curl or a webserver.  This will hopefully increase the testing
coverage for http-backend because it does not require users to set
GIT_TEST_HTTPD.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
As a side note, I am very impressed that git rebase was able to
apply this patch properly even after I renamed the tests earlier in
the series.
---
 t/t5560-http-backend-noserver.sh |   30 ++++++++++++++++++++++++------
 t/t556x_common                   |    3 +++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index a9ba2d9..9013824 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -6,18 +6,36 @@ test_description='test git-http-backend-noserver'
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
 
 run_backend() {
-	REQUEST_METHOD=GET \
+	echo "$2"| \
+	QUERY_STRING="${1#*\?}" \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
-	PATH_INFO="$1" \
+	PATH_INFO="${1%%\?*}" \
 	git http-backend >act.out 2>act.err
 }
 
 GET() {
-	return 0
+	REQUEST_METHOD="GET" \
+	run_backend "/repo.git/$1" &&
+	grep "Status" act.out >act
+	if [ $? -eq 1 ];
+	then
+		printf "Status: 200 OK\r\n" > act
+	fi
+	printf "Status: $2\r\n" > exp &&
+	test_cmp exp act
 }
 
 POST() {
-	return 0
+	REQUEST_METHOD="POST" \
+	CONTENT_TYPE="application/x-$1-request" \
+	run_backend "/repo.git/$1" "$2" &&
+	grep "Status" act.out >act
+	if [ $? -eq 1 ];
+	then
+		printf "Status: 200 OK\r\n" > act
+	fi
+	printf "Status: $3\r\n" > exp &&
+	test_cmp exp act
 }
 
 log_div() {
@@ -28,9 +46,9 @@ log_div() {
 
 expect_aliased() {
 	if test $1 = 0; then
-		run_backend "$2"
+		REQUEST_METHOD=GET run_backend "$2"
 	else
-		run_backend "$2" &&
+		REQUEST_METHOD=GET run_backend "$2" &&
 		echo "fatal: '$2': aliased" >exp.err &&
 		test_cmp exp.err act.err
 	fi
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
1.6.6.236.gc56f3
