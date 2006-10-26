X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: StGIT and rerere
Date: Thu, 26 Oct 2006 17:34:12 +0100
Message-ID: <tnxu01r2fzv.fsf@arm.com>
References: <200610210039.10215.robin.rosenberg.lists@dewire.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 16:35:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610210039.10215.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sat, 21 Oct 2006 00:39:09 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 26 Oct 2006 16:34:14.0573 (UTC) FILETIME=[92E835D0:01C6F91C]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30235>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8Bm-0002Gt-PJ for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161434AbWJZQe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbWJZQe3
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:34:29 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:20909 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1161434AbWJZQe2 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 12:34:28 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k9QGYEQb006451;
 Thu, 26 Oct 2006 17:34:14 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Thu, 26 Oct 2006
 17:34:14 +0100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> It seems stgit does not use git-rerere, so why not? Any reason other
> than it hasn't been done yet?

I didn't know it exists. I've been thinking at a way to avoid
duplicating the conflict fixing but haven't got to any results. This
looks like a good idea.

> I abuse stgit heavily, by frequently reording patches, which for
> some patches result in re-occuring conflicts. git-rerere seems to be
> the solution.

My problem was with maintaining a public branch where re-basing
patches is not welcomed but I would still like to use StGIT in my
development branch. When pulling from upstream in my devel branch, I
get conflicts in some patches. The problem is that I get the same
conflicts in the patches already merged in the public branch where the
patches were previously checked in.

Another case is several branches with common patches that generate
conflicts.

> What's the "rules" for when to invoke rerere? It seems it is mostly
> automatic in git, but since only the porcelainish commands use it,
> that means StGIT doesn't.

It could probably be invoked by stgit.git.merge() if the git-read-tree
(and maybe the diff3 merge) failed (BTW, I replaced git-read-tree with
git-recursive-merge in my local tree and seems to detect renames
properly; I'll push it once I'm convinced there are no problems).

Note, however, that I haven't looked at how git-rerere works and I
might have misunderstood its functionality.

> So here is what I *think* needs to be done. Seems simple enough.
>
> stg push, stg pick, stg import, stg goto, stg fold, stg float do
> what push does and invoke git-rerere at the end whether the push
> ends with conflicts or not

the git.merge() function handles all the merges.

> stg pop
> 	nothing, or do I need to remove rr-cache/MERGE_RR, like
> git-reset does?

I think pop shouldn't do anything.

> stg status --reset, stg push --undo
> 	remove rr-cache/MERGE_RR ?

Yes (not sure for push --undo).

> stg refresh
> 	do what stgit does normally and then invoke git-rerere

Why should it invoke git-rerere? This just creates a commit. Or is it
needed for storing rerere ids?

> stg resolved:
> 	do what stgit does normally and then invoke git-rerere

No need to call rerere here since resolved is an StGIT-only function,
it doesn't affect the repository (it just unmarks the conflict files
so that stgit allows you to refresh).

> stg clean, stge delete:
> 	remove rr-cache/MERGE_RR ?

That's not needed. Delete can act like pop for the top patch.

-- 
