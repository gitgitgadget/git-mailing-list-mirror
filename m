From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] pack-objects: warn on split packs disabling bitmaps
Date: Thu, 28 Apr 2016 08:02:28 +0000
Message-ID: <20160428080228.GB5252@dcvr.yhbt.net>
References: <20160427215324.GA22165@dcvr.yhbt.net>
 <20160428022514.GC9707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 10:02:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avguB-0004VP-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 10:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcD1ICb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 04:02:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37007 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbcD1IC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 04:02:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562C41F980;
	Thu, 28 Apr 2016 08:02:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160428022514.GC9707@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292856>

Jeff King <peff@peff.net> wrote:
> On Wed, Apr 27, 2016 at 09:53:24PM +0000, Eric Wong wrote:
> 
> > It can be tempting for a server admin to want a stable set of
> > long-lived packs for dumb clients; but also want to enable
> > bitmaps to serve smart clients more quickly.

> But I did want to mention one thing, which is that long-lived split
> packs are a tradeoff, even for dumb clients. The pack format cannot do
> deltas between packs, so the sum of your split packs is larger than a
> single pack would be. That's a good thing for somebody who cloned
> earlier, and wants to only a few small packs on top. But it's much worse
> for somebody who wants to do a fresh clone, and has to grab all of the
> packs either way.

Definitely a trade off, but a fresh clone with packs might only
be (at worst) doubling or tripling bandwidth use on both sides?

However, the CPU/memory cost of packing is at least an order of
magnitude (more likely several orders of magnitude) more
expensive on the server.  The client most likely won't care
about CPU/memory usage, though.

> >  Fwiw, I'm hoping to publish an ~800MB git-clone-able repo of
> >  our ML archives, soonish.  I can serve terabytes of dumb HTTP
> >  traffic all day long without breaking a sweat; but smart
> >  packing of big repos worries me; especially when feeding
> >  slow clients and having to leave processes running
> >  (or buffering pack output to disk).  So perhaps I'll teach
> >  my HTTP server play dumb whenever CPU/memory usage is high.
> 
> Yeah, CPU and memory load for serving large clones is a problem. Memory
> especially scales with number of objects (because we keep the whole
> packing list in memory for the entirety of the write). At GitHub, we
> have some changes to try to serve things verbatim from the on-disk pack
> without even creating an in-memory list of objects (it's just a bitmap
> of which objects in the packfile to send), and that reduces CPU and
> memory load quite a bit. Cleaning up and submitting those patches has
> been on my todo list for a while, but I just haven't gotten to it. I'm
> of course happy to share the messy state if you want to pick through it
> yourself.

Sure thing!  I can't promise I'll have time, either, but being
able to serve packs verbatim would be great; especially if you
could multiplex it with epoll/kqueue for folks on slow pipes
(and maybe use sendfile, but perhaps that's not worth the effort
 with TLS everywhere nowadays).

I was also wondering if fresh clones could be memoized entirely.
