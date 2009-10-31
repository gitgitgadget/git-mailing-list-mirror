From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 00/28] interdiff to v4
Date: Fri, 30 Oct 2009 17:47:19 -0700
Message-ID: <1256950067-27938-2-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N428a-0001cH-UV
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588AbZJaArw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbZJaArw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:47:52 -0400
Received: from george.spearce.org ([209.20.77.23]:36900 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757562AbZJaArp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:45 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 00C4E38221; Sat, 31 Oct 2009 00:47:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4AF4B381D3
	for <git@vger.kernel.org>; Sat, 31 Oct 2009 00:47:48 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131786>

diff --git a/pkt-line.c b/pkt-line.c
index 893dd3c..295ba2b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -124,14 +124,12 @@ static int packet_length(const char *linelen)
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
 	int len;
-	char linelen[5];
+	char linelen[4];
 
 	safe_read(fd, linelen, 4);
 	len = packet_length(linelen);
-	if (len < 0) {
-		linelen[4] = '\0';
-		die("protocol error: bad line length character: %s", linelen);
-	}
+	if (len < 0)
+		die("protocol error: bad line length character: %.4s", linelen);
 	if (!len)
 		return 0;
 	len -= 4;
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 2098ce0..0fe3fd0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -8,20 +8,22 @@ ErrorLog error.log
 <IfModule !mod_log_config.c>
 	LoadModule log_config_module modules/mod_log_config.so
 </IfModule>
-<IfModule !mod_cgi.c>
-	LoadModule cgi_module modules/mod_cgi.so
-</IfModule>
 <IfModule !mod_alias.c>
 	LoadModule alias_module modules/mod_alias.so
 </IfModule>
+<IfModule !mod_cgi.c>
+	LoadModule cgi_module modules/mod_cgi.so
+</IfModule>
 <IfModule !mod_env.c>
 	LoadModule env_module modules/mod_env.so
 </IfModule>
 
-<Location /git/>
+Alias /dumb/ www/
+
+<Location /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 </Location>
-ScriptAlias /git/ ${GIT_EXEC_PATH}/git-http-backend/
+ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
 <Directory ${GIT_EXEC_PATH}>
 	Options None
 </Directory>
@@ -46,7 +48,7 @@ SSLEngine On
 	LoadModule dav_fs_module modules/mod_dav_fs.so
 
 	DAVLockDB DAVLock
-	<Location />
+	<Location /dumb/>
 		Dav on
 	</Location>
 </IfDefine>
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5c0f4d7..bb18f8b 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -9,17 +9,16 @@ This test runs various sanity checks on http-push.'
 
 . ./test-lib.sh
 
-ROOT_PATH="$PWD"
-LIB_HTTPD_DAV=t
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
-
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
 	say "skipping test, USE_CURL_MULTI is not defined"
 	test_done
 fi
 
+LIB_HTTPD_DAV=t
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5540'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
+ROOT_PATH="$PWD"
 start_httpd
 
 test_expect_success 'setup remote repository' '
@@ -43,7 +42,7 @@ test_expect_success 'setup remote repository' '
 
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/test_repo.git test_repo_clone
+	git clone $HTTPD_URL/dumb/test_repo.git test_repo_clone
 '
 
 test_expect_success 'push to remote repository with packed refs' '
@@ -76,7 +75,7 @@ test_expect_success 'http-push fetches unpacked objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
 
-	git clone $HTTPD_URL/test_repo_unpacked.git \
+	git clone $HTTPD_URL/dumb/test_repo_unpacked.git \
 		"$ROOT_PATH"/fetch_unpacked &&
 
 	# By reset, we force git to retrieve the object
@@ -85,14 +84,14 @@ test_expect_success 'http-push fetches unpacked objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_unpacked.git master)
 '
 
 test_expect_success 'http-push fetches packed objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
 
-	git clone $HTTPD_URL/test_repo_packed.git \
+	git clone $HTTPD_URL/dumb/test_repo_packed.git \
 		"$ROOT_PATH"/test_repo_clone_packed &&
 
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
@@ -105,7 +104,7 @@ test_expect_success 'http-push fetches packed objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_packed.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_packed.git master)
 '
 
 test_expect_success 'create and delete remote branch' '
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 690c466..2a58d0c 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -12,7 +12,7 @@ if test -n "$NO_CURL"; then
 fi
 
 ROOT_PATH="$PWD"
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5541'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
@@ -36,10 +36,10 @@ test_expect_success 'setup remote repository' '
 
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/git/test_repo.git test_repo_clone
+	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
 '
 
-test_expect_success 'push to remote repository with packed refs' '
+test_expect_success 'push to remote repository' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -55,15 +55,6 @@ test_expect_success 'push already up-to-date' '
 	git push
 '
 
-test_expect_success 'push to remote repository with unpacked refs' '
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 rm packed-refs &&
-	 git update-ref refs/heads/master $ORIG_HEAD) &&
-	git push &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 test $HEAD = $(git rev-parse --verify HEAD))
-'
-
 test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
