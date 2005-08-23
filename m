From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 23 Aug 2005 17:55:21 +0100
Message-ID: <tnxvf1wd24m.fsf@arm.com>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	<20050819194832.GA8562@fanta>
	<1124572356.7512.21.camel@localhost.localdomain>
	<20050821094059.GA5453@fanta>
	<Pine.LNX.4.63.0508221707520.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Veldeman <jan.veldeman@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 18:57:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7c4T-00041l-6C
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 18:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVHWQzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVHWQzv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 12:55:51 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37098 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932224AbVHWQzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 12:55:50 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7NGtWmC029353;
	Tue, 23 Aug 2005 17:55:32 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id RAA03339;
	Tue, 23 Aug 2005 17:55:24 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 23 Aug 2005 17:55:23 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508221707520.23242@iabervon.org> (Daniel
 Barkalow's message of "Mon, 22 Aug 2005 18:10:02 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 23 Aug 2005 16:55:23.0067 (UTC) FILETIME=[73C648B0:01C5A803]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
> One factor not mentioned there is that, as things move upstream, we often
> want to discard a lot of history; if someone commits constantly to deal
> with editor malfunction or something, we don't really want to take all of
> this junk into the project history when it is cleaned up and
> accepted.

That's true but Jan's proposal is to choose which commits to preserve
in the history via a 'freeze' command. That's a bit difficult to
implement in a clean way since the patches are floating on top of the
stack base and they change every time the base changes. It is possible
that a previous frozen state might no longer apply on top of a new
base.

> So the point is that there are things which are, in fact, parents, but we
> don't want to list them, because it's not desired information.

What's the definition of a parent in GIT terms? What are the
restriction for a commit object to be a parent? Can a parent be an
arbitrarily chosen commit?

> Probably the right thing is to have two views of the stack: the internal
> view, showing what actually happened, and the external view, showing what
> would have happened if the developers had done everything right the first
> time. When you make changes to the series, this adds to the internal view
> and entirely replaces the external view.

That's what I've been thinking. StGIT currently only implements the
external view.

An StGIT patch is a represented by a top and bottom commit
objects. The bottom one is the same as the parent of the top
commit. The patch is the diff between the top's tree id and the
bottom's tree id.

Jan's proposal is to allow a freeze command to save the current top
hash and later be used as a second parent for the newly generated
top. The problem I see with this approach is that (even for the
internal view you described) the newly generated top will have two
parents, new-bottom and old-top, but only the diff between new-top and
new-bottom is meaningful. The diff between new-top and old-top (as a
parent-child relation) wouldn't contain anything relevant to the patch
but all the new changes to the base of the stack.

Is the above an acceptable usage of the GIT DAG structure?

> I think that users will also want to discard the commits from the stack
> before rebasing in favor of the commits after, because (a) rebasing isn't
> all that interesting, especially if there's minimal merging, and (b)
> otherwise you'd get a ton of boring commits that obscure the interesting
> ones.

StGIT does this currently. The old commit is no longer available and
can be pruned (I still need to save the commits corresponding to the
unpushed patches since prune would remove those as well).

> I think that the best rule would be that, when you modify a patch, the
> previous version is the new version's parent, and when you rebase a
> series, you include as a parent any parent of the input that isn't also in
> the input (but never include the input itself as a parent of the output;
> the point of rebasing is to pretend that it was the newer mainline that
> you modified). This should mean that the internal history of a patch
> consists of the present version, based on each version that was replaced
> due to changing the patch rather than rebasing it.

Since you proposed this, my above usage of the DAG structure would be
fine then.

> Of course, there's an interesting situation with the commits earlier in a
> series from a patch that was changed not being ancestors of the newer
> versions of those patches (because they weren't interesting in the
> development of those patches) but accessible as the commits that an
> interesting patch was based on.
>
> A possible solution is just to consider the revision of any patch a
> significant event in the history of the whole stack, causing all of the
> patches to get a new retained version.

That's another idea to think about.

-- 
Catalin


P.S. I'll be away until next week and not able to follow-up the
discussions.
