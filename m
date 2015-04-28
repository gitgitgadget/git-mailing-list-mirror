From: Jeff King <peff@peff.net>
Subject: [PATCH] rebase: silence "git checkout" for noop rebase
Date: Tue, 28 Apr 2015 01:17:37 -0400
Message-ID: <20150428051737.GE24580@peff.net>
References: <CAFGg4-hsRY9S4ok0-KSUWN7AWS=Eptk4E5B-LZcPFPsKrOP-_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sam Cates <sam@samcates.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 07:17:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymxty-0008Br-0b
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 07:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbbD1FRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 01:17:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:50956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751343AbbD1FRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 01:17:39 -0400
Received: (qmail 17733 invoked by uid 102); 28 Apr 2015 05:17:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:17:39 -0500
Received: (qmail 11466 invoked by uid 107); 28 Apr 2015 05:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:18:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 01:17:37 -0400
Content-Disposition: inline
In-Reply-To: <CAFGg4-hsRY9S4ok0-KSUWN7AWS=Eptk4E5B-LZcPFPsKrOP-_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267894>

On Mon, Apr 27, 2015 at 12:05:41PM -0700, Sam Cates wrote:

> STEPS TO REPRODUCE:
> 1. git checkout master
> 2. git rebase --quiet master topic
> 
> EXPECTED RESULTS:
> The checkout and rebase occur with no output.
> 
> ACTUAL RESULTS:
> The output from the checkout is not suppressed.

Can you be more specific about your setup? What is the relationship
between "master" and "topic"?

If "topic" is already up to date with master, I get:

  $ git rebase --quiet master topic
  Switched to branch 'topic'

(the --quiet does suppress "Current branch topic is up to date").  The
patch below addresses that. But there may be other calls to git-checkout
that would need similar treatment (either unconditional "-q" as below,
or respecting $GIT_QUIET, depending on the individual case).

-- >8 --
Subject: rebase: silence "git checkout" for noop rebase

When the branch to be rebased is already up to date, we
"git checkout" the branch, print an "up to date" message,
and end the rebase early. However, our checkout may print
"Switched to branch 'foo'" or "Already on 'foo'", even if
the user has asked for "--quiet".

We should avoid printing these messages at all, "--quiet" or
no. Since the rebase is a noop, this checkout can be seen as
optimizing out these other two checkout operations (that
happen in a real rebase):

  1. Moving to the detached HEAD to start the rebase; we
     always feed "-q" to checkout there, and instead rely on
     our own custom message (which respects --quiet).

  2. Finishing a rebase, where we move to the final branch.
     Here we actually use update-ref rather than
     git-checkout, and produce no messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 55da9db..90854e3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -582,7 +582,7 @@ then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" ||
 		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
-			git checkout "$switch_to" --
+			git checkout -q "$switch_to" --
 		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
 		finish_rebase
 		exit 0
-- 
2.4.0.rc3.477.gc25258d
