From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Fri, 1 May 2015 14:22:58 -0400
Message-ID: <20150501182257.GA27728@peff.net>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
 <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 20:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoFac-0001DY-FY
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbEASXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 14:23:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:52945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751122AbbEASXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:23:00 -0400
Received: (qmail 28375 invoked by uid 102); 1 May 2015 18:23:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 13:23:00 -0500
Received: (qmail 18606 invoked by uid 107); 1 May 2015 18:23:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 14:23:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 14:22:58 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268170>

On Fri, May 01, 2015 at 10:51:47AM -0700, Stefan Beller wrote:

> > diff --git a/refs.c b/refs.c
> > index 47e4e53..3f8ac63 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2413,9 +2413,19 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
> >  /* This should return a meaningful errno on failure */
> >  int lock_packed_refs(int flags)
> >  {
> > +       static int timeout_configured = 0;
> > +       static int timeout_value = 1000;
> 
> I'd personally be more happier with a default value of 100 ms or less
> The reason is found in the human nature, as humans tend to perceive
> anything faster than 100ms as "instant"[1], while a 100ms is a long time
> for computers.
> 
> Now a small default time may lead to to little retries, so maybe it's worth
> checking at the very end of the time again (ignoring the computed backoff
> times). As pushes to $server usually take a while (connecting, packing packs,
> writing objects etc), this may be overcautios bikeshedding from my side.

Keep in mind that this 1s is the maximum time to wait. The
lock_file_timeout() code from patch 1 starts off at 1ms, grows
quadratically, and quits as soon as it succeeds. So in most cases, the
user will wait a much smaller amount of time.

The factors that go into this timeout length are really:

  1. If there's a stale lockfile, the user will have to wait the whole
     period. How long do we keep retrying before giving up?

  2. How long do we typically hold the lock for? Aside from absurd
     cases, writing out the packed-refs file isn't that expensive. But
     while holding the packed-refs lock, we may actually be iterating
     the loose refs, which can be rather slow on a cold-cache.

If we want to improve _responsiveness_ in the normal case, I think it's
not the max timeout we want to tweak but the resolution of retries.
That's set in patch 1 by the maximum backoff multiplier, which can put
us up to 1s between retries. It might make sense to drop that to 500ms
or even less.

-Peff
