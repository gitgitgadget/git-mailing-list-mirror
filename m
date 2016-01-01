From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/14] strutil: add skip_prefix_icase
Date: Fri, 1 Jan 2016 03:50:46 -0500
Message-ID: <20160101085045.GC20715@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229072204.GC8842@sigill.intra.peff.net>
 <CAPig+cTF_HF-xoiV2osEi6RnGBKQTmkvmUcUn1GbYHVP15_hDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 01 09:50:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEvQD-0003Y8-07
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 09:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbcAAIut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 03:50:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:47628 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751280AbcAAIus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 03:50:48 -0500
Received: (qmail 13813 invoked by uid 102); 1 Jan 2016 08:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:50:48 -0500
Received: (qmail 14866 invoked by uid 107); 1 Jan 2016 08:51:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jan 2016 03:51:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jan 2016 03:50:46 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTF_HF-xoiV2osEi6RnGBKQTmkvmUcUn1GbYHVP15_hDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283250>

On Thu, Dec 31, 2015 at 01:40:46AM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -677,10 +677,10 @@ static void add_header(const char *value)
> > -       if (!strncasecmp(value, "to: ", 4))
> > -               item = string_list_append(&extra_to, value + 4);
> > -       else if (!strncasecmp(value, "cc: ", 4))
> > -               item = string_list_append(&extra_cc, value + 4);
> > +       if (skip_prefix_icase(value, "to: ", &value))
> > +               item = string_list_append(&extra_to, value);
> > +       else if (skip_prefix_icase(value, "cc: ", &value))
> > +               item = string_list_append(&extra_cc, value);
> 
> Is it worth holding this patch, with its introduction of
> skip_prefix_icase(), hostage to the unrelated change in the previous
> patch (2/14) which touches the same bit of code? Would it make sense
> to split this change out?

I assumed that this was at least as contentious as 2/14, so it wouldn't
be a problem. I'm inclined to leave it, unless it looks like we'll scrap
2/14.

> > +static inline int skip_prefix_icase(const char *str, const char *prefix,
> > +                                   const char **out)
> > +{
> > +       do {
> > +               if (!*prefix) {
> > +                       *out = str;
> > +                       return 1;
> > +               }
> > +       } while (tolower(*str++) == tolower(*prefix++));
> 
> I wondered initially if we should be concerned about invoking
> tolower() with an expression with side-effects since some older and/or
> non-compliant libraries implement it as a macro which doesn't ensure
> that the argument is evaluated only once. However, it seems that Git
> already uses tolower(*p++) in a few other places, so I guess we're not
> worrying about those broken implementations.

Right. There are a few other gotchas with tolower(), and we work around
it by implementing the ctype functions ourselves (even on non-broken
platforms). It's one of the oldest bits of git-compat-util.h.

-Peff
