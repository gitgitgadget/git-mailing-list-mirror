From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 08:13:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505310758270.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <2cfc4032050531005820979ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 17:15:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd8Q1-0000FE-IQ
	for gcvg-git@gmane.org; Tue, 31 May 2005 17:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVEaPO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 11:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVEaPO5
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 11:14:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:9861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261905AbVEaPLm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 11:11:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VFBVjA006358
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 08:11:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VFBUv6021894;
	Tue, 31 May 2005 08:11:31 -0700
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
>      A 
>   /  |  \ 
> B    C   D
> |  /   /
> E
> | \ 
> F G
> 
> and searching for git-rev-list A ^B it would actually be better to stop
> at E (printing A,B,C,D,E)

Btw, you probably looked at the actual code, so you know this, but maybe 
it wasn't clear to everybody else: the code obviously _will_ look at all 
of ABCDE before it can even decide that it should print out ACD, since it 
really needs to.

What happens is that it walks the tree "time-first" (not depth-first or 
breadth-first, but "most-recent-first"), which tends to approximate what 
we want, and when it sees "B" it will mark all of its children as 
uninteresting since they were clearly seen. So it will actually have 
gotten all the way to E before it can tell that it has seen enough.

The thing that makes git-rev-list preferred over git-rev-tree is that it 
can avoid looking at F and G and older parents, since it's clear by E that 
walking the tree any further would be pointless, and all the commits we 
could look at are already marked uninteresting.

But if somebody wanted to actually show this as a _graph_, what you would 
probably want is actually all of ABCDE, except you'd get the "interesting" 
bit separately (ie ACD would be tagged some way). Then you could show a 
sane graph that is colored by whether something is new or not, for 
example. That's absolutely trivial to do wiyth the new rev-list algorithm, 
in case somebody really cares - it's literally just changing the printout 
to show the entries marked "ignored" with some extra marking.

(Well, slightly more too: you'd have to add the uninteresting commits to
the list, and mark the end object itself as being ignored, but that's two
more trivial lines. Right now the code knows that it won't even add some 
objects to the output list, so..).

		Linus
