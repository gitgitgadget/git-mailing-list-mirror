From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks: add post-update hook for updating working copy
Date: Sun, 01 Jul 2007 18:10:15 -0700
Message-ID: <7vk5tj1uh4.fsf@assigned-by-dhcp.cox.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
	<1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
	<11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
	<7vejjte4wp.fsf@assigned-by-dhcp.cox.net>
	<46882AF2.6020705@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jul 02 03:10:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5AQn-0003o3-Ni
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 03:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXGBBKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 21:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXGBBKS
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 21:10:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50665 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbXGBBKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 21:10:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702011016.PXMY22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 21:10:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JRAF1X0081kojtg0000000; Sun, 01 Jul 2007 21:10:15 -0400
In-Reply-To: <46882AF2.6020705@vilain.net> (Sam Vilain's message of "Mon, 02
	Jul 2007 10:30:10 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51333>

Sam Vilain <sam@vilain.net> writes:

> Basically I'm trying to figure out "does the current index have any
> uncommitted changes".  If it matches the tree from the previous (handful
> of) ref(s), then the answer is "no".  If we can't find it anywhere then
> it's probably got staged changes, and short of trying to move the
> changes forward, we should stop.

The fact that the index does not match the HEAD means that the
user (possibly not the one who is pushing) is in the middle of
doing something.  A tree that happens to match that state exists
in the recent reflog history would only mean that the same state
exists _somewhere_; it does not mean it is easy for the end user
to go back to it at all.

>> But more importantly, why is it justified to throw away such
>> files to begin with?
>
> Because we've already previously decided that they are safely stowed in
> a previous (via time/reflog) revision of the current branch.

The user may have spent hours to come up to that state while
doing something we do not have any way of knowing what, and this
"heuristic" is allowing to lose that.  As you say, we do not
lose the tree from the repository, but we lose track of which
state the user was interested in.  I find that unjustified.

> Perhaps it would make sense to do this check in the "update" hook as
> well, thereby chmod +x refuses to allow a push that touches the
> currently checked out branch.

Having the check in update to prevent it makes sense,
independently.

>> The longer I look at this patch, the more inclined I become to
>> say that the only part that is worth saving is the next hunk.

Actually, I think "the first sentence of the output in the next
hunk" was what I meant.  That is, "we are not updating it
because it is dirty and you cannot get back to the original
state if this was a mistake".  And not updating the index nor
the working tree.

How about doing something simpler, more predicatable and safer,
like this...

 * If HEAD/index/working tree match, then obviously we can do an
   equivalent of "reset --hard".  There is little chance that
   this is a wrong thing to do, and even when the user did not
   want that happen, the user can easily recover with for
   example "git checkout @{1} .".  So I am not opposed to
   updating the index/working tree in this case at all.

 * Otherwise, especially when HEAD and index do not match,
   touching index nor working tree is absolutely a no-no,
   without giving the user to sort the mess out.  So either in
   "update" hook you prevent it from happening.

Later, when we have git-stash, we can do a bit better in a dirty
working tree.  We could make a stash of the state _before_
updating the tip of the current branch, and let the push update
the tip, and do an equivalent of "reset --hard".  Unstashing the
state on top of the updated tip could fail, but at that point,
the user has the choice of making a new branch (or use detached
HEAD) at @{1} (that is, the HEAD before the push updated it) and
then unstash the state on top of it to recreate the state before
the push made a mess.


    
