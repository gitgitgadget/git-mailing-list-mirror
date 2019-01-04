Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E461F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 07:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfADHuh (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 02:50:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:54434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726046AbfADHuh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 02:50:37 -0500
Received: (qmail 25608 invoked by uid 109); 4 Jan 2019 07:50:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 07:50:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15754 invoked by uid 111); 4 Jan 2019 07:50:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 02:50:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 02:50:35 -0500
Date:   Fri, 4 Jan 2019 02:50:35 -0500
From:   Jeff King <peff@peff.net>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] Add 'human' date format
Message-ID: <20190104075034.GA26014@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-2-ischis2@cox.net>
 <20190103073735.GB24925@sigill.intra.peff.net>
 <2637944.PqRbksyA0G@thunderbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2637944.PqRbksyA0G@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 06:19:56AM -0700, Stephen P. Smith wrote:

> On Thursday, January 3, 2019 12:37:35 AM MST Jeff King wrote:
> > I like the idea of "human", and I like the idea of "auto", but it seems
> > to me that these are really two orthogonal things. E.g., might some
> > people not want to do something like:
> > 
> >   git config log.date auto:relative
> I didn't see anything in the code which would prohibit setting something like 
> that.

Yeah, I don't think supporting that is too hard. I was thinking
something like this:

diff --git a/date.c b/date.c
index 4486c028ac..f731803872 100644
--- a/date.c
+++ b/date.c
@@ -883,11 +883,6 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
-static int auto_date_style(void)
-{
-	return (isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
-}
-
 static enum date_mode_type parse_date_type(const char *format, const char **end)
 {
 	if (skip_prefix(format, "relative", end))
@@ -907,8 +902,6 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_NORMAL;
 	if (skip_prefix(format, "human", end))
 		return DATE_HUMAN;
-	if (skip_prefix(format, "auto", end))
-		return auto_date_style();
 	if (skip_prefix(format, "raw", end))
 		return DATE_RAW;
 	if (skip_prefix(format, "unix", end))
@@ -923,6 +916,14 @@ void parse_date_format(const char *format, struct date_mode *mode)
 {
 	const char *p;
 
+	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
+	if (skip_prefix(format, "auto:", &p)) {
+		if (isatty(1) || pager_in_use())
+			format = p;
+		else
+			format = "default";
+	}
+
 	/* historical alias */
 	if (!strcmp(format, "local"))
 		format = "default-local";

That removes "auto" completely. We could still support it as an alias
for "auto:human" with something like:

  if (!strcmp(format, "auto"))
	format = "auto:human";

but IMHO it is a simpler interface to just have the user be explicit
(this is meant to be set once in config, after all).

> > I don't personally care about using this myself, but we already had to
> > deal with retrofitting "local" as a modifier. I'd prefer to avoid making
> > the same mistake again.
> Since I wasn't involved could you summarize the you are referring to?

The format "local" was a variant of "default" that would use the local
timezone instead of the author's. But there was no way to format, say,
iso8601 in the local timezone. So we had to invent a new syntax that was
compatible ("iso8601-local"), and keep "local" around forever for
backwards compatibility. Not the end of the world, but we can avoid it
in this case with a little preparation.

> > (I'd actually argue that "log.date" should basically _always_ have the
> > "auto" behavior, since it tends to get treated as plumbing anyway, and I
> > suspect that anybody who sets log.date now would see subtle breakage
> > from scripts. But maybe it's too late at this point?).
> If auto isn't added to the "log.date" file, then the date behaviour is not 
> changed from is currently in the code base.   Therefore, there shouldn't be 
> any breakage.

Right, this isn't a problem with your patches. I mean that the existing
"log.date" is arguably mis-designed, and we ought to have had something
like "auto" from day one (or even made it the default for log.date).

-Peff
