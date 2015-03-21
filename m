From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Sat, 21 Mar 2015 18:23:04 -0400
Message-ID: <20150321222304.GA27850@peff.net>
References: <20150320100429.GA17354@peff.net>
 <CAPig+cRCbhMR58_PSFnsWoyo_aZoTOVZM2YeYC6Tvo7iXMZwBA@mail.gmail.com>
 <20150321081909.GA8221@peff.net>
 <xmqq384ydybc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZRnV-0003ty-SV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 23:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbbCUWXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 18:23:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:36549 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbbCUWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 18:23:07 -0400
Received: (qmail 2843 invoked by uid 102); 21 Mar 2015 22:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 17:23:06 -0500
Received: (qmail 3634 invoked by uid 107); 21 Mar 2015 22:23:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 18:23:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2015 18:23:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqq384ydybc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266038>

On Sat, Mar 21, 2015 at 11:01:43AM -0700, Junio C Hamano wrote:

> > Running:
> >
> >   git diff origin origin/jk/test-chain-lint |
> >   perl diff-blame.pl jk/test-chain-lint |
> >   grep EOF
> >
> > was fun. At least I am not the only one. :)
> 
> The parameter to diff-blame.pl should be origin, instead of
> jk/test-chain-lint, I presume?  You are grabbing the preimage line
> numbers and asking blame to find out who wrote them.

Yes, sorry, that was an error translating from what I actually ran in
the shell into the email. It should be "origin". And if the script
really wanted to be user-friendly, it should probably take two endpoints
and just run the diff itself (when I started it, I assume that you could
process any diff, but of course you must know the start point to get a
reasonable blame).

> > Nor the worst in the "severe" category.
> 
> I do not quite get what this means---the script does not seem to
> judge what is severe and what is not, so I presume that this is to
> be judged by whoever is reading the output from the above pipeline
> after replacing "grep EOF" with "less" or something?

That was the exercise I left to the reader. :) In this case, it is
possible because I have already split the patches into "severe",
"moderate", and "trivial" cases, so you can blame only the severe patch
(using its parent as the start-point).

> > while (<STDIN>) {
> >   if (m{^--- .*?/(.*)}) {
> 
> This may match a removal of a line that begins with "^-- something/" ;-)

True. I was trying to avoid being stateful in my diff parsing. I guess
it would be enough to parse the hunk headers to know how many lines are
in the hunk. Not worth it for this one-off, but a good thing if somebody
wanted to pick this idea up for a "real" tool.

> >   # XXX coalesce blocks of adjacent lines into ranges?
> >   system(qw(git --no-pager blame), @ARGV,
> 
> You may want to pass an option to always show the filename here.

I left that to the user. I actually found "--line-porcelain" useful for
gathering statistics (e.g., piped to "grep '^author ' | sort | uniq -c").

-Peff
