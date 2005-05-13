From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 18:11:49 -0700
Message-ID: <20050513011149.GK5914@waste.org>
References: <20050512222943.GI5914@waste.org> <Pine.LNX.4.21.0505121949210.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262191AbVEMBSQ@vger.kernel.org Fri May 13 03:15:23 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262191AbVEMBSQ@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWOln-0005YS-Vq
	for glk-linux-kernel@gmane.org; Fri, 13 May 2005 03:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVEMBSQ (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Thu, 12 May 2005 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVEMBRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:17:33 -0400
Received: from waste.org ([216.27.176.166]:11221 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262191AbVEMBL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 21:11:57 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4D1BogR003198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2005 20:11:50 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4D1BnOf003192;
	Thu, 12 May 2005 20:11:49 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505121949210.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:33:56PM -0400, Daniel Barkalow wrote:
> On Thu, 12 May 2005, Matt Mackall wrote:
> 
> > On Thu, May 12, 2005 at 05:24:27PM -0400, Daniel Barkalow wrote:
> > > On Thu, 12 May 2005, Matt Mackall wrote:
> > > 
> > > > Does this need an HTTP request (and round trip) per object? It appears
> > > > to. That's 2200 requests/round trips for my 800 patch benchmark.
> > > 
> > > It requires a request per object, but it should be possible (with
> > > somewhat more complicated code) to overlap them such that it doesn't
> > > require a serial round trip for each. Since the server is sending static
> > > files, the overhead for each should be minimal.
> > 
> > It's not minimal. The size of an HTTP request is often not much
> > different than the size of a compressed file delta.
> 
> I was thinking of server-side processing overhead, not bandwidth. It's
> true that the bandwidth could be noticeable for these small files.
> 
> > All the junk that gets bundled in an http request/response will be
> > similar in size to the stuff in the third column.
> 
> kernel.org seems to send 283-byte responses, to be completely
> precise. This could be cut down substantially if Apache were tweaked a bit
> to skip all the optional headers which are useless or wrong in this
> context. (E.g., that includes sending a content-type of "text/plain" for
> the binary data)
> 
> > Does it do this recursively? Eg, if the server has 800 new linear
> > commits, does the client have to do 800 round trips following parent
> > pointers to find all the new changesets? 
> 
> Yes, although that also includes pulling the commits, and may be
> interleaved with pulling the trees and objects to cover the
> latency. (I.e., one round trip gets the new head hash; the second gets
> that commit; on the third the tree and the parent(s) can be requested at
> once; on the fouth the contents of the tree and the grandparents, at
> which point the bandwidth will probably be the limiting factor for the
> rest of the operation.)

What if a changeset is smaller than the bandwidth-delay product of
your link? As an extreme example, Mercurial is currently at a point
where its -entire repo- changegroup (set of all changesets) can be in
flight on the wire on a typical link.

> > In this case, Mercurial does about 6 round trips, totalling less than
> > 1K, plus one requests that pulls everything.
> 
> I must be misunderstanding your numbers, because 6 HTTP responses is more
> than 1K, ignoring any actual content from the server, and 1K for 800
> commits is less than 2 bytes per commit.

1k of application-level data, sorry. And my whole point is that I
don't send those 800 commit identifiers (which are 40 bytes each as
hex). I send about 30 or so. It's basically a negotiation to find the
earliest commits not known to the client with a minimum of round trips
and data exchange.

> I'm also worried about testing on 800 linear commits, since the projects
> under consideration tend to have very non-linear histories. 

Not true at all. Dumps from Andrew to Linus via patch bombs will
result in runs of hundreds of linear commits on a regular basis.
Linear patch series are the preferred way to make changes and series
of 30 or 40 small patches are not at all uncommon.

-- 
Mathematics is the supreme nostalgia of our time.
