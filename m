Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C13FC83F2E
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbjHaQdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjHaQdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 12:33:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64ACD6
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:33:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B756A191248;
        Thu, 31 Aug 2023 12:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9A2mFhX4OfcLwiAlAt0mVHEkYjly8E1SttZJXd
        /jiDk=; b=WtRIWOFUCjW/rbzMk49KwLIAaSqdvjKyTkGpv99/jWzNhMluCM1PaT
        DQrpiAe5rKV48WMsnF/59JMBxtAx7G+dWs3Divzt9NOSUEIh4IwdWunS6VI9Cc1w
        M1e1mseGk+XK//j4GLrSeVr+lfHy9ICIGXwz6jIWJ+qB+rMIghLGQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AED26191247;
        Thu, 31 Aug 2023 12:33:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C340191246;
        Thu, 31 Aug 2023 12:33:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 4/8] parse-options: mark unused "opt" parameter in
 callbacks
In-Reply-To: <20230831071820.GB3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:18:20 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071820.GB3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 09:33:22 -0700
Message-ID: <xmqqil8vxjcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AC81F72-481C-11EE-8D8D-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index f62f13f2b5..95b3717dd1 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -190,7 +190,7 @@ static const char * const builtin_checkout_index_usage[] = {
>  	NULL
>  };
>  
> -static int option_parse_stage(const struct option *opt,
> +static int option_parse_stage(const struct option *opt UNUSED,
>  			      const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);

I suspect that the original is buggy; when given

  $ git checkout-index --stage=all --stage=1 path

the first option turns --temp on, but the second one does not turn
it off.  For now I think being bug-to-bug compatible and annotating
the opt as UNUSED is good, but as a follow-up, we could make the
caller:

 (1) point &checkout_stage with opt->value;

 (2) make to_tempfile to tristate <unspecified, false, true> by
     initializing it to -1;

 (3) adjust to_tempfile that is still <unspecified> after
     parse_options() returns, according to the value in
     checkout_stage.

and then this can follow the "opt->value points at the variable that
is affected" pattern.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8f93529505..cd2afe33e5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -168,7 +168,8 @@ static int git_fetch_config(const char *k, const char *v,
>  	return git_default_config(k, v, ctx, cb);
>  }
>  
> -static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
> +static int parse_refmap_arg(const struct option *opt UNUSED,
> +			    const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);

Can't this just point opt->value at the global &refmap?  Obviously
not a huge deal, as we could have taken the "annotate as UNUSED"
approach for all the functions in [3/8].

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 369bd43fb2..b842349d86 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1403,7 +1403,7 @@ static void initialize_task_config(int schedule)
>  	strbuf_release(&config_name);
>  }
>  
> -static int task_option_parse(const struct option *opt,
> +static int task_option_parse(const struct option *opt UNUSED,
>  			     const char *arg, int unset)
>  {
>  	int i, num_selected = 0;

The TASK__COUNT constant is very closely tied to the task[] array
and it is not worth passing the address of the array in opt->value.
The loss of clarity inside the callback funtion is a more serious
downside than the value on the caller side to document what array
is being modified.  So I agree this is a good change.

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index aee3cb8cbd..59acae3336 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -856,7 +856,7 @@ static int chmod_callback(const struct option *opt,
>  	return 0;
>  }
>  
> -static int resolve_undo_clear_callback(const struct option *opt,
> +static int resolve_undo_clear_callback(const struct option *opt UNUSED,
>  				const char *arg, int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> @@ -890,7 +890,7 @@ static int parse_new_style_cacheinfo(const char *arg,
>  }
>  
>  static enum parse_opt_result cacheinfo_callback(
> -	struct parse_opt_ctx_t *ctx, const struct option *opt,
> +	struct parse_opt_ctx_t *ctx, const struct option *opt UNUSED,
>  	const char *arg, int unset)
>  {
>  	struct object_id oid;

These two refuses to take "arg" and the callback mechanism is used
purely to trigger the side effect of the function, not as a part of
parsing something for its "value", so I agree that these UNUSED
annotations reflect the reality very well.

Thanks.

