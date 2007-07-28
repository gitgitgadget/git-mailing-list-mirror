From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Clean up work-tree handling
Date: Fri, 27 Jul 2007 22:18:08 -0700
Message-ID: <7vlkd1umwf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
	<Pine.LNX.4.64.0707271956420.14781@racer.site>
	<7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280115370.14781@racer.site>
	<7vejitwe8m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707280152120.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 07:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEegx-0002Kn-Om
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 07:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbXG1FSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 01:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbXG1FSL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 01:18:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50652 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbXG1FSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 01:18:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728051810.OWOE1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 01:18:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UtJ81X0051kojtg0000000; Sat, 28 Jul 2007 01:18:08 -0400
In-Reply-To: <Pine.LNX.4.64.0707280152120.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 28 Jul 2007 01:56:23 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53993>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Well, one of the conditions to accept the worktree stuff was not
>> to break anybody who never ever uses worktree.  So if we can
>> keep the UP-ness of cdup, it would be much better.
>
> One could record if the work tree was changed from the default one, and 
> do the old thing in that case.

This really should not be something you have to bend over with
special code to support.  One thing I think people's scripts
expect is that cdup is what the name suggests, "how much do I go
*up* in order to go to the top of the working tree", and if the
answer is "nothing", they can tell that they are already at the
top of the tree.

Now, I think it is fair to say that if your worktree is
somewhere totally unrelated to your cwd, no amount of going up
will take you to the top.  IOW, you have to come down after
going up some levels.  In such a case, it is easier to code the
implementation of --show-cdup to give an absolute path.

But in that case you are not even in the working tree to begin
with, aren't you?  Does git need to support that?  What should
"prefix = setup_git_dir()" do and return, in order to come up
with the string to prepend to paths relative to the current
directory the users give us?  I would say if your cwd is not
inside your working tree, then --show-cdup and --show-prefix
should error out, saying "Not in the working tree".  These
options are about translating paths relative to your cwd to
relative to the top of the working tree, so if you are outside a
working tree, they do not make much sense.

Also I think the implementation of --show-prefix needs to work
in terms of relative relationship between cwd and the top
already, so I am not sure where your aversion of keeping the
current cdup behaviour is coming from.

I was hoping that --show-cdup is rarely used, but unfortunately
cd_to_toplevel() in git-sh-setup.sh is not even the only in-tree
user of --show-cdup; it checks if it is empty to avoid chdir()
unnecessarily.  There are others:

 - emacs/git.el uses it as part of expand-file-name, so I think
   giving an absolute path back is Ok.

 - contrib/fast-import/git-p4 gives it to os.chdir() after
   checking if the length is positive; this should be Ok
   although it would involve an unnecessary chdir() if the
   process is already at the top with this change.

 - contrib/p4import/git-p4import.py: the same story as git-p4.

 - git-svn.perl: the same story as above.
