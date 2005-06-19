From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Sun, 19 Jun 2005 00:26:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506182338300.30848-100000@iabervon.org>
References: <tnxis0b1h7g.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 06:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjrK9-0000l6-TQ
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 06:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVFSE1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 00:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVFSE1x
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 00:27:53 -0400
Received: from iabervon.org ([66.92.72.58]:51206 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261826AbVFSE1t (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 00:27:49 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DjrO5-0002jS-00; Sun, 19 Jun 2005 00:26:25 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxis0b1h7g.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Jun 2005, Catalin Marinas wrote:

> Having different series would be a good idea but it might complicate
> the tool usage. I will thing about it once I'm sure the basic
> operations work fine.

You could future-proof yourself a bit by simply saving the base as
.git/refs/bases/master and making the patches be
.git/patches/master/. That way, you'd be ready when you start to support
multiple series.

> Before commenting further on your or Jon's e-mail, I want to clarify
> how I think this tool should be used (this might be misunderstood if
> someone never used quilt before). First of all, a StGIT patch is a
> collection of git commits. This tool *doesn't* remove or modify git
> changesets.

(snip)

Okay; this fits what I thought quilt and StGIT did. 

An aside:

> - pushing a patch to the stack when the base changed is done by
>   merging with a diff3 algorithm. I find this slightly superior to a
>   simple 'patch -p1 < file.diff' (well, some people do not agree with
>   this point)

diff3 is clearly superior to patch in how effective it is; the
disagreement is only over how useful the output format is. But diff3 gets
all the information that patch gets, plus more, so it would have to be
buggy if it did worse, aside from by patch getting lucky. (Also, patch can
be used in situations where diff3 couldn't, due to having no known common
ancestor). IIRC, diff3 can generate .rej files if you tell it to, rather
than reporting conflicts inline.

> I don't know whether this is still valid after clarifying the intended
> use of StGIT. When a patch was merged upstream, the local push
> operation should detect that the patch being pushed doesn't change
> anything and, at this point, you can safely delete it.

If you're lucky, it will generate only a warning that changes are present
in both trees, the push will have no effect, and StGIT can determine that
the rebased patch is now empty. But consider this situation:

You have three patches stacked on a base.

The mainline takes a patch from somewhere else, then the first of your
patches, then a second patch from somewhere else. The last of these is
based on your first patch (or on mainline after your patch went in).

Then you update.

When you try to push your first patch, merge sees the common base, your
change, and the current mainline. There is no way to tell, from the
information available, that the correct merge is to ignore your change in
favor of mainline's version; the program only sees that there were two
different changes to the same area. The information which would resolve
this were patches not used would be that there was a mainline commit that
merged your first patch; the left side of the merge is an ancestor of the
right side, so the merge is the right side. My goal is to get the same
information into the system so it can reach the same conclusion when
patches are used.

Note that it gets more complex if mainline takes only your second patch
(due to it not requiring your first, and your first not being as
acceptable). In this case, it needs to entire mainline as a patch, because
merges can't cherrypick, whereas patches can act arbitrarily. But it would
be nice to store the information of what happened even with patches that
cherrypick, such that we have a better chance for managing things later.

The above situation is not actually particular to StGIT or quilt; any case
where something gets exported as a patch and applied to a different base
has this problem. But I think that you have the right ideas about how
patches should be represented, and it would be good to get your
representation implemented inside git, because operations more central to
git would benefit from having this information.

	-Daniel
*This .sig left intentionally blank*

