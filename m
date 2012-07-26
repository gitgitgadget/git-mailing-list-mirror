From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] t7502: drop confusing test_might_fail call
Date: Thu, 26 Jul 2012 16:31:15 -0400
Message-ID: <20120726203115.GD16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUiQ-0006Dq-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2GZUbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:31:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362Ab2GZUbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:31:17 -0400
Received: (qmail 13385 invoked by uid 107); 26 Jul 2012 20:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:31:15 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202306>

In t7502.20, we run "git commit" and check that it warns us
that the author and committer identity are not the same
(this is always the case in the test environment, since we
set up the idents differently).

Instead of actually making a commit, we have a clean index,
so the "git commit" we run will fail. This is marked as
might_fail, which is not really correct; it will always fail
since there is nothing to commit.

However, the only reason not to do a complete commit would
be to see the intermediate state of the COMMIT_EDITMSG file
when the commit is not completed. We don't need to care
about this, though; even a complete commit will leave
COMMIT_EDITMSG for us to view.  By doing a real commit and
dropping the might_fail, we are more robust against other
unforeseen failures of "git commit" that might influence our
test result.

It might seem less robust to depend on the fact that "git
commit" leaves COMMIT_EDITMSG in place after a successful
commit. However, that brings this test in line with others
parts of the script, which make the same assumption.
Furthermore, if that ever does change, the right solution is
not to prevent commit from completing, but to set EDITOR to
a script that will record the contents we see. After all,
the point of these tests is to check what the user sees in
their EDITOR, so that would be the most direct test. For
now, though, we can continue to use the "shortcut" that
COMMIT_EDITMSG is left intact.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry for the long explanation. It took me a long time to figure out why
this test_might_fail is there at all, so I wanted to present my full
analysis as to why it's OK to remove.

 t/t7502-commit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index efecb06..d261b82 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -237,7 +237,7 @@ test_expect_success 'cleanup commit messages (strip,-F,-e): output' '
 
 test_expect_success 'message shows author when it is not equal to committer' '
 	echo >>negative &&
-	test_might_fail git commit -e -m "sample" &&
+	git commit -e -m "sample" -a &&
 	test_i18ngrep \
 	  "^# Author: *A U Thor <author@example.com>\$" \
 	  .git/COMMIT_EDITMSG
-- 
1.7.11.3.8.ge78f547
