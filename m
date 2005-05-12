From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 15:29:43 -0700
Message-ID: <20050512222943.GI5914@waste.org>
References: <20050512205735.GE5914@waste.org> <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 00:23:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWM4z-0006Wa-2v
	for gcvg-git@gmane.org; Fri, 13 May 2005 00:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVELWaY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 18:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVELWaY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 18:30:24 -0400
Received: from waste.org ([216.27.176.166]:3766 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262165AbVELW3v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 18:29:51 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4CMThTP014787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2005 17:29:43 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4CMThq8014784;
	Thu, 12 May 2005 17:29:43 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 at 05:24:27PM -0400, Daniel Barkalow wrote:
> On Thu, 12 May 2005, Matt Mackall wrote:
> 
> > Does this need an HTTP request (and round trip) per object? It appears
> > to. That's 2200 requests/round trips for my 800 patch benchmark.
> 
> It requires a request per object, but it should be possible (with
> somewhat more complicated code) to overlap them such that it doesn't
> require a serial round trip for each. Since the server is sending static
> files, the overhead for each should be minimal.

It's not minimal. The size of an HTTP request is often not much
different than the size of a compressed file delta. Here's one of the
indexes from a file in an hg repo:

   rev    offset  length  base linkrev p1           p2           nodeid
     0         0    2307     0       0 0000000000.. 0000000000.. b6444347c6..
     1      2307      77     0       5 b6444347c6.. 0000000000.. 06763db6de..
     2      2384     225     0      11 06763db6de.. 0000000000.. acc8e2b2f0..
     3      2609      40     0      16 acc8e2b2f0.. 0000000000.. 461b079d98..
     4      2649     261     0      17 461b079d98.. 0000000000.. 8507ba44cc..
     5      2910     486     0      18 8507ba44cc.. 0000000000.. b68523252b..
     6      3396      98     0      21 b68523252b.. 0000000000.. b3f2586243..
     7      3494     238     0      22 b3f2586243.. 0000000000.. d73d0f8ee9..
     8      3732      39     0      23 d73d0f8ee9.. 0000000000.. caaf506196..
     9      3771     266     0      24 caaf506196.. 0000000000.. 54485fc96f..
    10      4037      81     0      29 54485fc96f.. 0000000000.. b9eae7b990..
    11      4118     310     0      31 b9eae7b990.. 0000000000.. a9926b092a..
    12      4428     545     0      33 a9926b092a.. 0000000000.. f26c600172..
    13      4973     419     0      34 f26c600172.. 0000000000.. ec4ab0acb7..
    14      5392     136     0      38 ec4ab0acb7.. 0000000000.. eb5f3f76c8..
    15      5528     161     0      39 eb5f3f76c8.. 0000000000.. 4fc5f3a3ae..
    16      5689     258     0      46 4fc5f3a3ae.. 0000000000.. 3ad83891fb..
    17      5947     171     0      49 3ad83891fb.. 0000000000.. 3983ac6cd2..
    18      6118     195     0      50 3983ac6cd2.. 0000000000.. f138865e04..
    19      6313      79     0      52 f138865e04.. 0000000000.. 3566c1f449..
    20      6392      85     0      53 3566c1f449.. 0000000000.. 0694a4e3eb..
    21      6477      91     0      54 0694a4e3eb.. 0000000000.. 5f98ae7426..
    22      6568     208     0      56 5f98ae7426.. 0000000000.. dae5cb80db..
    23      6776     286     0      62 dae5cb80db.. 0000000000.. 90ff243869..

All the junk that gets bundled in an http request/response will be
similar in size to the stuff in the third column.

Relative to the 10-20x overhead of not sending deltas, yes, it's only 10%.
 
> > How does git find the outstanding changesets?
> 
> In the present mainline, you first have to find the head commit you
> want. I have a patch which does this for you over the same
> connection. Starting from that point, it tracks reachability on the
> receiving end, and requests anything it doesn't have.

Does it do this recursively? Eg, if the server has 800 new linear
commits, does the client have to do 800 round trips following parent
pointers to find all the new changesets? In this case, Mercurial does
about 6 round trips, totalling less than 1K, plus one requests
that pulls everything.

-- 
Mathematics is the supreme nostalgia of our time.
