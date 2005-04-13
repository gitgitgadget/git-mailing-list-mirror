From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 15:11:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504131503180.4501@ppc970.osdl.org>
References: <425C3F12.9070606@zytor.com> <Pine.LNX.4.58.0504121452330.4501@ppc970.osdl.org>
 <20050412224027.GB20821@elte.hu> <Pine.LNX.4.58.0504121554140.4501@ppc970.osdl.org>
 <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu>
 <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com>
 <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com>
 <Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org> <87aco2gxu2.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:08:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLq13-000276-IZ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDMWKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 18:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDMWKc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:10:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:28828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbVDMWKX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 18:10:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3DM9ws4032489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Apr 2005 15:09:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3DM9vrs022141;
	Wed, 13 Apr 2005 15:09:57 -0700
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87aco2gxu2.fsf@deneb.enyo.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, Florian Weimer wrote:
> 
> I've run a few tests, just to get a few numbers of the overhead
> involved.  I used the last ~8,000 changesets from the BKCVS kernel
> repository.  With cold cache, a checkout from cold cache takes about
> 250 seconds on my laptop.  I don't have git numbers, but a mere copy
> of the kernel tree needs 40 seconds.

I will bet you that a git checkout is _faster_ than a kernel source tree
copy. The time will be dominated by the IO costs (in particular the read
costs), and the IO costs are lower thanks to compression. So I think that
the cold-cache case will beat your 40 seconds by a clear margin. It
generally compresses to half the size, so 20 seconds is not impossible
(although seek costs would tend to stay constant, so I'd expect it to be
somewhere in between the two).

> For the hot-cache case, the difference is 140 seconds vs. 2.5 seconds
> (or 6 seconds with decompression).
> 
> Uh-oh.  I wouldn't have imaged the difference would be *that*
> dramatic.  The file system layer is *fast*.

Did I mention that I designed git for speed?

Yes. The whole damn design is really about performance, distribution, and 
built-in integrity checking. 

> On the storage front, we have 220 MB for the skip deltas vs. 106 MB
> for pure deltas-to-previous vs. 1.1 GB for uncompressed files
> (directories are always delta-compressed, so to speak[1]).

That's actually pretty encouraging. Your 1.1GB number implies to me that a
compressed file setup should be about half that, which in turn says that
the cost of full-file is not at all outrageous. Sure, it's 2-3 times
larger than your skip deltas, but considering that the performance is
about fifty times faster (and I can do distributed stuff without any
locking synchronization and you can't), that's a tradeoff I'm more than
happy with.

Or maybe I misunderstood what you were comparing?

Of course, the numbers will all depend on how the history looks etc, so 
this is all pretty much just guidelines.

			Linus
