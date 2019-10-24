Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465A61F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 06:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408506AbfJXGGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 02:06:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65286 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404173AbfJXGGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 02:06:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D25CE19031;
        Thu, 24 Oct 2019 02:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gttqq+41VOnbfLOfzCI5Li90NZw=; b=aup7sg
        Fynm/a4ToHNudjkGdX03S/PQBb82vzDs3PdDT96olowtVFwOPAk+QWAQo0aS7G/w
        8D4dIkxSMnQ6ugWO6962ikKUQCCk2w2Kgn58164aRor7zSaigEPKdYXlHxwHr7R5
        Ww8eh7ANEMi3mmT3itwQ9S0UMmYzAZp9Lc/fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sXXMJN0C4V+U2NJ0wrLF5DL8E4hNwmv4
        S9GA+eD+g8sRtRXLXEYDucwZdg08QAZJUWeywjwJYyMs3WADf1p7gno7BZtY3/0J
        6V0l0a71dg0UBHBItZMv8sp0tJMWMMdVHTj1mhayUdIr9dQaHV4y40Gy26n2ijGS
        hRmpBbuW1jQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA12419030;
        Thu, 24 Oct 2019 02:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E5AB1902F;
        Thu, 24 Oct 2019 02:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/23] fsck: unify object-name code
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018045613.GI17879@sigill.intra.peff.net>
Date:   Thu, 24 Oct 2019 15:05:58 +0900
In-Reply-To: <20191018045613.GI17879@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:56:13 -0400")
Message-ID: <xmqq8spafzjt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5985CEC4-F624-11E9-957B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +/*
> + * Subsystem for storing human-readable names for each object.
> + *
> + * If fsck_enable_object_names() has not been called, all other functions are
> + * noops.

I think it is clear from the context that put_ and get_ we see below
refer to functions whose true names have fsck_ prefix, but the fact
that this one has fsck_ spelled out disrupts that context.

IOW, s/fsck_// for consistency, perhaps.

> + * Use put_object_name() to seed initial names (e.g. from refnames); the fsck
> + * code will extend that while walking trees, etc.
> + *
> + * Use get_object_name() to get a single name (or NULL if none). Or the more
> + * convenient describe_object(), which always produces an output string with
> + * the oid combined with the name (if any). Note that the return value points
> + * to a rotating array of static buffers, and may be invalidated by a
> + * subsequent call.
> + */
> +void fsck_enable_object_names(struct fsck_options *options);
> +const char *fsck_get_object_name(struct fsck_options *options,
> +				 struct object *obj);
> +__attribute__((format (printf,3,4)))
> +void fsck_put_object_name(struct fsck_options *options, struct object *obj,
> +			  const char *fmt, ...);
> +const char *fsck_describe_object(struct fsck_options *options,
> +				 struct object *obj);
> +
>  #endif
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 50d28e6fdb..7c7ff7e961 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -616,7 +616,7 @@ test_expect_success 'fsck --name-objects' '
>  		remove_object $(git rev-parse julius:caesar.t) &&
>  		test_must_fail git fsck --name-objects >out &&
>  		tree=$(git rev-parse --verify julius:) &&
> -		test_i18ngrep -E "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
> +		test_i18ngrep "$tree (refs/tags/julius:" out
>  	)
>  '
