From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 10:13:39 -0700
Message-ID: <7vd4zzeq0s.fsf@assigned-by-dhcp.pobox.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131559210.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyWYt-00075u-Pe
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbXFMRNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758870AbXFMRNn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:13:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57063 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758001AbXFMRNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 13:13:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613171341.GINB3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 Jun 2007 13:13:41 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B5Df1X00X1kojtg0000000; Wed, 13 Jun 2007 13:13:40 -0400
In-Reply-To: <Pine.LNX.4.64.0706131559210.4059@racer.site> (Johannes
	Schindelin's message of "Wed, 13 Jun 2007 16:01:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50100>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The other thing, if you have to, is to put all dirty changes into the
> index before pull. Something like "git add $(git ls-files --modified)".
> You can even make that a global alias for your users. Although IIRC it
> does not work if the merge changes the same files as your dirty work tree
> touches, but I could very well be wrong there.

I do not think that would change the issue in general, as the
index needs to be clean (wrt HEAD) during a conflicting merge.

Incidentally, I was planning to start a "stash dirty state and
later reapply on a different commit" soon (if I survive an event
planned tomorrow, that is ;-).

When you are in the middle of something (and when you are not in
the middle of a merge), you have two states you care about.
What is in the index, and what is in the working tree.
Conceptually, even though you do _not_ have commits for these
two extra states, your "history" would look like this:

                 o <- working tree state = W
                /
               o <- index state = I
              /
      -------o <- HEAD

A dirty merge (whether it is done as "git checkout $another",
"git merge $commit", or "git pull $somebodyelse") is to first
stash away I and W, perform the merge proper to advance HEAD,
and after all that is done, recreate the index and working tree
state on top of the updated HEAD, to arrive at this:

                 o  -->  * <- new working tree state = W'
                /       /
               o  -->  * <- new index state = I'
              /       /
      -------o-------* <- merge = new HEAD
    old HEAD ^      /
                   /
      --------o---o <- other history

This can be internally done as four steps:

 * stash the dirty states (save I and W)

   - record I by "git commit" (no parameters to commit the index).

   - record W by "git add . && git commit -a".

   - remember HEAD as $STASH.

 * match the working tree and the index to original HEAD by
   "reset HEAD^ && reset --hard HEAD".  The first --mixed reset
   is to forget about new files added with "git add .", so that
   the second reset will not remove them from the working tree.

 * perform a merge in the resulting clean tree

 * unstash the dirty states

   - I' is the three-way merge between $STASH~1 and the new HEAD
     using $STASH~2 as the common ancestor.

   - W' is the three-way merge between $STASH and I' using
     $STASH~1 as the common ancestor.

Unstashing operation can potentially require two merge conflict
resolutions.  As we _care_ about distinction between the index
state and the working tree state, this is unavoidable.

    Side note: as an implementation, it is a possibility not to
    record I and record only W as the direct child of the HEAD
    when stashing.  Unstashing would update only the working
    tree (i.e. after unstashing, the index and the HEAD exactly
    matches).  But it risks "forgetting" newly added files and I
    would say it is unacceptable for that reason, even if we
    declare that this feature is only for non-git people.

Combined with the potential conflict resolution for the merge
proper, you have to resolve up to three merges in a row.  One
conflict resolution is something even CVS users must accept
anyway, so we are talking about up to two _extra_ conflict
resolutions here.
