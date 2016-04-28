From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: warn on split packs disabling bitmaps
Date: Wed, 27 Apr 2016 22:25:14 -0400
Message-ID: <20160428022514.GC9707@sigill.intra.peff.net>
References: <20160427215324.GA22165@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 04:25:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avbdu-0006F1-6u
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 04:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcD1CZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 22:25:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:58022 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752210AbcD1CZR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 22:25:17 -0400
Received: (qmail 23023 invoked by uid 102); 28 Apr 2016 02:25:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 22:25:16 -0400
Received: (qmail 4571 invoked by uid 107); 28 Apr 2016 02:25:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 22:25:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 22:25:14 -0400
Content-Disposition: inline
In-Reply-To: <20160427215324.GA22165@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292843>

On Wed, Apr 27, 2016 at 09:53:24PM +0000, Eric Wong wrote:

> It can be tempting for a server admin to want a stable set of
> long-lived packs for dumb clients; but also want to enable
> bitmaps to serve smart clients more quickly.
> 
> Unfortunately, such a configuration is impossible;
> so at least warn users of this incompatibility since
> commit 21134714787a02a37da15424d72c0119b2b8ed71
> ("pack-objects: turn off bitmaps when we split packs").
> 
> Tested the warning by inspecting the output of:
> 
> 	make -C t t5310-pack-bitmaps.sh GIT_TEST_OPTS=-v

I think the intent and code in your patch is fine; looks like doc
specifics are being discussed elsewhere.

But I did want to mention one thing, which is that long-lived split
packs are a tradeoff, even for dumb clients. The pack format cannot do
deltas between packs, so the sum of your split packs is larger than a
single pack would be. That's a good thing for somebody who cloned
earlier, and wants to only a few small packs on top. But it's much worse
for somebody who wants to do a fresh clone, and has to grab all of the
packs either way.

>  Fwiw, I'm hoping to publish an ~800MB git-clone-able repo of
>  our ML archives, soonish.  I can serve terabytes of dumb HTTP
>  traffic all day long without breaking a sweat; but smart
>  packing of big repos worries me; especially when feeding
>  slow clients and having to leave processes running
>  (or buffering pack output to disk).  So perhaps I'll teach
>  my HTTP server play dumb whenever CPU/memory usage is high.

Yeah, CPU and memory load for serving large clones is a problem. Memory
especially scales with number of objects (because we keep the whole
packing list in memory for the entirety of the write). At GitHub, we
have some changes to try to serve things verbatim from the on-disk pack
without even creating an in-memory list of objects (it's just a bitmap
of which objects in the packfile to send), and that reduces CPU and
memory load quite a bit. Cleaning up and submitting those patches has
been on my todo list for a while, but I just haven't gotten to it. I'm
of course happy to share the messy state if you want to pick through it
yourself.

-Peff
