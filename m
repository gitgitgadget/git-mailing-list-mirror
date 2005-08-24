From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 12:09:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508241135120.23242@iabervon.org>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
 <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tony.luck@intel.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 18:11:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7xlV-0003JG-T1
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 18:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVHXQGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 12:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVHXQGK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 12:06:10 -0400
Received: from iabervon.org ([66.92.72.58]:40453 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751104AbVHXQGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 12:06:09 -0400
Received: (qmail 22256 invoked by uid 1000); 24 Aug 2005 12:09:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 12:09:42 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7710>

On Wed, 24 Aug 2005, Junio C Hamano wrote:

> tony.luck@intel.com writes:
>
> > So I have another anomaly in my GIT tree.  A patch to
> > back out a bogus change to arch/ia64/hp/sim/boot/bootloader.c
> > in my release branch at commit
> >
> >  62d75f3753647656323b0365faa43fc1a8f7be97
> >
> > appears to have been lost when I merged the release branch to
> > the test branch at commit
> >
> >  0c3e091838f02c537ccab3b6e8180091080f7df2
>
>     : siamese; git cat-file commit 0c3e091838f02c537ccab3b6e8180091080f7df2
>     tree 61a407356d1e897e0badea552ce69e657cab6108
>     parent 7ffacc1a2527c219b834fe226a7a55dc67ca3637
>     parent a4cce10492358b33d33bb43f98284c80482037e8
>     author Tony Luck <tony.luck@intel.com> 1124808655 -0700
>     committer Tony Luck <tony.luck@intel.com> 1124808655 -0700
>
>     Pull release into test branch
>
> So I pulled 7ffacc and a4cce1 from your repository and started
> digging from there.  7ffacc was the head of "test" branch back
> then, and a4cce1 was the head of "release" branch.  I checked
> out 7ffacc in the repository and pulled a4cce1 into it, using
> the GIT with the "optimum merge-base" patch.
>
>     : siamese; git pull . aegl-release
>     Packing 0 objects
>     Unpacking 0 objects
>
>     * committish: a4cce10492358b33d33bb43f98284c80482037e8	refs/heads/aegl-release from .
>     Trying to find the optimum merge base.
>     Trying to merge a4cce10492358b33d33bb43f98284c80482037e8 into 7ffacc1a2527c219b834fe226a7a55dc67ca3637 using c1ffb910f7a4e1e79d462bb359067d97ad1a8a25.
>     Simple merge failed, trying Automatic merge
>     Auto-merging arch/ia64/sn/kernel/io_init.c.
>     Committed merge db376974c0aebb9e99e5cd0bce21088c6a9d927c
>      arch/ia64/hp/sim/boot/boot_head.S |    2 +-
>      1 files changed, 1 insertions(+), 1 deletions(-)
>
> It is using c1ffb9 as the merge base.  The problematic path
> in the three trees involved are:
>
> : siamese; git ls-tree -r aegl-test-7ffacc1a | grep arch/ia64/hp/sim/boot/bootloader.c
> 100644 blob a7bed60b69f9e8de9a49944e22d03fb388ae93c7	arch/ia64/hp/sim/boot/bootloader.c
> : siamese; git ls-tree -r aegl-release-a4cce1 | grep arch/ia64/hp/sim/boot/bootloader.c
> 100644 blob 51a7b7b4dd0e7c5720683a40637cdb79a31ec4c4	arch/ia64/hp/sim/boot/bootloader.c
> : siamese; git ls-tree -r aegl-c1ffb9 | grep arch/ia64/hp/sim/boot/bootloader.c
> 100644 blob 51a7b7b4dd0e7c5720683a40637cdb79a31ec4c4	arch/ia64/hp/sim/boot/bootloader.c
>
> So the file did not change between the merge base and release,
> and test had the change.  merge-cache picked the one in the test
> release.  Your guess in the other message hits the mark.
>
> I wonder what _other_ candidates these two commits have in
> common and what would have happened if they were used as the
> base instead?
>
>     : siamese; git merge-base -a aegl-test-7ffacc1a aegl-release-a4cce1
>     f6fdd7d9c273bb2a20ab467cb57067494f932fa3
>     3a931d4cca1b6dabe1085cc04e909575df9219ae
>     c1ffb910f7a4e1e79d462bb359067d97ad1a8a25
>
> You can check what variant of the file each of these commits
> contain.
>
> What is happening is:
>
> * the problematic patch 4aec0f is one before 3a931d.  Among the
>   three merge-base candidates, only 3a931d contains teh wrongly
>   patched version.
>
> * the problematic change 4aec0f patch introduces is part of test
>   branch, because it was pulled via release.
>
> * the tip of release being merged into test has this patch
>   reverted, and the file is exactly the same as before 4aec0f
>   patch.
>
> So three-way trivial merge algorithm says, "hey, the file did
> not change between common ancestor and release but it is
> different in test, so the one in the test branch must be the
> merge result."
>
> This does not have much to do with which common ancestor
> merge-base chooses.  Sorry, I am not sure what is the right way
> to resolve this offhand.

If it picks 3a931d4cca1b6dabe1085cc04e909575df9219ae, it will determine
that the file didn't change between that and test, and is different in
release, so the one in release must be right. I believe that the hint that
something is going on is that different common ancestors give
different trivial merges (as opposed to some giving failure and some
giving the same result), and resolving it probably involves identifying
that that paths from f6f... and c1f... to release don't keep the same blob
through the middle, despite having the same ends.

	-Daniel
*This .sig left intentionally blank*
