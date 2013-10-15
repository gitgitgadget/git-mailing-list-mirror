From: Jeff King <peff@peff.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Mon, 14 Oct 2013 21:51:13 -0400
Message-ID: <20131015015113.GA17486@sigill.intra.peff.net>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
 <20131015001926.GC10415@sigill.intra.peff.net>
 <alpine.LFD.2.03.1310142141200.1873@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 03:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVtnK-0006p3-D1
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 03:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3JOBvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 21:51:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:49466 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834Ab3JOBvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 21:51:16 -0400
Received: (qmail 30963 invoked by uid 102); 15 Oct 2013 01:51:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 20:51:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 21:51:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1310142141200.1873@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236161>

On Mon, Oct 14, 2013 at 09:45:12PM -0400, Nicolas Pitre wrote:

> > No, as far as I know, it is a novel idea. When we were discussing commit
> > caching a while back, Shawn suggested slicing trees on boundaries and
> > store delta instructions that were pure "change this entry", "add this
> > entry", and "delete this entry" chunks. The deltas might end up a little
> > bigger, but if the reader knew the writer had sliced in this way, it
> > could get a packv4-style cheap tree-diff, while remaining backwards
> > compatible with implementations that just blindly reassemble the buffer
> > from delta instructions.
> > 
> > I didn't get far enough to try it, but doing what you propose would be
> > the first step. Now that packv4 is more of a reality, it may not be
> > worth pursuing, though.
> 
> The "easy" way to produce pack v2 tree objects from a pack v4 would be 
> exactly that: take the pack v4 tree encoding and do a straight 
> translation into delta encoding using the base from which the most 
> entries are copied from.

Yeah, that makes a lot of sense.

By the way, I'm sorry I haven't looked more carefully at the packv4
patches yet. I am excited about it, but I've just got a long queue of
other things (and because it's big and challenging, it's easy to put
off).

One of the things that makes me most nervous about switching to it on
the server side is that we'll have packv2-only clients for a while, and
I worry that converting to v2 on the fly is going to end up costing a
lot (even with clever tricks like this, you still have to pay the cost
to zlib deflate each item). But even if it is slow, the sooner we have
packv4 readers, the sooner the clocks start ticking for it being a
reasonable decision for a big server provider to switch.

-Peff
