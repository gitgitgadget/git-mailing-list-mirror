From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 17:54:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506221654550.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506221315201.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 23:58:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlDEM-00061E-Cg
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 23:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVFVWDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVFVV6n
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 17:58:43 -0400
Received: from iabervon.org ([66.92.72.58]:8709 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262441AbVFVVzg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 17:55:36 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlDAX-0000GU-00; Wed, 22 Jun 2005 17:54:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221315201.2353@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Jun 2005, Linus Torvalds wrote:

> I do realize that people use patch ID's inside various companies already, 
> because it's a nice way to track things. But the fact is, especially with 
> the patch going outside the SCM (which is the whole _point_ here, after 
> all), any modifications will make that ID be dubious.

If this were done within the system, the maintainer would merge a commit
from the author, commit, fix up the whitespace, commit, and push out the
result. The developer then sees that the head was merged, and that
whitespace changes were applied on top of that.

The benefit to an ID that doesn't get changed is that the developer (or
the developer's scripts) can tell that the patch is an ancestor of the new
base tree, which is really important information about maintainer
intent: the remnant in this case is a revert of the maintainer's
changes to the patch, not an independant but conflicting patch.

> And if it _isn't_ modified, then the ID is pointless - you might as well 
> use the SHA1 of the patch itself as its ID, ie not use an explicit ID at 
> all.

My thought was actually to use the hash as the ID, and add headers for
"this patch is a descendant of <other-ID>" as it gets tweaked.

But even in the case where the patch is not modified, the developer can't
retrieve the hash of the applied patch, because it may have applied with
fuzz, in which case diffing the parent's tree with the tree wouldn't
generate a byte-for-byte identical patch. So it would be worth having the
commit store the hash of the submitted patch in a header anyway.

> So I think introducing extra ID's in the process only creates the
> possibility for more confusion. Either the patch is unmodified (and the ID
> is not needed in the first place) or the patch is modified (and the ID
> doesn't convey that).

Do you actually modify patches before applying them, rather than applying
them and the fixing the resulting files? I've never managed to modify
content in a patch (aside from dropping hunks) without upsetting patch. If
you apply them and then fix things, the ID (and for that matter, the 
hash) will be safely conveyed from my system to yours and available for
the commit to mention.

> Which of course is ok, but it's _not_ what I'm interested in if we're
> discussing trying to make git itself have some support for "end-developer
> merges" (re-write history) as opposed to "maintainer merges" (merge
> history).

I believe there are separate issues here: 

 1. pure history rewriting: maintainer merges a developer's
    intermediate head; developer generates a new history in which
    everything later is based on the new mainline.
 2. patches: changes are transferred as diffs over SMTP instead of trees
    inside git.
 3. cherry-picking: maintainer applies some set of changes from a
    developer which is not merging a head the developer created.

I think (1) is easily handled as a merge script that goes through a series
of commits and makes a new series out of merging each of them, rather than
merging the last of them only.

I think (2) should be as transparent as possible, and, in cases where
there was no cherry-picking, be equivalent in the system's behavior to the
result of pull and merge (with the possibility for various cleanup 
happening on top of or along with the merge in either method).

The tricky part is (3), which is currently only possible by going outside
of git. But I think that this is something to tackle separately from
(1) and (2) (where (2) does not involve doing (3)).

	-Daniel
*This .sig left intentionally blank*

