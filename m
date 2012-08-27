From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] t5550: put auth-required repo in auth/dumb
Date: Mon, 27 Aug 2012 09:23:37 -0400
Message-ID: <20120827132337.GA17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zIA-0000xz-4J
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab2H0NXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:23:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39684 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2H0NXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:23:39 -0400
Received: (qmail 12744 invoked by uid 107); 27 Aug 2012 13:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:23:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:23:37 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204334>

In most of our tests, we put repos to be accessed by dumb
protocols in /dumb, and repos to be accessed by smart
protocols in /smart.  In our test apache setup, the whole
/auth hierarchy requires authentication. However, we don't
bother to split it by smart and dumb here because we are not
currently testing smart-http authentication at all.

That will change in future patches, so let's be explicit
that we are interested in testing dumb access here. This
also happens to match what t5540 does for the push tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5550-http-fetch.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index b06f817..5ad2123 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -41,9 +41,9 @@ test_expect_success 'clone http repository' '
 '
 
 test_expect_success 'create password-protected repository' '
-	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
+	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
-	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/repo.git"
+	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"
 '
 
 test_expect_success 'setup askpass helpers' '
@@ -81,28 +81,28 @@ expect_askpass() {
 test_expect_success 'cloning password-protected repository can fail' '
 	>askpass-query &&
 	echo wrong >askpass-response &&
-	test_must_fail git clone "$HTTPD_URL/auth/repo.git" clone-auth-fail &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-fail &&
 	expect_askpass both wrong
 '
 
 test_expect_success 'http auth can use user/pass in URL' '
 	>askpass-query &&
 	echo wrong >askpass-response &&
-	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
+	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
 	expect_askpass none
 '
 
 test_expect_success 'http auth can use just user in URL' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
-	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-pass &&
+	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
 	expect_askpass pass user@host
 '
 
 test_expect_success 'http auth can request both user and pass' '
 	>askpass-query &&
 	echo user@host >askpass-response &&
-	git clone "$HTTPD_URL/auth/repo.git" clone-auth-both &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
 	expect_askpass both user@host
 '
 
@@ -114,7 +114,7 @@ test_expect_success 'http auth respects credential helper config' '
 	}; f" &&
 	>askpass-query &&
 	echo wrong >askpass-response &&
-	git clone "$HTTPD_URL/auth/repo.git" clone-auth-helper &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
 	expect_askpass none
 '
 
@@ -122,7 +122,7 @@ test_expect_success 'http auth can get username from config' '
 	test_config_global "credential.$HTTPD_URL.username" user@host &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
-	git clone "$HTTPD_URL/auth/repo.git" clone-auth-user &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
 	expect_askpass pass user@host
 '
 
@@ -130,7 +130,7 @@ test_expect_success 'configured username does not override URL' '
 	test_config_global "credential.$HTTPD_URL.username" wrong &&
 	>askpass-query &&
 	echo user@host >askpass-response &&
-	git clone "$HTTPD_URL_USER/auth/repo.git" clone-auth-user2 &&
+	git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
 	expect_askpass pass user@host
 '
 
-- 
1.7.11.5.10.g3c8125b
