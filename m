From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCHv2 1/2] t5550: test HTTP authentication and userinfo decoding
Date: Sun, 14 Nov 2010 02:51:14 +0100
Message-ID: <1289699475-11364-2-git-send-email-gabriel.corona@enst-bretagne.fr>
References: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: srabbelier@gmail.com,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 03:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHRvU-0003Pg-K4
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 03:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0KNCC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 21:02:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50158 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395Ab0KNCCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 21:02:25 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 64317A60E8;
	Sun, 14 Nov 2010 03:02:19 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289699475-11364-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161403>

Add a test for HTTP authentication and proper percent-decoding of the
userinfo (username and password) part of the URL.

Signed-off-by: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
---
 t/lib-httpd.sh          |    3 +++
 t/lib-httpd/apache.conf |   29 +++++++++++++++++++++++++++++
 t/lib-httpd/passwd      |    1 +
 t/t5550-http-fetch.sh   |    7 +++++++
 4 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100644 t/lib-httpd/passwd

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index e733f65..3f24384 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -75,12 +75,14 @@ fi
 
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
+	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
 	if test -n "$LIB_HTTPD_SSL"
 	then
 		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
+		AUTH_HTTPD_URL=https://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
 
 		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
 			-config "$TEST_PATH/ssl.cnf" \
@@ -92,6 +94,7 @@ prepare_httpd() {
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
 	else
 		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
+		AUTH_HTTPD_URL=http://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
 	fi
 
 	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4961505..b40e43b 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -17,8 +17,30 @@ ErrorLog error.log
 <IfModule !mod_env.c>
 	LoadModule env_module modules/mod_env.so
 </IfModule>
+<IfModule !mod_version.c>
+	LoadModule version_module modules/mod_version.so
+</IfModule>
+
+<IfVersion < 2.1>
+<IfModule !mod_auth.c>
+	LoadModule auth_module modules/mod_auth.so
+</IfModule>
+</IfVersion>
+
+<IfVersion >= 2.1>
+<IfModule !mod_auth_basic.c>
+	LoadModule auth_basic_module modules/mod_auth_basic.so
+</IfModule>
+<IfModule !mod_authn_file.c>
+	LoadModule authn_file_module modules/mod_authn_file.so
+</IfModule>
+<IfModule !mod_authz_user.c>
+	LoadModule authz_user_module modules/mod_authz_user.so
+</IfModule>
+</IfVersion>
 
 Alias /dumb/ www/
+Alias /auth/ www/auth/
 
 <Location /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
@@ -48,6 +70,13 @@ SSLMutex file:ssl_mutex
 SSLEngine On
 </IfDefine>
 
+<Location /auth/>
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</Location>
+
 <IfDefine DAV>
 	LoadModule dav_module modules/mod_dav.so
 	LoadModule dav_fs_module modules/mod_dav_fs.so
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
new file mode 100644
index 0000000..f2fbcad
--- /dev/null
+++ b/t/lib-httpd/passwd
@@ -0,0 +1 @@
+user@host:nKpa8pZUHx/ic
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 2fb48d0..a0564de 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -34,6 +34,13 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
+test_expect_failure 'clone http repository with authentication' '
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
+	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git" &&
+	git clone $AUTH_HTTPD_URL/auth/repo.git clone-auth &&
+	test_cmp file clone-auth/file
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
1.7.2.3
