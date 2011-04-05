From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] stash: fix accidental apply of non-existent stashes
Date: Tue, 5 Apr 2011 17:20:25 -0400
Message-ID: <20110405212025.GA3579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 23:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Dlm-0001TV-Oj
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab1DEVUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:20:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44448
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811Ab1DEVUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:20:31 -0400
Received: (qmail 28608 invoked by uid 107); 5 Apr 2011 21:21:14 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 17:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 17:20:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170917>

Once upon a time, "git rev-parse ref@{9999999}" did not
generate an error. Therefore when we got an invalid stash
reference in "stash apply", we could end up not noticing
until quite late.  Commit b0f0ecd (detached-stash: work
around git rev-parse failure to detect bad log refs,
2010-08-21) handled this by checking for the "Log for stash
has only %d entries" warning on stderr when we validated the
ref.

A few days later, e6eedc3 (rev-parse: exit with non-zero
status if ref@{n} is not valid., 2010-08-24) fixed the
original issue. That made the extra stderr test superfluous,
but also introduced a new bug. Now the early call to:

  git rev-parse --symbolic "$@"

fails, but we don't notice the exit code. Worse, its empty
output means we think the user didn't provide us a ref, and
we try to apply stash@{0}.

This patch checks the rev-parse exit code and fails early in
the revision parsing process. We can also get rid of the
stderr test; as a bonus, this means that "stash apply" can
now run under GIT_TRACE=1 properly.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-stash.sh     |   12 +-----------
 t/t3903-stash.sh |    6 ++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a305fb1..a5b1dc3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,7 +264,7 @@ parse_flags_and_rev()
 	b_tree=
 	i_tree=
 
-	REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
+	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
 
 	FLAGS=
 	for opt
@@ -310,16 +310,6 @@ parse_flags_and_rev()
 	IS_STASH_LIKE=t &&
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
-
-	if test "${REV}" != "${REV%{*\}}"
-	then
-		# maintainers: it would be better if git rev-parse indicated
-		# this condition with a non-zero status code but as of 1.7.2.1 it
-		# it did not. So, we use non-empty stderr output as a proxy for the
-		# condition of interest.
-		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$REV does not exist in the stash log"
-	fi
-
 }
 
 is_stash_like()
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f62aaf5..11077f0 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -37,6 +37,12 @@ test_expect_success 'parents of stash' '
 	test_cmp output expect
 '
 
+test_expect_success 'applying bogus stash does nothing' '
+	test_must_fail git stash apply stash@{1} &&
+	echo 1 >expect &&
+	test_cmp expect file
+'
+
 test_expect_success 'apply needs clean working directory' '
 	echo 4 > other-file &&
 	git add other-file &&
-- 
1.7.4.3.13.g0b769.dirty
