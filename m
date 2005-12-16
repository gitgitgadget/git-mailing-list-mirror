From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 09:07:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512160843450.3060@g5.osdl.org>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com> 
 <Pine.LNX.4.63.0512160229140.6323@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90512152037u66993aadg566a2a47abd279c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:10:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnJ43-0004nF-7p
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 18:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVLPRIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 12:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVLPRIL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 12:08:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbVLPRIK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 12:08:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBGH7hDZ025018
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Dec 2005 09:07:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBGH7gvo001478;
	Fri, 16 Dec 2005 09:07:42 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512152037u66993aadg566a2a47abd279c9@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13739>



On Fri, 16 Dec 2005, Martin Langhoff wrote:
>
> On 12/16/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > For starters, you could use my attempt:
> > http://www.gelato.unsw.edu.au/archives/git/0508/7171.html
> 
> Not bad at all! I might simplify it a bit (won't need the commitmsg
> parsing), and see if how fast I can make it.

NOTE! You can make it a whole lot faster these days by passing the path 
down to git-rev-list. But as usual, I'm perl-incompatible, so I can't help 
you with that modification.

> OTOH, yours didn't get included. Any particular reasons? (other than
> stressing the point that you should use whatchanged/pickaxe?)

I'd love to see a git-annotate, but I want it to be efficient enough that 
it's not embarrassing.

For example, "git-whatchanged" is certainly efficient enough, and you 
could just parse that output (possible without using -p and comparing file 
contents on your own against the current HEAD as you progress backwards)

Or, you could now use "git-rev-list <rev> <filename>", which is even more 
efficient, but the downside of that is that it computes the _full_ graph 
before it starts outputting the early ones. 

But, for example:

	[torvalds@g5 linux-history]$ time git-whatchanged drivers/char/Makefile > /dev/null 
	real    0m37.993s
	user    0m41.912s
	sys     0m0.400s

	[torvalds@g5 linux-history]$ time git-rev-list HEAD drivers/char/Makefile > /dev/null 
	real    0m6.713s
	user    0m6.656s
	sys     0m0.056s

that's the old Linux history thing, with 60,000+ commit. The path-based 
git-rev-list thing cuts it down to just 103 commits you need to look at 
(so the annotate itself should be really fast, and the cost really is all 
in that "git-rev-list" thing).

Of course, with the current kernel tree, the git-rev-list takes a lot less 
time, and only results in six commits, but that's a tree that only has a 
few months of history, so when looking at performance, you really should 
look at some bigger tree.

NOTE! You can also decide to cut down on time by saying "annotate back 
only to a specific date", ie something like

	git-rev-list $(git-rev-parse --since=2.years.ago HEAD) drivers/char/Makefile

which limits the thing by filename _and_ date (a good way to handle really 
really big projects) where the rev-parse might otherwise be very 
expensive.

And, of course, a quality implementation will notice when a file 
disappears, and use "git-diff-tree -M" on that commit to see if it was 
renamed, and then continuing with the old name...

			Linus
