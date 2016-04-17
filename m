From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sat, 16 Apr 2016 23:54:15 -0400
Message-ID: <20160417035414.GA30002@sigill.intra.peff.net>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-2-git-send-email-rappazzo@gmail.com>
 <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 06:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arduo-0002ec-1T
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 06:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcDQDyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 23:54:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:50867 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbcDQDyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 23:54:18 -0400
Received: (qmail 16719 invoked by uid 102); 17 Apr 2016 03:54:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Apr 2016 23:54:17 -0400
Received: (qmail 26418 invoked by uid 107); 17 Apr 2016 03:54:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Apr 2016 23:54:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Apr 2016 23:54:15 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291742>

On Sat, Apr 16, 2016 at 11:07:02PM -0400, Eric Sunshine wrote:

> > test_stdout accepts an expection and a command to execute.  It will execute
> > the command and then compare the stdout from that command to an expectation.
> > If the expectation is not met, a mock diff output is written to stderr.
> 
> I wonder if this deserves more flexibility by accepting a comparison
> operator, such as = and !=, similar to test_line_count()? Although, I
> suppose such functionality could be added later if deemed useful.

IMHO the funny syntax would outweigh the readability benefits. Unlike
test_line_count(), which is abstracting a portability solution, this is
mostly just about trying to save a few lines.

Though I do actually find that:

  test_stdout false git rev-parse --whatever

isn't great, because there's no syntactic separator between the expected
output and the actual command to run. So I dunno, maybe it would be
better as:

  test_stdout false = git rev-parse --whatever

and then you get "!=" for free later on if you want it.

We could also do:

  test_stdout git rev-parse --whatever <<-\EOF
  false
  EOF

which is more robust for multi-line output, but I think part of the
point is to keep these as simple one-liners. You're not buying all that
much over:

  cat >expect <<-\EOF &&
  false
  EOF
  git rev-parse --whatever >actual &&
  test_cmp expect actual

Though I do admit I've considered such a helper for some tests where
that pattern is repeated ad nauseam.

> > Based-on-a-patch-by: Jeff King <peff@peff.net>
> 
> Since Peff wrote the actual code[1], it might be worthwhile to give
> him authorship by prepending the commit message with a "From: Jeff
> King <peff@peff.net>" header.

Michael contacted me offline asking how to credit, and I actually
suggested the "Based-on" route. I'm OK with it either way.

And for the record, my contribution is:

  Signed-off-by: Jeff King <peff@peff.net>

in case there are any DCO questions.

-Peff
