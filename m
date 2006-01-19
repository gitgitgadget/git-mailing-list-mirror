From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 08:58:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
 <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
 <cda58cb80601190251v5251c8bdh@mail.gmail.com> <20060119130940.GC28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Franck <vagabon.xyz@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 17:59:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezd7I-000252-6o
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 17:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWASQ62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 11:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWASQ62
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 11:58:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbWASQ61 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 11:58:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0JGwADZ027183
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Jan 2006 08:58:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0JGw90O013939;
	Thu, 19 Jan 2006 08:58:09 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060119130940.GC28365@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14915>



On Thu, 19 Jan 2006, Petr Baudis wrote:
>
> Dear diary, on Thu, Jan 19, 2006 at 11:51:22AM CET, I got a letter
> where Franck <vagabon.xyz@gmail.com> said that...
> > well, dealing with a repo that has more than 300,000 objects becomes a
> > burden. A lots of git commands are slow, and cloning it take a while !
> 
> Were the objects packed? It would be interesting to have some data about
> how GIT performs with that much objects...

The historical linux archive has a lot more than 300,000 objects. In fact, 
even the _current_ kernel archive has almost 200,000 objects.

Maybe somebody was thinking "commits", not "objects". Something with 
300,000 commits is indeed a pretty big project.

Anyway, from a scalability standpoint, git should have no problem at all 
with tons of objects, as long as you pack the old history. There are a few 
things that get slower:

 - if you end up doing things that look at history, they are obviously at 
   least linear is history size. Often there are other downsides too 
   (using lots of memory).

   Example: try even just a simple "gitk" on the (regular, new) kernel 
   archive, and it will take a while before the whole thing has been done. 
   Of course, you'll see the top entries interactively, so mostly you 
   won't care, but I routinely limit it some way just to make it not make 
   the CPU fans come on. So I do something like

	gitk --since=1.week.ago
	gitk v2.6.15..

   instead of plain gitk, just because it makes operations cheaper.

 - a full clone takes a long time. Git _could_ fairly easily have an 
   extension to add a date specifier to clone too:

	git clone --since=1.month.ago <source> <dst>

   and just leave any older stuff (you could always fetch it later), but 
   we've just never done it. Maybe we should. It _should_ be pretty simple 
   to do from a conceptual standpoint.

but "everyday" operations shouldn't slow down from having a long history. 
I can still apply 4-5 patches a second to the kernel archive, for example, 
as you can see from

	git log --pretty=fuller | grep CommitDate | less -S

and looking for one of the patch series I've applied from Andrew..

		Linus
