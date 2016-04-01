From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 3/4] bundle: don't leak an fd in case of early return
Date: Fri, 1 Apr 2016 13:15:35 -0400
Message-ID: <20160401171535.GB20345@sigill.intra.peff.net>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
 <1459470946-16522-4-git-send-email-sbeller@google.com>
 <xmqqzitdi7iq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2ff-0007zc-7g
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcDARPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:15:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:42520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbcDARPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:15:38 -0400
Received: (qmail 10951 invoked by uid 102); 1 Apr 2016 17:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:15:37 -0400
Received: (qmail 27171 invoked by uid 107); 1 Apr 2016 17:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:15:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 13:15:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzitdi7iq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290562>

On Fri, Apr 01, 2016 at 10:05:49AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > In successful operation `write_pack_data` will close the `bundle_fd`,
> > but when we exit early, we need to take care of the file descriptor
> > as well as the lock file ourselves. The lock file may be deleted at the
> > end of running the program, but we are in library code, so we should
> > not rely on that.
> >
> > Helped-by: Jeff King <peff@peff.net>
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> 
> Thanks.  I think this turned out to be the trickiest one to get
> right among the four and my reading of this round tells me that
> it addresses all the trickiness pointed out in the reviews.

You didn't see my response to the other patch yet. :)

> >  	/* write pack */
> >  	if (write_pack_data(bundle_fd, &revs))
> > -		return -1;
> > +		goto err;

This does still suffer from the double-close I mentioned earlier. I'm
not sure if we want to address that or not.

-Peff
