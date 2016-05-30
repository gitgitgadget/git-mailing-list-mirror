From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 07:50:29 +0900
Message-ID: <20160530225029.GA9624@glandium.org>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <20160530215652.GA6456@glandium.org>
 <1686469496.216457.1464648383516.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 00:51:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7W2P-0001Rb-B7
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 00:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161790AbcE3Wuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 18:50:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60042 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161690AbcE3Wuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 18:50:40 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b7W0z-0002XV-H5; Tue, 31 May 2016 07:50:29 +0900
Content-Disposition: inline
In-Reply-To: <1686469496.216457.1464648383516.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295938>

On Tue, May 31, 2016 at 12:46:23AM +0200, William Duclot wrote:
> Mike Hommey <mh@glandium.org> writes:
> >>  struct strbuf {
> >> +	unsigned int flags;
> >>  	size_t alloc;
> >>  	size_t len;
> >>  	char *buf;
> >>  };
> > 
> > Depending whether the size of strbuf matters, it /might/ be worth
> > considering some packing here. malloc() usually returns buffers that can
> > contain more data than what is requested. Which means allocation sizes
> > could be rounded and that wouldn't change the amount of allocated
> > memory. On glibc malloc_usable_size(malloc(1)) apparently returns 24.
> > On jemalloc, it's 4 or 8. It's in the same ballbark with many
> > allocators.
> > 
> > So, it would be possible to round alloc such that it's always a multiple
> > of, say, 4, and stick flags in the low, unused bits.
> 
> If I'm not mistaken, the memory allocated is not necessarily linear with
> the size asked, depending on the algorithm used by the allocator and/or
> the kernel. The system for exemple use powers of two, if the user asks
> for exactly 2^x bytes, adding the space for the flags would lead to an
> allocation of 2^(x+1) bytes.

No, it would not. If you requested 129 bytes, you'd request 136 instead,
which the allocator would round to the same power of two. If you
requested 128, you'd still request 128. It's not about adding space in
the allocated buffer for the flags, it's about needing less bits in
`alloc` because those bits are effectively useless because of how
allocators work.

> Way worse than storing an unsigned.
> If the allocator use a fibonnaci system, we can't even rely on multiples
> of 4 (or 2).
> I'm not sure the fibonnaci system is actually used by any allocator, but
> my point is that I'm not sure it is a good thing to rely on such 
> low-level implementations.

Allocators have constraints related to word sizes and alignment, so they
are pretty much guaranteed to align things to powers of two.

Mike
