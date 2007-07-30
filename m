From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 14:29:02 -0700
Message-ID: <7vabtdk2ch.fsf@assigned-by-dhcp.cox.net>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	<20070730201023.GC64467@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcni-0001qt-Vt
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967682AbXG3V3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967438AbXG3V3I
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:29:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38128 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765616AbXG3V3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:29:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730212905.GSEG1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 30 Jul 2007 17:29:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VxV31X00J1kojtg0000000; Mon, 30 Jul 2007 17:29:04 -0400
In-Reply-To: <20070730201023.GC64467@nowhere> (Craig Boston's message of "Mon,
	30 Jul 2007 15:10:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54271>

Craig Boston <craig@olyun.gank.org> writes:

> 1) Have a separate repository clone for each branch that I want to
> import to and leave that branch permanently checked out.  I lose the
> disk space for N working copies, but on the server I'm doing the import
> on, it's not a huge issue, especially with ZFS compression ;-)
>
>  * This might not actually be so bad if I put the .git directory inside
>    of the CVS checkout directory and used it as my "working copy".  I
>    just need to insure that git doesn't create any additional files in
>    there, as cvsup is really picky about not deleting files that it
>    didn't create, even if they were removed from CVS.

With one of the projects hosted on CVS I have to interoperate
with, that is what I do.  For historical reasons I do not use
git-cvsimport/exportcommit for this one, but basically:

 - "cvs co" to prime the working tree;
 - "echo CVS >.gitignore";
 - "git init && git add . && git commit";
 - "git checkout -b mine";

then I work in "mine" branch.  When other people have something
to say, I do:

 - "git checkout master";
 - "cvs up";
 - "git add <whatever was added with the above cvs up>";
 - "git commit -a";
 - "git rebase master mine";

When feeding my own changes back to CVS, I would:

 - "git checkout master";
 - "cvs up" to make sure other people do not have any stuff;
 - "git show-branch master mine" to see what I have; 

 - "git cherry-pick <whatever the change I want to feed back>";
 - "cvs commit";
 - repeat the last two steps for all the changes I want;

 - "git rebase master mine";

I only need to make sure not to commit on "master", and not to
run "cvs up" while on "mine".

This can be extended to more than one CVS branches by using
different branches than "master".

> 2) Have one repository clone that gets re-used for each import, with the
>    "checked out" branch getting changed before the import.  As far as I can
>    tell this means suffering the "git checkout" overhead for 30,000 files,
>    which is conceptually inefficient but in real time only a minute or so.

That should only be "conceptually" in fact, as switching between
branches should not touch paths that are the same between
branches.
