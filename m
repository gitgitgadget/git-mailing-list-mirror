From: Linus Torvalds <torvalds@osdl.org>
Subject: Broken PPC sha1.. (Re: Figured out how to get Mozilla into git)
Date: Sun, 18 Jun 2006 15:51:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606181543270.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> 
 <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain> 
 <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
 <46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
 <Pine.LNX.4.64.0606181532130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 19 00:51:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs66t-0002cH-3j
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 00:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWFRWvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 18:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWFRWvM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 18:51:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750958AbWFRWvL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 18:51:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IMp3gt006125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 15:51:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IMp2de006616;
	Sun, 18 Jun 2006 15:51:02 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0606181532130.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22110>




On Sun, 18 Jun 2006, Linus Torvalds wrote:
> 
> On Mon, 19 Jun 2006, Martin Langhoff wrote:
> > 
> > No problems here with my latest import run. fsck-objects --full comes
> > clean, takes 14m:
> >
> > /usr/bin/time git-fsck-objects --full
> > 737.22user 38.79system 14:09.40elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (20807major+19483471minor)pagefaults 0swaps
> 
> It takes much less than that for me: 
> 
> 	408.40user 32.56system 7:22.07elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 	0inputs+0outputs (145major+13455672minor)pagefaults 0swaps

Ok, re-building the thing with MOZILLA_SHA1=1 rather than my default 
PPC_SHA1=1 fixes the problem. I no longer get that "SHA1 mismatch with 
itself" on the pack-file.

Sadly, it also takes a _lot_ longer to fsck.

Paul - I think the ppc SHA1_Update() overflows in 32 bits, when the length 
of the memory area to be checksummed is huge.

In particular, the pack-file is 535MB in size, and the way we check the 
SHA1 checksum is by just mapping it all, doing a single SHA1_Update() over 
the whole pack-file, and comparing the end result with the internal SHA1 
at the end of the pack-file.

The PPC SHA1_Update() function starts off with:

	int SHA1_Update(SHA_CTX *c, const void *ptr, unsigned long n)
	{
	...
		c->len += n << 3;

which will obviously overflow if "n" is bigger than 29 bits, ie 512MB.

So doing the length in bits (or whatever that "<<3" is there for) doesn't 
seem to be such a great idea.

I guess we could make the caller just always chunk it up, but wouldn't it 
be nice to fix the PPC SHA1 implementation instead?

That said, the _only_ thing this will ever trigger on in practice is 
exactly this one case: a large packfile whose checksum was _correctly_ 
generated - because pack-file generation does it in IO chunks using the 
csum-file interfaces - but that will be incorrectly checked because we 
check it all at once.

So as bugs go, it's a fairly benign one.

			Linus
