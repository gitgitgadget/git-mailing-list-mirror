From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 4 Nov 2015 15:02:49 -0500
Message-ID: <20151104200249.GC16101@sigill.intra.peff.net>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
 <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
 <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
 <xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
 <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
 <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4Gm-0000p8-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965457AbbKDUCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:02:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:52894 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965366AbbKDUCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:02:52 -0500
Received: (qmail 14522 invoked by uid 102); 4 Nov 2015 20:02:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 14:02:51 -0600
Received: (qmail 6113 invoked by uid 107); 4 Nov 2015 20:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 15:03:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 15:02:49 -0500
Content-Disposition: inline
In-Reply-To: <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280876>

On Wed, Nov 04, 2015 at 01:56:38PM -0600, Doug Kelly wrote:

> > I did wonder if we want to say anything about .bitmap files, though.
> > If there is one without matching .idx and .pack, shouldn't we report
> > just like we report .idx without .pack (or vice versa)?
> 
> I think you're right -- this would be something worth following up on.
> At least, t5304 doesn't cover this case explicitly, but when I tried
> adding an empty bitmap with a bogus name, I did see a "no
> corresponding .idx or .pack" error, similar to the stale .keep file.

Yeah, that should be harmless warning (although note because the bitmap
code only really handles a single bitmap, it can prevent loading of the
"real" bitmap; so you'd want to clean it up, for sure).

> I'd trust your (and Jeff's) knowledge on this far more than my own,
> but would it be a bad idea to clean up .keep and .bitmap files if the
> .idx/.pack pair are missing?  I think we may have had a discussion
> previously on how things along these lines might be racey -- but I
> don't know what order the .keep file is created in relation to the
> .idx/.pack.

Definitely cleaning up the .bitmap is sane and not racy (it's in the
same boat as the .idx, I think).

.keep files are more tricky. I'd have to go over the receive-pack code
to confirm, but I think they _are_ racy. That is, receive-pack will
create them as a lockfile before moving the pack into place. That's OK,
though, if we use mtimes to give ourselves a grace period (I haven't
looked at your series yet).

But moreover, .keep files can be created manually by the user. If the
pack they referenced goes away, they are not really serving any purpose.
But it's possible that the user would want to salvage the content of the
file, or know that it was there.

So I'd argue we should leave them. Or at least leave ones that do not
have the generic "{receive,fetch}-pack $pid on $host comment in them,
which were clearly created as lockfiles.

-Peff
