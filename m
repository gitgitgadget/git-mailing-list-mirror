From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 11:51:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602231143290.3771@g5.osdl.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 20:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMWE-0002n7-W4
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWBWTwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWBWTwG
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:52:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751777AbWBWTvv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 14:51:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1NJplDZ011776
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Feb 2006 11:51:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1NJphgY010990;
	Thu, 23 Feb 2006 11:51:45 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16661>



On Thu, 23 Feb 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes: 
> > There are many portable interpreters out there, and I don't mean perl. And 
> > writing a small "specialized for git" one isn't even that hard. In fact, 
> > most of the shell (and bash) hackery we do now would be unnecessary if we 
> > just made a small "git interpreter" that ran "git scripts".
> 
> Before anybody mentions tcl ;-).

Well, I was thinking more of the "embeddable" ones - things that are so 
small that they can be compiled with the project. Things like Lua.

Now, Lua is not really very useful for this use case: our scripts are much 
more about combining other programs - piping the output from one to the 
other - than about any traditional scripting. Which, afaik, Lua isn't good 
at.

> I agree with the above in principle, but I am afraid that is
> only half of the solution to the problem Alex is having.
> 
> In the longer term, libified git with script language bindings
> would make the way git things work together a lot better.  I've
> always wanted to make merge-base a subroutine callable from
> other things, so that I can say "git diff A...B" to mean "diff
> up to B since B forked from A" ;-).

Yeah, we should libify some of it, to make things easier. That said, I 
don't belive in the "big-picture" libification. The fact is, a lot of git 
really _is_ about piping things from one part to another, and library 
interfaces work horribly badly for that. You really want more of a 
"stream" interface, and that's just not something I see happening.

I think one of the strengths of git is that you can use it in a very 
traditional UNIX manner, and do your own pipelines. And that will 
obviously NEVER work well under Windows, if only because it's not the 
natural way to do things.

Again, libification does nothing for that thing.

What I'd suggest using an embedded interpreter for is literally just the 
common helper scripts. We'll never make 

	git-rev-list --header a..b -- tree | 
		grep -z '^author.*torvalds' |
		..

style interesting power-user pipelines work in windows, but we _can_ make 
the things like "git commit" work natively in windows without having to 
re-write it in C by just having an embedded interpreter.

And I very much mean _embedded_. Otherwise we'll just have all the same 
problems with perl and bash and versioning. 

> But we do need to talk to non-git things.  git-grep needs a way
> for ls-files to drive xargs/grep, for example.  diff --cc reads
> from GNU diff output.  And for these external tools, the way
> they expect the input to be fed to them or their output is taken
> out is via UNIXy pipe.

I was really thinking more of a simple shell-like script interpreter. 
Something that we can make portable, by virtue of it _not_ being real 
shell. For example, the "find | xargs" stuff we do is really not that hard 
to do portably even on windows using standard C, it's just that you can't 
do it THAT WAY portably without assuming that it's a full cygwin thing.

		Linus
