From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend into pieces
Date: Mon, 28 Dec 2009 17:04:58 -0500
Message-ID: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O . Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 23:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNjS-0000yM-FA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZL1WF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZL1WF0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:05:26 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:40125 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbZL1WFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 17:05:21 -0500
Received: by qyk30 with SMTP id 30so4971989qyk.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=GpIEGvTbr9lt29elQsxd7ghtT3rtXuB0+Wekra+IcKA=;
        b=lCDjLhbdz3ZAB8NYnokuxFjlNRn/Aehbozr8cNX9LQoEg+AoOkSBdGuPYuchksnilY
         EUxsN2vWV2eXUFxRvBr6JFPGxE22zqi865fxdl3P3oCprXtDQBlFEJGAYhYubsk1rHM2
         aMdT/8bJZiaiO62etA/PKdHiMMKLIQZp1MmO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=hIIemzxrtUnIiLUce5fSHUn/uy7jMW7ffr5s8d4s6Hxg4GAJtGSs1g4evG9kyBqAPs
         OWJb2Lo74rPCHY8P9aodc22urcLHiUur0PM7S/wI+55L13eSUVbGIvI5iZwG5WvjiVcc
         FFrV7DEWhNc6snBQHkkq1g+Vo1/NCGlh6rvOo=
Received: by 10.224.105.26 with SMTP id r26mr7829700qao.0.1262037920110;
        Mon, 28 Dec 2009 14:05:20 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 23sm10745696qyk.11.2009.12.28.14.05.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 14:05:18 -0800 (PST)
X-Mailer: git-send-email 1.6.6.62.g67314
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135766>

This should introduce no functional change in the tests or the amount
of test coverage.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 t/t5560-http-backend.sh          |  135 +-------------------------------------
 t/t5561-http-backend-noserver.sh |   52 +++++++++++++++
 t/t556x_common                   |  105 +++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 134 deletions(-)
 create mode 100755 t/t5561-http-backend-noserver.sh
 create mode 100755 t/t556x_common

diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index ed034bc..b0d08e2 100755
--- a/t/t5560-http-backend.sh
+++ b/t/t5560-http-backend.sh
@@ -12,16 +12,6 @@ LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5560'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-find_file() {
-	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	find $1 -type f |
-	sed -e 1q
-}
-
-config() {
-	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config $1 $2
-}
-
 GET() {
 	curl --include "$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
 	tr '\015' Q <out |
@@ -52,130 +42,7 @@ log_div() {
 	echo "###" >>"$HTTPD_ROOT_PATH"/access.log
 }
 
-test_expect_success 'setup repository' '
-	echo content >file &&
-	git add file &&
-	git commit -m one &&
-
-	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 git --bare init &&
-	 : >objects/info/alternates &&
-	 : >objects/info/http-alternates
-	) &&
-	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git push public master:master &&
-
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 git repack -a -d
-	) &&
-
-	echo other >file &&
-	git add file &&
-	git commit -m two &&
-	git push public master:master &&
-
-	LOOSE_URL=$(find_file objects/??) &&
-	PACK_URL=$(find_file objects/pack/*.pack) &&
-	IDX_URL=$(find_file objects/pack/*.idx)
-'
-
-get_static_files() {
-	GET HEAD "$1" &&
-	GET info/refs "$1" &&
-	GET objects/info/packs "$1" &&
-	GET objects/info/alternates "$1" &&
-	GET objects/info/http-alternates "$1" &&
-	GET $LOOSE_URL "$1" &&
-	GET $PACK_URL "$1" &&
-	GET $IDX_URL "$1"
-}
-
-test_expect_success 'direct refs/heads/master not found' '
-	log_div "refs/heads/master"
-	GET refs/heads/master "404 Not Found"
-'
-test_expect_success 'static file is ok' '
-	log_div "getanyfile default"
-	get_static_files "200 OK"
-'
-test_expect_success 'static file if http.getanyfile true is ok' '
-	log_div "getanyfile true"
-	config http.getanyfile true &&
-	get_static_files "200 OK"
-'
-test_expect_success 'static file if http.getanyfile false fails' '
-	log_div "getanyfile false"
-	config http.getanyfile false &&
-	get_static_files "403 Forbidden"
-'
-
-test_expect_success 'http.uploadpack default enabled' '
-	log_div "uploadpack default"
-	GET info/refs?service=git-upload-pack "200 OK"  &&
-	POST git-upload-pack 0000 "200 OK"
-'
-test_expect_success 'http.uploadpack true' '
-	log_div "uploadpack true"
-	config http.uploadpack true &&
-	GET info/refs?service=git-upload-pack "200 OK" &&
-	POST git-upload-pack 0000 "200 OK"
-'
-test_expect_success 'http.uploadpack false' '
-	log_div "uploadpack false"
-	config http.uploadpack false &&
-	GET info/refs?service=git-upload-pack "403 Forbidden" &&
-	POST git-upload-pack 0000 "403 Forbidden"
-'
-
-test_expect_success 'http.receivepack default disabled' '
-	log_div "receivepack default"
-	GET info/refs?service=git-receive-pack "403 Forbidden"  &&
-	POST git-receive-pack 0000 "403 Forbidden"
-'
-test_expect_success 'http.receivepack true' '
-	log_div "receivepack true"
-	config http.receivepack true &&
-	GET info/refs?service=git-receive-pack "200 OK" &&
-	POST git-receive-pack 0000 "200 OK"
-'
-test_expect_success 'http.receivepack false' '
-	log_div "receivepack false"
-	config http.receivepack false &&
-	GET info/refs?service=git-receive-pack "403 Forbidden" &&
-	POST git-receive-pack 0000 "403 Forbidden"
-'
-
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
-test_expect_success 'http-backend blocks bad PATH_INFO' '
-	config http.getanyfile true &&
-
-	run_backend 0 /repo.git/HEAD &&
-
-	run_backend 1 /repo.git/../HEAD &&
-	run_backend 1 /../etc/passwd &&
-	run_backend 1 ../etc/passwd &&
-	run_backend 1 /etc//passwd &&
-	run_backend 1 /etc/./passwd &&
-	run_backend 1 /etc/.../passwd &&
-	run_backend 1 //domain/data.txt
-'
+. "$TEST_DIRECTORY"/t556x_common
 
 cat >exp <<EOF
 
diff --git a/t/t5561-http-backend-noserver.sh b/t/t5561-http-backend-noserver.sh
new file mode 100755
index 0000000..501b328
--- /dev/null
+++ b/t/t5561-http-backend-noserver.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='test git-http-backend-noserver'
+. ./test-lib.sh
+
+HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
+
+GET() {
+    return 0
+}
+
+POST() {
+    return 0
+}
+
+logdiv() {
+    return 0
+}
+
+. "$TEST_DIRECTORY"/t556x_common
+
+run_backend() {
+	REQUEST_METHOD=GET \
+	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
+	PATH_INFO="$2" \
+	git http-backend >act.out 2>act.err
+}
+
+path_info() {
+	if test $1 = 0; then
+		run_backend "$2"
+	else
+		test_must_fail run_backend "$2" &&
+		echo "fatal: '$2': aliased" >exp.err &&
+		test_cmp exp.err act.err
+	fi
+}
+
+test_expect_success 'http-backend blocks bad PATH_INFO' '
+	config http.getanyfile true &&
+
+	run_backend 0 /repo.git/HEAD &&
+
+	run_backend 1 /repo.git/../HEAD &&
+	run_backend 1 /../etc/passwd &&
+	run_backend 1 ../etc/passwd &&
+	run_backend 1 /etc//passwd &&
+	run_backend 1 /etc/./passwd &&
+	run_backend 1 /etc/.../passwd &&
+	run_backend 1 //domain/data.txt
+'
+test_done
diff --git a/t/t556x_common b/t/t556x_common
new file mode 100755
index 0000000..1845072
--- /dev/null
+++ b/t/t556x_common
@@ -0,0 +1,105 @@
+#!/bin/sh
+
+find_file() {
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	find $1 -type f |
+	sed -e 1q
+}
+
+config() {
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config $1 $2
+}
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init &&
+	 : >objects/info/alternates &&
+	 : >objects/info/http-alternates
+	) &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master &&
+
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git repack -a -d
+	) &&
+
+	echo other >file &&
+	git add file &&
+	git commit -m two &&
+	git push public master:master &&
+
+	LOOSE_URL=$(find_file objects/??) &&
+	PACK_URL=$(find_file objects/pack/*.pack) &&
+	IDX_URL=$(find_file objects/pack/*.idx)
+'
+
+get_static_files() {
+	GET HEAD "$1" &&
+	GET info/refs "$1" &&
+	GET objects/info/packs "$1" &&
+	GET objects/info/alternates "$1" &&
+	GET objects/info/http-alternates "$1" &&
+	GET $LOOSE_URL "$1" &&
+	GET $PACK_URL "$1" &&
+	GET $IDX_URL "$1"
+}
+
+test_expect_success 'direct refs/heads/master not found' '
+	log_div "refs/heads/master"
+	GET refs/heads/master "404 Not Found"
+'
+test_expect_success 'static file is ok' '
+	log_div "getanyfile default"
+	get_static_files "200 OK"
+'
+test_expect_success 'static file if http.getanyfile true is ok' '
+	log_div "getanyfile true"
+	config http.getanyfile true &&
+	get_static_files "200 OK"
+'
+test_expect_success 'static file if http.getanyfile false fails' '
+	log_div "getanyfile false"
+	config http.getanyfile false &&
+	get_static_files "403 Forbidden"
+'
+
+test_expect_success 'http.uploadpack default enabled' '
+	log_div "uploadpack default"
+	GET info/refs?service=git-upload-pack "200 OK"  &&
+	POST git-upload-pack 0000 "200 OK"
+'
+test_expect_success 'http.uploadpack true' '
+	log_div "uploadpack true"
+	config http.uploadpack true &&
+	GET info/refs?service=git-upload-pack "200 OK" &&
+	POST git-upload-pack 0000 "200 OK"
+'
+test_expect_success 'http.uploadpack false' '
+	log_div "uploadpack false"
+	config http.uploadpack false &&
+	GET info/refs?service=git-upload-pack "403 Forbidden" &&
+	POST git-upload-pack 0000 "403 Forbidden"
+'
+
+test_expect_success 'http.receivepack default disabled' '
+	log_div "receivepack default"
+	GET info/refs?service=git-receive-pack "403 Forbidden"  &&
+	POST git-receive-pack 0000 "403 Forbidden"
+'
+test_expect_success 'http.receivepack true' '
+	log_div "receivepack true"
+	config http.receivepack true &&
+	GET info/refs?service=git-receive-pack "200 OK" &&
+	POST git-receive-pack 0000 "200 OK"
+'
+test_expect_success 'http.receivepack false' '
+	log_div "receivepack false"
+	config http.receivepack false &&
+	GET info/refs?service=git-receive-pack "403 Forbidden" &&
+	POST git-receive-pack 0000 "403 Forbidden"
+'
-- 
1.6.6.62.g67314
