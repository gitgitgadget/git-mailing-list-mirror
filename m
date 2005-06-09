From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 19:48:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081936370.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeag1j9y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
 <7vll5kxolo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 04:43:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgD0s-0005cV-PT
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 04:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFICrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 22:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVFICrS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 22:47:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:38062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbVFICqr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 22:46:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j592kejA018962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 19:46:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j592kd9L011165;
	Wed, 8 Jun 2005 19:46:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll5kxolo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Junio C Hamano wrote:
> 
> Well, except that $I may validly be an empty tree ;-), so not
> quite.

Yeah, ok, so the fact that we allow missing things in the index (which was 
debatable to start with) makes for exceptions. 

We could certainly be stricter about the index contents, and require that
they match the branch we're merging from exactly, rather than be a subset.  
That said, I'm not convinced that it's worth it, even if it means that a
two-way merge ends up acceping merges that a three-way one never would.

> In case it was not clear, where I am headed is this.  I would
> like to rip out the two-tree "carry forward" implementation from
> read-tree, and replace it with:

Yeah, I see that, I'm just not entirely convinced it's a good idea.

The thing is, a two-way merge really _is_ very different from a three-way
one, in that it's a fast-forward, and the fact that it allows for things
that the more complex "full" case wouldn't allow I feel is something of an
advantage. And it _can_ allow them exactly because it's not the full case.

I like your concept:

> When/if that happens, then the current fast-forward code would
> need to be changed from:
> 
>     read-tree -m $H $M && echo $M >.git/HEAD
> 
> to
> 
>     read-tree -m $H $M &&
>     if unmerged paths in the resulting cache
>     then
>         merge-cache -o merge-one-file-script -a
>     fi &&
>     echo $M >.git/HEAD
> 
> and the user's local changes since H when fast forwarding to M
> would be handled with the same workflow as the three-way case.

but that one doesn't really help the case of stuff he hasn't marked 
up-dated, so I think that's actually a special case that _isn't_ the 
important one. I think the case that is more important (and more likely to 
hit people) is when they have something in their working tree that 
conflicts with the merge, and then what you want is really that the 
current "update" code do the three-way merge in the working directory, not 
that it's done on the index file contents.

So I see where you are coming from, but I don't think the index file is 
the most important case. The more important case is the one that the 
three-way merge doesn't handle either!

		Linus
