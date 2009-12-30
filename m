From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend into pieces
Date: Wed, 30 Dec 2009 13:59:01 -0500
Message-ID: <1262199542-73876-1-git-send-email-tarmigan+git@gmail.com>
References: <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com>
Cc: spearce@spearce.org, gitster@pobox.com,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 19:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ3lS-0007iQ-16
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 19:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbZL3S7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 13:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbZL3S7R
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 13:59:17 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:60946 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZL3S7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 13:59:16 -0500
Received: by qyk30 with SMTP id 30so5652484qyk.33
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ktgl1zFZdLxA6NimRpo2oqUQ53cFsXVXG3CTTJe/NfA=;
        b=DjCNO4/HwUkbnx/4QdNyBCtDC/YzkhUdbF7rs/Ev1pCo1DeUejGMBNtLSpPainoOYr
         OcvlF+fqnO7TNsQq8BzWv9G1IucdAWC2H27d1whMKleiQderRpqmFSzHT0F3ger90ktS
         LekSDfY/kihfJQt7Eat4700HSgW+5/WHor2XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=mO/Wb8Bhu690XYyiQhS2CMMKFbEFJmbPhX0YAgZNe264R71K+oIRyZ6dbI6zSxjFAX
         OayV27IJVNILcS7hF5vqnUP2Iara3ZDsYBhk7+EldAAUxO7BFuF2PCLX6coMg/Z7JK3P
         2W6mJED1T3C0Idx30s/8yNsInhw9JTbqxe4Zc=
Received: by 10.224.18.26 with SMTP id u26mr8887870qaa.215.1262199555379;
        Wed, 30 Dec 2009 10:59:15 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 5sm37373683qwg.58.2009.12.30.10.59.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 10:59:14 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <905315640912301009x491f957al839f66de7aba56ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135914>

This should introduce no functional change in the tests or the amount
of test coverage.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
This is rebased on top of today's pu and the conflicts should be fixed.

 t/t5560-http-backend.sh          |  148 +-------------------------------------
 t/t5561-http-backend-noserver.sh |   52 +++++++++++++
 t/t556x_common                   |  119 ++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 147 deletions(-)
 create mode 100755 t/t5561-http-backend-noserver.sh
 create mode 100755 t/t556x_common

diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index 04a9896..dd844d3 100755
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
 	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
 	tr '\015' Q <out |
@@ -52,143 +42,7 @@ log_div() {
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
-SMART=smart
-test_expect_success 'direct refs/heads/master not found' '
-	log_div "refs/heads/master"
-	GET refs/heads/master "404 Not Found"
-'
-test_expect_success 'static file is ok' '
-	log_div "getanyfile default"
-	get_static_files "200 OK"
-'
-SMART=smart_noexport
-test_expect_success 'no export by default' '
-	log_div "no git-daemon-export-ok"
-	get_static_files "404 Not Found"
-'
-test_expect_success 'export if git-daemon-export-ok' '
-	log_div "git-daemon-export-ok"
-        (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	 touch git-daemon-export-ok
-	) &&
-        get_static_files "200 OK"
-'
-SMART=smart
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
index 0000000..1b4921c
--- /dev/null
+++ b/t/t556x_common
@@ -0,0 +1,119 @@
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
+SMART=smart
+test_expect_success 'direct refs/heads/master not found' '
+	log_div "refs/heads/master"
+	GET refs/heads/master "404 Not Found"
+'
+test_expect_success 'static file is ok' '
+	log_div "getanyfile default"
+	get_static_files "200 OK"
+'
+SMART=smart_noexport
+test_expect_success 'no export by default' '
+	log_div "no git-daemon-export-ok"
+	get_static_files "404 Not Found"
+'
+test_expect_success 'export if git-daemon-export-ok' '
+	log_div "git-daemon-export-ok"
+        (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 touch git-daemon-export-ok
+	) &&
+        get_static_files "200 OK"
+'
+SMART=smart
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
1.6.6
