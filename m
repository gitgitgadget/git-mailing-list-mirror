From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] t9103: modernize test style
Date: Fri, 13 May 2016 16:47:28 -0400
Message-ID: <20160513204728.GE15391@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Jzp-0000e2-F7
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbcEMUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:47:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:39378 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932254AbcEMUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:47:36 -0400
Received: (qmail 16745 invoked by uid 102); 13 May 2016 20:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:31 -0400
Received: (qmail 21640 invoked by uid 107); 13 May 2016 20:47:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:47:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:47:28 -0400
Content-Disposition: inline
In-Reply-To: <20160513204654.GA10684@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294581>

The main goal here was to avoid double-quotes for
surrounding the test snippet, since it makes the code hard
to read (and to grep for common problems).

But while we're here, we can fix a few other things:

  - use test_path_* helpers, which are more robust and give
    better error messages

  - only "cd" inside a subshell, which leaves the
    environment pristine if further tests are added

  - consistently quote shell arguments. These aren't wrong
    if we assume find-rev output doesn't have any
    whitespace, but it doesn't hurt to be careful.

  - replace the old-style 'test x$foo = x' with 'test -z
    "$foo"'. Besides the quoting fix, this is the form we
    generally use in our test suite.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9103-git-svn-tracked-directory-removed.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/t/t9103-git-svn-tracked-directory-removed.sh b/t/t9103-git-svn-tracked-directory-removed.sh
index 3413164..b282713 100755
--- a/t/t9103-git-svn-tracked-directory-removed.sh
+++ b/t/t9103-git-svn-tracked-directory-removed.sh
@@ -23,17 +23,19 @@ test_expect_success 'make history for tracking' '
 
 test_expect_success 'clone repo with git' '
 	git svn clone -s "$svnrepo" x &&
-	test -f x/FOLLOWME &&
-	test ! -f x/README
+	test_path_is_file x/FOLLOWME &&
+	test_path_is_missing x/README
 '
 
-test_expect_success 'make sure r2 still has old file' "
-	cd x &&
-		test -n \"\$(git svn find-rev r1)\" &&
-		git reset --hard \$(git svn find-rev r1) &&
-		test -f README &&
-		test ! -f FOLLOWME &&
-		test x\$(git svn find-rev r2) = x
-"
+test_expect_success 'make sure r2 still has old file' '
+	(
+		cd x &&
+		test -n "$(git svn find-rev r1)" &&
+		git reset --hard "$(git svn find-rev r1)" &&
+		test_path_is_file README &&
+		test_path_is_missing FOLLOWME &&
+		test -z "$(git svn find-rev r2)"
+	)
+'
 
 test_done
-- 
2.8.2.825.gea31738
