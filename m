Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E95C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0B611C3
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhI0Xfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:35:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:55900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbhI0Xfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:35:50 -0400
Received: (qmail 7868 invoked by uid 109); 27 Sep 2021 23:34:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 23:34:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22069 invoked by uid 111); 27 Sep 2021 23:34:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 19:34:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 19:34:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/5] submodule-config.h: remove unused SUBMODULE_INIT
 macro
Message-ID: <YVJU89iekC0zZSkF@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
 <patch-v2-1.5-7a7a0141515-20210927T124407Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.5-7a7a0141515-20210927T124407Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 02:54:24PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This macro was added and used in c68f8375760 (implement fetching of
> moved submodules, 2017-10-16) but its last user went away in
> be76c212823 (fetch: ensure submodule objects fetched, 2018-12-06).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  submodule-config.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/submodule-config.h b/submodule-config.h
> index c11e22cf509..65875b94ea5 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -45,10 +45,6 @@ struct submodule {
>  	struct object_id gitmodules_oid;
>  	int recommend_shallow;
>  };
> -
> -#define SUBMODULE_INIT { NULL, NULL, NULL, RECURSE_SUBMODULES_NONE, \
> -	NULL, NULL, SUBMODULE_UPDATE_STRATEGY_INIT, { { 0 } }, -1 };

I was a bit surprised by this one, just because we generally prefer the
builtin initializers to init functions. And even if we are only using
the latter, I like the move to implementing it in terms of the former.

But this struct is extra funny, as now it will have neither. It comes
only from submodule_from_name() or submodule_from_path(), which in turn
are building up from config and the initialization in
lookup_or_create_by_name(). And keeping those two in sync is potentially
error-prone.

So this whole "make a submodule struct on the stack" thing is pretty odd
in the first place, and I'm happy to see this initializer going away.

-Peff
