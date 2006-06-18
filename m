From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 12:30:03 -0700
Message-ID: <7vac8a1cuc.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 21:30:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs2yH-0001TR-Hz
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWFRTaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 15:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWFRTaF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 15:30:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4246 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932299AbWFRTaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 15:30:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618193004.ZBEG5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 15:30:04 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <449557B6.1080907@garzik.org> (Jeff Garzik's message of "Sun, 18
	Jun 2006 09:40:06 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22099>

Jeff Garzik <jeff@garzik.org> writes:

> Now that kernel 2.6.17 is out, I updated all my repositories to be
> based against that kernel.  And for each repository I updated, my
> merge was rejected, due to an error similar to:
>
>> fatal: Untracked working tree file '.gitignore' would be overwritten by merge.
>
> I am only able to merge if I delete files in the working directory, so
> that git stops complaining on merge.
>
> This behavior is new with git 1.4.0, which Fedora Extras just added.
> I verified that merges work as expected in git 1.3.3, the last version
> Fedora Extras shipped prior to 1.4.0.
>
> This behavior is a definite regression, that impacts workflow :(
>
> Here is how to reproduce:
>
> git clone -l $url/torvalds/linux-2.6.git tmp-2.6
> cd tmp-2.6
> cp .git/refs/tags/v2.6.12 .git/refs/heads/tmp
> git checkout -f tmp
> git pull . master

I was not happy with this change myself when I saw the extent of
damage it caused to the existing testsuite that was loosely
written (fcc387db9bc453dc7e07a262873481af2ee9e5c8 introduced
this change, and the needed changes to the testsuite can be seen
in the same commit).

This was done in response to this problem report:

        From: Santi <sbejar@gmail.com>
        Subject: Merge with local conflicts in new files
        Date: Wed, 17 May 2006 00:00:10 +0200
        Message-ID: <8aa486160605161500m1dd8428cj@mail.gmail.com>

        Hi *,

              In the case of:

        - You merge from a branch with new files
        - You have these files in the working directory
        - You do not have these files in the HEAD.

          The end result is that you lose the content of these files.

It is an improvement not to lose untracked files, and this is
consistent with how "read-tree -m -u" tries to protect your
changes to tracked files.  When moving around in the history of
the same project without using "git checkout" (sans -f),
however, it is bound to cause the above trouble whenever your
version switching involves created/deleted files.

I am open to suggestions to make this check easily overridable.
I suspect it should be sufficient to disable verify_absent()
check in builtin-read-tree.c when the user tells us to do so,
but the issue is how.  I can think of a few ways:

 (1) define an environment variable, return from verify_absent()
     without checking when that variable is set, and have the
     user run

     	$ GIT_UNTRACKED_CLOBBER_OK=t git pull

     when clobbering is desired.

 (2) In addition to the above, modify Porcelainish commands such
     as checkout, pull, and merge to set the environment variable
     when --clobber-ok flag is given to them.

 (3) define a new flag --clobber-ok to git-read-tree, pass it
     around from Porcelainish commands that would eventually
     call "read-tree -m -u".

I suspect the last one would be quite intrusive.  Independent of
the above, we could have a configuration item "core.clobberok = true"
to always disable the check for the repository.

It might be better to give the user a way to recover from the
situation while keeping things still safer than before by not
giving the above "clobber-ok" flag.  For example, "read-tree -m
-u" currently dies on the first "refraining from clobbering
untracked file" message, but there is not an obvious way to list
all untracked files that will be clobbered by the operation so
that you can make sure they are something you do not care about
and remove them yourself before retrying.
