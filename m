From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 9 Jun 2016 13:14:29 -0400
Message-ID: <20160609171429.GB9016@sigill.intra.peff.net>
References: <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
 <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
 <20160608194216.GA3731@sigill.intra.peff.net>
 <vpqwplypnpr.fsf@anie.imag.fr>
 <xmqqr3c6iad1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:14:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB3XS-0002g1-2R
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbcFIROd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:14:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:51984 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932066AbcFIROc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:14:32 -0400
Received: (qmail 23536 invoked by uid 102); 9 Jun 2016 17:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:14:31 -0400
Received: (qmail 25172 invoked by uid 107); 9 Jun 2016 17:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:14:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 13:14:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3c6iad1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296905>

On Thu, Jun 09, 2016 at 09:40:42AM -0700, Junio C Hamano wrote:

> >>  	for (i = 0; i < extra->nr; i++)
> >> -		if (!feed_object(extra->sha1[i], po.in, 1))
> >> -			break;
> >> +		feed_object(extra->sha1[i], po_in, 1);
> >
> > I may have missed the obvious, but doesn't this change the behavior when
> > "negative && !has_sha1_file(sha1)" happens? I understand that you don't
> > need write_or_whine anymore, but don't understand how you get rid of the
> > "return 1" here.
> [...]
> The original caller checks for errors to break out the feeding of
> the process early, with things like:
> 
> 	if (!feed_object(...))
>         	break;
> 
> IOW, the caller would have continued when hitting that "return 1"
> codepath.
> 
> And the code with the patch, the caller continues unconditionally,
> so there is no behaviour change, if I am reading the code correctly.

Right, that's my reading as well (and IMHO another good motivation for
the patch, if it makes this all less confusing).

-Peff