@@ -77,17 +68,15 @@ test_expect_success 'create and delete remote branch' '
 '
 
 cat >exp <<EOF
-GET  /git/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /git/test_repo.git/git-upload-pack HTTP/1.1 200
-GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /git/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /git/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
+GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
 	sed -e "
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 8d6443f..8cfce96 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -30,7 +30,7 @@ test_expect_success 'create http-accessible bare repository' '
 '
 
 test_expect_success 'clone http repository' '
-	git clone $HTTPD_URL/repo.git clone &&
+	git clone $HTTPD_URL/dumb/repo.git clone &&
 	test_cmp file clone/file
 '
 
@@ -58,7 +58,7 @@ test_expect_success 'fetch packed objects' '
 	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
 	git --bare repack &&
 	git --bare prune-packed &&
-	git clone $HTTPD_URL/repo_pack.git
+	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
 test_expect_success 'did not use upload-pack service' '
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index afddc2c..eb0c039 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -8,7 +8,7 @@ if test -n "$NO_CURL"; then
 	test_done
 fi
 
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5550'}
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5551'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
@@ -28,19 +28,21 @@ test_expect_success 'create http-accessible bare repository' '
 '
 
 cat >exp <<EOF
-> GET /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1
-Accept: */*
-Pragma: no-cache
+> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
+> Accept: */*
+> Pragma: no-cache
+
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
 < 
-> POST /git/repo.git/git-upload-pack HTTP/1.1
-Accept-Encoding: deflate, gzip
-Content-Type: application/x-git-upload-pack-request
-Accept: application/x-git-upload-pack-response
-Content-Length: xxxx
+> POST /smart/repo.git/git-upload-pack HTTP/1.1
+> Accept-Encoding: deflate, gzip
+> Content-Type: application/x-git-upload-pack-request
+> Accept: application/x-git-upload-pack-response
+> Content-Length: xxx
+
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
@@ -48,13 +50,26 @@ Content-Length: xxxx
 < 
 EOF
 test_expect_success 'clone http repository' '
-	GIT_CURL_VERBOSE=1 git clone $HTTPD_URL/git/repo.git clone 2>err &&
+	GIT_CURL_VERBOSE=1 git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
-	egrep "^([<>]|Pragma|Accept|Content-|Transfer-)" err |
-	egrep -v "^< (Server|Expires|Date|Content-Length:|Transfer-Encoding: chunked)" |
+	tr '\''\015'\'' Q <err |
 	sed -e "
-		s/
//
-		s/^Content-Length: .*$/Content-Length: xxxx/
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
 	" >act &&
 	test_cmp exp act
 '
@@ -68,10 +83,10 @@ test_expect_success 'fetch changes via http' '
 '
 
 cat >exp <<EOF
-GET  /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /git/repo.git/git-upload-pack HTTP/1.1 200
-GET  /git/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /git/repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
 	sed -e "
