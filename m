From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --strategy=resolve segfaults if picking a root
 commit
Date: Thu, 12 May 2011 06:45:58 -0400
Message-ID: <20110512104558.GA22108@sigill.intra.peff.net>
References: <iqgbvs$pm5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 12:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKTPG-0002kQ-2U
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 12:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab1ELKqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 06:46:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43295
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab1ELKqD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 06:46:03 -0400
Received: (qmail 12469 invoked by uid 107); 12 May 2011 10:47:59 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 May 2011 06:47:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2011 06:45:58 -0400
Content-Disposition: inline
In-Reply-To: <iqgbvs$pm5$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173455>

On Thu, May 12, 2011 at 12:15:24PM +0200, Sebastian Schuberth wrote:

> I just noticed that (under both Linux and Windows) Git 1.7.5
> segfaults for me if cherry-picking a root commit from one repo into
> another one with "--strategy=resolve". It does not segfault if
> "--strategy=resolve" is omitted. Here's what I did:
> [...]
> Is this already a known issue?

No, I think you found a new one (I doubt many people use alternate
strategies for cherry-picking, and probably even less frequently on root
commits).

Here's a fix, but see below.

---
 builtin/revert.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f697e66..2eebb58 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -497,7 +497,8 @@ static int do_pick_commit(void)
 
 		write_message(&msgbuf, defmsg);
 
-		commit_list_insert(base, &common);
+		if (base)
+			commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
 		res = try_merge_command(strategy, xopts_nr, xopts, common,
 					sha1_to_hex(head), remotes);

The base commit comes from the "parent" pointer in a cherry, which is
going to be NULL in this case. In a revert, however, the parent pointer
ends up in "next". However, you can't get a segfault with "git revert
--strategy=resolve $some_root_commit", because earlier we explicitly
disallow reverting a root commit.

So this patch makes it stop segfaulting, but I'm not sure that it is
doing anything useful. Merge-resolve seems to just barf, whereas
merge-recursive properly handles this case (it cherry-picks the
difference between the empty tree and the root commit's tree).

So probably we should:

  1. Pass the empty tree along to merge-resolve. This will take a little
     bit of refactoring, but more importantly, it means we will be
     passing a tree-ish and not a commit-ish to a merge strategy. Is
     that OK?

  2. Consider lifting the restriction on reverting root commits. If we
     can cherry-pick it, we can revert it, so I suspect this would
     already work with merge-recursive, but I didn't try. I don't care
     too much either way, though; I doubt it's something people would do
     a lot. It just seems like an unnecessary restriction.

-Peff
