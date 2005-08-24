From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 15:48:21 -0700
Message-ID: <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
	<20050824181004.GA18790@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
	<20050824195615.GA693@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241634350.23242@iabervon.org>
	<20050824204736.GA13194@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241651420.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Baldwin <cnb@fc.hp.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 00:49:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E842l-0001CU-Ez
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 00:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHXWsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHXWsY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 18:48:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:63113 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932347AbVHXWsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 18:48:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824224821.BSNW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 18:48:21 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508241651420.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 24 Aug 2005 17:04:51 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7735>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Generally, each subdirectory of refs/ has refs to objects of the same
> type, and heads/ is commits, but other directories are other things. tags/
> is all tag objects, and you could have undo/ be trees.

That's OK from the prune front, but I am not sure what the
ramifications of this for pulling, pushing, and resolving.
I would not recommend it without really thinking it through.

Also note that tags/ is not all tag objects.  I think "git tag"
by default creates a lightweight tag, not an annotated kind.

I think you could do either one of two things.  As usual, totally
untested.  Just thinking aloud.

(1) A hack.

     - Have a single "undo-redo" branch, which was forked from
       somewhere on the "master" branch.

     - When doing "undo", make a commit that has the current top
       of undo-redo branch as the first parent and the current
       HEAD commit as the second parent, using the tree that
       represents your snapshot, to grow "undo-redo" branch.

       No, this commit does *not* represent a merge, but I am
       abusing the capability to record more than one parent
       commits.

     - When running "redo", you would want a handy way to name
       what to redo.  You can say "undo-redo~N" to mean "Nth
       from the top of undo-redo branch.

       Your implementation of "redo" can either be (patch way):

       git-diff-tree -p undo-redo~N^ undo-redo~N | git apply --index

       or (merge way):

       git-read-tree -m undo-redo~N^2 undo-redo~N HEAD &&
       git-merge-cache -o git-merge-one-file-script -a

(2) Try StGIT.
