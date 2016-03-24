From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/GSoC] parse-options: Add a new nousage opt
Date: Thu, 24 Mar 2016 13:34:27 -0400
Message-ID: <20160324173427.GC6341@sigill.intra.peff.net>
References: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
 <20160323223157.GA12531@sigill.intra.peff.net>
 <CAJj6+1EYYiK3qjOpZLBZG1d0FfW2r67759dCcLjxEy=+vFN0Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:34:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj99X-0001iN-8y
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbcCXReb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:34:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:37617 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750828AbcCXRea (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:34:30 -0400
Received: (qmail 14751 invoked by uid 102); 24 Mar 2016 17:34:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 13:34:29 -0400
Received: (qmail 14899 invoked by uid 107); 24 Mar 2016 17:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 13:34:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 13:34:27 -0400
Content-Disposition: inline
In-Reply-To: <CAJj6+1EYYiK3qjOpZLBZG1d0FfW2r67759dCcLjxEy=+vFN0Dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289768>

On Thu, Mar 24, 2016 at 10:51:05PM +0530, Chirayu Desai wrote:

> I definitely want to work with Git in the future too, it has always
> piqued my interest being something that I use daily.
> I want to get this change done as well, if that is okay.

Sure, that's great. Part of the point of microprojects is that they're
useful changes on their own, outside of GSoC.

> >> diff --git a/parse-options.c b/parse-options.c
> >> index 47a9192060..d136c1afd0 100644
> >> --- a/parse-options.c
> >> +++ b/parse-options.c
> >> @@ -158,6 +158,9 @@ static int get_value(struct parse_opt_ctx_t *p,
> >>                       return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
> >>               if (get_arg(p, opt, flags, &arg))
> >>                       return -1;
> >> +             if (opt->flags & PARSE_OPT_NOUSAGE) {
> >> +                     return (*opt->callback)(opt, arg, 0);
> >> +             }
> >>               return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
> >
> > Here you use PARSE_OPT_NOUSAGE to pass the callback's value directly
> > back to the rest of the option-parsing code. But can't we just intercept
> > "-3" always? It's possible that another callback is using it to
> > generically return an error, but it seems like a rather low risk, and
> > the resulting code is much simpler.
> I don't get what you mean by intercepting '-3'.
> The idea was that other options could use it in the future to return
> arbitary values.

I mean could this code just be:

  switch (opt->callback(opt, arg, 0)) {
  case 0: /* ok, no error */
	return 0;
  case -3: /* error, but we were asked not to show usage; relay it */
	return -3;
  default: /* anything else is a normal error */
	return -1;
  }

Do we need PARSE_OPT_NOUSAGE at all?

> > Or we could go the opposite direction. If a callback is annotated with
> > PARSE_OPT_NOUSAGE, why do we even need to care about its return value?
> > The callback could continue to return -1, and we would simply suppress
> > the usage message.
> That would also work, but I feel that this is cleaner.

Yeah, I think it comes down to where the decision for "don't show usage"
should be made. Is it something that the options-list (that is using the
callback) knows, or is it something that the callback knows?

> >>       case OPTION_INTEGER:
> >> @@ -504,6 +507,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
> >>                       goto show_usage_error;
> >>               case -2:
> >>                       goto unknown;
> >> +             case -3:
> >> +                     return PARSE_OPT_DONE;
> >>               }
> >>               continue;
> >>  unknown:
> >
> > If I understand correctly, this is now getting the value from the
> > callback directly. What happens if a callback returns "-4" or "4"?
> That could be handled in the future if somebody decides to use that.
> Now this makes using the above "return -1 always but don't print usage if flags
> contain PARSE_OPT_NOUSAGE" option look much better.

What I meant specifically was that I think a callback returning "-4" is
an error (with usage) in the current code, but is silently ignored with
your patch (if PARSE_OPT_NOUSAGE is set, of course), making it a
potential hazard.

> > Also, this covers the parse_long_opt() call, but there are two
> > parse_short_opt() calls earlier. Wouldn't they need to learn the same
> > logic?
> I didn't add it right now as both "--contains" and "--with" are long opts.

Yeah, I agree it is not necessary for those long opts, but it seems like
a maintenance hazard for it to work in one case, but not another. IOW,
it would be a big surprise for somebody who later adds a short option
for "--contains", or who adds PARSE_OPT_NOUSAGE to an existing short
option.

-Peff
