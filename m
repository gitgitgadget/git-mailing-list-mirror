Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA60C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B926613D8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhGPVXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:23:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhGPVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:23:05 -0400
Received: (qmail 22119 invoked by uid 109); 16 Jul 2021 21:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 21:20:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14622 invoked by uid 111); 16 Jul 2021 21:20:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 17:20:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 17:20:09 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Message-ID: <YPH4Cf0OPni6sqql@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
 <07624f34-2c0d-d577-e4bc-ab8ebe146ffe@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07624f34-2c0d-d577-e4bc-ab8ebe146ffe@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 07:18:59AM +0200, Andrzej Hunt wrote:

> > I see a few possible solutions:
> >  [...]
> > I can't say I _love_ any of that, but I think it would work (and
> > probably we'd adapt our helpers like git_config_pathname() to take a
> > def_string. Or I guess just have a def_string_free() which can be called
> > before writing into them).
> 
> Is it worth sidestepping the whole globals issue by migrating core.hookspath
> (and other string config values) to be fetched via git_config_get_pathname()
> and equivalents at the point of use instead?

Yeah, I almost suggested that. It probably does work OK in this
instance, but it's a much bigger change to convert all cases.

I'm also not sure if you'd run into tricky details. For instance,
calling git_config_* is doing an expensive-ish lookup in the cached
config (well, expensive to accessing a single pointer). So in cases
where we're going to access the string many times (say, in a loop), we'd
want our own variable. That might end up being easy by calling it once
outside the loop. Or it might not be, for cases where the variable is
used under the hood by a helper function.

-Peff
