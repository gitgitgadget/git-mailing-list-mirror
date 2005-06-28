From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 10:36:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 19:29:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnJsu-0007Hr-HM
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 19:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVF1RfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 13:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1RfW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 13:35:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262171AbVF1Re2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 13:34:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SHYDjA002876
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 10:34:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SHYAgZ015487;
	Tue, 28 Jun 2005 10:34:11 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Daniel Barkalow wrote:
> 
> Actually, the ideal thing would be to move the packing code into an object
> file that git-ssh-push can include; that way it can write directly to the
> socket instead of going through disk

It doesn't work very easily that way because the index file (which
contains the object list and the offsets into the pack file) cannot be
created until after the pack file has been created (and we don't want to
evaluate that one in memory, since it can be quite big).

Now, what we could do is to stream out the pack file first to stdout, and
write the index file afterwards. But since we don't know how big the pack
file will be when we start packing, and the pack-file can contain
basically arbitrary patterns, that requires that the receiver actually 
parse the pack-file as it comes in.

The format of the pack-file is a fairly trivial data stream of

 - rinse and repeat for each object:

     - one character of type of file (C, T, B, G, D for "commit", "tree", 
       "blob", "tag" or "delta" respectively)

     - four bytes of network-order unpacked data length

     - [ if delta: 20 bytes of delta object ID ]

     - zlib-packed data (length unknown, except we know how much we want 
       it to unpack to)

 - Finally at the end: 20 bytes of SHA1 of the pack-file contents (up to 
   the SHA1)

so it's actually possible to pick up the objects as they come off the 
stream, since the SHA1 name is defined by the contents and you don't need 
the index file unless you want to look things up.

So the receiver side could try this algorithm:

 - unpack each object in memory on the receiving side

	If the unpack failed, it must have been the SHA1 at the end, so 
	verify it!

 - if it's a delta object and you haven't seen the object it's a delta 
   against, keep it in memory.

 - if it's a non-delta object, just write it to the object store, and try 
   to resolve any delta objects you have pending that this new object 
   satisfies. That in turn creates other objects that may have more deltas 
   they satisfy etc.

which looks quite doable. The delta objects are small, so keeping them in 
memory shouldn't be a problem (especially since we _tend_ to write deltas 
after the object they depend on).

I can certainly add an option to git-pack-file that disables writing of
the index file, and just writes the pack-file to stdout. I'm not sure I
want to write the "parse incoming pack-file" thing, but git-unpack-objects
comes _reasonably_ close (but right now it seeks around using the index
file to resolve deltas, instead of keeping them in memory and resolving
them when possible). But I can make the infrastructure ready for it.

Sounds like a plan.

			Linus
