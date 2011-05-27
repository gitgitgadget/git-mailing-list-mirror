From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rebase: write a reflog entry when finishing
Date: Fri, 27 May 2011 16:16:14 -0400
Message-ID: <20110527201614.GB29836@sigill.intra.peff.net>
References: <BANLkTinyKQJQUHa8tn43=cCJMsVbgaZXjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Csaba Henk <csaba@lowlife.hu>
X-From: git-owner@vger.kernel.org Fri May 27 22:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ3SH-0001EM-Is
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 22:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab1E0UQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 16:16:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57207
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab1E0UQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 16:16:16 -0400
Received: (qmail 27279 invoked by uid 107); 27 May 2011 20:16:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 May 2011 16:16:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2011 16:16:14 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinyKQJQUHa8tn43=cCJMsVbgaZXjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174645>

When we finish a rebase, our detached HEAD is at the final
result. We update the original branch ref with this result,
and then point the HEAD symbolic ref at the updated branch.
We write a reflog for the branch update, but not for the
update of HEAD.

Because we're already at the final result on the detached
HEAD, moving to the branch actually doesn't change our
commit sha1 at all. So in that sense, a reflog entry would
be pointless.

However, humans do read reflogs, and an entry saying "rebase
finished: returning to refs/heads/master" can be helpful in
understanding what is going on.

Signed-off-by: Jeff King <peff@peff.net>
---
See the minor test update for an example of how this could break people
or scripts who assume they know what's at which point in the reflog. In
general I think all bets are off with HEAD, because commands do their
work on a detached HEAD, and then provide a nice single-entry result in
the branch reflog (which is why I switched the test to use the more
stable master@{1}).

 git-rebase--interactive.sh    |    4 +++-
 git-rebase.sh                 |    4 +++-
 t/t3404-rebase-interactive.sh |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 41ba96a..65690af 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -510,7 +510,9 @@ do_next () {
 	refs/*)
 		message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
-		git symbolic-ref HEAD $head_name
+		git symbolic-ref \
+		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
+		  HEAD $head_name
 		;;
 	esac && {
 		test ! -f "$state_dir"/verbose ||
diff --git a/git-rebase.sh b/git-rebase.sh
index 57cbe49..d7855ea 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -153,7 +153,9 @@ move_to_original_branch () {
 		message="rebase finished: $head_name onto $onto"
 		git update-ref -m "$message" \
 			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref HEAD $head_name ||
+		git symbolic-ref \
+			-m "rebase finished: returning to $head_name" \
+			HEAD $head_name ||
 		die "Could not move back to $head_name"
 		;;
 	esac
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d8147b..47c8371 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -317,7 +317,7 @@ test_expect_success '--continue tries to commit' '
 '
 
 test_expect_success 'verbose flag is heeded, even after --continue' '
-	git reset --hard HEAD@{1} &&
+	git reset --hard master@{1} &&
 	test_tick &&
 	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
-- 
1.7.5.3.12.g99e25
