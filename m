From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] t1430: add another refs-escape test
Date: Thu, 16 Apr 2015 05:04:44 -0400
Message-ID: <20150416090443.GI17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 11:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YifjA-0001FJ-4D
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbbDPJEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 05:04:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:46136 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971AbbDPJEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 05:04:46 -0400
Received: (qmail 22309 invoked by uid 102); 16 Apr 2015 09:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:04:46 -0500
Received: (qmail 23640 invoked by uid 107); 16 Apr 2015 09:05:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 05:05:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 05:04:44 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267270>

In t1430, we check whether deleting the branch "../../foo"
will delete ".git/foo". However, this is not that
interesting a test; the precious file ".git/foo" does not
look like a ref, so even if we did not notice the "escape"
from the "refs/" hierarchy, we would fail for that reason
(i.e., if you turned refname_is_safe into a noop, the test
still passes).

Let's add an additional test for the same thing, but with a
file that actually looks like a ref. That will make sure we
are exercising the refname_is_safe code. While we're at it,
let's also make the code work a little harder by adding some
extra paths and some empty path components.

Signed-off-by: Jeff King <peff@peff.net>
---
This was originally included to exercise refname_is_safe(), because in
the v1 series I refactored it (here I just avoid calling it entirely).
So it's not as important in v2. But AFAICT, we do not exercise
refname_is_safe() at all in the test suite without this patch, so it's
probably a good thing to do regardless.

 t/t1430-bad-ref-name.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 468e856..16d0b8b 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -68,6 +68,14 @@ test_expect_success 'branch -D cannot delete non-ref in .git dir' '
 	test_cmp expect .git/my-private-file
 '
 
+test_expect_success 'branch -D cannot delete ref in .git dir' '
+	git rev-parse HEAD >.git/my-private-file &&
+	git rev-parse HEAD >expect &&
+	git branch foo/legit &&
+	test_must_fail git branch -D foo////./././../../../my-private-file &&
+	test_cmp expect .git/my-private-file
+'
+
 test_expect_success 'branch -D cannot delete absolute path' '
 	git branch -f extra &&
 	test_must_fail git branch -D "$(pwd)/.git/refs/heads/extra" &&
-- 
2.4.0.rc2.384.g7297a4a
