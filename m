From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 09:11:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160841360.3816@woody.linux-foundation.org>
References: <20070316060841.19946.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Mar 16 17:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSF1x-0003u3-JJ
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417AbXCPQLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965426AbXCPQLq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:11:46 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49302 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965417AbXCPQLo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:11:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GGB9cD027752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 09:11:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GGB66x015792;
	Fri, 16 Mar 2007 08:11:07 -0800
In-Reply-To: <20070316060841.19946.qmail@science.horizon.com>
X-Spam-Status: No, hits=-0.484 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42368>



On Thu, 16 Mar 2007, linux@horizon.com wrote:
>
> Er, it's a little hard to see, but zlib spends the bulk of its time
> in inflate_fast().

Not for git.

It may be true for *big* inflate events, but the bulk of git inflates are 
small trees etc. Here is one particular profile:

	CPU: Core 2, speed 1596 MHz (estimated)
	Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit 
	mask of 0x00 (Unhalted core cycles) count 100000
	samples  %        image name               app name                 symbol name
	169540   15.9845  git                      git                      inflate
	138377   13.0464  git                      git                      inflate_fast
	94738     8.9321  git                      git                      inflate_table
	73511     6.9308  git                      git                      strlen
	70398     6.6373  git                      git                      find_pack_entry_one
	59200     5.5815  vmlinux                  vmlinux                  __copy_user_nocache
	45103     4.2524  git                      git                      adler32
	42973     4.0516  git                      git                      memcpy
	23438     2.2098  git                      git                      interesting
	..

so yes, inflate_fast() is certainly up there too, but plain "inflate()" is 
actually more important.

(Btw, to get this level of detail, you need to link statically, at least 
if you are using Fedora Core. If you do the normal dynamic linking, 
oprofile will not be able to show you which function, and will just say 
that 50% of all time was spent in libz.so.1.2.3).

Also note that the above is with oprofile: do *not* bother to try to 
profile using "-pg" and gprof. That changes the binary so much as to be 
useless - small functions get the profiling code overhead and things that 
take no time at all will suddenly become twice or three times as 
expensive. Using oprofile you get fairly correct results.

> The code in inflate.c just handles the last few bytes when near
> one limit or the other.  Are you sure it's a performance problem?

See above. I'm absolutely positive.

(The load for the above was roughly:

	git log drivers/usb/ > /dev/null

on the kernel tree - ie I was mainly testing the commit tree pruning, 
which is one of the most fundamnetal operations, and is what makes 
or breaks the performance of things like "git blame" etc).

I'd obviously *also* like to see inflate_fast() go down, and it has some 
really strange code too, like:

	#  define PUP(a) *++(a)

			...
                            len -= op;
                            do {
                                PUP(out) = PUP(from);
                            } while (--op);
			...

which looks rather odd, wouldn't you say? That's a memcpy. But I 
especially find the nice "unrolled" memcpy interestign:

		...
                    while (len > 2) {
                        PUP(out) = PUP(from);
                        PUP(out) = PUP(from);
                        PUP(out) = PUP(from);
                        len -= 3;
                    }
                    if (len) {
                        PUP(out) = PUP(from);
                        if (len > 1)
                            PUP(out) = PUP(from);
                    }
		...

yeah, that's right - we unroll memcpy() BY DOING IT THREE BYTES AT A TIME!

Whoever wrote that crap must have been on some strange medication. If you 
need to do enough of a memcpy() that you want to unroll it, you sure as 
hell don't want to do it a byte-at-a-time, you want to do it with full 
words etc. And the thing is called "memcpy()", for chrissake!

That's the "optimized" code. Strange.

> There's equivalent inflate code in the PGP 5.0i distribution

Interesting. I'll take a look.

		Linus
