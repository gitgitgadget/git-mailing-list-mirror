From: Tony Lindgren <tony@atomide.com>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 10:54:19 -0700
Message-ID: <20050602175419.GD21363@atomide.com>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org> <20050602071453.GA16616@kiste.smurf.noris.de> <20050602073205.GA31482@muru.com> <Pine.LNX.4.58.0506020741480.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 19:53:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddts3-0004aq-Fb
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 19:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVFBRzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 13:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFBRzk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 13:55:40 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:14226 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261218AbVFBRz3
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 13:55:29 -0400
Received: from torttu.muru.com (adsl-67-117-73-34.dsl.sntc01.pacbell.net [67.117.73.34])
	by ylpvm01.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j52Hrlqa025681;
	Thu, 2 Jun 2005 13:53:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by torttu.muru.com (Postfix) with ESMTP id 5B957BF459;
	Thu,  2 Jun 2005 10:54:30 -0700 (PDT)
Received: from torttu.muru.com ([127.0.0.1])
	by localhost (torttu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09977-05; Thu, 2 Jun 2005 10:54:24 -0700 (PDT)
Received: from marenki.muru.com (unknown [192.168.100.15])
	by torttu.muru.com (Postfix) with ESMTP id 7E167BF456;
	Thu,  2 Jun 2005 10:54:18 -0700 (PDT)
Received: by marenki.muru.com (Postfix, from userid 1000)
	id C50603C048D; Thu,  2 Jun 2005 10:54:19 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506020741480.1876@ppc970.osdl.org>
User-Agent: mutt-ng 1.5.9i (Linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at adsl-67-117-73-34.dsl.sntc01.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [050602 07:50]:
> 
> 
> On Thu, 2 Jun 2005, Tony Lindgren wrote:
> > 
> > I don't think locking for the duration of the push really is a problem.
> > It is unlikely that there would be so many people pushing that it would
> > cause inconvenience... Of course it would be nice to optimize it if
> > possible.
> 
> I don't think the locking is a _huge_ issue - the only real problem I had
> with locking with BK was that readers could block a writer (ie I couldn't
> push to my public tree if there were people downloading from it), and git
> doesn't have that problem. I only push to trees that are my private ones
> anyway.
> 
> The real reason I'd prefer to not do locking is that _if_ the remote tree
> is actually more than just a CVS-like "public repository", ie if somebody
> actually does _development_ in the remote tree (hey, it may be crazy, but
> git makes this usage pattern possible), then we should eventually plan on
> having all of the regular "git-commit-script" and "git-pull-script" etc
> _also_ do locking, since they also change HEAD.

Or perhaps a more likely scenario would be automated pulls from other trees
running as cronjobs on the remote server.

> And that's going to be a lot easier if we only do a cmp-xchg and fail at
> the end (this concurrent change and "remote repo" usage is really quite
> wrong, since it basically mean that you consider somebody's development
> tree to be "public", and that's not what git is all about, but whatever..)
> 
> But this is not a huge issue. The most important thing is to make sure
> that the new HEAD is written last, regardless, so that at least local
> readers (including things like "fsck" that can take a _loong_ time) always
> see consistent state.
> 
> > I would assume the biggest problem for most people is how they can push
> > through a firewall. From that point of view it would make sense to do
> > the push as a cgi script rather than something over ssh. And with a
> > cgi script you can of course optimize the locking and use tmp files
> > before renaming which are a bit hard to do with rsync.
> 
> Me personally, I want ssh as a major option. There are tons of machines 
> (every single of my own ones) that I use that don't let anything but ssh 
> through.

Yeah I prefer ssh too in general. Many corporate firewalls don't allow
ssh through though.

> But having alternatives is good. But ssh should be the first and primary 
> one, since it also means that there can't be any new security issues (ie 
> you won't be opening up any new holes by installing git on the remote 
> machine).

Yeah. Doing it as cgi also has some issues getting the file
permissions right so the repo would still work for ssh users too...

Is anybody planning to work on this? I'm pretty much out of
time and will probably be happy with the rsync script for now.

Tony
