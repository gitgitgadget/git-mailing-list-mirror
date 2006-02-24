From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Fri, 24 Feb 2006 08:14:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602240800240.3771@g5.osdl.org>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
 <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <20060224120225.GE12309@localdomain> <Pine.LNX.4.63.0602241440330.9461@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Alex Riesen <raa.lkml@gmail.com>, Sam Vilain <sam@vilain.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 17:16:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCfbU-0006iV-MS
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 17:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWBXQPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 11:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWBXQPR
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 11:15:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932312AbWBXQPG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 11:15:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1OGErDZ032284
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 08:14:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1OGEqYt028519;
	Fri, 24 Feb 2006 08:14:52 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602241440330.9461@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16710>



On Fri, 24 Feb 2006, Johannes Schindelin wrote:
> 
> Sorry, but no. Really no. Pipes have several advantages over temporary 
> files:
> 
> - The second program can already work on the data before the first 
>   finishes.

This really is a _huge_ issue in general, although probably not a very 
big one in this case.

This is what I talked about when I said "streaming" data. Look at the 
difference between

	git whatchanged -s drivers/usb

and

	git log drivers/usb

in the kernel repo. They give almost the same output, but...

Notice how one starts _immediately_, while the other starts after a few 
seconds (or, if you have a slow machine, and an unpacked archive, after 
tens of seconds or longer).

And the reason is that "git log" uses "git-rev-list" with a path limiter, 
and currently that ends up having to walk basically the whole history in 
order to generate a minimal graph.

In contrast, "git-whatchanged" uses "git-diff-tree" to limit the output, 
and git-diff-tree doesn't care about "minimal graph" or crud like that: it 
just cares about discarding any local commits that aren't interesting. It 
doesn't need to worry about updating parent chains etc, so it can do it 
all incrementally - and can thus start output as soon as it gets anything 
at all.

Now, maybe you think that "a few seconds" isn't a big deal. Sure, it's 
actually fast as hell, considering what it is doing, and anybody should be 
really really impressed that we can do that at all.

But (a) it _is_ a huge deal. Responsiveness is really important. And 
worse: (b) it scales badly with repository size. Creating the whole 
data-set before starting to output it really doesn't scale.

Now, I have ways to make "git-rev-list" better. It doesn't really need to 
walk the _whole_ history for its path limiting before it can start 
outputting stuff: it really _could_ do things more incrementally. However, 
it's a real bitch sometimes to work with incremental data when you don't 
know everything, so it gets a lot more complicated. 

So my point isn't that "git log drivers/usb" will get less and less 
responsive over time. I can fix that - eventually. My point is that in 
order to make it more responsive, I need to make it less synchronous. More 
"streaming". 

And that is where a pipe is so much better than a file. It's very 
fundamentally a streaming interface.

However, I suspect some of these issues are non-issues for the perl 
programs that work with a few entries at a time.

		Linus
