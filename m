Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFA61413
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhGAQcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:32:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhGAQcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:32:35 -0400
Received: (qmail 28308 invoked by uid 109); 1 Jul 2021 16:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17419 invoked by uid 111); 1 Jul 2021 16:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] serve.c: add trace2 regions for advertise &
 command
Message-ID: <YN3tjEE8Ir7Zuvkq@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.8-baeee6539ad-20210628T191634Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 09:19:23PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Now that we've factored out "call_{advertise,command}()" in a
> preceding commit it becomes easy to trace all these callbacks with
> trace2. Let's do that. As the tests demonstrate there's no v2 push
> protocol, which the tests assert.

Seems reasonable. I haven't ever wanted these myself, but it seems like
a natural spot to mention when debugging server-side actions (especially
because we may get multiple rounds of "fetch" for a single upload-pack
invocation).

> diff --git a/serve.c b/serve.c
> index 85cd3eab26e..6dbd05248b9 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -111,14 +111,34 @@ static struct protocol_capability capabilities[] = {
>  static int call_advertise(struct protocol_capability *command,
>  			  struct repository *r, struct strbuf *value)
>  {
> -	return command->advertise(r, value);
> +	int ret;
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *msg;
> +
> +	strbuf_addf(&sb, "advertise/%s", command->name);
> +	trace2_region_enter("serve", sb.buf, r);
> +	ret = command->advertise(r, value);
> +	msg = ret ? "advertised" : "hidden";
> +	trace2_region_leave_printf("serve", sb.buf, r, "%s", msg);
> +	strbuf_release(&sb);

We'll do these allocations even if trace2 isn't enabled. I guess that's
probably not that big a deal in practice. I think:

  if (trace2_is_enabled())
	strbuf_addf(&sb, "advertise/%s", command->name);

would work (everything else is cheap and handles the unallocated state
fine), but it might not be worth the readability hit (and it's probably
premature optimization anyway).

-Peff
