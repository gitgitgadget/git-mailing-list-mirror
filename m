From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 20:33:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505121949210.30848-100000@iabervon.org>
References: <20050512222943.GI5914@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 02:27:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWO1H-0000yI-Ok
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVEMAeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVEMAed
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:34:33 -0400
Received: from iabervon.org ([66.92.72.58]:22791 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262191AbVEMAeW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 20:34:22 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWO7o-0001w9-00; Thu, 12 May 2005 20:33:56 -0400
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050512222943.GI5914@waste.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 May 2005, Matt Mackall wrote:

> On Thu, May 12, 2005 at 05:24:27PM -0400, Daniel Barkalow wrote:
> > On Thu, 12 May 2005, Matt Mackall wrote:
> > 
> > > Does this need an HTTP request (and round trip) per object? It appears
> > > to. That's 2200 requests/round trips for my 800 patch benchmark.
> > 
> > It requires a request per object, but it should be possible (with
> > somewhat more complicated code) to overlap them such that it doesn't
> > require a serial round trip for each. Since the server is sending static
> > files, the overhead for each should be minimal.
> 
> It's not minimal. The size of an HTTP request is often not much
> different than the size of a compressed file delta.

I was thinking of server-side processing overhead, not bandwidth. It's
true that the bandwidth could be noticeable for these small files.

> All the junk that gets bundled in an http request/response will be
> similar in size to the stuff in the third column.

kernel.org seems to send 283-byte responses, to be completely
precise. This could be cut down substantially if Apache were tweaked a bit
to skip all the optional headers which are useless or wrong in this
context. (E.g., that includes sending a content-type of "text/plain" for
the binary data)

> Does it do this recursively? Eg, if the server has 800 new linear
> commits, does the client have to do 800 round trips following parent
> pointers to find all the new changesets? 

Yes, although that also includes pulling the commits, and may be
interleaved with pulling the trees and objects to cover the
latency. (I.e., one round trip gets the new head hash; the second gets
that commit; on the third the tree and the parent(s) can be requested at
once; on the fouth the contents of the tree and the grandparents, at
which point the bandwidth will probably be the limiting factor for the
rest of the operation.)

> In this case, Mercurial does about 6 round trips, totalling less than
> 1K, plus one requests that pulls everything.

I must be misunderstanding your numbers, because 6 HTTP responses is more
than 1K, ignoring any actual content from the server, and 1K for 800
commits is less than 2 bytes per commit.

I'm also worried about testing on 800 linear commits, since the projects
under consideration tend to have very non-linear histories. 

	-Daniel
*This .sig left intentionally blank*

