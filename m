From: Jeff King <peff@peff.net>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Sat, 19 Mar 2011 18:47:26 -0400
Message-ID: <20110319224726.GC7116@sigill.intra.peff.net>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q14vn-0002jY-Ig
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab1CSWrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 18:47:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43637
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab1CSWra (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 18:47:30 -0400
Received: (qmail 20064 invoked by uid 107); 19 Mar 2011 22:48:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Mar 2011 18:48:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Mar 2011 18:47:26 -0400
Content-Disposition: inline
In-Reply-To: <20110319222852.GB7116@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169473>

On Sat, Mar 19, 2011 at 06:28:52PM -0400, Jeff King wrote:

> On Sat, Mar 19, 2011 at 10:53:13PM +0100, Piotr Krukowiecki wrote:
> 
> > It says "by 0 commits" when going back from detached HEAD to
> > master branch:
> > 
> > 
> > $ git checkout HEAD^
> > 
> > $ git checkout master
> > Previous HEAD position was af4c62a... Merge branch 'maint'
> > Switched to branch 'master'
> > Your branch is ahead of 'origin/master' by 0 commits.
> >                                         ^^^^^^^^^^^^
> > 
> > $ git status
> > # On branch master
> > # Your branch is ahead of 'origin/master' by 1 commit.
> >                                           ^^^^^^^^^^^
> 
> Hmm. My guess is that the new "check for connectivity when leaving
> detached HEAD" test is polluting the commit flags for the ahead/behind
> test.
> 
> [bisect bisect bisect]
> 
> Yep, it bisects to 8e2dc6a (commit: give final warning when reattaching
> HEAD to leave commits behind, 2011-02-18). We probably need to clean the
> uninteresting flags between the two traversals.

This patch fixes it:

diff --git a/remote.c b/remote.c
index ca42a12..92b7428 100644
--- a/remote.c
+++ b/remote.c
@@ -1560,6 +1560,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	strcpy(symmetric + 40, "...");
 	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
 
+	clear_commit_marks(ours, -1);
+	clear_commit_marks(theirs, -1);
 	init_revisions(&revs, NULL);
 	setup_revisions(rev_argc, rev_argv, &revs, NULL);
 	prepare_revision_walk(&revs);

but I'm not quite sure if this is the right place. Is it the
responsibility of the checkout-orphan-warning code to clean up after
itself, or is it the responsibility of a revision walker to clean up
before itself?

In the former case, things can be a bit tricky because you have to
remember the tips you started from to call clear_commit_marks(), which
means saving away the revs.pending list after setup_revisions but before
prepare_revision_walk. It might be worth having an alternate
clear_commit_marks() that didn't actually walk the tree but just cleared
the marks from every commit we've loaded, giving other walkers a total
clean slate.

If the latter case (clean up beforehand), should prepare_revision_walk
actually be clearing any existing marks?

I think I favor the prepare_revision_walk approach; in most cases
cleaning up afterwards is just a waste (since there usually isn't a
second walk). But I don't know if there is code that actually depends on
the intermediate results of a previous walk.

-Peff
