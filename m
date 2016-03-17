From: Jeff King <peff@peff.net>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 21:43:10 -0400
Message-ID: <20160317014310.GA12830@sigill.intra.peff.net>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
 <20160316204912.GA1890@sigill.intra.peff.net>
 <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
 <20160316212308.GA4538@sigill.intra.peff.net>
 <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
 <20160316214442.GC4441@sigill.intra.peff.net>
 <CAGZ79kbbAv=PukD+sftmoO8u3GX=S1YCYGV8zcNMxrZ+E41-UA@mail.gmail.com>
 <20160316231626.GA11808@sigill.intra.peff.net>
 <CAGZ79kYVT0cq8XgruZ+i_gGuSDySE+s3POU95PXyra9DwVGLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 02:43:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agMyI-0000YX-R3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 02:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967101AbcCQBnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 21:43:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:33009 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756464AbcCQBnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 21:43:13 -0400
Received: (qmail 5311 invoked by uid 102); 17 Mar 2016 01:43:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 21:43:13 -0400
Received: (qmail 22964 invoked by uid 107); 17 Mar 2016 01:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 21:43:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 21:43:10 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYVT0cq8XgruZ+i_gGuSDySE+s3POU95PXyra9DwVGLkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289069>

On Wed, Mar 16, 2016 at 04:33:03PM -0700, Stefan Beller wrote:

> The way I understand verbosity is this:
> * You can instruct a command to be more verbose if it is supported by
> adding more -v
> * --no-verbose tells the command to be not verbose, i.e. no additional output.
> 
> So my question was, if there is any command, which is verbose by
> default, and --no-verbose would make it "more quiet"? Such a case
> would be a UX bug, as a user would rather expect --quiet instead of
> --no-verbose IMO. Would such a case ever happen, that we'd want to
> give --no-verbose to decrease the amount said by the command?

Ah, I see. I agree that would be a bug, because --no-verbose is not
"more quiet". It is "cancel all previous -v". The right way to spell
that is "--quiet" (usually, see below).

> IIRC some commands use one integer variable to determine
> the amount of output, i.e. --verbose increases that variable, --quiet
> decreases it.
> What happens for example with
> 
>   git commit -v --no-verbose -v -q -q --no-quiet
> 
> In case of commit, the quietness and verbosity is done in 2 variables,
> so these are orthogonal to each other, there are even no internal checks for
> (verbosity > 0 && quietness > 0) at the same time, so it seems to be a valid
> command.

Yes, I think in general, "-v" and "-q" should work as opposites. But
that is not the case with commit, where "-v" and "-q" operate on totally
separate messages. I think that is a UX mistake, and we would not do
it that way if designing from scratch. But we're stuck with it for
historical reasons (I'd probably name "--verbose" as "--show-diff" or
something if writing it today).

Arguably cmd_commit() should be using OPT_BOOL instead of OPT__VERBOSE,
as there is no such thing as "verbose > 1" here. But I don't think there
is any real user-facing consequence of that (however, given Eric's
suggestion, I suspect it would make Pranit's problem just go away, as it
assigns rather than increments; IOW, it does the thing Eric was
suggestion OPT__VERBOSE to do).

> In case of a command where this is tracked in one variable,
> 
>   git <foo> -v --no-verbose -v -q -q --no-quiet
> 
> you'd expect:
> 
>   verbosity++ // because of first -v
>   verbosity = 0 // because of the reset with --no-verbose
>   verbosity++ // because of second -v
>   verbosity-- // because of first -q
>   verbosity-- // because of second -q
>   verbosity = 0 // because of the reset with --no-quiet
> 
> Having typed that, I think my comment was not adding value to
> the discussion, as --no-{verbose/quiet} would just reset it to 0 no matter
> if you track verbosity/quietness in one or two variables internally.

Right, in a command using OPT_VERBOSITY(), that is how it should (and
does) work. I think "commit" is just funny for historical reasons.

-Peff
