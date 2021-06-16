Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C0DC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D6761166
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 16:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhFPQZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:25:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:57718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhFPQY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 12:24:57 -0400
Received: (qmail 13511 invoked by uid 109); 16 Jun 2021 16:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 16:22:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28305 invoked by uid 111); 16 Jun 2021 16:22:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 12:22:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 12:22:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>
Subject: Re: [PATCH 5/5] serve: add support for a git_config() callback
Message-ID: <YMolS8iJAMgbbg9D@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <patch-5.5-c8625025125-20210616T141332Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.5-c8625025125-20210616T141332Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 04:16:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Since the introduction of serve.c we've added git_config() callbacks
> and other config reading for capabilities in the following commits:
> 
> - e20b4192a37 (upload-pack: support hidden refs with protocol v2, 2018-12-18)
> - 59e1205d167 (ls-refs: report unborn targets of symrefs, 2021-02-05)
> - 6b5b6e422ee (serve: advertise session ID in v2 capabilities, 2020-11-11)
> 
> This code can be simplified by simply adding support to serve.c itself
> for reading config at the right time before the capability is
> called. In particular the ensure_config_read() function being gone
> makes this whole thing much simpler.
> 
> A behavior change here is that we're eagerly doing the configuration
> for all our capabilities regardless of which one we end up serving,
> whereas before we'd defer it until the point where we were processing
> the specific command.

Hmm. I like simplifying things, but what's the plan for when we have a
v2 receive-pack? We'll need different config based on whether we're
serving a fetch or a push.

While working on e20b4192a37, I had originally proposed patches that
would pass that context into the serve mechanism (based on whether we
were called by upload-pack or receive-pack). But the review there
indicated that v2 receive-pack would probably involve an extra
capability argument passed by the client to ls-refs.

So we'd eventually need to parse config _after_ we've received the
actual ls-refs command. To be clear, this patch isn't breaking anything
now. But I think it's painting us into a corner that we'll regret later.

Of course there are ways around this. E.g., we could read config for
both operations ahead of time, and then decide which to use later. But
that definitely isn't how it works now, and we'd have to refactor the
whole ref_is_hidden() system to fix that. Definitely do-able, but given
the relatively limited upside of this patch, I'm not sure if it's worth
it.

I'd also note that this patch doesn't touch upload_pack_v2() at all,
which also reads config. That one is extra-weird because it reads the
config fresh for every round of interaction with the client, and then
cleans it up. Which led to fixes like the one in 08450ef791
(upload-pack: clear filter_options for each v2 fetch command,
2020-05-08).

Doing a single config read would probably make that simpler. But the
config setup is shared between the v0 and v2 functions, so extracting it
into serve() would potentially be awkward.

> In particular the ensure_config_read() function being gone
> makes this whole thing much simpler.

I do agree this is awkward. The two calls for that function seem to come
from the "should we advertise ls-refs" and "actually do ls-refs"
functions. Should we be able to assume that the former ran if we are in
the latter? I'm not sure if that's true or not (i.e., because it's
rare but possible for a client to make two separate HTTP requests, one
to discover our v2 capabilities and another to actually issue ls-refs).

-Peff
