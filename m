Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E8DC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C265610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDIUFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 16:05:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:47058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234298AbhDIUFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 16:05:42 -0400
Received: (qmail 1948 invoked by uid 109); 9 Apr 2021 20:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 20:05:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16388 invoked by uid 111); 9 Apr 2021 20:05:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 16:05:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 16:05:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
Message-ID: <YHCzhcBkqdeEMrWA@coredump.intra.peff.net>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
 <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
 <xmqqa6q8tymu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6q8tymu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 11:33:13AM -0700, Junio C Hamano wrote:

> > +/**
> > + * Same as `git_parse_maybe_bool`, except that "auto" is recognized and
> > + * will return "2".
> > + */
> > +int git_parse_maybe_tristate(const char *);
> 
> A false being 0 and a true being 1 is understandable for readers
> without symbolic constant, but "2" deserves to have a symbolic
> constant, doesn't it?

I had the same thought.

This "tristate" really has four outcomes: true, false, auto, or error.
Since the caller has to then check for error or for "auto" themselves,
it feels like it is not actually making their lives any easier. I.e.,
without it:

  if (value && !strcmp(value, "auto"))
	do_auto();
  else {
	int b = git_parse_maybe_bool(value);
	if (b < 0)
		do_error();
	else if (b)
		do_true();
	else
		do_false();
  }

but with it:

  b = git_parse_maybe_tristate(value);
  if (b < 0)
        do_error();
  else if (b == 2)
        do_auto();
  else if (b)
        do_true();
  else
        do_false();

which is the same thing, swapping string comparison for a numeric one.

And a caller of git-config has the same thing: it still has to check for
"auto" in the output it gets (which it could just do via bool-or-str).

It seems like it would be more convenient if you could pass it a bool
value to turn the "auto" into. E.g., if you could do:

  b = git_parse_maybe_tristate(value, 1); /* default to "1" */
  if (b < 0)
          do_error();
  if (b)
          do_true(); /* true, or maybe "auto" */
  else
          do_false();

I dunno. That would probably be hard to represent via "git config
--type". And some callers probably do care about "auto" versus "true".

It also feels funny calling this "tristate". Aren't there other
tristates we could have besides "auto"? The command-line option is
bool-or-auto, which is descriptive. Should this use a similar name?

-Peff
