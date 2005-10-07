From: Junio C Hamano <junkio@cox.net>
Subject: Re: Create object subdirectories on demand
Date: Fri, 07 Oct 2005 02:38:14 -0700
Message-ID: <7vfyrd7jll.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 11:38:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENogM-0004rS-26
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 11:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVJGJiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVJGJiW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 05:38:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64196 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932266AbVJGJiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 05:38:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007093811.CUI19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 05:38:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 6 Oct 2005 16:23:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9799>

Linus Torvalds <torvalds@osdl.org> writes:

> This has _not_ gotten a lot of testing, but I verified that basic things 
> seem to work, and that packing an archive properly removes the unnecessary 
> subdirectories.
>
> I'd suggest it sit in "pu" for a while.

I typically use the tip of "pu" myself, which resulted in an
interesting case (nothing grave).  After running 'git prune', I
switched to another topic branch that did not include this
patch, built it, and tried it out -- and got complaint because
the earlier 'git prune' happened to remove ".git/objects/00".
Now I was not in a valid git repository anymore ;-).

This needs to wait until everybody's git get this update,
especially, I cannot use this version in my $HOME/bin/ on
kernel.org right now.

But then once everybody else updates, the repository their git
creates cannot be read by my git -- an interesting chicken and
egg problem.

Maybe successful rmdir() immediately followed by mkdir(), if we
are willing to waste 4KB or so per empty directory, trading
space for safety and ease of transition?  That is, phase I tools
do not complain if objects/00 is missing, lazily creates
object/??/ is missing, and makes sure empty directories are
pruned but still recreates them for safety.  Then phase II tools
then stops the recreating part.

> However, somebody should really check my code carefully before merging 
> this. In particular, I didn't test "git-ssh-pull" at all, so I'm not sure 
> I actually fixed the "write temp-file" thing properly.

Well, the thing is, I do not use commit walkers over ssh myself
and honestly consider them having outlived their usefulness.
But you are right -- I should look at this one again before
placing in the master.
