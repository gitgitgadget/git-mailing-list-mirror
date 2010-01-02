From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v4 2/3] Smart-http tests: Break test t5560-http-backend into pieces
Date: Sat,  2 Jan 2010 13:38:06 -0800
Message-ID: <1262468287-8629-2-git-send-email-tarmigan+git@gmail.com>
References: <20100102205928.GM6914@spearce.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:38:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBg7-0008GD-4P
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab0ABViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149Ab0ABViV
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:38:21 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:46611 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0ABViU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:38:20 -0500
Received: by mail-gx0-f211.google.com with SMTP id 3so1824960gxk.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9EbwNGFAN0ujKrJjqO8D/PMJ9OHmhbhaxudKuC3GW7k=;
        b=tzp8PxhKv0oJsx/MMJKKWrGmwdecE4Tk7xZOwelG7c4wNrz1vHlahYR+RAnRxvfqBc
         kMZAEDR1nyWM58tBHySeggs6TaRrDXl8tMxM89Q31tczE0OTnZSWx5uvDEEUSbFRWTtl
         rLTtDcNlLZ2oggz4m95uqxfjTo+f15GSBmJ5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=mu/1MKMC49+eLPb1cmNJR389rd5KSwCUq0WiL8FaifvfIrnjZ7+0Ry9vUf3q+3JrIM
         aKFXD0u2I/aMVwixB/otMioPCsZFYZd0cDiAu7SUB9We5oNsAL/K/UTibQ2rAVbW+CMh
         RiiYRFOg1UNn0JQxt6JyYBrd9QlSa/U8+FF5A=
Received: by 10.150.239.16 with SMTP id m16mr31515022ybh.289.1262468299605;
        Sat, 02 Jan 2010 13:38:19 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 5sm6538971yxg.10.2010.01.02.13.38.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:38:18 -0800 (PST)
X-Mailer: git-send-email 1.6.6.236.gc56f3
In-Reply-To: <20100102205928.GM6914@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136057>

This should introduce no functional change in the tests or the amount
of test coverage.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 t/t5560-http-backend-noserver.sh |   52 +++++++
 t/t5560-http-backend.sh          |  294 --------------------------------------
 t/t5561-http-backend.sh          |  149 +++++++++++++++++++
 t/t556x_common                   |  119 +++++++++++++++
 4 files changed, 320 insertions(+), 294 deletions(-)
 create mode 100755 t/t5560-http-backend-noserver.sh
 delete mode 100755 t/t5560-http-backend.sh
 create mode 100755 t/t5561-http-backend.sh
 create mode 100755 t/t556x_common

diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
new file mode 100755
index 0000000..a9ba2d9
--- /dev/null
+++ b/t/t5560-http-backend-noserver.sh
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
diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
deleted file mode 100755
index 0e4dc4b..0000000
--- a/t/t5560-http-backend.sh
+++ /dev/null
@@ -1,294 +0,0 @@
-#!/bin/sh
-
-test_description='test git-http-backend'
-. ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
-	test_done
-fi
-
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5560'}
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
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
-GET() {
-	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
-	tr '\015' Q <out |
-	sed '
-		s/Q$//
-		1q
-	' >act &&
-	echo "HTTP/1.1 $2" >exp &&
-	test_cmp exp act
-}
-
-POST() {
-	curl --include --data "$2" \
-	--header "Content-Type: application/x-$1-request" \
-	"$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
-	tr '\015' Q <out |
-	sed '
-		s/Q$//
-		1q
-	' >act &&
-	echo "HTTP/1.1 $3" >exp &&
-	test_cmp exp act
-}
-
-log_div() {
-	echo >>"$HTTPD_ROOT_PATH"/access.log
-	echo "###  $1" >>"$HTTPD_ROOT_PATH"/access.log
-	echo "###" >>"$HTTPD_ROOT_PATH"/access.log
-}
-
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
-
-cat >exp <<EOF
-
-###  refs/heads/master
-###
-GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
-
-###  getanyfile default
-###
-GET  /smart/repo.git/HEAD HTTP/1.1 200
-GET  /smart/repo.git/info/refs HTTP/1.1 200
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
-GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
-GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
-GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
-
-###  no git-daemon-export-ok
-###
-GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404 -
-
-###  git-daemon-export-ok
-###
-GET  /smart_noexport/repo.git/HEAD HTTP/1.1 200
-GET  /smart_noexport/repo.git/info/refs HTTP/1.1 200
-GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 200
-GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 200 -
-GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 200 -
-GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 200
-GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 200
-GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 200
-
-###  getanyfile true
-###
-GET  /smart/repo.git/HEAD HTTP/1.1 200
-GET  /smart/repo.git/info/refs HTTP/1.1 200
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
-GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
-GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
-GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
-
-###  getanyfile false
-###
-GET  /smart/repo.git/HEAD HTTP/1.1 403 -
-GET  /smart/repo.git/info/refs HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
-GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 403 -
-GET  /smart/repo.git/$PACK_URL HTTP/1.1 403 -
-GET  /smart/repo.git/$IDX_URL HTTP/1.1 403 -
-
-###  uploadpack default
-###
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
-
-###  uploadpack true
-###
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
-
-###  uploadpack false
-###
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
-
-###  receivepack default
-###
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
-
-###  receivepack true
-###
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
-
-###  receivepack false
-###
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
-EOF
-test_expect_success 'server request log matches test results' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
-	test_cmp exp act
-'
-
-stop_httpd
-test_done
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
new file mode 100755
index 0000000..8c6d0b2
--- /dev/null
+++ b/t/t5561-http-backend.sh
@@ -0,0 +1,149 @@
+#!/bin/sh
+
+test_description='test git-http-backend'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5561'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+GET() {
+	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
+	tr '\015' Q <out |
+	sed '
+		s/Q$//
+		1q
+	' >act &&
+	echo "HTTP/1.1 $2" >exp &&
+	test_cmp exp act
+}
+
+POST() {
+	curl --include --data "$2" \
+	--header "Content-Type: application/x-$1-request" \
+	"$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	tr '\015' Q <out |
+	sed '
+		s/Q$//
+		1q
+	' >act &&
+	echo "HTTP/1.1 $3" >exp &&
+	test_cmp exp act
+}
+
+log_div() {
+	echo >>"$HTTPD_ROOT_PATH"/access.log
+	echo "###  $1" >>"$HTTPD_ROOT_PATH"/access.log
+	echo "###" >>"$HTTPD_ROOT_PATH"/access.log
+}
+
+. "$TEST_DIRECTORY"/t556x_common
+
+cat >exp <<EOF
+
+###  refs/heads/master
+###
+GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
+
+###  getanyfile default
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 200
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
+
+###  no git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404 -
+
+###  git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 200
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 200
+
+###  getanyfile true
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 200
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
+
+###  getanyfile false
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 403 -
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 403 -
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 403 -
+
+###  uploadpack default
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
+
+###  uploadpack true
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
+
+###  uploadpack false
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
+
+###  receivepack default
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+
+###  receivepack true
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
+
+###  receivepack false
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+EOF
+test_expect_success 'server request log matches test results' '
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	test_cmp exp act
+'
+
+stop_httpd
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
1.6.6.236.gc56f3
