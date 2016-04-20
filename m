From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix deadlock in git-push
Date: Wed, 20 Apr 2016 17:51:17 -0400
Message-ID: <20160420215117.GA18297@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
 <xmqqwpnst1yb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:51:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at01u-0001mn-0C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbcDTVvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:51:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:53260 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751179AbcDTVvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:51:20 -0400
Received: (qmail 16827 invoked by uid 102); 20 Apr 2016 21:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 17:51:20 -0400
Received: (qmail 3368 invoked by uid 107); 20 Apr 2016 21:51:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 17:51:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 17:51:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpnst1yb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292086>

On Wed, Apr 20, 2016 at 02:17:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The first patch below fixes the deadlock. Unfortunately, it turns it
> > into a likely SIGPIPE death. Which is an improvement, but not ideal.
> >
> > Patches 2 and 3 address that by fixing the way we handle SIGPIPE in
> > async threads.
> >
> > Patches 4 and 5 are cleanups to earlier topics that are enabled by the
> > new SIGPIPE handling.
> >
> >   [1/5]: send-pack: close demux pipe before finishing async process
> >   [2/5]: run-command: teach async threads to ignore SIGPIPE
> >   [3/5]: send-pack: isolate sigpipe in demuxer thread
> >   [4/5]: fetch-pack: isolate sigpipe in demuxer thread
> >   [5/5]: t5504: drop sigpipe=ok from push tests
> 
> Thanks for a very well explained series.
> 
> We do not call finish_async (rather, we do not use async) from that
> many places, and from a cursory look this codepath is the only case
> where we may encounter this kind of deadlock (the ones in
> receive-pack is about relaying the error messages back to the other
> end over sideband multiplexing)?

Yeah, I checked the other demuxer in fetch-pack, but it does not have
any early returns like this (it just dies :) ).

It does not do an explicit close on demux.out, but I think it is
effectively closed when we hand it off to index-pack/unpack-objects via
cmd.in.

Arguably finish_async() should "close(demux.out)" itself, but that felt
like an ownership violation. Yes, that's how "struct async" passes out
the descriptor, but the caller is then expected to handle it, and
correct callers will typically have closed it themselves, handed it off
to a sub-process, etc. Closing it in finish_async() runs the risk that
we just call close() on a descriptor number that is either unattached,
or attached to some random other thing.

-Peff
