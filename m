From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 07:04:12 -0400
Message-ID: <20050419110407.GB28269@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr> <20050418122011.GA13769@abridgegame.org> <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 13:06:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNqXu-0003Bx-WF
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 13:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDSLJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSLJj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 07:09:39 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:37695 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261230AbVDSLJa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 07:09:30 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DNqWa-0007OQ-Ol; Tue, 19 Apr 2005 07:04:12 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 02:55:05AM +0200, Juliusz Chroboczek wrote:
> [Using git as a backend for Darcs.]
...
> >>  1. remove the assumption that patch IDs have a fixed format.  Patch
> >>  IDs should be opaque blobs of binary data that Darcs only compares
> >>  for equality.
> 
> > I'm not really comfortable with this,
> 
> Why?

I'm not clear why it would be necesary, and it takes the only immutable
piece of information regarding a patch, and makes it variable.  Just seems
dangerous and complicated, and I'm not sure why we'd need to do it.

> Suppose I record a patch in Darcs; it gets a Darcs id.  I push it into
> git, at which point it gets a git id, whether we want it to or not.
> What do we do when we pull that patch back into darcs?
> 
> Either we arbitrarily discard one of the ids (which one?), or we keep
> both.  If there's more pulling/pushing going on on the git side, we
> definitely need to keep both.

Or alternatively, we could have a one-to-one mapping between git IDs and
darcs IDs, which is what I'd do.

> > I think when dealing with git (and probably also with *any* other SCM
> > (arch being a possible exception), we need to consider the exchange
> > medium to be not a patch, but a tag.
> 
> We're thinking in opposite directions -- you're thinking of the alien
> versions as integrals of Darcs patches, I'm thinking of Darcs patches
> as derivatives of alien versions.
> 
>   You:  alien version = Darcs tag
> 
>   Me:   Darcs patch = pair of successive alien versions
> 
> My gut instinct is that the second model can be made to work almost
> seamlessly, unlike the first one.  But that's just a guess.

The problem is that there is no sequence of alien versions that one can
differentiate.  Git has a branched history, with each version that follows
a merge having multiple parents.  How do you define that change?  It's easy
enough to do if we tag each git version in darcs, since we know what the
two parents are, and we know what the final state is, but there *is* no
translation from a single git ID either to a single patch(1) patch, or to a
single darcs patch--unless you treat its parents as tags.

The key is that we can't make git work like darcs, so we'll have to make
darcs work like git.  If we do it right (automatically tagging like crazy
people), darcs users between themselves can cherry-pick all they like,
without introducing inconsistencies or losing interoperability with git.

To summarize how I'd see the mapping between git information and darcs, a
git commit would be composed of one darcs patch and one darcs tag.  With
this mapping, I don't believe we lose any information, and I believe we'll
be able to (except that patches would have to be uniquely determined by a
pair of trees) simply translate the darcs system right back again, since
it's a one-to-one correspondence of information.

My proposed mapping:

tree 6ff0e9f3d131bd110d32829f0b14f07da8313c45
# This is a darcs tag ID
parent abd62b9caee377595a9bf75f363328c82a38f86e
# This is the context of both a patch and tag.
author James Bottomley <James.Bottomley@SteelEye.com> 1113879319 -0700
# This is the author and date of the patch
committer Linus Torvalds <torvalds@ppc970.osdl.org.(none)> 1113879319 -0700
# This is the author and date of the tag
# Everything below would be the name and long comment of the patch

[PATCH] SCSI trees, merges and git status

Doing the latest SCSI merge exposed two bugs in your merge script:

1) It doesn't like a completely new directory (the misc tree contains a
   new drivers/scsi/lpfc)
2) the merge testing logic is wrong.  You only want to exit 1 if the
   merge fails. 


-- 
David Roundy
http://www.darcs.net
