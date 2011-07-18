From: Jeff King <peff@peff.net>
Subject: [PATCH 03/14] improve httpd auth tests
Date: Mon, 18 Jul 2011 03:49:12 -0400
Message-ID: <20110718074912.GC12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiiZs-0003sM-6V
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1GRHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:49:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50617
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab1GRHtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:49:14 -0400
Received: (qmail 19745 invoked by uid 107); 18 Jul 2011 07:49:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:49:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:49:12 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177346>

These just checked that we could clone a repository when the
username and password were given in the URL; we should also
check that git will prompt when no or partial credentials
are given.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh        |   10 +++++---
 t/t5550-http-fetch.sh |   51 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b8996a3..f7dc078 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -81,8 +81,7 @@ prepare_httpd() {
 
 	if test -n "$LIB_HTTPD_SSL"
 	then
-		HTTPD_URL=https://127.0.0.1:$LIB_HTTPD_PORT
-		AUTH_HTTPD_URL=https://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
+		HTTPD_PROTO=https
 
 		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
 			-config "$TEST_PATH/ssl.cnf" \
@@ -93,9 +92,12 @@ prepare_httpd() {
 		export GIT_SSL_NO_VERIFY
 		HTTPD_PARA="$HTTPD_PARA -DSSL"
 	else
-		HTTPD_URL=http://127.0.0.1:$LIB_HTTPD_PORT
-		AUTH_HTTPD_URL=http://user%40host:user%40host@127.0.0.1:$LIB_HTTPD_PORT
+		HTTPD_PROTO=http
 	fi
+	HTTPD_DEST=127.0.0.1:$LIB_HTTPD_PORT
+	HTTPD_URL=$HTTPD_PROTO://$HTTPD_DEST
+	HTTPD_URL_USER=$HTTPD_PROTO://user%40host@$HTTPD_DEST
+	HTTPD_URL_USER_PASS=$HTTPD_PROTO://user%40host:user%40host@$HTTPD_DEST
 
 	if test -n "$LIB_HTTPD_DAV" -o -n "$LIB_HTTPD_SVN"
 	then
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index a1883ca..ed4db09 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -35,11 +35,54 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
-test_expect_success 'clone http repository with authentication' '
+test_expect_success 'create password-protected repository' '
 	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
-	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git" &&
-	git clone $AUTH_HTTPD_URL/auth/repo.git clone-auth &&
-	test_cmp file clone-auth/file
+	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git"
+'
+
+test_expect_success 'setup askpass helpers' '
+	cat >askpass <<-EOF &&
+	#!/bin/sh
+	echo >>"$PWD/askpass-query" "askpass: \$*" &&
+	cat "$PWD/askpass-response"
+	EOF
+	chmod +x askpass &&
+	GIT_ASKPASS="$PWD/askpass" &&
+	export GIT_ASKPASS &&
+	>askpass-expect-none &&
+	echo "askpass: Password: " >askpass-expect-pass &&
+	{ echo "askpass: Username: " &&
+	  cat askpass-expect-pass
+	} >askpass-expect-both
+'
+
+test_expect_success 'cloning password-protected repository can fail' '
+	>askpass-query &&
+	echo wrong >askpass-response &&
+	test_must_fail git clone "$HTTPD_URL/auth/repo.git" clone-auth-fail &&
+	test_cmp askpass-expect-both askpass-query
+'
+
+test_expect_success 'http auth can use user/pass in URL' '
+	>askpass-query &&
+	echo wrong >askpass-reponse &&
+	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
+	test_cmp askpass-expect-none askpass-query
+'
+
+test_expect_success 'http auth can use just user in URL' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
+	test_cmp askpass-expect-pass askpass-query
+'
+
+test_expect_success 'http auth can request both user and pass' '
+	>askpass-query &&
+	echo user@host >askpass-response &&
+	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
+	test_cmp askpass-expect-both askpass-query
 '
 
 test_expect_success 'fetch changes via http' '
-- 
1.7.6.rc1.12.g65e2
