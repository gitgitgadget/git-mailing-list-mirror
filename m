From: Jeff King <peff@peff.net>
Subject: Re: Redundant merges?
Date: Wed, 30 Sep 2009 23:34:11 -0400
Message-ID: <20091001033411.GB30094@coredump.intra.peff.net>
References: <2729632a0909301415p7fe0da44l9453fca70bd523ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 01 05:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtCSE-0000u6-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 05:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbZJADeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 23:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZJADeQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 23:34:16 -0400
Received: from peff.net ([208.65.91.99]:38388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522AbZJADeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 23:34:15 -0400
Received: (qmail 11782 invoked by uid 107); 1 Oct 2009 03:37:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Sep 2009 23:37:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Sep 2009 23:34:11 -0400
Content-Disposition: inline
In-Reply-To: <2729632a0909301415p7fe0da44l9453fca70bd523ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129375>

On Wed, Sep 30, 2009 at 02:15:50PM -0700, skillzero@gmail.com wrote:

> Is there a way to avoid redundant merges when merging maint to master
> if both maint and master have already merged in the same topic
> branches? For example, assuming the git.git repository:
> 
> 1. A bug was found and a topic branch (with a merge-base at or before
> maint) is created with the fix.
> 2. The fix looks good so it's merged into master.
> 3. maint is already past the freeze date so the fix isn't merged into
> maint (bug is not super critical).
> 4. maint is delayed for some reason and is accepting fixes.
> 5. Topic branch from step 1 is merged into maint.
> 6. maint is merged into master.

Not without losing the shape of history (which is immutable in git).

We can suppress the merge if you do it in this order:

  1. maint merges topic
  2. master merges maint
  3. master merges topic

In step (3), we see that we already have everything from topic. It works
because the merges happened linearly along a line of history.

But you are merging in a non-linear way:

  1. maint merges topic
  2. master merges topic
  3. master merges maint

So the merging of the topic branches happened "simultaneously" with
respect to the history topology. Any attempt to _not_ have a merge
commit between master and maint in step (3) would have to rewrite one of
the merges from (1) or (2), which would change history.

> What I see is two merge commits that merge the same topic. I think I
> understand why it's doing this (the merge commit is just another
> commit so it merges it). But could it look at what the merge did and
> realize that it already has the commit that the merge commit merged
> and do nothing in this case?

But there isn't nothing to do. You don't have to merge the topic
branch, but you do have to merge the current state of 'maint'. In
addition to keeping the history information (the fact that the topic was
merged, by whom, and when), we also need to record the state of any
conflict resolution that occurred. And when we merge it into master, we
need to resolve any conflicts introduced by the different ways in which
master and maint incorporated the changes from the topic.

For an example, try setting up the repo described by the script below,
checking "gitk --all", and then doing the merges in the two orders I
specified above. In the second case, you will get conflicts that need
resolving for all three merges, whereas in the first, there can be no
conflict for the step (3).

-- >8 --
#!/bin/sh

rm -rf repo
mkdir repo && cd repo && git init

commit() {
  echo $1 >>file && git add file && git commit -m "$1"
}

commit base
git checkout -b maint
commit maint
git checkout master
commit master

git checkout -b topic maint^
commit topic
