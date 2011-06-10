From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: diff'ing files ...
Date: Fri, 10 Jun 2011 16:37:32 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106101612060.2142@xanadu.home>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
 <20110606224356.GC13697@sigill.intra.peff.net>
 <BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
 <20110607221948.GA10104@sigill.intra.peff.net>
 <alpine.LFD.2.00.1106092145390.2142@xanadu.home>
 <m34o3xesqn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Albretch Mueller <lbrtchx@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:37:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV8SZ-0005uK-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478Ab1FJUhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:37:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58298 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1FJUhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:37:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LML00EN4D9XR900@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Jun 2011 16:37:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m34o3xesqn.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175626>

On Fri, 10 Jun 2011, Jakub Narebski wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> > The libxdiff code was pretty generic so to be highly portable and usable 
> > for many application types.  What I did is to get rid of everything that 
> > git strictly didn't need in order to make the code as simple as 
> > possible, and most importantly as fast as possible. [...]
> > 
> > And then further modifications were made to avoid pathological corner 
> > cases which were taking too much time for little gain in the Git 
> > context.
> > 
> > I also changed the output encoding to make it tighter.
> 
> Nicolas, do you know how binary diff used by git compares with respect
> to performance and compression with other binary diff algorithms:
> 
>   * original LibXDiff
>   * bsdiff
>   * xdelta (vcdif algorithm)
>   * vbindiff

No idea.  But you can test that pretty easily if you wish.  I would be 
interested in the results of course. Just do:

	make test-delta

and then, to compress something:

	./test-delta -d <input_file> <reference_file> <output_file>

Of course this will produce <output_file> which is only the bare binary 
diff annotation data against the reference file.  In Git that output is 
also deflated with zlib, before it is stored in a pack.  The other 
binary diff tools are usually doing a similar post-deflation pass as 
well.

It should be noted that the algorithm that Git uses won't produce the 
absolute smallest output.  When I tried that, computation time went up 
of course, but surprizingly the final deflated result was slightly 
_larger_ as well, probably due to the fact that zlib was less efficient 
with the increased randomness in the tighter delta output to deflate.


Nicolas
