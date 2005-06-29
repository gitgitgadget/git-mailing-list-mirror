From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Wed, 29 Jun 2005 11:59:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506291142510.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 20:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnhhK-00080l-8a
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 20:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVF2TAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVF2TAI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 15:00:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262430AbVF2S5d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 14:57:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5TIvOjA011937
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Jun 2005 11:57:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5TIvMgY025469;
	Wed, 29 Jun 2005 11:57:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Linus Torvalds wrote:
> 
> On Mon, 27 Jun 2005, Junio C Hamano wrote:
> > 
> > Shouldn't feeding "git-rev-list --object" output plus
> > handcrafted list of objects in 2.6.11 tree object to
> > git-pack-objects just work???
> 
> You could do that. And yes, we can add support for "tag" objects too 
> (which the packing doesn't do at all right now. So this is not a 
> "fundamental" problem, it's just a practical one right now.

Ok, I've added the logic to "git-rev-list --object" to handle arbitrary 
object dependencies.

So you can do things like this, if you want to:

	git-rev-list --object HEAD ^v2.6.11-tree

which basically generates the complete list of every object reachable from 
HEAD, but not reachable from the v2.6.11 tree. It also understands about 
tags, so if you do

	git-rev-list --object v2.6.12 ^v2.6.11-tree

the end result will have the "v2.6.12" tag in it (along with all the
objects reachable from it, but not reachable from v2.6.11-tree).

What does this mean? It means that you can do a "push" from repository "a" 
to repository "b" by doing

 - in "b", do

	refs_in_b=($(find .git/refs -type f | xargs cat))


 - in "a" do

	refs_in_a=($(find .git/refs -type f | xargs cat))

 - then, in "a", do

	git-rev-list "${refs_in_a[@]}" --not "${refs_in_b[@]}" |
		git-pack-objects --stdout > push.pack

   to generate the objects pack in "push.pack"

 - then, in "b", do

	git-unpack-objects < push.pack

and you now have moved over _all_ the objects that were referenced in "a",
but not in "b". Including tags etc. So after that last stage, when you've
unpacked the objects, the only thing left to do is to make the refs in "b"  
point to the new references from "a" (which basically boils down to a
"cp", except it would be good to verify that the refs in "b" still have
the same values as they did before we did the object push).

Daniel (or anybody else), interested? Please?

Of course, you can do this one branch at a time, too, if you want to, but
the above was meant as an example of how you can actually do all the
branches in one single pack-file, which is a lot more efficient (if you do
it one branch at a time, you'll quite possible end up transferring objects
that are reachable in other branches multiple times, while the "all in one
go" thing will pack each object just once).

Now, have I actually _tested_ the above? Hell no. But all the heavy 
lifting should now be done for doing an efficient "git push" that pushes 
all branches in one go (or one at a time, it's your choice on how you end 
up using git-rev-list).

		Linus
