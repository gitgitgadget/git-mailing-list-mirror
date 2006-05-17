From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 02:22:32 -0700
Message-ID: <7v7j4lhup3.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<7vpsidhx79.fsf@assigned-by-dhcp.cox.net>
	<f3d7535d0605170206y76e24f25w305a688d32f4a0a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 11:22:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIEx-0007Tc-3D
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWEQJWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWEQJWe
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:22:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42677 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932502AbWEQJWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:22:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517092233.EVEM27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 05:22:33 -0400
To: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0605170206y76e24f25w305a688d32f4a0a1@mail.gmail.com>
	(Stefan Pfetzing's message of "Wed, 17 May 2006 11:06:34 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20176>

"Stefan Pfetzing" <stefan.pfetzing@gmail.com> writes:

> Hm, gitexecdir is also the path where git is installed, right? So if I'd
> install git with pkgsrc it will be /usr/pkg/bin, right? - If so,
> putting symlinks
> there _will_ break pkgsrc.

If you look at our Makefile, you will see bindir does not have
to be gitexecdir.  The suggestion by Linus is that you set
bindir to /usr/local/bin or whereever your distribution's
packaging scheme wants the locally installed software to be that
is on user's PATH, and gitexecdir to /usr/local/libexec/git
(again, whereever), _and_ have:

	ln -s /usr/bin/gtr /usr/local/libexec/git/tr
	ln -s /usr/bin/gxargs /usr/local/libexec/git/xargs
        ...

Then:

	(1) git and gitk are available in /usr/local/bin;

        (2) while git and gitk runs, /usr/local/libexec/git will
            be prepended to the PATH, so when they want xargs,
            they will get gxargs;

        (3) but your users will _not_ have /usr/local/libexec/git
            on their PATH, so when they type xargs they will get
            the one that barfs on -0 option.

and train your users and user's scripts to use the officially
sanctioned way to refer to git subprograms.  From interactive
sessions, say "git foo", not "git-foo".  If your script _really_
cares about extra exec git wrapper does, use "git --exec-path"
upfront in the script to obtain correct gitexecpath, export
GIT_EXEC_PATH environment variable with that value, and prepend
it to PATH so that it can find "git-foo" executable (you would
probably need to do both, so that git-foo can find git-bar and
its friends).


	
