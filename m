From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 00:46:23 +0200 (CEST)
Message-ID: <1686469496.216457.1464648383516.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr> <20160530215652.GA6456@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:39:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Vpt-0004pv-O3
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 00:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161711AbcE3Wi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 18:38:57 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48288 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161681AbcE3Wi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 18:38:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2401C2093;
	Tue, 31 May 2016 00:38:54 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqCDFSJUU4V7; Tue, 31 May 2016 00:38:54 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0A1A62074;
	Tue, 31 May 2016 00:38:54 +0200 (CEST)
In-Reply-To: <20160530215652.GA6456@glandium.org>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: strbuf: allow to use preallocated memory
Thread-Index: VgErMhTnmSbVtHTlvOQwLPqKzak0Rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295937>

Mike Hommey <mh@glandium.org> writes:
>>  struct strbuf {
>> +	unsigned int flags;
>>  	size_t alloc;
>>  	size_t len;
>>  	char *buf;
>>  };
> 
> Depending whether the size of strbuf matters, it /might/ be worth
> considering some packing here. malloc() usually returns buffers that can
> contain more data than what is requested. Which means allocation sizes
> could be rounded and that wouldn't change the amount of allocated
> memory. On glibc malloc_usable_size(malloc(1)) apparently returns 24.
> On jemalloc, it's 4 or 8. It's in the same ballbark with many
> allocators.
> 
> So, it would be possible to round alloc such that it's always a multiple
> of, say, 4, and stick flags in the low, unused bits.

If I'm not mistaken, the memory allocated is not necessarily linear with
the size asked, depending on the algorithm used by the allocator and/or
the kernel. The system for exemple use powers of two, if the user asks
for exactly 2^x bytes, adding the space for the flags would lead to an
allocation of 2^(x+1) bytes. Way worse than storing an unsigned.
If the allocator use a fibonnaci system, we can't even rely on multiples
of 4 (or 2).
I'm not sure the fibonnaci system is actually used by any allocator, but
my point is that I'm not sure it is a good thing to rely on such 
low-level implementations.

> Whether it's worth doing is another question.

I'd say it is not, we generally lack time more than space, storing an
unsigned seems very reasonable compared to operations involved in using
malloc() leftovers :)
Not even talking about growing buffers, so realloc(), so a whole new set
of problems...
