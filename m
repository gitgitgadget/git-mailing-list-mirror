From: Junio C Hamano <junkio@cox.net>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 14:25:13 -0700
Message-ID: <7vfy712uva.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	<7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdCE7-0002Nh-OL
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbXDOVZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbXDOVZQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:25:16 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51714 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbXDOVZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:25:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415212513.KDFH1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 17:25:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nZRD1W00h1kojtg0000000; Sun, 15 Apr 2007 17:25:14 -0400
In-Reply-To: <Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 15 Apr 2007 14:01:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44528>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> If "next" and "pu" are the same, and you have "next" checked out, and you 
> push into "pu", what happens? Since the two branches were the same, the 
> SHA1 was the same before, so the BASE commit in the index will be the one 
> that is updated.

But it does not matter if "pu" was not checked out.  You will be
building on top of "next" which was not changed.

> The only thing that matters is that if you update the branch that HEAD 
> points to, and then you'd always need to do something special, but I don't 
> see that it has anything to do with what the "BASE" commit was.. It's 
> purely a matter of "what does HEAD point to", independently of the index.
>
> But no, I wasn't following that series, so I probably totally 
> misunderstood what you were going after..

Could be.

The issue in short was about:

	$ git checkout $branch

At this point you think your HEAD is at $branch head, and you
are working towards building a commit that has that commit as
one of the parents.

Then a gremlin updates the commit HEAD points at.  Maybe
somebody else pushed into $branch.  Or you had another working
tree that shares refs (but not index nor HEAD -- perhaps set up
with contrib/workdir/git-new-workdir) with this repository and
made a commit there by mistake on the branch.

And you try to make a commit.

	$ git commit

The work you did in your repository were mostly based on the
contents of the commit you checked out but this "git commit"
will create a commit on top of something else (i.e. the one the
gremlin updated to).

To detect this case, we needed to record "which commit are we
expecting to base the next commit on".  The place to record that
information does not have to be in the index (I could have
picked a separate file .git/current-head-commit and stored the
information there), but the index was a convenient place to do
so.

So it does not have anything to do with the index, but very much
about the HEAD.  The problem was about keeping it in sync with
what really was going on in the repository / working tree.
