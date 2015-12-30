From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Tue, 29 Dec 2015 23:25:19 -0500
Message-ID: <20151230042519.GA5037@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
 <20151229063545.GA30340@sigill.intra.peff.net>
 <xmqq4mf0g5la.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 05:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE8KF-0003Z7-7S
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 05:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbbL3EZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 23:25:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:47015 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753247AbbL3EZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 23:25:22 -0500
Received: (qmail 10547 invoked by uid 102); 30 Dec 2015 04:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 22:25:22 -0600
Received: (qmail 27864 invoked by uid 107); 30 Dec 2015 04:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 23:25:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 23:25:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mf0g5la.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283162>

On Tue, Dec 29, 2015 at 04:09:21PM -0800, Junio C Hamano wrote:

> > diff --git a/diff.h b/diff.h
> > index f7208ad..893f446 100644
> > --- a/diff.h
> > +++ b/diff.h
> > @@ -91,7 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
> >  #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
> >  #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
> >  #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
> > -#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
> > +#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
> >  
> >  #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
> >  #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
> 
> Thanks.
> 
> Seeing (1 << 30) and (1U <<31) together made me feel that we are way
> _too_ explicit being careful about 32-bit archs (iow, it would be
> more consistent to turn all of these "1 <<" into "1U <<"), but at
> the same time, (1 << 30) won't be broken unless we are on 31-bit
> arch in the sense that if we are on 30-bit or smaller arch the
> expression is already broken with or without "U", and if we are on
> 32-bit or more, then with or without "U" we are OK---which made me
> feel somewhat funny.

Yeah, I was tempted to convert them all, but there's no benefit except
consistency. Interestingly, if we spelled these as:

  0x01
  0x02
  ...
  0x80000000

that _is_ OK by the C standard (the type of the constant is "the first
thing big enough to hold it" from a list of int, unsigned, etc[1]). I find
that style more error-prone, though, so I don't think it's a good idea
to move to it.

We pretty much assume an int of at least 32-bits anyway; the flags field
itself is a simple "unsigned". We could make that a uint32_t, but in
practice I hope that sub-32-bit platforms are all dead, at least for
general purpose application code like git.

-Peff

[1] The list of possible types is actually _different_ for decimal and
    hex constants. Which seems slightly insane, but hey, it's C.
    Notably, the decimal equivalent of 0x80000000 is guaranteed to be
    signed (but would be a "long int" on a 32-bit platform).
