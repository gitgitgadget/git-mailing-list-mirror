From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 6 Nov 2013 14:54:14 -0800
Message-ID: <20131106225414.GA15920@sigill.intra.peff.net>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
 <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
 <1383774082.2850.10.camel@centaur.cmartin.tk>
 <xmqqvc056uc1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBzR-0007Vf-PF
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab3KFWyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:54:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:34595 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955Ab3KFWyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:54:16 -0500
Received: (qmail 13483 invoked by uid 102); 6 Nov 2013 22:54:16 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Nov 2013 16:54:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Nov 2013 14:54:14 -0800
Content-Disposition: inline
In-Reply-To: <xmqqvc056uc1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237378>

On Wed, Nov 06, 2013 at 02:25:50PM -0800, Junio C Hamano wrote:

> > Support in the code isn't always enough. The particular case that
> > brought this on is one where the index-pack implementation can deal with
> > thin packs just fine.
> >
> > This particular service takes the pack which the client sent and does
> > post-processing on it to store it elsewhere. During the receive-pack
> > equivalent, there is no git object db that it can query for the missing
> > base objects. I realise this is pretty a unusual situation.
> 
> OK, I agree that it sounds quite niche-y, but it still is sensible.
> If a receiving end does not want to (this includes "it is incapable
> of doing so", but does not have to be limited to) complete a thin
> pack, the series will give it such an option in the longer term.

I wonder if we want to make the flag go in the opposite direction, then.

Right now we have no flag, and we assume the other side can handle a
thin pack. If we add a "thin" flag, then the timeline is roughly:

  1. Receive-pack starts advertising "thin".

  2. Send-pack cannot assume lack of "thin" means the other side cannot
     handle "thin" (it might just be an older receive-pack), and keeps
     sending thin packs.

  [time passes]

  3. Send-pack can safely assume that every server has learned "thin"
     and can assume that lack of "thin" means the server does not want a
     thin pack.

In other words, the benefit happens at step 3, and we do not get any
effect until some long assumption time passes.

If we instead introduced "no-thin", it is more like:

  1. Receive-pack starts advertising "no-thin" (as dictated by
     circumstances, as Carlos describes).

  2. Send-pack which does not understand no-thin will ignore it and send
     a thin pack. This is the same as now, and the same as step 2 above.

  3. An upgraded send-pack will understand no-thin and do as the server
     asks.

So an upgraded client and server can start cooperating immediately, and
we do not have to wait for the long assumption time to pass before
applying the second half.

It is tempting to think about a "thin" flag because that would be the
natural way to have implemented it from the very beginning. But it is
not the beginning, and the negative flag is the only way at this point
to say "if you understand this, please behave differently than we used
to" (because the status quo is "send a thin pack, whether I said it was
OK or not").

-Peff
