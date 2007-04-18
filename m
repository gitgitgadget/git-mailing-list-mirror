From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 00:40:10 -0700
Message-ID: <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
References: <20070417161720.GA3930@xp.machine.xx>
	<Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
	<20070418055215.GA32634@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4mK-000102-OZ
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbXDRHkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbXDRHkN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:40:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:65409 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbXDRHkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 03:40:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418074011.SEDF1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Apr 2007 03:40:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oXgA1W0021kojtg0000000; Wed, 18 Apr 2007 03:40:10 -0400
cc: Julian Phillips <julian@quantumfyre.co.uk>
In-Reply-To: <20070418055215.GA32634@xp.machine.xx> (Peter Baumann's message
	of "Wed, 18 Apr 2007 07:52:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44867>

Peter Baumann <waste.manager@gmx.de> writes:

> The problem is, when I created the new workdir, I don't have a file
> .git/packed-refs, so a new workdir was created with a dangling symlink,
> e.g.  workdir/.git/packed-refs -> repo/.git/packed-refs (but the last one
> doesn't exist). As it seems, git gc removes the dangling symlink and
> replaces it with a file.

Yes, packed-refs file is creat-to-temp-and-then-rename, and we
will lose the sharing if it is run in the symlink-shared work
tree.

We can do one of two things.  I am not sure which one is better.

 (0) The effect of 'git gc' by definition in the symlink-shared
     work tree should be the same as in the original repository
     as the former is to share all the refspace and object
     database.  So we _could_ declare that running 'git gc' in
     symlink-shared work tree is insane and educate people to
     run that in the original repository.  This is _not_ doing
     anything.

 (1) We could by convention declare a worktree whose .git/refs
     is a symlink, and have git-gc and friends check for it, and
     either refuse to run or automatically chdir and run there.

     If we were to do this, we probably should check more than
     just .git/refs but some other symlinks under .git/ as well.

 (2) We could dereference .git/packed-refs, when it is a
     symlink, by hand, just like we dereference a symlink HEAD
     by hand (see resolve_ref() in refs.c), and run the
     creat-to-temp-and-then-rename sequence to update the real
     file that is pointed at by it.


     
