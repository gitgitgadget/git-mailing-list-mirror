From: Jeff King <peff@peff.net>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 16:40:35 -0400
Message-ID: <20121019204035.GA24448@sigill.intra.peff.net>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 <7vd30fl736.fsf@alter.siamese.dyndns.org>
 <20121019103627.GA29366@sigill.intra.peff.net>
 <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
 <20121019202723.GA24184@sigill.intra.peff.net>
 <CAHOQ7J8D-8++vgMh=c0rcTtAKrhWUCQx2nSd_spBzFe=QdXwBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <sop@google.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJNC-0007s1-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700Ab2JSUkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:40:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39916 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723Ab2JSUkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:40:39 -0400
Received: (qmail 18700 invoked by uid 107); 19 Oct 2012 20:41:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Oct 2012 16:41:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2012 16:40:35 -0400
Content-Disposition: inline
In-Reply-To: <CAHOQ7J8D-8++vgMh=c0rcTtAKrhWUCQx2nSd_spBzFe=QdXwBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208061>

On Fri, Oct 19, 2012 at 01:37:06PM -0700, Stefan Zager wrote:

> > diff --git a/http.c b/http.c
> > index df9bb71..cd07cdf 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -631,6 +631,19 @@ void run_active_slot(struct active_request_slot *slot)
> >                         FD_ZERO(&excfds);
> >                         curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
> >
> > +                       /*
> > +                        * Sometimes curl will give a really long timeout for a
> > +                        * CONNECT when there are no fds to read, but we can
> > +                        * get better results by running curl_multi_perform
> > +                        * more frequently.
> > +                        */
> > +                       if (maxfd < 0 &&
> > +                           (select_timeout.tv_sec > 0 ||
> > +                            select_timeout.tv_usec > 50000)) {
> > +                               select_timeout.tv_sec = 0;
> > +                               select_timeout.tv_usec = 50000;
> > +                       }
> > +
> >                         select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
> >                 }
> >         }
> >
> I have no objection to this; any one else?

If you wouldn't mind, I was hoping you could flesh out the comment a bit
more with real details of when this happens (and/or put them in the
commit message). If this is indeed a bug to be worked around, it will be
a huge help to somebody reading this code in a year who can confirm that
modern curl does not need it anymore.

-Peff
