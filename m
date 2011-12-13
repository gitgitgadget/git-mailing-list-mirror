From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t5540: test DAV push with authentication
Date: Tue, 13 Dec 2011 15:17:04 -0500
Message-ID: <20111213201704.GA12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:17:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYmn-0006G0-LW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1LMURK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:17:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49759
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753104Ab1LMURH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:17:07 -0500
Received: (qmail 24019 invoked by uid 107); 13 Dec 2011 20:23:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 15:23:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 15:17:04 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187058>

We don't currently test this case at all, and instead just
test the DAV mechanism over an unauthenticated push. That
isn't very realistic, as most people will want to
authenticate pushes.

Two of the tests expect_failure as they reveal bugs:

  1. Pushing without a username in the URL fails to ask for
     credentials when we get an HTTP 401. This has always
     been the case, but it would be nice if it worked like
     smart-http.

  2. Pushing with a username fails to ask for the password
     since 986bbc0 (http: don't always prompt for password,
     2011-11-04). This is a severe regression in v1.7.8, as
     authenticated push-over-DAV is now totally unusable
     unless you have credentials in your .netrc.

Signed-off-by: Jeff King <peff@peff.net>
---
Nobody has mentioned the regression on git@vger yet, but there are two
threads already on msysgit:

  http://thread.gmane.org/gmane.comp.version-control.msysgit/14138

  http://thread.gmane.org/gmane.comp.version-control.msysgit/14161

 t/lib-httpd/apache.conf |    3 +++
 t/t5540-http-push.sh    |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0a4cdfa..3c12b05 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -92,6 +92,9 @@ SSLEngine On
 	<Location /dumb/>
 		Dav on
 	</Location>
+	<Location /auth/dumb>
+		Dav on
+	</Location>
 </IfDefine>
 
 <IfDefine SVN>
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 64767d8..3300227 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -40,6 +40,22 @@ test_expect_success 'setup remote repository' '
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
 
+test_expect_success 'create password-protected repository' '
+	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb" &&
+	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
+	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git"
+'
+
+test_expect_success 'setup askpass helper' '
+	cat >askpass <<-\EOF &&
+	#!/bin/sh
+	echo user@host
+	EOF
+	chmod +x askpass &&
+	GIT_ASKPASS="$PWD/askpass" &&
+	export GIT_ASKPASS
+'
+
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/dumb/test_repo.git test_repo_clone
@@ -144,6 +160,24 @@ test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone master
 
+test_expect_failure 'push to password-protected repository (user in URL)' '
+	test_commit pw-user &&
+	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
+	git rev-parse --verify HEAD >expect &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
+		rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'push to password-protected repository (no user in URL)' '
+	test_commit pw-nouser &&
+	git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
+	git rev-parse --verify HEAD >expect &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
+		rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
+'
+
 stop_httpd
 
 test_done
-- 
1.7.8.17.gfd3524
