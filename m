From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:18:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112010120.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBNF-0002Fw-Sk
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVGLDV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGLDTN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:19:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262261AbVGLDSe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 23:18:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C3ITjA017113
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 20:18:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C3ISCD018707;
	Mon, 11 Jul 2005 20:18:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Junio C Hamano wrote:
>
> > Opinions?
> 
> How about treating "master" a temporary thing --- "whatever I
> happen to be working on right now"?

I'd not mind with this in theory, but it has the fundamental problem that 
we can end up losing sight of commits we have, and then have no way to 
reach them.

Which is ok per se - sometimes you simply don't care about them, and I
occasionally drop some commits on purpose when I've done something I
decide to undo and then do a "git prune" to get rid of the objects.

But I don't want this to happen _easily_.

Your examples aren't actually very interesting:

>  - git branch <branch-name>       ;# copies master to branch-name;
> 				     if branch-name exists in refs/heads,
>                                      warn and refuse.  Override
> 				     with --force flag.
> 
>  - git checkout <branch-name>     ;# copies branch-name to master; but
>                                      if master does not match any
>                                      of the other refs/heads/, warn
>                                      and refuse.  Override with
>                                      --force flag.

because those two examples end up avoiding the _real_ issue, which is the

	git checkout v2.6.12

case, which is exactly the case that would need a "--force" flag, since 
master is what you're working on before. And --force would drop that 
information. 

So I want something that naturally works with this (very reasonable) way 
of working, and does _not_ force people to drop information.

In your world, you'd have to first save the old master with

	git branch work-branch

and then you could do

	git checkout v2.6.12

to start on "master" anew. That's fair, but it's conceptually very wrong: 
it rquires you to name the _old_ thing, which to me just sounds very 
confusing indeed. You don't care about the old thing, it's the _new_ thing 
you care about.

So at least to me it makes much more sense to say "ok, I'll start
something new, and call it xyzzy", than "ok, I'll start something new, and
I'll save the old under 'old'".

The "old" thing might not even be anything you worked on (it might be
something you just cloned from somebody else), so you giving it a name 
isn't very logical. In contrast, you're clearly doing something active 
with the new thing, so naming _that_ makes sense.

		Linus
