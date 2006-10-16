From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 16:24:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161604360.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org> <7vy7rfub36.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 01:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZboe-0000eR-5h
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWJPXYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWJPXYN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:24:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWJPXYM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 19:24:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GNO6aX031518
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 16:24:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GNO5A7032385;
	Mon, 16 Oct 2006 16:24:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7rfub36.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28994>



On Mon, 16 Oct 2006, Junio C Hamano wrote:
> 
> I agree (although I am not sure about the "do it twice for
> small" bit), and I think Davide agrees with you in his reply:

Sure. Davide's all-macro version is fine. I don't like re-using the same 
value twice even in a ALL-CAPS macro, so I'm used to inline functions, but 
all the uses of XDL_HASHLONG() are fine with multiple uses of the 
arguments.

Somebody should just double-check that all the parentheses ended up being 
right ;)

It might be easier to read if you write it as

	#define BITS_IN_LONG	(CHAR_BIT * sizeof(unsigned long))
	#define XDL_HIGHBITS(v,b) ((v) >> (BITS_IN_LONG - (b)))
	#define XDL_MASKBITS(b) ((1UL << (b)) - 1)
	#define XDL_HASHBITS(v,b) (((v) + XDL_HIGHBITS(v,b)) & XDL_MASKBITS(b))
	#define XDL_HASHLONG(v,b) XDL_HASHBITS( (unsigned long)(v) , b )

just to avoid one huge #define.

That said, it unnecessarily calculates "BITS_IN_LONG - (b)" to shift with, 
because it really shouldn't matter _which_ high bits you use for hashing, 
so you might as well just use the "next" b bits, and have

	#define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
	#define XDL_MASKBITS(b)		((1UL << (b)) - 1)
	#define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))

which generates better code at least on x86 (and x86-64), because the 
shift count stays the same for all shifts and can thus be kept in %ecx. 
For example, on x86-64, you get

	movq    %rdi, %rax		# copy 'val'
	movl    $1, %edx		# const 1: start generating (1 << b) - 1
	shrq    %cl, %rax		# val >> b
	salq    %cl, %rdx		# 1 << b
	leaq    (%rdi,%rax), %rax	# val + (val >> b)
	subq    $1, %rdx		# (1 << b) -1
	andq    %rdx, %rax		# final hash

which is short and sweet. And on ppc32 (or ppc64) you get

	li 9,1			# const 1: start generating (1 << b) - 1
	srw 0,3,4		# val >> b
	slw 9,9,4		# 1 << b
	add 0,0,3		# val + (val >> b)
	addi 9,9,-1		# (1 << b) - 1
	and 3,0,9		# final hash

in other words, apart from having two shifts (which you can't really 
avoid, although a multiply can do one of them) it's just a very efficient 
way to mix together (2*b) bits into a (b)-bit hash.

But taking the high bits from the "unsigned long" doesn't add _that_ much 
cost. I just suspect that it's a good way to continue to get different 
answers on 32-bit and 64-bit architectures. 

		Linus
