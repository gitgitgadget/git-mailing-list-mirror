From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 28/28] test smart http fetch and push
Date: Fri, 30 Oct 2009 17:47:47 -0700
Message-ID: <1256950067-27938-30-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429v-0001yQ-Jn
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbZJaAtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbZJaAtL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:49:11 -0400
Received: from george.spearce.org ([209.20.77.23]:36974 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbZJaAsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:48:03 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7C1A0381FF; Sat, 31 Oct 2009 00:48:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 7ACEA38221
	for <git@vger.kernel.org>; Sat, 31 Oct 2009 00:47:58 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131810>

The top level directory "/smart/" of the test Apache server is mapped
through our git-http-backend CGI, but uses the same underlying
repository space as the server's document root.  This is the most
simple installation possible.

Server logs are checked to verify the client has accessed only the
smart URLs during the test.  During fetch testing the headers are
also logged from libcurl to ensure we are making a reasonably sane
HTTP request, and getting back reasonably sane response headers
from the CGI.

When validating the request headers used during smart fetch we munge
away the actual Content-Length and replace it with the placeholder
"xxx".  This avoids unnecessary varability in the test caused by
an unrelated change in the requested capabilities in the first want
line of the request.  However, we still want to look for and verify
that Content-Length was used, because smaller payloads should be
using Content-Length and not "Transfer-Encoding: chunked".

When validating the server response headers we must discard both
Content-Length and Transfer-Encoding, as Apache2 can use either
format to return our response.

During development of this test I observed Apache returning both
forms, depending on when the processes got CPU time.  If our CGI
returned the pack data quickly, Apache just buffered the whole
thing and returned a Content-Length.  If our CGI took just a bit
too long to complete, Apache flushed its buffer and instead used
"Transfer-Encoding: chunked".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/lib-httpd/apache.conf |   17 ++++++++
 t/t5540-http-push.sh    |    2 +-
 t/t5541-http-push.sh    |   92 ++++++++++++++++++++++++++++++++++++++++++
 t/t5550-http-fetch.sh   |    8 +++-
 t/t5551-http-fetch.sh   |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 219 insertions(+), 2 deletions(-)
 create mode 100755 t/t5541-http-push.sh
 create mode 100755 t/t5551-http-fetch.sh

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 47a438f..0fe3fd0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -11,9 +11,26 @@ ErrorLog error.log
 <IfModule !mod_alias.c>
 	LoadModule alias_module modules/mod_alias.so
 </IfModule>
+<IfModule !mod_cgi.c>
+	LoadModule cgi_module modules/mod_cgi.so
+</IfModule>
+<IfModule !mod_env.c>
+	LoadModule env_module modules/mod_env.so
+</IfModule>
 
 Alias /dumb/ www/
 
+<Location /smart/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+</Location>
+ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
+<Directory ${GIT_EXEC_PATH}>
+	Options None
+</Directory>
+<Files ${GIT_EXEC_PATH}/git-http-backend>
+	Options ExecCGI
+</Files>
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 4a9450e..bb18f8b 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-test_description='test http-push
+test_description='test WebDAV http-push
 
 This test runs various sanity checks on http-push.'
 
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
new file mode 100755
index 0000000..2a58d0c
--- /dev/null
+++ b/t/t5541-http-push.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
+#
+
+test_description='test smart pushing over http via http-backend'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+ROOT_PATH="$PWD"
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5541'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup remote repository' '
+	cd "$ROOT_PATH" &&
+	mkdir test_repo &&
+	cd test_repo &&
+	git init &&
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -m initial &&
+	cd - &&
+	git clone --bare test_repo test_repo.git &&
+	cd test_repo.git &&
+	git config http.receivepack true &&
+	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
+	cd - &&
+	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
+'
+
+test_expect_success 'clone remote repository' '
+	cd "$ROOT_PATH" &&
+	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path2 &&
+	git add path2 &&
+	test_tick &&
+	git commit -m path2 &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	git push &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
+'
+
+test_expect_success 'push already up-to-date' '
+	git push
+'
+
+test_expect_success 'create and delete remote branch' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout -b dev &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -m dev &&
+	git push origin dev &&
+	git push origin :dev &&
+	test_must_fail git show-ref --verify refs/remotes/origin/dev
+'
+
+cat >exp <<EOF
+GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+EOF
+test_expect_success 'used receive-pack service' '
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
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 776057c..8cfce96 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test fetching over http'
+test_description='test dumb fetching over http via static file'
 . ./test-lib.sh
 
 if test -n "$NO_CURL"; then
@@ -61,5 +61,11 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'did not use upload-pack service' '
+	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
+	: >exp
+	test_cmp exp act
+'
+
 stop_httpd
 test_done
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
new file mode 100755
index 0000000..eb0c039
--- /dev/null
+++ b/t/t5551-http-fetch.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+
+test_description='test smart fetching over http via http-backend'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5551'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create http-accessible bare repository' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init
+	) &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+cat >exp <<EOF
+> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
+> Accept: */*
+> Pragma: no-cache
+
+< HTTP/1.1 200 OK
+< Pragma: no-cache
+< Cache-Control: no-cache, max-age=0, must-revalidate
+< Content-Type: application/x-git-upload-pack-advertisement
+< 
+> POST /smart/repo.git/git-upload-pack HTTP/1.1
+> Accept-Encoding: deflate, gzip
+> Content-Type: application/x-git-upload-pack-request
+> Accept: application/x-git-upload-pack-response
+> Content-Length: xxx
+
+< HTTP/1.1 200 OK
+< Pragma: no-cache
+< Cache-Control: no-cache, max-age=0, must-revalidate
+< Content-Type: application/x-git-upload-pack-result
+< 
+EOF
+test_expect_success 'clone http repository' '
+	GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
+	test_cmp file clone/file &&
+	tr '\''\015'\'' Q <err |
+	sed -e "
+		s/Q\$//
+		/^[*] /d
+
+		/^[^><]/{
+			s/^/> /
+		}
+
+		/^> User-Agent: /d
+		/^> Host: /d
+		s/^> Content-Length: .*/> Content-Length: xxx/
+
+		/^< Server: /d
+		/^< Expires: /d
+		/^< Date: /d
+		/^< Content-Length: /d
+		/^< Transfer-Encoding: /d
+	" >act &&
+	test_cmp exp act
+'
+
+test_expect_success 'fetch changes via http' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public
+	(cd clone && git pull) &&
+	test_cmp file clone/file
+'
+
+cat >exp <<EOF
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+EOF
+test_expect_success 'used upload-pack service' '
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
-- 
1.6.5.2.181.gd6f41
