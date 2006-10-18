From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Wed, 18 Oct 2006 07:56:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180752500.3962@g5.osdl.org>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 16:57:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaCrE-0002EW-M6
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 16:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWJRO5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 10:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161084AbWJRO5G
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 10:57:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161107AbWJRO5D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 10:57:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IEuqaX025467
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 07:56:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IEup6l005279;
	Wed, 18 Oct 2006 07:56:51 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29237>



On Tue, 17 Oct 2006, Davide Libenzi wrote:
> 
> Ehm, I think there's a little bit of confusion. The incorrect golden ratio 
> prime selection for 64 bits machines was coalescing hash indexes into a 
> very limited number of buckets, hence creating very bad performance on diff 
> operations. The result of the diff would have been exacly the same, just 
> coming out after the time for a cup of coffee and a croissant ;)

But my point is, you would have been better off _without_ an algorithm 
that cared about the word-size at all, or with just using "uint32_t".

See? Yes, a "unsigned long" has more bits for hashing on a 64-bit 
architecture. But that's totally the wrong way of thinking about it. YOU 
DO NOT WANT MORE BITS! You want the same damn answer regardless of 
architecture!

A diff algorithm that gives different answers on a 32-bit LE architecture 
than on a 64-bit BE architecture is BROKEN. If I run on x86-64, I want the 
same answers I got on x86-32, and the same ones I get on ppc32. Anything 
else is SIMPLY NOT ACCEPTABLE!

So the whole idea that you should have used 64-bit values was broken, 
broken, broken. You should never have had anything that cared, because 
anything that cares is by definition buggy.

This is why we should use the _low_ bits. Never the high bits.

		Linus
