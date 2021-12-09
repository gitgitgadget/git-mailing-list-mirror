Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D2FC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhLIVIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:08:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53603 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhLIVIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:08:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97E9FF4E89;
        Thu,  9 Dec 2021 16:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ApyQRjRcMvUN8UEum/vq8POiN3guRChJ8XmQG8+AjjI=; b=RKHL
        tqJPEv3garILvLJT7k1hI6NnpKfQYtInF26JI3lILeiaAdN7/LrS1x5Ms9NYJAH8
        9uc7Ir2rkk0wRx3zLPfC76dZxhTI5O+s2CjOk32MBKCuOANfWwoqkBPhiwTsZRo2
        QymzI/bDGjHQzc3mLoRurwlCIH6T7M6RllrHRbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E25FF4E88;
        Thu,  9 Dec 2021 16:04:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EEBF3F4E86;
        Thu,  9 Dec 2021 16:04:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 01/14] rebase: factor out checkout for up to date branch
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <0e84d00572ed9a99d68ec856b779f550b2a934de.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 13:04:32 -0800
Message-ID: <xmqqk0gdpk0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C2B9F64-5933-11EC-94A9-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This code is heavily indented and it will be convenient later in the
> series to have it in its own function.

Looks good in the sense that it is straight code movement without
changing any behaviour that won't hurt.

Without a clear overall direction given in the cover letter, however,
it is hard to judge if "being convenient later in the series" is a
good thing in the first place, though.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 34b4744e5f3..f5c37b7d4a5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -812,6 +812,23 @@ static int rebase_config(const char *var, const char *value, void *data)
>  	return git_default_config(var, value, data);
>  }
>  
> +static int checkout_up_to_date(struct rebase_options *options)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret = 0;
> +
> +	strbuf_addf(&buf, "%s: checkout %s",
> +		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
> +		    options->switch_to);
> +	if (reset_head(the_repository, &options->orig_head, "checkout",
> +		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> +		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
> +		ret = error(_("could not switch to %s"), options->switch_to);
> +	strbuf_release(&buf);
> +
> +	return ret;
> +}
> +
>  /*
>   * Determines whether the commits in from..to are linear, i.e. contain
>   * no merge commits. This function *expects* `from` to be an ancestor of
> @@ -1673,21 +1690,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (!(options.flags & REBASE_FORCE)) {
>  			/* Lazily switch to the target branch if needed... */
>  			if (options.switch_to) {
> -				strbuf_reset(&buf);
> -				strbuf_addf(&buf, "%s: checkout %s",
> -					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
> -					    options.switch_to);
> -				if (reset_head(the_repository,
> -					       &options.orig_head, "checkout",
> -					       options.head_name,
> -					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> -					       NULL, buf.buf,
> -					       DEFAULT_REFLOG_ACTION) < 0) {
> -					ret = error(_("could not switch to "
> -							"%s"),
> -						      options.switch_to);
> +				ret = checkout_up_to_date(&options);
> +				if (ret)
>  					goto cleanup;
> -				}
>  			}
>  
>  			if (!(options.flags & REBASE_NO_QUIET))
