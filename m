Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF68C83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbjHaQ6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjHaQ6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 12:58:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA2BA3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:58:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C69D1A880C;
        Thu, 31 Aug 2023 12:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wGJBvxIvclQqP2dj23FIu5uv7oRBCCPoCpY33z
        ESOw0=; b=SrZBqjxSvcqPpWsY97wvnEoAZxt9HrZ6Ks6DvOhM/lxN4kT/KtzfLw
        ZYOylZtE/m8URyHwZ1iMxSZK8YSCmTHIYMEmE4bDniolWl99nJhmjAINyKCHPls9
        +bP5P3LiK+2nn2CZF7HX3fSveUAzhu80DgwsP34KL9lqNHIWKXr2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 055C71A880B;
        Thu, 31 Aug 2023 12:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B6381A880A;
        Thu, 31 Aug 2023 12:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 6/8] parse-options: add more BUG_ON() annotations
In-Reply-To: <20230831071900.GD3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:19:00 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071900.GD3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 09:58:38 -0700
Message-ID: <xmqq8r9rxi69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A205E818-481F-11EE-9215-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> These callbacks are similar to the ones touched by 517fe807d6 (assert
> NOARG/NONEG behavior of parse-options callbacks, 2018-11-05), but were
> either missed in that commit (the one in add.c) or were added later (the
> one in log.c).

They obviously look good.  Thanks.


>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/add.c | 2 ++
>  builtin/log.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 4b0dd798df..cf59108523 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -232,6 +232,8 @@ static char *chmod_arg;
>  
>  static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
>  {
> +	BUG_ON_OPT_ARG(arg);
> +
>  	/* if we are told to ignore, we are not adding removals */
>  	*(int *)opt->value = !unset ? 0 : 1;
>  	return 0;
> diff --git a/builtin/log.c b/builtin/log.c
> index 87e29c4171..80fa642858 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -121,6 +121,8 @@ static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
>  static int clear_decorations_callback(const struct option *opt UNUSED,
>  				      const char *arg, int unset)
>  {
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
>  	string_list_clear(&decorate_refs_include, 0);
>  	string_list_clear(&decorate_refs_exclude, 0);
>  	use_default_decoration_filter = 0;
