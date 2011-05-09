From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 9 May 2011 10:44:51 -0400
Message-ID: <20110509144451.GA11362@sigill.intra.peff.net>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: conrad.irwin@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 16:45:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJRhk-0006t4-NE
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 16:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab1EIOoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 10:44:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60267
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab1EIOoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 10:44:54 -0400
Received: (qmail 9904 invoked by uid 107); 9 May 2011 14:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 10:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 10:44:51 -0400
Content-Disposition: inline
In-Reply-To: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173235>

On Fri, May 06, 2011 at 10:59:58PM -0700, conrad.irwin@gmail.com wrote:

> I've rebased my support for git commit -p onto the current master
> branch. I've posted it to the list twice before [1][2].

Thanks for reposting. I had been meaning to look at this again, but
hadn't gotten around to it. So thanks for being persistent. :)

>   Use a temporary index for git commit --interactive

I think the intent of this one is good. In reviewing your initial
series, I had wondered about consistency with respect to the atomicity
of "git commit -p" versus "git add -p" (i.e., what state is the index
left in when you abort). But reading through the discussion again, I
think we should worry more about consistency between "git commit -i" and
"git commit --interactive". That is, both should produce no changes to
the index when the commit is aborted. So I think your patch is a step in
the right direction.

That still leaves an inconsistency in "git add -p" versus "git commit
-p" (e.g., if you abort "git add -p" with "^C"). But if we care, the
right solution is probably to make "git add -p" atomic. That can be a
separate topic, though, and I'm not sure anyone really cares enough to
work on it.

I have one final question. If I do abort a commit, is there any way to
recover the state that was in the temporary index? That is, if I abort
"git commit -i" by using an empty commit message, it is easy enough to
use shell history to repeat the command (possibly with a different set
of files). But if I spend some time selecting (and possibly editing)
hunks, and then decide to abort the commit, is there any way to recover
the intermediate index state?

>From my reading of the code, it looks like "no". We will rollback the
lockfile which contains the new index when aborting the commit.

I'm not sure if it is worth caring about. If you are really interested
in index state, you are probably better off using "git add -p" and "git
commit" separately. And even if we kept the index file around, it
requires a fairly savvy plumbing user to be able to pick changes out of
it.

>   Allow git commit --interactive with paths

Hmm. Test t7501.8 explicitly tests that this isn't allowed. But the test
is poorly written, and falsely returns success even with your patch.

The original test should have looked like this:

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 7f7f7c7..8090b3c 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -45,7 +45,8 @@ test_expect_success \
 test_expect_success PERL \
 	"using paths with --interactive" \
 	"echo bong-o-bong >file &&
-	! (echo 7 | git commit -m foo --interactive file)"
+	! ({ echo 2; echo 1; echo; echo 7; } |
+	git commit -m foo --interactive file)"
 
 test_expect_success \
 	"using invalid commit with -C" \

which does properly fail with your change. Your commit should tweak that
test (speaking of which, it would be nice for patch 1 to have a test,
too).

Other than that, the code in all 3 looks fine to me.

-Peff
