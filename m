From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Fri, 07 Dec 2007 17:55:29 -0800 (PST)
Message-ID: <20071207.175529.104353710.davem@davemloft.net>
References: <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
	<20071207.045329.204650714.davem@davemloft.net>
	<alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jonsmirl@gmail.com, peff@peff.net, nico@cam.org,
	dberlin@dberlin.org, harvey.harrison@gmail.com,
	ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Sat Dec 08 02:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ov3-0005Tw-8E
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 02:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbXLHBzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 20:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXLHBzb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 20:55:31 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60840
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754700AbXLHBza (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 20:55:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id E42B6C8C17F;
	Fri,  7 Dec 2007 17:55:29 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67495>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Dec 2007 09:23:47 -0800 (PST)

> 
> 
> On Fri, 7 Dec 2007, David Miller wrote:
> > 
> > Also I could end up being performance limited by SHA, it's not very
> > well tuned on Sparc.  It's been on my TODO list to code up the crypto
> > unit support for Niagara-2 in the kernel, then work with Herbert Xu on
> > the userland interfaces to take advantage of that in things like
> > libssl.  Even a better C/asm version would probably improve GIT
> > performance a bit.
> 
> I doubt yu can use the hardware support. Kernel-only hw support is 
> inherently broken for any sane user-space usage, the setup costs are just 
> way way too high. To be useful, crypto engines need to support direct user 
> space access (ie a regular instruction, with all state being held in 
> normal registers that get saved/restored by the kernel).

Unfortunately they are hypervisor calls, and you have to give
the thing physical addresses for the buffer to work on, so
letting userland get at it directly isn't currently doable.

I still believe that there are cases where userland can take
advantage of in-kernel crypto devices, such as when we are
streaming the data into the kernel anyways (for a write()
or sendmsg()) and the user just wants the transformation to
be done on that stream.

As a specific case, hardware crypto SSL support works quite
well for sendmsg() user packet data.  And this the kind of API
Solaris provides to get good SSL performance with Niagara.

> > Is SHA a significant portion of the compute during these repacks?
> > I should run oprofile...
> 
> SHA1 is almost totally insignificant on x86. It hardly shows up. But we 
> have a good optimized version there.

Ok.

> zlib tends to be a lot more noticeable (especially the uncompression: it 
> may be faster than compression, but it's done _so_ much more that it 
> totally dominates).

zlib is really hard to optimize on Sparc, I've tried numerous times.
Actually compress is the real cycle killer, and in that case the inner
loop wants to dereference 2-byte shorts at a time but they are
unaligned half of the time, and any the check for alignment nullifies
the gains of avoiding the two byte loads.

Uncompress I don't think is optimized at all on any platform with
asm stuff like the compress side is.  It's a pretty straightforward
transformation and the memory accesses dominate the overhead.

I'll do some profiling to see what might be worth looking into.
