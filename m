From: Petr Baudis <pasky@suse.cz>
Subject: Re: rethinking patch management with GIT / topgit
Date: Sat, 20 Mar 2010 18:47:41 +0100
Message-ID: <20100320174740.GC4535@machine.or.cz>
References: <201003201802.51129.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vcs-pkg-discuss@lists.alioth.debian.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Sat Mar 20 18:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt2m7-00030r-UW
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 18:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0CTRrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 13:47:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51721 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102Ab0CTRrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 13:47:46 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3E9A2125A0E8; Sat, 20 Mar 2010 18:47:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003201802.51129.thomas@koch.ro>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142730>

  Hi!

On Sat, Mar 20, 2010 at 06:02:51PM +0100, Thomas Koch wrote:
> I'd like to argue, that topgit (tg) fails to fullfill it's task and propose a 
> different approach to the problem of patch management on top of git.
> 
> IMHO tg fails due to the following reasons:
> 
> - it pollutes the patch branches with metadata (.topmsg, .topdeps)

I'd like to single this out - this is a very arbitrary decision and has
its distinct pros and cons compared to alternative approaches, and was
not taken lightly. It wouldn't be that difficult to go in a different
way and it's not a fundamental limitation.

> - AFAIK nobody has solved the problem of managing different patchsets with tg

Why not just manage them in separate repositories? If you want to pick
patches between patchsets, that should be easily posible through remotes.

> - it's to complicate
> - even after 1 1/2 years topgit isn't feature complete and development seems 
> to stagnate
> - there also aren't best practices documented
> - it quickly fills the list of branches
> - it's very easy to break something
> 
> Although the above is quite a harsh judgement, I'd like to note, that tg has 
> had its merrit to promote one right idea: Patches should be managed in the 
> form of branches by the means of the underlying VCS and not as simple 
> patchfiles.

  I agree that topgit really sucks in many areas. :) While it is usable
in practice if you know what you are doing, in some aspects it never got
out of the proof-of-concept stage.

> The new approach I'd like to propose is based on two core ideas:
> 
> 1) merge commits to save history
> 
> git allows the free creation of merge commits with an arbitrary content tree. 
> So we can create an octupus merge combining all patch-branches while the 
> content of this merge can contain meta data about a patchset instead of the 
> content of the merged commits.
> Such a merge commit thus provides a pointer to all the history of all patches 
> and can contain all metadata about the merged patch branches. Pushing only a 
> branch or tag with this commit to a central repository thus pushes all the 
> history of all contained patches.

  But how is this different from TopGit's approach? TopGit doesn't use
octopus merges for various reasons (I mainly guess since I was too lazy
to implement that), but that's more of an implementation detail than
anything conceptual.

> 2) collapse / expand branches
> 
> Managing a Debian package in stable, unstable and experimental can quickly 
> doom you to manage at least three different patchsets with possibly three 
> different roots. The list of branches grows in the douzens. Which branches 
> belong to which patchset? Which branches are already pushed or pulled?
> It may be an advantage to see only some main branches and the branches of one 
> patchset I'm currently working on.
> The tool I propose would manage each patchset in one branch per patchset. This 
> branch has two roles:
> - keep the metadata of the patchset as files in the content tree
> - keep pointers to the top of the patch-branches in the parent pointers of the 
> commit
> With the help of such a patchset-metadata-branch I can:
> - delete the patch-branches of one patchset while the commits are kept save
> - recreate the patch-branches of one patchset

  The disadvantage is that you will have to invent a lot of arbitrary
metadata and wide range of commands to manipulate and work with this
metadata, all to accomplish something that _is actually one of the main
Git functions to do_!

  Wouldn't it be better to do the collapsing/expanding instead, e.g.
have a convention for patchset/stage branch tying up all patchset/*
branches, and an alias that lists only */stage branches and another that
lists only patchset/* minus patchset/stage branches.

> For Debian packaging one last function is needed: export a patchset as quilt 
> series.
> 
> Is my explanation understandable? Could this approach work or did I miss 
> something? Who has time to implement it (GSOC?)?

  It's especially not clear at all whether you propose to start over or
just make two improvements to TopGit, and if the former, how would your
approach differ from TopGit in all the other aspects. It's all a bit
ambiguous.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
