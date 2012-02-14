From: Jeff King <peff@peff.net>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 15:29:34 -0500
Message-ID: <20120214202934.GA23291@sigill.intra.peff.net>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
 <20120214195036.GD12072@sigill.intra.peff.net>
 <7vfwed6uws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP0R-0003Ot-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab2BNU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:29:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35866
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510Ab2BNU3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:29:38 -0500
Received: (qmail 10905 invoked by uid 107); 14 Feb 2012 20:36:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 15:36:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 15:29:34 -0500
Content-Disposition: inline
In-Reply-To: <7vfwed6uws.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190751>

On Tue, Feb 14, 2012 at 12:07:31PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. Looking at scale_linear, the formula is:
> >
> >    return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
> >
> > I don't see how that can be accurate, since the magnitude of the "-1"
> > tweak will vary based on the value of "it". This code is due to
> > 3ed74e6, but I don't quite follow the logic in the commit message.
> 
> Doesn't it need +1 at the end, I wonder?  We want to map:
> 
>  - zero to zero
>  - any number to at least 1
> 
> so scaling a non-zero "it" so that maximum maps to (width-1) and then
> adding 1 would be the right way for the latter case.

Yeah, that makes more sense to me. I think you could also get by with
simply rounding the above properly to the nearest integer (so a little
bit of error that makes 23.9 into 24.0 would be OK, because we would end
up rounding 30.9 to 31.0, too). This seems like the most obvious
solution to me:

  static int divide_and_round(int a, int b)
  {
          return (2 * a + b) / (2 * b);
  }

  /*
   * We want non-zero changes to have at least 1 marker, so special-case
   * zero, then scale to width-1, and add back in 1.
   */
  static int scale_linear(int it, int width, int max_change)
  {
          if (!it)
                  return 0;
          return 1 + divide_and_round(it * (width-1), max_change);
  }

Any "must show at least 1" scheme is going to have some error in the
scaling (because we are rounding up all of the low end). I have a
feeling that the scheme from 3ed74e6 was trying to distribute that error
more evenly throughout the scale, and the scheme above is lumping all of
it at the start (i.e., the difference between what constitutes one
marker and two markers is much greater than the difference between two
and three).

But that's just a vague feeling. For some reason my brain is not doing
well with math today, so I'll forego writing a proof.

> Of course, an easy way out without worrying about the correct math is to
> scale the total and the smaller one and then declare that the scaled
> larger one is the difference between the two. That way, both of these two
> files have 109 in total so the length of the entire graph would be the
> same ;-).

It looks like we actually did that, pre-3ed74e6. I think it's a valid
strategy. It is just pushing the error around, but I don't know that
people are counting the +/- markers on the line and comparing them
exactly. A little error there is less of a big deal than error between
two lines which are supposed to have the same number of changes (you'll
note that we don't give the per-file added/deleted numbers exactly, so
they are a good place to hide error. :) ).

-Peff
