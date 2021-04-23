Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C86C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5EB6145A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhDWJ2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:28:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:33120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241760AbhDWJ2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:28:20 -0400
Received: (qmail 6001 invoked by uid 109); 23 Apr 2021 09:27:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 09:27:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6445 invoked by uid 111); 23 Apr 2021 09:27:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 05:27:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 05:27:42 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <YIKTDjOX3WtBjqAq@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
 <20210416211451.GP2947267@szeder.dev>
 <YHqf9zjSzpYl7IAW@coredump.intra.peff.net>
 <xmqq7dl0d23g.fsf@gitster.g>
 <YHvGE5/LRPN9obZi@coredump.intra.peff.net>
 <YH1jnIhuF4UjXVNW@tanuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YH1jnIhuF4UjXVNW@tanuki>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 01:03:56PM +0200, Patrick Steinhardt wrote:

> It's only by accident that I dropped the call to `git_config_system()`,
> must've happened when resolving conflicts somewhere. The issue with just
> returning `/dev/null` from `git_system_config()` is that git-config(1)
> would be broken, as you hint at. We do not honor GIT_CONFIG_NOSYSTEM
> there if the "--system" flag was given.
> 
> So yes, we could change it to return `/dev/null`, but that would change
> semantics of GIT_CONFIG_NOSYSTEM. I'm not sure doing this in the same
> series is a good idea. Even more so because with returning `/dev/null`,
> the conversion would be silent: whereas previous versions simply wrote
> to or read from the system-level config, we now pretend to have read or
> written something even though we didn't.

I'm OK being more cautious here, and leaving NOSYSTEM as it is.

My original thinking was that returning /dev/null would be an
improvement even for the existing call in "git config --system". And I
do think it would be for reading. But it actually gets pretty weird for
writing, because of our atomic-rename strategy.

And that is actually true of your new variable too. Doing this:

  GIT_CONFIG_SYSTEM=/dev/null git config --system foo.bar

would return nothing, which makes sense to me. But this:

  GIT_CONFIG_SYSTEM=/dev/null git config --system foo.bar value

would try to write /dev/null.lock, and then rename it into place over
the real /dev/null! That may be slightly surprising, but it is not
really any different than any other non-regular-file entry.

The stakes are slightly higher here, as it breaks all sorts of things
that can be hard to recover from (even if you know the correct mknod
incantation, important things like bash seem to get crabby if they can't
open /dev/null for writing). And it may be more likely to happen by
mistake (as opposed to "git config --file=/dev/null", which behaves the
same). But unless you are root, you are likely to just get an error in
the first place, so it seems like an unlikely mistake in practice.

So I think it may fall into "if it hurts, don't do it".

-Peff
