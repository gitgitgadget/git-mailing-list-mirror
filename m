From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] t7502: handle systems where auto-identity is broken
Date: Thu, 26 Jul 2012 16:32:31 -0400
Message-ID: <20120726203231.GE16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUje-0007Le-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548Ab2GZUce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:32:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37606 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab2GZUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:32:33 -0400
Received: (qmail 13415 invoked by uid 107); 26 Jul 2012 20:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:32:31 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202307>

Test t7502.21 checks whether we write the committer name
into COMMIT_EDITMSG when it has been automatically
determined. However, not all systems can produce valid
automatic identities.

Prior to f20f387 (commit: check committer identity more
strictly), this test worked even when we did not have a
valid automatic identity, since it did not run the strict
test until after we had generated the template. That commit
tightened the check to fail early (since we would fail
later, anyway), meaning that systems without a valid GECOS
name or hostname would fail the test.

We cannot just work around this, because it depends on
configuration outside the control of the test script.
Therefore we introduce a new test_prerequisite to run this
test only on systems where automatic ident works at all.

As a result, we can drop the confusing test_must_fail bit
from the test. The intent was that by giving "git commit"
invalid input (namely, nothing to commit), that it would
stop at a predictable point, whether we had a valid identity
or not, from which we could view the contents of
COMMIT_EDITMSG. Since that assumption no longer holds, and
we can only run the test when we have a valid identity,
there is no reason not to let commit run to completion. That
lets us be more robust to other unforeseen failures.

Signed-off-by: Jeff King <peff@peff.net>
---
This should fix the test failure that started the thread. Please let me
know if it doesn't.

 t/t7502-commit.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index d261b82..c444812 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -243,14 +243,21 @@ test_expect_success 'message shows author when it is not equal to committer' '
 	  .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'message shows committer when it is automatic' '
+test_expect_success 'setup auto-ident prerequisite' '
+	if (sane_unset GIT_COMMITTER_EMAIL &&
+	    sane_unset GIT_COMMITTER_NAME &&
+	    git var GIT_COMMITTER_IDENT); then
+		test_set_prereq AUTOIDENT
+	fi
+'
+
+test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 
 	echo >>negative &&
 	(
 		sane_unset GIT_COMMITTER_EMAIL &&
 		sane_unset GIT_COMMITTER_NAME &&
-		# must fail because there is no change
-		test_must_fail git commit -e -m "sample"
+		git commit -e -m "sample" -a
 	) &&
 	# the ident is calculated from the system, so we cannot
 	# check the actual value, only that it is there
-- 
1.7.11.3.8.ge78f547
