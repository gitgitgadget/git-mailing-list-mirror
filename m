From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 18:29:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121810140.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org> <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 03:29:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIcoN-0001eN-JS
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 03:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWCMC3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 21:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCMC3Z
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 21:29:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751447AbWCMC3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 21:29:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D2TGDZ007892
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 18:29:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D2TFTa022584;
	Sun, 12 Mar 2006 18:29:16 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17537>



On Sun, 12 Mar 2006, Linus Torvalds wrote:
> 
> So I would suggest instead the hash function to be:
> 
> 	typedef unsigned long long u64;
> 
> 	/* Biggest prime in 32 bits */
> 	#define HASHVAL (4294967291u)
> 
> 
> 	u64 value = *(u64 *)src;
> 	src += 8;
> 	hash = value % 4294967291u;
> 
> which does a 64-bit modulus, but hey, 64-bit hw isn't _that_ uncommon any 
> more, and it's not _excessively_ slow on x86 (gcc doesn't generate good 
> code, but we could actually use the kernel "do_div()" routine for much 
> faster division of 64 % 32 than what gcc can do - since the dividend is 
> 32-bit, you actually only need to do one 32/32 division and one 64/32 
> division, so the optimized hash function on a good x86 will be just in 
> the teens of cycles for the 64-bit modulus).

Actually, on x86, where we can do the 64-by-32 division with a single 
instruction, this seems to be the best possible code:

	#define HASH_VAL (4294967291u)

	static inline unsigned int hash64x32(unsigned long long a)
	{
		unsigned int high, low;
		unsigned int modulus;

		asm(""
			:"=a" (low), "=d" (high)
			:"A" (a));
		if (high > HASH_VAL)
			high -= HASH_VAL;
		asm("divl %2"
			:"=a" (low), "=d" (modulus)
			:"rm" (HASH_VAL), "0" (low), "1" (high));
		return modulus;
	}

at least as far as I can think.

The magic is the reduction of the high 32 bits: for the general case you
want a modulus for that reduction, but since we're dividing with a
really big value, the modulus of the high bits really does end up
becoming just that simple

	if (high > HASH_VAL)
		high -= HASH_VAL;

and then we just need to do a single "divl" instruction.

So if you want a 32-bit hash of an 8-byte area, this should be a pretty
good and fast way to calculate it. 

Of course, maybe just doing an adler32() is simpler/better.  But with
the above, at least on x86, I suspect you get an even better
distribution at a lower cost (of course, different coress do differently
well on large divisions, but integer division being pretty important for
some codes, modern cores actually tend to be pretty good at it). 

			Linus
