From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 13:25:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 22:25:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F430F-0002XJ-9H
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWAaVZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWAaVZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:25:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751503AbWAaVZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 16:25:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VLP9DZ007199
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 13:25:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VLP8gW032546;
	Tue, 31 Jan 2006 13:25:08 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060130225107.GA3857@limbo.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15349>



On Mon, 30 Jan 2006, Alex Riesen wrote:
> 
> I use git in cygwin for a project with more then 17k files (almost 6M lines).
> It's real slow on ntfs (on 3.2Mhz PIV!)

One thing that git does rely on is a fast "lstat()" system call. The index 
file means that we almost never need to read the contents of a file to 
compare, but git _does_ check that files haven't been modified, and doing 
an "lstat()" on every single file it knows about is the way to do that.

Now, I suspect that you simply can't do basic filename lookups much faster 
than Linux does them. The Linux VFS layer name caching reigns supreme: the 
dentries are just incredibly powerful, and the reason Linux kicks ass on 
many benchmarks.

And yes, git was designed for it. git is _really_ fast on Linux, but any 
operating system that is so stupid that it has to call down to the 
low-level filesystem for filename lookup (which is most of them, and from 
what I have heard, the NT VFS layer is worse than most) will take a lot 
longer.

This is sadly not something I think you can possibly avoid. Git is 
literally being as fast as is humanly possible without doing explicit 
locking. You _can_ avoid the "lstat()" calls if you are willing to always 
explicitly mark files that you have changed (so that the SCM can stat just 
_those_ files and ignore all the others), but I personally much prefer 
being able to use any random tools on the files without having to prepare 
them some way.

So we could speed it up on cygwin (and yes, it would speed git up a lot 
even on Linux, but since the cached lstat() case is so fast anyway, I 
doubt a lot of Linux users care - the biggest win would be on a cold-cache 
tree).  But it would require that you explicitly _mark_ the files you edit 
some way.

Btw, BK wanted that, and it wasn't _too_ painful. You had to do

	bk edit

to mark a file as being ready to be dirtied, and as a helper command you 
would use

	bk editor

which would first do the "bk edit" thing and then start up your favourite 
editor (the usual ${EDITOR:${VISUAL:vi}} rules applied) on it, and it 
worked fine. We _could_ do the same in git.

I'd just prefer not to.

For small projects (or big projects with fairly few files), it really 
shouldn't matter. Your 17k files example is hopefully fairly rare..

> But its more intuitive and more powerful than any alternatives here (Perforce,
> SVN and CVS come to mind).

Good to know.

		Linus
