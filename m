From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Mon, 8 May 2006 08:32:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605080813590.3718@g5.osdl.org>
References: <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org>
 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
 <20060507075631.GA24423@coredump.intra.peff.net> <Pine.LNX.4.64.0605070802590.16343@g5.osdl.org>
 <20060508042429.GA20249@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 17:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd7j2-0007e9-ML
	for gcvg-git@gmane.org; Mon, 08 May 2006 17:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWEHPcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWEHPcm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 11:32:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbWEHPcl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 11:32:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k48FWbtH018886
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 08:32:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k48FWabL013540;
	Mon, 8 May 2006 08:32:36 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060508042429.GA20249@coredump.intra.peff.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19770>



On Mon, 8 May 2006, Jeff King wrote:
>
> On Sun, May 07, 2006 at 08:27:02AM -0700, Linus Torvalds wrote:
> 
> > factor for a lot of things for many "common" filesystem setups. You 
> > probably didn't even account for the size of inodes in your "du" setup.
> 
> My numbers came from git-count-objects, which uses the st_blocks sum for
> all objects. The actual du numbers showing space wasted by block
> boundaries are:
>   du -c ??: 1429216
>   du -c --apparent-size ??: 792277
> So it's about 45% wasted space.

And that's actually ignoring inode sizes and directory sizes (well, it 
doesn't "ignore" directory sizes - it counts them - but if you compare it 
to a straight packed format, it's still overhead).

Anyway, looks like it's about 2:1, not 3:1 like I claimed, but the point 
being that blocking factors tend to be at least on the same order of 
magnitude as just plain compression (which also tends to be in the 2:1 
area for normal, fairly easily compressible, stuff).

The delta-packing obviously is much bigger for any project with real 
history. In traditional setups (where you always delta-pack within one 
thing, ie at the level of individual SCCS/RCS files), the delta packing 
obviously _also_ avoids blocking issues, since it means that a thousand 
revisions of the same file will all share the same inode.

So because git uses a whole-file model, it obviously makes the blocking 
issues with its unpacked format _much_ higher than for any traditional 
medium - no conglomeration of different versions of the file in the same 
filesystem object. On the other hand, the packed format also tends to be 
even _more_ efficient than a traditional one, so the end result of it all 
is apparently a pretty big net win even in space consumption).

Side note: I realize that some people think the packs are ugly and 
strange. They aren't linear versions of a file, and instead appear as a 
fairly random "jumble". And they can't be incrementally re-packed, and you 
have to generate a whole new pack-file (which can be incremental in 
_content_, of course). So people think they are ugly.

I'd argue that they are beautiful. They are beautiful because they _don't_ 
contain history in themselves (the objects they contain encode the history 
of course, but the pack-file itself does not).

And they are beautiful because we can use the exact same format for 
streaming data over the network as for the database itself (that, of 
course, was just about _the_ design consideration). Show me another system 
that has exactly the same (not "similar", not "same concepts": _same_) 
network protocol as it internal database.

And they are beautiful exactly because their lack of any internal 
structure allows you to pack things by criteria _you_ care about, ie the 
whole "sort things by recency" thing, so that commonly accessed data can 
be packed at the head of the pack-file - exactly because the pack-file 
doesn't have any internal structure of its own that you need to worry 
about and that constrains your sorting.

The same thing is what allows you to delta any blob against any other 
blob - without worrying about history or other random pack-file rules. You 
can do packign purely by how well you want to pack, not by any secondary 
constraints.

And the "no incremental updates" may sound like a huge downside, but it's 
all the same basic git logic: objects and filesystem contents are 
immutable, and that allows us to avoid a lot of locking overhead. Locking 
is _hard_. Locking is _inefficient_. And locking really really screws you 
when you miss it.

So I'll happily say that pack-files are strange, and that you have to get 
a bit used to the notion that they should be repacked "asynchronously". 
But it's really a matter of "getting used to it", because once you do, 
you'll see that it's actually an absolutely huge deal, and you'll learn to 
love the bomb^H^H^H^Hpack-file.

			Linus "pack-files rule" Torvalds
