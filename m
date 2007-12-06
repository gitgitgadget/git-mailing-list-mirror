From: Jeff King <peff@peff.net>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 12:39:47 -0500
Message-ID: <20071206173946.GA10845@sigill.intra.peff.net>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> <20071205.202047.58135920.davem@davemloft.net> <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> <20071206071503.GA19504@coredump.intra.peff.net> <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Kho-0007Hb-5V
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 18:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbXLFRjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 12:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXLFRjs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 12:39:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1566 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbXLFRjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 12:39:48 -0500
Received: (qmail 31690 invoked by uid 111); 6 Dec 2007 17:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 06 Dec 2007 12:39:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 12:39:47 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67308>

On Thu, Dec 06, 2007 at 09:18:39AM -0500, Nicolas Pitre wrote:

> > The downside is that the threading partitions the object space, so the
> > resulting size is not necessarily as small (but I don't know that
> > anybody has done testing on large repos to find out how large the
> > difference is).
> 
> Quick guesstimate is in the 1% ballpark.

Fortunately, we now have numbers. Harvey Harrison reported repacking the
gcc repo and getting these results:

> /usr/bin/time git repack -a -d -f --window=250 --depth=250
>
> 23266.37user 581.04system 7:41:25elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (419835major+123275804minor)pagefaults 0swaps
>
> -r--r--r-- 1 hharrison hharrison  29091872 2007-12-06 07:26 pack-1d46ca030c3d6d6b95ad316deb922be06b167a3d.idx
> -r--r--r-- 1 hharrison hharrison 324094684 2007-12-06 07:26 pack-1d46ca030c3d6d6b95ad316deb922be06b167a3d.pack

I tried the threaded repack with pack.threads = 3 on a dual-processor
machine, and got:

  time git repack -a -d -f --window=250 --depth=250

  real    309m59.849s
  user    377m43.948s
  sys     8m23.319s

  -r--r--r-- 1 peff peff  28570088 2007-12-06 10:11 pack-1fa336f33126d762988ed6fc3f44ecbe0209da3c.idx
  -r--r--r-- 1 peff peff 339922573 2007-12-06 10:11 pack-1fa336f33126d762988ed6fc3f44ecbe0209da3c.pack

So it is about 5% bigger. What is really disappointing is that we saved
only about 20% of the time. I didn't sit around watching the stages, but
my guess is that we spent a long time in the single threaded "writing
objects" stage with a thrashing delta cache.

-Peff
