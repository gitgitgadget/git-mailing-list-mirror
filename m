From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v3 2/3] Smart-http tests: Break test t5560-http-backend into pieces
Date: Sat,  2 Jan 2010 12:45:18 -0800
Message-ID: <1262465119-96115-2-git-send-email-tarmigan+git@gmail.com>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com>
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 21:46:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRArM-0001QV-8u
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 21:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0ABUpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031Ab0ABUpo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 15:45:44 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52644 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0ABUpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 15:45:43 -0500
Received: by ywh6 with SMTP id 6so14212004ywh.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 12:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ZdSWC3qZe77KcZVh6EdEKvpSWazpLK3ORcGRig0Bp/o=;
        b=wMlZEtCxRlQpdVj7jzvp0ane6Coui8Tiegfes5ilKAaXvHEmo0wGqHDAcenAPj2T3q
         /HBtfK/9ljAyhzoHy9SznNNBBZ84lx3YB9JzYGaE3F3KdbVAree9WHzXhWMsivcV+tax
         clbRrTDoWGC08Ld86K3bGq1jFmputEaepM/O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=QGWxLbaXm+OXJKBrVjGQI9LNcTUOgntOZaXxX3GKRdCn6bNp58hU2DbIIrT56E3/SE
         SCBUHwu15/KZgiDE4AcVyF69Al8cJSYHmrb/QYpdbA1aAXQLQ8MFy+u45cm2mqpVF3lW
         o3erJKvp3QsDZOWIEmu29y3virWE+X49Tmd4c=
Received: by 10.150.128.31 with SMTP id a31mr4446713ybd.73.1262465142553;
        Sat, 02 Jan 2010 12:45:42 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 5sm6541697yxd.35.2010.01.02.12.45.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 12:45:41 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136047>

This should introduce no functional change in the tests or the amount
of test coverage.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 t/t5560-http-backend.sh          |  147 +-------------------------------------
 t/t5561-http-backend-noserver.sh |   52 +++++++++++++
 t/t556x_common                   |  119 ++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 146 deletions(-)
 create mode 100755 t/t5561-http-backend-noserver.sh
 create mode 100755 t/t556x_common

diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index 0e4dc4b..dd844d3 100755
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
@@ -52,142 +42,7 @@ log_div() {
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
-	PATH_INFO="$1" \
-	git http-backend >act.out 2>act.err
-}
-
-expect_aliased() {
-	if test $1 = 0; then
-		run_backend "$2"
-	else
-		run_backend "$2" &&
-		echo "fatal: '$2': aliased" >exp.err &&
-		test_cmp exp.err act.err
-	fi
-}
-
-test_expect_success 'http-backend blocks bad PATH_INFO' '
-	config http.getanyfile true &&
-
-	expect_aliased 0 /repo.git/HEAD &&
-
-	expect_aliased 1 /repo.git/../HEAD &&
-	expect_aliased 1 /../etc/passwd &&
-	expect_aliased 1 ../etc/passwd &&
-	expect_aliased 1 /etc//passwd &&
-	expect_aliased 1 /etc/./passwd &&
-	expect_aliased 1 //domain/data.txt
-'
+. "$TEST_DIRECTORY"/t556x_common
 
 cat >exp <<EOF
 
diff --git a/t/t5561-http-backend-noserver.sh b/t/t5561-http-backend-noserver.sh
new file mode 100755
index 0000000..a9ba2d9
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
+run_backend() {
+	REQUEST_METHOD=GET \
+	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
+	PATH_INFO="$1" \
+	git http-backend >act.out 2>act.err
+}
+
+GET() {
+	return 0
+}
+
+POST() {
+	return 0
+}
+
+log_div() {
+	return 0
+}
+
+. "$TEST_DIRECTORY"/t556x_common
+
+expect_aliased() {
+	if test $1 = 0; then
+		run_backend "$2"
+	else
+		run_backend "$2" &&
+		echo "fatal: '$2': aliased" >exp.err &&
+		test_cmp exp.err act.err
+	fi
+}
+
+test_expect_success 'http-backend blocks bad PATH_INFO' '
+	config http.getanyfile true &&
+
+	expect_aliased 0 /repo.git/HEAD &&
+
+	expect_aliased 1 /repo.git/../HEAD &&
+	expect_aliased 1 /../etc/passwd &&
+	expect_aliased 1 ../etc/passwd &&
+	expect_aliased 1 /etc//passwd &&
+	expect_aliased 1 /etc/./passwd &&
+	expect_aliased 1 //domain/data.txt
+'
+
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
