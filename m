From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 13:03:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
 <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:00:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkzR-0000Li-6P
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVE0UBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVE0UBg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 16:01:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:63191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262566AbVE0UBc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 16:01:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RK1SjA001879
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 13:01:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RK1Rqv006409;
	Fri, 27 May 2005 13:01:27 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Thomas Glanzmann wrote:
> 
> > I get the urge to do octopus-merges in the kernel just because of how
> > good they look in gitk ;) ]
> 
> talking about octopus-merges ... I don't understand how they work. What
> happens if one file is touched in every of the 8 trees. How can that be
> handled?

Automatically? You can do multiple three-way merges, no problem. 

In fact, the general algorithm for an n-way merge is to just do the 
"git-resolve-script" n-1 times, but _without_ the commit. Then you just 
commit the result, and the only thing to keep in mind is to get the 
parents right, because if you don't, you're screwed.

This does imply a merge ordering, but since we order the parents anyway,
that's actually also described 100% by the commit, so the end result is
clean and good.

There are two reasons not to do octopus-merges, and neither of them is 
huge, but they've kept me from doing them..

 - if you screw up half-way through the merge, it's a lot harder to 
   recover without blowing away all the other merges too and having to 
   re-do them. You certainly _can_ do it (say, by just recording the trees
   in between merges - it's definitely not rocket science), but it
   basically means that you need to keep track of things _outside_ of the
   normal "what was the last HEAD" model.

   More importantly, since an octopus merge has only one commit message 
   associated with it, you really should never use one for anything that 
   needs any manual intervention. Otherwise you'll have to start 
   explaining which merge you needed to fix up manually etc, and it just 
   gets complex for no actual gain.

   IOW, this argument is only against complex merges. The trivial ones can 
   easily be done as octopuses, and in many ways the resulting history may 
   actually reflect what you did better. For example, for somebody like 
   Jeff, who maintains 50 different branches, and merges 5 of them to send 
   them to me, an octopus merge in many ways is much more intuitive: it 
   really says "I took these five branches and combined them", while a 
   series of four regular merges just gets messy.

 - Compatibility with other systems. 

   I don't care one whit about stuff I consider broken (ie CVS), but there 
   are SCM's out there that I _don't_ think are broken, and that don't do
   multi-parent merges for "nrparent > 2".  You can always split an 
   octopus merge that didn't have any manual intervention, so again, this
   is not a huge argument if you follow rule #1, but unless you have a 
   reason for doing an octopus merge, it means that you should probably 
   avoid it.

   So _I_ usually don't have any reason at all, it would be stupid of me
   to merge trees from different people as an octopus, but usage like 
   Jeff's (where the merge is due to "pass these <n> trees upwards") is 
   different.

So there you have it. Don't do it just because you can, but if you have a 
good reason for them and they were done automatically without any human 
intervention (apart from having to change the scripts, of course), I won't 
argue too much against them either. I already took one such merge from 
Junio in the GIT tree, and I actually like having that as a way to make 
sure the tools can handle it.

		Linus
