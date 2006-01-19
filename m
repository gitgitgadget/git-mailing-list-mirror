From: Junio C Hamano <junkio@cox.net>
Subject: Re: /etc in git?
Date: Wed, 18 Jan 2006 21:05:01 -0800
Message-ID: <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 06:05:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzRyx-0003xX-DR
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 06:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWASFFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 00:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWASFFG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 00:05:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24462 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030417AbWASFFF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 00:05:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119050303.VLAI17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 00:03:03 -0500
To: Adam Hunt <kinema@gmail.com>
In-Reply-To: <b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	(Adam Hunt's message of "Wed, 18 Jan 2006 20:40:22 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14886>

Adam Hunt <kinema@gmail.com> writes:

> Do you have any more details by chance?  Does it work?  Does it work
> well?  How does one do it?

I personally feel it is a horrible and stupid thing to do, if by
"version control /etc" you mean to have /.git which controls
/etc/hosts and stuff in place.  It would work (git does not
refuse to run as root).  But being a *source* control system, we
deliberately refuse to store the full permission bits, so if
your /etc/shadow is mode 0600 while /etc/hosts is mode 0644, you
have to make sure they stay that way after checking things out.

You are much better off to keep /usr/src/rootstuff/.git (and
working tree files are /usr/src/rootstuff/etc/hosts and
friends), have a build procedure (read: Makefile) there, and
version control that source directory.  I usually have 'install'
and 'diff' target in that Makefile, so that I can do this:

	$ cd /usr/src/rootstuff
        $ make diff ;# to see if somebody edited any targets by hand
	$ edit etc/hosts
	$ git diff ;# to see the source change
        $ make diff ;# to see the change I am going to install
        $ su
        # make install; exit
        $ git commit -a -m 'Add a new host.'

Being able to run "diff" before actually doing it is very handy
and useful safety/sanity measure.

Obviously, /usr/src/rootstuff/ should be mode 0770 or stricter,
owned by the operator group; it would contain some sensitive
information.
