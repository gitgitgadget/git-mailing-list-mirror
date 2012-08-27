From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] t: test basic smart-http authentication
Date: Mon, 27 Aug 2012 09:25:36 -0400
Message-ID: <20120827132536.GE17375@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:25:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5zK5-0001qb-4O
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 15:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2H0NZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 09:25:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab2H0NZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 09:25:38 -0400
Received: (qmail 12880 invoked by uid 107); 27 Aug 2012 13:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 09:25:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 09:25:36 -0400
Content-Disposition: inline
In-Reply-To: <20120827132145.GA17265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204338>

We do not currently test authentication over smart-http at
all. In theory, it should work exactly as it does for dumb
http (which we do test). It does indeed work for these
simple tests, but this patch lays the groundwork for more
complex tests in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push.sh  | 14 ++++++++++++++
 t/t5551-http-fetch.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 312e484..eeb9932 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -36,6 +36,8 @@ test_expect_success 'setup remote repository' '
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
 
+setup_askpass_helper
+
 cat >exp <<EOF
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
@@ -266,5 +268,17 @@ test_expect_success 'http push respects GIT_COMMITTER_* in reflog' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push over smart http with auth' '
+	cd "$ROOT_PATH/test_repo_clone" &&
+	echo push-auth-test >expect &&
+	test_commit push-auth-test &&
+	set_askpass user@host &&
+	git push "$HTTPD_URL"/auth/smart/test_repo.git &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
+		log -1 --format=%s >actual &&
+	expect_askpass both user@host &&
+	test_cmp expect actual
+'
+
 stop_httpd
 test_done
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 91eaf53..e653ae3 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -27,6 +27,8 @@ test_expect_success 'create http-accessible bare repository' '
 	git push public master:master
 '
 
+setup_askpass_helper
+
 cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
@@ -109,6 +111,15 @@ test_expect_success 'follow redirects (302)' '
 	git clone $HTTPD_URL/smart-redir-temp/repo.git --quiet repo-t
 '
 
+test_expect_success 'clone from password-protected repository' '
+	echo two >expect &&
+	set_askpass user@host &&
+	git clone --bare "$HTTPD_URL/auth/smart/repo.git" smart-auth &&
+	expect_askpass both user@host &&
+	git --git-dir=smart-auth log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.7.11.5.10.g3c8125b
