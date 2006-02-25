From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 20:05:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net> <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 05:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCqp1-0008TB-5u
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 05:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWBYENx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 23:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWBYENx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 23:13:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932620AbWBYENw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 23:13:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1P45DDZ001428
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 20:05:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1P457mq021636;
	Fri, 24 Feb 2006 20:05:10 -0800
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16753>



On Fri, 24 Feb 2006, Nicolas Pitre wrote:
> 
> Well, that's the compromize to make.  By default the version with 
> adler32 used 16 byte blocks to index the reference buffer.  That means 
> you can match target data against the reference only if whole 16 byte 
> blocks match.  Then, if you fix a typo in the target buffer then you'll 
> inevitably need 16 literal bytes in the delta instead of only 
> one because you won't be able to resynchronize with the reference buffer 
> until the next 16 byte block.

That shouldn't be true. Once you find a 16-byte match, you can search 
forward (in theory you should be able to search backwards too, but by that 
time we've already expanded the non-matching previous bytes, I think).

But I'm no xdelta expert, so I migt be wrong.

> What I've made in my last delta patch is to reduce that 16 byte block to 
> only 3 bytes.  Why 3 bytes? Because less than that produces smaller 
> delta data if done with literal bytes directly, and 3 bytes provided 
> enough bits to hash.

On the other hand, the cost is that your lookups _are_ going to be more 
expensive. Regardless of how good the hash is, basically you have 16/3 
more hash-entries to look up, so you've made compression more expensive in 
footprint, at least (I assume you've made the hash appropriately larger).

Also, at 3 bytes, insertion is at least equally dense (three bytes of data 
vs three bytes of offset into the source), and can be worse (the offset 
might be 5 bytes, no?). So it would seem like you'd be better off with 4+ 
bytes, at which point the delta should be a win.

Have you tried some half-way point, like ~8 bytes?

> Now the problem comes when indexing a reference file full of:
> 
>         0x46f8, 0x000b, 0x42fe, 0x0000, 0xffc0, 0x0001, 0xff00, 0x0008,
...
> 
> There is a bunch of ", 0x" that get hashed to the same thing.

You'll find a lot of that in any file: three or four bytes of similarity 
just doesn't sound worthwhile to go digging after. 

> The adler32 made that particular example a non issue since the 
> likelyhood of many 16 byte blocks to be the same is pretty low in this 
> case.  But the flaw remains if for example there is lots of similar 16 
> byte blocks, like a binary file with lots of zeroes for example.  In 
> fact, the performance problem Carl is having does use the diff-delta 
> version still using adler32.

Agreed. I think limiting the hash length is a fine idea regardless, I just 
think it sounds dangerous with the three-byte thing where a lot of matches 
should be expected (never mind ", 0x", just things like newlines and tabs 
in source code).

Only considering 16-byte sequences of similarities is a trade-off of 
packing cost vs win.. Not saying other block-sizes aren't worth testing, 
but I suspect trying too hard is going to be too costly.

Especially as deltas compress _worse_ the smaller they are. Bigger 
"insert" chunks probably compress a lot better than a copy chunk. 

Have you looked at the delta size vs compression?

		Linus
