From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 15:49:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 21:47:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do4zm-0005BF-IH
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVF3Txw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 15:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVF3Txw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 15:53:52 -0400
Received: from iabervon.org ([66.92.72.58]:55303 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263038AbVF3TvG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 15:51:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Do52F-0002hF-00; Thu, 30 Jun 2005 15:49:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jun 2005, Linus Torvalds wrote:

> Anyway, what are the limitations? Here's a few obvious ones:
> 
>  - I really hate how "ssh" apparently cannot be told to have alternate 
>    paths. For example, on master.kernel.org, I don't control the setup, so 
>    I can't install my own git binaries anywhere except in my ~/bin
>    directory, but I also cannot get ssh to accept that that is a valid 
>    path. This one really bums me out, and I think it's an ssh deficiency. 
> 
>    You apparently have to compile in the paths at compile-time into sshd, 
>    and PermitUserEnvironment is disabled by default (not that it even 
>    seems to work for the PATH environment, but that may have been my 
>    testing that didn't re-start sshd).
> 
>    That just sucks.

The easiest thing might be to have a centrally-installed wrapper script
that could run programs installed in your home directory. E.g., if
"git" had a "source ~/.git-env" at the beginning, and your ~/.git-env
fixed your PATH, then "git receive-pack ARGS" should work, for a generic
centrally installed git and special stuff in your home directory.

>  - It doesn't update the working directory at the other end. This is fine 
>    for what it's intended for (pushing to a central "raw" git archives), 
>    so this could be considered a feature, but it's worth pointing out. 
>    Only a "pull" will update your working directory, and this pack sending 
>    really is meant to be used in a kind of "push to central archive" way.

I thought only "resolve" (as part of "fetch") updated your working
directory, so this is completely consistant.

>  - this is also (at least once we've tested it a lot more and added the
>    code to allow it to create new refs on the remote side) meant to be a
>    good way to mirror things out, since clearly rsync isn't scaling. 
> 
>    However, I don't know what the rules for acceptable mirroring 
>    approaches are, and it's entirely possible (nay, probable) that an ssh
>    connection from the "master" ain't it. It would be good to know what 
>    (of any) would be acceptable solutions..

The right solution probably involves getting each pack file you push to
the mirrors as well as to the master. They'll probably update no less
frequently than you push, and they should go through a series of states
which matches the master, so it's not necessary to have anything smart on
master sending them, and they only have to unpack the files they get (and
update the refs afterward). That should make the cross-system trust
requirements relatively minimal; the mirror can fetch things from master,
and neither side has to allow the other to specify a command line.

	-Daniel
*This .sig left intentionally blank*
