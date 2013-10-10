From: Jeff King <peff@peff.net>
Subject: Re: A workflow for local patch maintenance
Date: Wed, 9 Oct 2013 21:33:43 -0400
Message-ID: <20131010013343.GB14429@sigill.intra.peff.net>
References: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Oct 10 03:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU58Q-0005AG-V9
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 03:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab3JJBdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 21:33:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:46659 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752050Ab3JJBdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 21:33:45 -0400
Received: (qmail 26725 invoked by uid 102); 10 Oct 2013 01:33:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 20:33:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:33:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235847>

On Tue, Oct 08, 2013 at 07:12:22PM +0100, Tony Finch wrote:

> We often need to patch the software that we run in order to fix bugs
> quickly rather than wait for an official release, or to add functionality
> that we need. In many cases we have to maintain a locally-developed patch
> for a significant length of time, across multiple upstream releases,
> either because it is not yet ready for incorporation into a stable
> upstream version, or because it is too specific to our setup so will not
> be suitable for passing upstream without significant extra work.

Do you need to keep the modifications you make on top of upstream as a
nice, clean series of rebased patches? If not, then you can avoid the
repeated rebasing, and just use a more traditional topic-branch
workflow. Treat modifications from upstream as just another topic.

For example, start with some version (let's say 1.0) of the upstream
software as your "master" branch. If it's kept in git, build on
upstream's git history.  If all you get are tarballs, create an
"upstream" branch with v1.0, and fork "master" from it.

Build on master as you would if it were your own. Fork topic branches,
develop the topics, test them, and then merge them back to "master" when
they're ready (or do development straight on master, or whatever
workflow you're accustomed to).

When v1.1 of the upstream software comes out, create a "merge-upstream"
topic branch from the tip of your "master". If upstream is in git, just
"git merge v1.1" from upstream. If not, then checkout your pristine
"upstream" branch (which should still be sitting at the v1.0 commit),
and build a v1.1 commit on top of it. And then "git merge upstream" to
pick up the new changes.

Test your merge-upstream topic in isolation, and when you think it's
ready merge it into master and deploy.

The most difficult part is the merge of upstream into the topic branch.
But git's 3-way merge tends to do a pretty good job (e.g., if you
contributed your patches upstream, then there should be no conflict).
You can also break up the work by keeping the "merge" topic running for
a long time, and merging as often as possible from upstream. That breaks
the conflict resolution into smaller chunks, and lets you do it closer
to when the conflicting patches were actually made, when they are
hopefully closer in your mind. And you don't have to worry about having
a broken intermediate result, because you're not deploying it; you're
just keeping the topic up to date until you're ready to test it.

You can also try git-imerge, which can make big merges a little more
manageable (though it can also make them harder sometimes...):

  https://github.com/mhagger/git-imerge

The history for such a repository might look like:

       o--o--B--o--o--C  <-- upstream branch
      /       \        \
     o--o---o--o--o--o--D  <-- upstream-merge branch
    /      /        /    \
   A--o---E--o--o--F--o---G <-- master branch
    \    / \      /
     o--o   o----o  <-- topic branches

where:

  - A is the v1.0 commit you start at

  - B and C are milestones where you merged upstream into your
    upstream-merge topic branch. These could be releases (like v1.1), or
    they could just be random spots where you felt like merging to keep
    things up to date. It depends how you want to break up the conflict
    resolution

  - D is a state of the upstream-merge branch that you test to make sure
    the merge happened OK

  - E and F are merges of regular topic branches (i.e., the patches you
    are working on locally). Note that we also merge those up to the
    upstream-merge branch, so that we can resolve early any conflicts
    between what's happening on master and what's happening upstream.

  - G is the merge of D into the master branch, after we have decided
    it's good to deploy

This all assumes that "master" is your known-good state that you deploy
or ship. If you prefer to have a "deploy" or "maint" branch for
hotfixes, you can do that too.

Hope that helps,
-Peff
