From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 17:29:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
 <7voe0bdeyr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
 <7vk6azcv9y.fsf@assigned-by-dhcp.cox.net> <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 02:30:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIbsj-0007So-NT
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 02:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCMB3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 20:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWCMB3y
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 20:29:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751463AbWCMB3y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 20:29:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D1TkDZ005231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 17:29:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D1TjR2020974;
	Sun, 12 Mar 2006 17:29:46 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17534>



On Sun, 12 Mar 2006, Linus Torvalds wrote:
> 
> Also, I think it is likely really wasteful to try to actually hash at 
> _each_ character. Instead, let's say that the chunk-size is 8 bytes (like 
> you do now), and let's say that you have a 32-bit good hash of those 8 
> bytes. What you can do is:

Side note: regardless, your new algorithm clearly does seem faster.

However, it worries me a bit that you don't check the source strings, 
especially since the hash you use seems somewhat suspect (why limit it to 
essentially just 16 bits? Wouldn't it be best to have the _biggest_ prime 
that fits in the "hashval" thing, which is at least 32 bits? Also, 
shouldn't you make that spanhash thing use a "unsigned int" instead of 
"unsigned long"?)

So I would suggest instead the hash function to be:

	typedef unsigned long long u64;

	/* Biggest prime in 32 bits */
	#define HASHVAL (4294967291u)


	u64 value = *(u64 *)src;
	src += 8;
	hash = value % 4294967291u;

which does a 64-bit modulus, but hey, 64-bit hw isn't _that_ uncommon any 
more, and it's not _excessively_ slow on x86 (gcc doesn't generate good 
code, but we could actually use the kernel "do_div()" routine for much 
faster division of 64 % 32 than what gcc can do - since the dividend is 
32-bit, you actually only need to do one 32/32 division and one 64/32 
division, so the optimized hash function on a good x86 will be just in 
the teens of cycles for the 64-bit modulus).

		Linus
