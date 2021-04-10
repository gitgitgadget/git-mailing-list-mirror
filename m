Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D803CC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30AA610E5
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhDJBXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235410AbhDJBXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:23:31 -0400
Received: (qmail 4671 invoked by uid 109); 10 Apr 2021 01:23:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 Apr 2021 01:23:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18622 invoked by uid 111); 10 Apr 2021 01:23:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 21:23:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 21:23:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
Message-ID: <YHD+BMo35krbH9rx@coredump.intra.peff.net>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
 <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
 <xmqqa6q8tymu.fsf@gitster.g>
 <YHCzhcBkqdeEMrWA@coredump.intra.peff.net>
 <xmqqv98vm7lt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv98vm7lt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 03:11:10PM -0700, Junio C Hamano wrote:

> > I dunno. That would probably be hard to represent via "git config
> > --type". And some callers probably do care about "auto" versus "true".
> 
> It would work well for codepaths where computing the default value
> is cheap (or even possible).
> 
> I think the point of using "auto" is to delay the decision as late
> as possible.  E.g. in-core parsed config and attribute may still
> want to stay "auto", until we actually get our hands on the blob
> contents to see if it is binary, until we know how heavily loaded
> the system is, until we know isatty(1), etc.  Some are cheap to
> compute in advance, some are expensive and impossible until we meet
> the data.

Hmm, yeah, that's the "do care about auto versus true" thing.

> So I still think the canonical use pattern for the "auto" thing is
> 
> 	is_frotz = git_parse_bool_or_auto(value);
> 
> 	... arbitrary number of things can happen here
> 	... the above may even be done in a git_config()
> 	... callback, and is_frotz may not even be used.
> 
> 	if (is_frotz == AUTO)
> 		is_frotz = auto_detect_frotz();
> 
> 	if (is_frotz)
> 		...; /* do the frotz thing */
> 	else
> 		...; /* do the non-frotz thing */

That makes sense. Usually we represent "undecided" in such a tristate
with -1, so something that returned -1/0/1 would feel very natural to me
(and probably wouldn't need symbolic constants even). But -1 is also
error.

So a function like:

  int git_parse_tristate(const char *value, int *out);

which returned success/error via its return value, and put the value
into "out" would feel pretty natural to me.

I dunno. I admit I don't care _that_ much, but somehow Ævar's series
have a way of sniping me into responding anyway. :)

-Peff
