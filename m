From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix empty line processing in git-shortlog.perl
Date: Sun, 06 Nov 2005 18:56:07 -0800
Message-ID: <7v3bm9upx4.fsf@assigned-by-dhcp.cox.net>
References: <20051106224218.22797.97260.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 03:58:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYxBD-0001xE-On
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 03:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVKGC4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKGC4K
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 21:56:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7911 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932412AbVKGC4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 21:56:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107025543.RNKL4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 21:55:43 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051106224218.22797.97260.stgit@machine.or.cz> (Petr Baudis's
	message of "Sun, 06 Nov 2005 23:42:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11251>

Petr Baudis <pasky@suse.cz> writes:

> Faced with a commit such as
>
> 	commit f1b2646c7f2713c3ea4bce120e1d0d8091808be4
> 	Author: Adrian Bunk <bunk@r063144.stusta.swh.mhn.de>
> 	Date:   Sun Nov 6 20:30:38 2005 +0100
>
> 	    From: Michal Wronski <wrona@mat.uni.torun.pl>
>
> 	    I've jchanged my email. Please apply this patch so as to everybody
> 	    could send me a remarks about mqueuefs.
>
> 	    Signed-off-by: Michal Wronski <Michal.Wronski@motorola.com>
> 	    Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> git-shortlog.perl would produce a line with an empty commit title.

> This patch fixes that...

> -			next unless /^\s*?(.*)/;
> +			next unless /^\s*?(\S.*)$/;

I suspect /(\S.*)$/ would do the same thing, but in any case
I do not think it is the right fix.

I think the problem is deeper than that.  Shortlog summarizes to
only one line per commit, so I suspect what you would be feeding
it would say something like this for the above example:

        commit f1b2646c7f2713c3ea4bce120e1d0d8091808be4
        Author: Adrian Bunk <bunk@r063144.stusta.swh.mhn.de>

            From: Michal Wronski <wrona@mat.uni.torun.pl>

That is, the commit you quoted is done by 'git log --pretty',
but a typical shortlog invocation would be:

	git log --pretty=short rev1..rev2 | git shortlog

With or without your fix, the command barfs.

Of course, that "From: " line should have been used as the
commit author by the tool that created the commit out of e-mail
Adrian received, but that is a separate issue.
