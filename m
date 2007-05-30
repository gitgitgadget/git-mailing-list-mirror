From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix signed range problems with hex conversions
Date: Wed, 30 May 2007 14:20:21 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705301346580.11491@xanadu.home>
References: <alpine.LFD.0.99.0705301213450.11491@xanadu.home>
 <alpine.LFD.0.98.0705301025170.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 30 20:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtSmc-00082y-E7
	for gcvg-git@gmane.org; Wed, 30 May 2007 20:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbXE3SUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 14:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbXE3SUY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 14:20:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60843 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbXE3SUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 14:20:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV008KE9LXPO30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 14:20:21 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0705301025170.26602@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48778>

On Wed, 30 May 2007, Linus Torvalds wrote:

> On Wed, 30 May 2007, Nicolas Pitre wrote:
> > 
> > This patch adds a range test to hexval() in order to prevent this.  Also 
> > let's index the hexval_table array directly in get_sha1_hex() using 
> > explicitly unsigned chars to avoid the range test producing faster
> > code.
> 
> Please just make hexval() take a "unsigned char" instead, solving the 
> problem in a manner that makes it much easier for the compiler to realize 
> that it never needs to sign-extend the value or test the end result..

Well, I did it the way I did for two reasons, the first being that 
random hexval() usage won't mask a bad value if it is passed an int 
which happens to be out of range (think EOF, or better yet -208, -207, 
etc).

Yet gcc appears to be smart enough to skip the test if it is passed a 
value that cannot exceed the test range, like an unsigned char.

> Ie I think your patch would be better off something like the following 
> instead (it would be a one-liner, but I agree that marking hexval_table 
> "const" is also a good idea).
> 
> With this, gcc can just generate:
> 
> 	movzbl  (%rdi), %eax
> 	movsbl  hexval_table(%rax),%edx
> 	movzbl  1(%rdi), %eax
> 	movsbl  hexval_table(%rax),%eax
> 	sall    $4, %edx
> 	orl     %eax, %edx
> 
> for the code to generate a byte from two hex characters.

My patch already produces code that looks like that for get_sha1_hex() 
on i386.  But my second reason for the patch is that on ARM it 
should becomes:

	/* r4 = hexval_table, ip = hex */
	ldrb	r1, [ip], #1
	ldrb    r2, [ip], #1
	ldrsb   r0, [r4, r1]
	ldrsb   r3, [r4, r2]
	orr     r0, r3, r0, asl #4

I.e. the compiler has a greater chance to fold the post increment with 
the load byte instruction as above without the need for an extra
add instruction.


Nicolas
