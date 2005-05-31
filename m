From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 07:35:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505310730010.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <2cfc4032050531005820979ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 16:33:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd7mq-0001ig-Ii
	for gcvg-git@gmane.org; Tue, 31 May 2005 16:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEaOeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 10:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEaOeJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 10:34:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:9706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVEaOdF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 10:33:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VEWujA003188
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 07:32:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VEWtwh019926;
	Tue, 31 May 2005 07:32:56 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050531005820979ca7@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Jon Seymour wrote:
>
> On 5/31/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > Somebody should probably take a look at my simplistic algorithm, since it
> > can probably be improved upon and/or fixed for corner-cases.
> 
> Seems reasonable, though I think that in a graph like this:
> 
>      A 
>   /  |  \ 
> B    C   D
> |  /   /
> E
> | \ 
> F G
> 
> and searching for git-rev-list A ^B it would actually be better to stop
> at E (printing A,B,C,D,E), rather than B because the contemporaneously
> parallel edits C and D and the common base E are relevant to evaluating
> B since they got merged with B into A from the common starting point E.

You're talking about something else - you worry about showing a graph, for 
example.

What git-rev-list A B does is literally for something like a "changelog" -
what commits were added in A that weren't in B, and the list is A, C and
D. Or, more commonly, used for something like

	git-rev-list HEAD v2.6.12-rc5 | git-diff-tree --stdin -v -p drivers/usb

which basically says "what changed since 2.6.12-rc5 in the drivers/usb 
tree"?

So in that situation, you really do _not_ want to see B and E, even if
you'd need those two to make all the connections. Because you've seen B
and E already (they were in v2.6.12-rc5), and if you're looking for a bug
that didn't happen in that release, you really only want to see the new
stuff.

		Linus
