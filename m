From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Mon, 10 Nov 2014 02:04:59 -0500
Message-ID: <20141110070459.GC7677@peff.net>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
 <20141109015918.GA24736@peff.net>
 <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
 <xmqqtx28b6z6.fsf@gitster.dls.corp.google.com>
 <20141110063035.GA7677@peff.net>
 <CAPc5daUrUZ135sbSuZn6DXmN_momR6KxNyN9cNdTbzwbD6Uu0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:05:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnj2D-000052-9x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 08:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbaKJHFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 02:05:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:38628 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbaKJHFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 02:05:01 -0500
Received: (qmail 16857 invoked by uid 102); 10 Nov 2014 07:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:05:01 -0600
Received: (qmail 501 invoked by uid 107); 10 Nov 2014 07:05:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 02:05:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 02:04:59 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daUrUZ135sbSuZn6DXmN_momR6KxNyN9cNdTbzwbD6Uu0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 10:47:52PM -0800, Junio C Hamano wrote:

> On Sun, Nov 9, 2014 at 10:30 PM, Jeff King <peff@peff.net> wrote:
> >
> > I know you "make test" before pushing out the results of any integration
> > you do. And I recall that for a while (and maybe still?) you even did so
> > on VMs of a few common platforms. OS X is notoriously irritating to run
> > in a VM, but would you be interested in a network-accessible install
> > that you could push to and "make test" on as part of your routine?
> >
> > If what Michael is offering cannot do that, I am sure I can get GitHub
> > to set something up.
> 
> Even if it were network-accessible, the latency for doing an integration
> cycle and pushing there and waiting for the tests to come back may
> make it impractical to use it as "part of pre-pushout test".

I had the impression you were already doing "for i in my_vms; do git
push $i && ssh $i make test; done", so in theory this could be done in
parallel. But yeah, I definitely wouldn't want to add latency to your
workflow.

> But I would think that the project certainly would benefit if a
> post-receive hook at Github did an automated test on the tip of
> 'pu' and bisected a breakage, if found, to pinpoint the patch
> that breaks. It could even send a notice to the author of the
> non-portable patch ;-).

Yeah, you're right. Testing on "pu" is probably enough. Coupled with
automated bisection, the "pinpointing" part is not that important, and
pu is often "early enough" to catch problems before people try to build
on top of them. So I think if Michael is still willing to set up his
build box, just pulling and building your "pu" automatically would be a
good start.

GitHub supports trigger hooks on pushes, but I do not think that is even
necessary here. Just polling once or twice a day would probably give us
good enough turn-around time.

I think somebody just needs to write the auto-bisect script. I suspect
the simplest form is something like:

  # fetch a new version; exit early if we already checked this one
  git fetch
  test "$(git rev-parse pu-ok)" = "$(git rev-parse origin/pu)" &&exit 0
  git reset --hard origin/pu

  # quick path: all tests succeed
  if make test; then
    git tag -f pu-ok HEAD
    exit 0
  fi

  # slow path: bisect the actual commit. We do not need worry about
  # cutting each bisection step down to the minimal size (e.g., finding
  # the actual failing test), because this should run only infrequently.
  git bisect start HEAD pu-ok
  git bisect run make test

The real work would be in wrapping it up in a cron-job or similar so
that it produces no output on success, and sends an email (or whatever)
with the bisect results when it fails.

-Peff
