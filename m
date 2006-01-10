From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 10:27:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	"Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwOEL-0004VQ-4B
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 19:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWAJS2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 13:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWAJS2V
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 13:28:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932256AbWAJS2U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 13:28:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AIRBDZ025195
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 10:27:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AIR3RN007181;
	Tue, 10 Jan 2006 10:27:04 -0800
To: Kyle Moffett <mrmacman_g4@mac.com>
In-Reply-To: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14432>


On Tue, 10 Jan 2006, Kyle Moffett wrote:
>
> On Jan 10, 2006, at 01:38, Martin Langhoff wrote:
> > 
> > The more complex your tree structure is, the more the interactions are
> > likely to be part of the problem. Is git-bisect not useful in this scenario?
> 
> IIRC git-bisect just does an outright linearization of the whole tree anyways,
> which makes git-bisect work everywhere, even in the presence of difficult
> cross-merges.

It's not really a linearization - at no time does git-bisect _order_ the 
commits. After all, no linear order actually exists. 

Instead, it really cuts the tree up into successively smaller parts. 

Think of it as doing a binary search in a 2-dimensional surface - you 
can't linearize the plane, but you can decide to test first one half of 
the surface, and then depending on whether it was there, you can halve 
that surface etc.. 

> On the other hand, if you are git-bisecting ACPI changes
> (perhaps due to some ACPI breakage), and ACPI has 10 pulls from mainline, you
> _also_ have to wade through the bisection of any other changes that occurred
> in mainline, even if they're totally irrelevant.

Yes. Although if you _know_ that the problem happened in a specific file 
or specific subdirectory, you can actually tell "git bisect" to only 
bother with changes to that file/directory/set-of-directories to speed up 
the search.

IOW, if you absolutely know that it's ACPI-related, you can do something 
like

	git bisect start drivers/acpi arch/i386/kernel/acpi

to tell the bisect code that it should totally ignore anything that 
doesn't touch those two directories.

However, if it turns out that you were wrong (and the ACPI breakage was 
brought on by something that changed something else), "git bisect" will 
just get confused and report the wrong commit, so this is really something 
you should be careful with (and verify the end result by checking that 
undoing that _particular_ commit really fixes things).

And yes, "git bisect" _will_ work with bugs that depend on two branches of 
a merge: it will point to the merge commit itself as being the problem. 
Now, at that point you really are screwed, and you'll have to figure out 
why both branches work, but the combination of them do not.

Maybe it's as simple as just a merge done wrong (bad manual fixups), but 
maybe it's a perfectly executed merge that just happens to have one branch 
changing the assumptions that the other branch depended on.

Happily, that is not very common. I know people are using "git bisect", 
and I don't think anybody has ever reported it so far. It will happen 
eventually, but I'd actually expect it to be much more common that "git 
bisect" will hit other - worse - problems, like bugs that "come and go", 
and that a simple bisection simply cannot find because they aren't 
totally repeatable.

			Linus
