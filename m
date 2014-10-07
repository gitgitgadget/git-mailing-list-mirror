From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo =
 bar"
Date: Tue, 7 Oct 2014 16:18:05 -0400
Message-ID: <20141007201805.GA22703@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003202743.GH16293@peff.net>
 <5433E8CB.1050005@alum.mit.edu>
 <xmqqsiiziy94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:18:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbbD3-0005w6-3q
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbaJGUSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:18:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:55912 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751447AbaJGUSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:18:07 -0400
Received: (qmail 2889 invoked by uid 102); 7 Oct 2014 20:18:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 15:18:07 -0500
Received: (qmail 9013 invoked by uid 107); 7 Oct 2014 20:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 16:18:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 16:18:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsiiziy94.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257955>

On Tue, Oct 07, 2014 at 10:29:59AM -0700, Junio C Hamano wrote:

> > test_eq () {
> > 	if test "$1" != "$2"
> > 	then
> > 		printf "%s" "$1" >expect &&
> > 		printf "%s" "$2" >actual &&
> > 		test_cmp expect actual
> > 	fi
> > }
> [...]
> 
> The above superficially looks nice; "! test_eq a b" would give
> useless output under "-v", and "test_ne a b" needs to be added if
> you go that route, though.

Yeah, that is why I ended up with the operator as a parameter. I modeled
after test_line_count, which faces the same problem (negation must
happen in the operator, not the full command).

> Anyway, with the version posted, you cannot do "! test_eq a b",
> either but with "test_eq a b !=", you do not have to.
> 
> 	Side note. Yes, now I looked at it again, I agree that the
> 	three-arg form is awkwards in at least two ways.  The
> 	operator, if we are to take one, should be infix, and the
> 	name "eq" no longer matches what it does when it is given an
> 	operator.

I made it postfix because it's optional, and my inclination is to handle
arguments left-to-right, since that extends to multiple optional
arguments. But of course we have just one optional argument and can
simply treat 2-arg and 3-arg forms differently. However, Michael noted
that this is really just 'test "$@"', and I think we should allow any
"test" parameters.

> The function is similar to test_cmp which takes two files but takes
> two strings, so "test_cmp_str" or something perhaps (we already have
> test_cmp_rev to compare two revisions, and the suggested name
> follows that pattern)?

Based on your responses, I'm leaning towards:

  test_cmp_str() {
	test "$@" && return 0
	echo >&2 "command failed: test $*"
	return 1
  }

since the point is really just to print _something_ when the test fails
(any quoting or whitespace may be wrong, of course, but that's OK; it's
for human consumption, and is just a hint).

Maybe "str" is not right here. Michael suggested "test_test" which is
semantically what we want, but just looks silly[1]. Maybe
"test_pred" or something? "test_cond"? Or I guess going the other way,
"sane_test" or "verbose_test" or something.

I think test_cond is my favorite of those.

-Peff

[1] Of course, we could always do "test_[". :)
