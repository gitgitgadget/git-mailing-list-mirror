From: Jeff King <peff@peff.net>
Subject: Re: mac test failure -- test 3301
Date: Mon, 10 Nov 2014 21:41:29 -0500
Message-ID: <20141111024128.GA21328@peff.net>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
 <CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
 <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 03:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo1Oq-0006m1-0j
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 03:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaKKCld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 21:41:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:38951 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751178AbaKKClc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 21:41:32 -0500
Received: (qmail 4896 invoked by uid 102); 11 Nov 2014 02:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 20:41:32 -0600
Received: (qmail 13999 invoked by uid 107); 11 Nov 2014 02:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 21:41:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 21:41:29 -0500
Content-Disposition: inline
In-Reply-To: <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 02:40:19AM +0100, Johan Herland wrote:

> > This and all other failures are due to the output of 'wc -l', which on
> > Mac is "{whitespace}1" rather than just "1" as it is on other
> > platforms. fbe4f748 added quotes around the $(... | wc -l) invocation
> > which caused the whitespace to be retained. A minimum fix would be to
> > drop the quotes surrounding $().
> 
> Ah, thanks!
> 
> I thought that quoting command output was a good idea in general. Am I
> wrong, or is this just one exception to an otherwise good guideline?

It usually is a good idea to prevent whitespace splitting by the shell
(and especially with things that might unexpectedly be empty, in which
case they end up as "no argument" and not an empty one). So yeah, this
is an exception.

> Anyway, here is the minimal diff to remove quoting from the $(... | wc
> -l) commands (probably whitespace damaged by GMail - sorry). Junio:
> feel free to squash this in, or ask for a re-roll:

I think we have test_line_count exactly because of this unportability
with wc output.

You'd want:

  git ls-tree refs/notes/commits >actual &&
  test_line_count = 1 actual

or similar.

By the way, the point of that "ls-tree" appears to be to check the
number of total notes stored. Since notes are stored in a hashed
structure, should it be "ls-tree -r"? Otherwise, we see only the leading
directories; two notes whose sha1s start with the same two characters
would be considered a single entry.

-Peff
