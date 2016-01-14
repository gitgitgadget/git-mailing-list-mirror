From: Jeff King <peff@peff.net>
Subject: Re: [PREVIEW v3 8/9] checkout-index: there are only two line
 terminators
Date: Thu, 14 Jan 2016 15:13:43 -0500
Message-ID: <20160114201342.GB1985@sigill.intra.peff.net>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-9-git-send-email-gitster@pobox.com>
 <20160114101830.GC30772@sigill.intra.peff.net>
 <xmqq8u3skrsd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJoHG-0008VL-5c
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbcANUNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:13:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:53894 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754112AbcANUNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:13:45 -0500
Received: (qmail 7665 invoked by uid 102); 14 Jan 2016 20:13:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:13:45 -0500
Received: (qmail 11132 invoked by uid 107); 14 Jan 2016 20:14:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:14:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 15:13:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8u3skrsd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284085>

On Thu, Jan 14, 2016 at 09:13:54AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I see that we switch the line termination on the fly in option_parse_z.
> > But I'm having trouble seeing how we could actually have mixed inputs.
> > We don't actually look at the line-terminator until after all of the
> > options are parsed.
> 
> I do not think we are aiming for mixed inputs.  What I meant by
> "mixed" in my description was a possible future option to allow
> input and output using different line termination (e.g. via "-Z"
> you would control output line termination, while "-z" only affects
> the input line termination).

Ah, I see.

> After this step, there is still one call that is more natural to
> have line_termination that is either '\0' or '\n' and that is on the
> output side, which calls write_name_quoted_relative() to report the
> names of the temporary files that received the file contents to the
> standard output.
> 
> Of course there is nothing wrong to do
> 
>         write_name_quoted_relative(name, prefix, stdout,
> 				   nul_term_lines ? '\0' : '\n');
> 
> though.
> 
> And I tend to think that it might even be a good idea to do so.  If
> somebody in the future really wants to introduce '-Z', then they can
> add a separate "output_line_termination" variable back (and it would
> likely be set to '\0' or '\n' via "-z" when "-Z" is not given), but
> until then, I agree that a simple bool for "-z" would be better.

Yeah, I agree with all of that.

> > I'm also not sure how "unset" would trigger here. If we have a long
> > option, we can use "--no-foo". But there isn't a long option for "-z".
> > Is there a way to negate short options?
> 
> I do not think there is.  It merely future-proofs against those who
> try to add "--nul" as a longer synonym.  They would complain after
> they add "--nul" in builtin_checkout_index_options[] as a synonym if
> they see "--no-nul" does not negate the effect of an earlier "-z".

Makes sense. Better still if we can turn it into OPT_BOOL, though, and
then it would Just Work. :)

-Peff
