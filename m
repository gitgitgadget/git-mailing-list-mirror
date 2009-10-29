From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Wed, 28 Oct 2009 17:00:48 -0700
Message-ID: <1256774448-7625-27-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISp-0000kN-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbZJ2ABR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbZJ2ABN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:13 -0400
Received: from george.spearce.org ([209.20.77.23]:36276 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbZJ2ABC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:01:02 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id BB56838215; Thu, 29 Oct 2009 00:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 03B5238268
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131524>

The top level directory "/git/" of the test Apache server is mapped
through our git-http-backend CGI, but uses the same underlying
repository space as the server's document root.  This is the most
simple installation possible.

Server logs are checked to verify the client has accessed only the
smart URLs during the test.  During fetch testing the headers are
also logged from libcurl to ensure we are making a reasonably sane
HTTP request, and getting back reasonably sane response headers
from the CGI.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/lib-httpd/apache.conf |   20 +++++++++
 t/t5540-http-push.sh    |    2 +-
 t/t5541-http-push.sh    |  103 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t5550-http-fetch.sh   |    8 +++-
 t/t5551-http-fetch.sh   |   87 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 218 insertions(+), 2 deletions(-)
 create mode 100755 t/t5541-http-push.sh
 create mode 100755 t/t5551-http-fetch.sh

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 21aa42f..2098ce0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -8,6 +8,26 @@ ErrorLog error.log
 <IfModule !mod_log_config.c>
 	LoadModule log_config_module modules/mod_log_config.so
 </IfModule>
+<IfModule !mod_cgi.c>
+	LoadModule cgi_module modules/mod_cgi.so
+</IfModule>
+<IfModule !mod_alias.c>
+	LoadModule alias_module modules/mod_alias.so
+</IfModule>
+<IfModule !mod_env.c>
+	LoadModule env_module modules/mod_env.so
+</IfModule>
+
+<Location /git/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+</Location>
+ScriptAlias /git/ ${GIT_EXEC_PATH}/git-http-backend/
+<Directory ${GIT_EXEC_PATH}>
+	Options None
+</Directory>
+<Files ${GIT_EXEC_PATH}/git-http-backend>
+	Options ExecCGI
+</Files>
 
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 28a746e..5c0f4d7 100755
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
index 0000000..690c466
--- /dev/null
+++ b/t/t5541-http-push.sh
@@ -0,0 +1,103 @@
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
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
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
+	git clone $HTTPD_URL/git/test_repo.git test_repo_clone
+'
+
+test_expect_success 'push to remote repository with packed refs' '
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
+test_expect_success 'push to remote repository with unpacked refs' '
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 rm packed-refs &&
+	 git update-ref refs/heads/master $ORIG_HEAD) &&
+	git push &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD))
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
+GET  /git/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /git/test_repo.git/git-upload-pack HTTP/1.1 200
+GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
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
index 0e69324..8d6443f 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test fetching over http'
+test_description='test dumb fetching over http via static file'
 . ./test-lib.sh
 
 if test -n "$NO_CURL"; then
@@ -61,5 +61,11 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/repo_pack.git
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
index 0000000..afddc2c
--- /dev/null
+++ b/t/t5551-http-fetch.sh
@@ -0,0 +1,87 @@
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
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
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
+> GET /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1
+Accept: */*
+Pragma: no-cache
+< HTTP/1.1 200 OK
+< Pragma: no-cache
+< Cache-Control: no-cache, max-age=0, must-revalidate
+< Content-Type: application/x-git-upload-pack-advertisement
+< 
+> POST /git/repo.git/git-upload-pack HTTP/1.1
+Accept-Encoding: deflate, gzip
+Content-Type: application/x-git-upload-pack-request
+Accept: application/x-git-upload-pack-response
+Content-Length: xxxx
+< HTTP/1.1 200 OK
+< Pragma: no-cache
+< Cache-Control: no-cache, max-age=0, must-revalidate
+< Content-Type: application/x-git-upload-pack-result
+< 
+EOF
+test_expect_success 'clone http repository' '
+	GIT_CURL_VERBOSE=1 git clone $HTTPD_URL/git/repo.git clone 2>err &&
+	test_cmp file clone/file &&
+	egrep "^([<>]|Pragma|Accept|Content-|Transfer-)" err |
+	egrep -v "^< (Server|Expires|Date|Content-Length:|Transfer-Encoding: chunked)" |
+	sed -e "
+		s/
//
+		s/^Content-Length: .*$/Content-Length: xxxx/
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
+GET  /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /git/repo.git/git-upload-pack HTTP/1.1 200
+GET  /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /git/repo.git/git-upload-pack HTTP/1.1 200
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
