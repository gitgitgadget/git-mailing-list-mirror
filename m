From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Sun, 28 Dec 2008 12:44:45 +0100
Message-ID: <20081228114445.GA8511@localhost>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost> <7vskopwxej.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 12:46:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGu6L-0001uY-EF
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 12:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYL1Loz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 06:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbYL1Loy
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 06:44:54 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:47977 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYL1Lox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 06:44:53 -0500
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 28 Dec 2008 12:44:50 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LGu4b-0002HW-3L; Sun, 28 Dec 2008 12:44:45 +0100
Content-Disposition: inline
In-Reply-To: <7vskopwxej.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 28 Dec 2008 11:44:50.0200 (UTC) FILETIME=[B0ECA980:01C968E1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104047>

On Mon, Dec 15, 2008 at 02:22:28AM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
> >> merge-recursive: do not clobber untracked working tree garbage
> >> 
> >> When merge-recursive wanted to create a new file in the work tree (either
> >> as the final result, or a hint for reference purposes while delete/modify
> >> conflicts), it unconditionally overwrote an untracked file in the working
> >> tree.  Be careful not to lose whatever the user has that is not tracked.
> >
> > This leaves the index in an unmerged state, however, so that a subsequent
> > git reset --hard still kills the file. And I just realized that the same
> > goes for merge-resolve. So I'd prefer to abort the merge, leave everything
> > unchanged and tell the user to clean up first.
> 
> That is unfortunately asking for a moon, I am afraid.
> 
> It needs a major restructuring of the code so that the recursive works
> more like the way resolve works, namely, changing the final "writeout"
> into two phase thing (the first phase making sure nothing is clobbered in
> the work tree, and then the second phase actually touching the work tree).

I've been giving this some thought and I would like to propose the following
solution:

1. Save index state.
2. Merge using whichever strategy, in index only, ignoring work tree.
   This step includes rename detection.
3. Check that work tree files match original index, if index does not match
   HEAD. Otherwise abort, restore index and leave everything unchanged.
4. Checkout index, overwriting work tree files, and removing files which are
   in HEAD, but not in the index.
5. If the merge was clean, commit.

AFAICS, this is largely the behavior right now, except that steps 3 and 4
are intermingled with step 2, which makes it impossible to abort the merge
if an untracked file is in the way after rename detection.

The idea at step 3 is that we can decide whether or not to proceed, based
only on the merge result, irrespective of the strategy used, possible rename
detection, or conflict resolution.

Apart from the fact that this seems like the sane thing to do, I want this
behavior because it allows me to do

git merge <branch>
# Conflicts? I don't have time for that now.
git reset --hard HEAD

under all circumstances, without touching any untracked files.

Do you agree that this is a desireable goal?

I have not looked into d/f conflicts, but I am under the impression that
this could also be handled at step 3, as far as the work tree is concerned.
Is the above proposal a workable approach, which I can pursue independently
of the major rewrite wrt. d/f conflicts Johannes indicated?
