From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] t: test http access to "half-auth" repositories
Date: Mon, 27 Aug 2012 09:25:53 -0400
Message-ID: <20120827132553.GF17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zKM-0001xy-8C
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab2H0NZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:25:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2H0NZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:25:55 -0400
Received: (qmail 12910 invoked by uid 107); 27 Aug 2012 13:26:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:26:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:25:53 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204339>

Some sites set up http access to repositories such that
fetching is anonymous and unauthenticated, but pushing is
authenticated. While there are multiple ways to do this, the
technique advertised in the git-http-backend manpage is to
block access to locations matching "/git-receive-pack$".

Let's emulate that advice in our test setup, which makes it
clear that this advice does not actually work.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf |  7 +++++++
 t/t5541-http-push.sh    | 12 ++++++++++++
 t/t5551-http-fetch.sh   |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index c6a1a87..49d5d87 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -92,6 +92,13 @@ SSLEngine On
 	Require valid-user
 </Location>
 
+<LocationMatch "^/auth-push/.*/git-receive-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
 <IfDefine DAV>
 	LoadModule dav_module modules/mod_dav.so
 	LoadModule dav_fs_module modules/mod_dav_fs.so
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index eeb9932..9b1cd60 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -280,5 +280,17 @@ test_expect_success 'push over smart http with auth' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'push to auth-only-for-push repo' '
+	cd "$ROOT_PATH/test_repo_clone" &&
+	echo push-half-auth >expect &&
+	test_commit push-half-auth &&
+	set_askpass user@host &&
+	git push "$HTTPD_URL"/auth-push/smart/test_repo.git &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
+		log -1 --format=%s >actual &&
+	expect_askpass both user@host &&
+	test_cmp expect actual
+'
+
 stop_httpd
 test_done
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index e653ae3..2db5c35 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -120,6 +120,15 @@ test_expect_success 'clone from password-protected repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone from auth-only-for-push repository' '
+	echo two >expect &&
+	set_askpass wrong &&
+	git clone --bare "$HTTPD_URL/auth-push/smart/repo.git" smart-noauth &&
+	expect_askpass none &&
+	git --git-dir=smart-noauth log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.7.11.5.10.g3c8125b
