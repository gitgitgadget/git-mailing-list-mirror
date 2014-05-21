From: Jeff King <peff@peff.net>
Subject: [PATCH 6/9] t5550: test display of remote http error messages
Date: Wed, 21 May 2014 06:29:55 -0400
Message-ID: <20140521102955.GF30464@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 12:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn3mi-00019R-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 12:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaEUK37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 06:29:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:56416 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752285AbaEUK35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 06:29:57 -0400
Received: (qmail 32547 invoked by uid 102); 21 May 2014 10:29:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 05:29:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 06:29:55 -0400
Content-Disposition: inline
In-Reply-To: <20140521102524.GA30301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249786>

Since commit 426e70d (remote-curl: show server content on
http errors, 2013-04-05), we relay any text/plain error
messages from the remote server to the user. However, we
never tested it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh             |  1 +
 t/lib-httpd/apache.conf    |  4 ++++
 t/lib-httpd/error.sh       | 17 +++++++++++++++++
 t/t5550-http-fetch-dumb.sh | 10 ++++++++++
 4 files changed, 32 insertions(+)
 create mode 100755 t/lib-httpd/error.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 8e680ef..f7640be 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -113,6 +113,7 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
+	install_script error.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 3a03e82..b384d79 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -97,12 +97,16 @@ Alias /auth/dumb/ www/auth/dumb/
 </LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
+ScriptAlias /error/ error.sh/
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
+<Files error.sh>
+  Options ExecCGI
+</Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/error.sh b/t/lib-httpd/error.sh
new file mode 100755
index 0000000..786f281
--- /dev/null
+++ b/t/lib-httpd/error.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+printf "Status: 500 Intentional Breakage\n"
+
+printf "Content-Type: "
+case "$PATH_INFO" in
+*html*)
+	printf "text/html"
+	;;
+*text*)
+	printf "text/plain"
+	;;
+esac
+printf "\n"
+
+printf "\n"
+printf "this is the error message\n"
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 1a3a2b6..13defd3 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -171,5 +171,15 @@ test_expect_success 'did not use upload-pack service' '
 	test_cmp exp act
 '
 
+test_expect_success 'git client shows text/plain errors' '
+	test_must_fail git clone "$HTTPD_URL/error/text" 2>stderr &&
+	grep "this is the error message" stderr
+'
+
+test_expect_success 'git client does not show html errors' '
+	test_must_fail git clone "$HTTPD_URL/error/html" 2>stderr &&
+	! grep "this is the error message" stderr
+'
+
 stop_httpd
 test_done
-- 
2.0.0.rc1.436.g03cb729
