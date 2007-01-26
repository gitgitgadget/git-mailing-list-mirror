From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 15:46:01 -0800
Message-ID: <7vtzydtkqu.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
	<7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
	<45B9B80E.E2534F97@eudaptics.com>
	<7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701260747110.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAalu-0007i0-GX
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXAZXqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXAZXqG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:46:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54127 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXAZXqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:46:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126234602.JSFF15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 18:46:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fzl41W00S1kojtg0000000; Fri, 26 Jan 2007 18:45:04 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37903>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 26 Jan 2007, Junio C Hamano wrote:
>> 
>> One thing you could do is to take the local-ness of grafts more
>> literally and enforce it more strictly by dropping grafts while
>> fetch-pack and receive-pack exchange common objects and spawn
>> pack-objects to come up with objects needed to be sent.  But
>> because we currently punt, we do not even do that.
>
> One option might be:
>
>  - add a global flag (like the current "save_commit_buffer") that commands 
>    can set to specify whether they want to honor grafts or not.
>
>    The "please_follow_grafts" flag defaults to 1.
>
>  - "git send-pack" would explicitly set it to zero, and thus we'd always 
>    send a non-grafted result.
>
>  - "git prune" would *also* explicitly set it to zero, but would also 
>    manually look at the grafts file, and mark anything that is set in the 
>    grafts file as being reachable (the same way it does for index entries 
>    etc).

I am not sure why your "git prune" one does that, but will think
about it for some time first before I ask you to waste your time
explaining it me.

> It might also be an option to then do:
>
>  - "git repack" should probably also set it to zero - I think we might be 
>    better off packing any grafted data separately.
>
> The alternative, of course, is to try to transfer the grafts file for 
> clones and fetches, but that is likely to be a *bad* idea. It's even a 
> potential security issue: grafts can literally be used to short-circuit 
> some of the inherent safety in git, in that an attacker can make a graft 
> that makes history *look* fine, but hide part of it (you can't "really" 
> hide history, but you can make normal git operations like "git log" 
> basically ignore it by judicious use of grafts).

I agree that transferring, potentially merging, and
automatically installing grafts upon fetch has security
implications.  Thanks for pointing it out [*1*].

But if you are cloning, it would be handy if send-pack followed
the altered world view and the result had identical grafts,
which is why I am not 100% convinced about send-pack always
sending a non-grafted result.


[Footnote]

*1* Running "git fetch some-random-url" is supposed to be a safe
operation.  The only thing it does is to download some objects
that are only reachable from .git/FETCH_HEAD, and it never
overwrites objects that existed in your repository before the
fetch, so after looking at what .git/FETCH_HEAD has, potentially
malicious contents will become cruft and you can gc them away.

Running "git pull some-random-url ref" (without storing refspec)
to merge and then running "git reset --hard ORIG_HEAD" also is,
except that the reflog entry for the current branch would refer
to the merge commit and you could inject bad objects that will
not be immediately pruned in your object database that way.

The moral of the story is you should not pull from suspicious
source without thinking; fetching and immediately discarding
should always be safe.
