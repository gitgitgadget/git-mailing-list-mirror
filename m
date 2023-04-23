Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4415C77B76
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjDWAhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 20:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjDWAhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 20:37:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34226B5
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 17:37:17 -0700 (PDT)
Received: (qmail 22301 invoked by uid 109); 23 Apr 2023 00:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 23 Apr 2023 00:37:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6934 invoked by uid 111); 23 Apr 2023 00:37:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 20:37:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 20:37:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230423003715.GB3953216@coredump.intra.peff.net>
References: <20230422135001.GA3942563@coredump.intra.peff.net>
 <7f48188b-2e06-9f01-de8d-a24812fb20fe@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f48188b-2e06-9f01-de8d-a24812fb20fe@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 05:53:10PM +0200, René Scharfe wrote:

> Am 22.04.23 um 15:50 schrieb Jeff King:
> > diff --git a/commit.c b/commit.c
> > index ede810ac1c..56877322d3 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -120,6 +120,16 @@ static timestamp_t parse_commit_date(const char *buf, const char *tail)
> >  	if (dateptr == buf || dateptr == eol)
> >  		return 0;
> >
> > +	/*
> > +	 * trim leading whitespace; parse_timestamp() will do this itself, but
> > +	 * it will walk past the newline at eol while doing so. So we insist
> > +	 * that there is at least one digit here.
> > +	 */
> > +	while (dateptr < eol && isspace(*dateptr))
> > +		dateptr++;
> > +	if (!strchr("0123456789", *dateptr))
> 
> You could use (our own) isdigit() here instead.  It's more concise and
> efficient.

Heh, yes, that is much better. I had strspn() on the mind since that is
what split_ident_line() uses.

I think it could even just be:

  if (dateptr != eol)

which implies that we found some non-whitespace character, and then we
rely on parse_timestamp() to return 0 (which is what the current code is
effectively doing).

-Peff
