From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-organize "git-rev-list --objects" logic
Date: Fri, 16 Sep 2005 11:11:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161051350.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509151507380.26803@g5.osdl.org>
 <Pine.LNX.4.63.0509160026010.20359@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKgt-0007zz-BQ
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbVIPSLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbVIPSLr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:11:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161217AbVIPSLq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 14:11:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GIBdBo003707
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 11:11:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GIBZjk004417;
	Fri, 16 Sep 2005 11:11:37 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509160026010.20359@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8702>



On Fri, 16 Sep 2005, Johannes Schindelin wrote:
> 
> On Thu, 15 Sep 2005, Linus Torvalds wrote:
> 
> > I know how to make it use _lots_ less memory, which will probably speed it 
> > up. But that's for another time, and I'd prefer to see this go in first.
> 
> Mind to elaborate just a bit?

Right now we keep track of every single object we parse, and never free 
it.

Some of it is necessary to keep track of whether a SHA has been seen or
not, but: we also keep every single relation list around. They're small,
but they are _many_. We can trivially free those after following them.
That should get us back another few tens of megabytes easily. It's the
parent pointers, and the "struct tree_entry" lists.

Now, some memory usage is very fundamental, and we can't get rid of the
"struct object" for each thing we've listed (or each thing we've
determined needs to be pruned). We can perhaps shrink it some, but we'll
always need to have at a minimum the 20-byte sha1 of every object. So if
we list/blacklist a hundred thousand objects, there's no way we can avoid
using a couple of megs just to keep track of that fact in order to avoid
duplicates.

However, I _think_ the majority of the memory use is in the refs. Even a 
full kernel tree only has about 95,000 objects, but we have many _many_ 
more of these relationship links. We've got ~9,000 commits, and pretty 
much each of them will have a different root tree with 20+ entries in it, 
and even when most of them end up pointing to the same blobs/trees (which 
is why we only have 95,000 objects - there's _tons_ of sharing), they'll 
all end up generating a "tree_entry" thing. So just there, you'll have 
something like 180,000 small allocations.

And yes, a "tree_entry" is smaller than a "struct object" or "struct
tree", but with twice as many "struct tree_entries" as there are objects
in _total_, that sure adds up pretty quickly.

And the refs. git-fsck-cache needs to be able to look through the 
dependency chains for all objects. git-rev-list doesn't. Again, they're 
small, but they're all over.

So I suspect half the memory allocations is just for these things. Maybe 
I'm overly optimistic. But I think that even without shrinking the object 
structures themselves, we should be able to make git-rev-list use a lot 
less memory.

			Linus
