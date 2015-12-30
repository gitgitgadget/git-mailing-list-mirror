From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 30 Dec 2015 02:37:59 -0500
Message-ID: <20151230073759.GA785@sigill.intra.peff.net>
References: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
 <CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
 <xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
 <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
 <xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
 <CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
 <20151104200249.GC16101@sigill.intra.peff.net>
 <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEBKi-0007rp-7Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 08:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbbL3HiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 02:38:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:47064 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750910AbbL3HiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 02:38:03 -0500
Received: (qmail 18768 invoked by uid 102); 30 Dec 2015 07:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 02:38:02 -0500
Received: (qmail 28657 invoked by uid 107); 30 Dec 2015 07:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 02:38:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 02:37:59 -0500
Content-Disposition: inline
In-Reply-To: <CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283168>

On Wed, Nov 04, 2015 at 02:08:21PM -0600, Doug Kelly wrote:

> On Wed, Nov 4, 2015 at 2:02 PM, Jeff King <peff@peff.net> wrote:
> > Definitely cleaning up the .bitmap is sane and not racy (it's in the
> > same boat as the .idx, I think).
> >
> > .keep files are more tricky. I'd have to go over the receive-pack code
> > to confirm, but I think they _are_ racy. That is, receive-pack will
> > create them as a lockfile before moving the pack into place. That's OK,
> > though, if we use mtimes to give ourselves a grace period (I haven't
> > looked at your series yet).
> >
> > But moreover, .keep files can be created manually by the user. If the
> > pack they referenced goes away, they are not really serving any purpose.
> > But it's possible that the user would want to salvage the content of the
> > file, or know that it was there.
> >
> > So I'd argue we should leave them. Or at least leave ones that do not
> > have the generic "{receive,fetch}-pack $pid on $host comment in them,
> > which were clearly created as lockfiles.
> 
> Currently there's no mtime-guarding logic (I dug up that conversation
> earlier, though, but after I'd done the respin on this series)... OK,
> in that case, I'll create a separate patch that tests/cleans up
> .bitmap, but doesn't touch .keep.  This might be a small series since
> I think the logic for finding pack garbage doesn't know anything about
> .bitmap per-se, so it's looking like I'll extend that relevant code,
> before adding the handling in gc and appropriate tests.

I happened to be looking over your series again, and I noticed that we
didn't end up with any mtime logic at all in what got merged.

I _think_ that is probably OK, because we always write the pack,
followed by the .idx, followed by the .bitmap (if any). And we don't
drop .keep files (though I think we would perhaps note them as possible
cruft?).

So I don't think there are any races introduced here, but I wonder if we
want to be a bit more conservative. Sorry to bring this up so much after
the fact; I completely forgot about it when reviewing the patches.

These changes are slated for the v2.7 release. Like I said, I don't
think it's buggy, so we don't necessarily need to address it before the
release. We could add an mtime check in the next cycle as a
belt-and-suspenders safety, rather than a fix.

-Peff
