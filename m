From: Junio C Hamano <junkio@cox.net>
Subject: Re: rebase problems
Date: Mon, 28 Nov 2005 12:19:40 -0800
Message-ID: <7v4q5wttib.fsf@assigned-by-dhcp.cox.net>
References: <20051128145814.GW8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 21:23:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgpTV-0003lh-4a
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 21:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVK1UTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVK1UTm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 15:19:42 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46291 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932238AbVK1UTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 15:19:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128201908.IFZF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 15:19:08 -0500
To: skimo@liacs.nl
In-Reply-To: <20051128145814.GW8383MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Mon, 28 Nov 2005 15:58:14 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12901>

Sven Verdoolaege <skimo@kotnet.org> writes:

> Recently, rebasing has stopped working for me.
> Here is an example:
>
> bash-3.00$ git-show-branch origin HEAD
> ! [origin] fix in which we remove the definition of index statements that are *not* used in the control vector
>  ! [HEAD] propagate LinearizationType typo fix.
> --
>  + [HEAD] propagate LinearizationType typo fix.
>  + [HEAD^] LinearizationType: typo
>  + [HEAD~2] espam::DecomposeChannels: actually decompose the channel if valid.
>  + [HEAD~3] DecomposeChannels: split channel and check whether result is a pair of fifos.
>  + [HEAD~4] Use proper class for LinearizationType.
>  + [HEAD~5] espam/../DecomposeChannels: partial implementation.
>  + [HEAD~6] espam: add flag for channel decomposition.
> +  [origin] fix in which we remove the definition of index statements that are *not* used in the control vector
> ++ [HEAD~7] espam/../IndexVector::toString: include contents of IndexVector.
> bash-3.00$ git rebase origin
>
> Applying 'espam::DecomposeChannels: actually decompose the channel if valid.'
>
> error: pa/espam/operations/transformations/DecomposeChannels.java: does not exist in index
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> ERROR: pa/espam/operations/transformations/DecomposeChannels.java: Not handling case 09322db769adbc03bfd4f3ac2720c6d1db5a85b1 ->  -> 32da8b1de4205c4adb0da50648a0a00d60b67582
> fatal: merge program failed
> Failed to merge in the changes.
> Patch failed at 0007.
> 0001-espam-add-flag-for-channel-decomposition.txt
>
>
> I'm not sure what rebase is doing here, but the only change in origin
> modified a file untouched by the changes in HEAD, so there shouldn't
> be any conflict whatsoever.
> Apparently it's trying to apply the change in HEAD~2 without having
> applied the earlier changes (which and the file named above).

What it should be doing (although I have not seen this kind of
breakage myself, there could be a bug that makes rebase not to
do what it should be doing) is:

 - save the original HEAD to .git/ORIG_HEAD
 - reset the tree to origin without switching branches
 - prepare patches for changes ~6, ~5, ... brings in
 - feed that to git-am, which saves the 7 patches in
   .dotest/0001 through .dotest/0007 and starts applying them.

As the first thing to do after you see something like this,
please stash away ORIG_HEAD, like this:

	$ git branch before-rebase-precious ORIG_HEAD

After this, if you choose not to rebase for whatever reason,
including "rebase is broken X-<", you could do

	$ git-reset --hard before-rebase-precious

to come back to the state before trying rebase.

The output seems very inconsistent I am not sure why the first
message says "Applying HEAD~2", not HEAD~6.    What patches do
you see in .dotest/ directory, and are they numbered in the
right order?  HEAD~6 should be numbered 0001 and that should be
the first one that was applied.
