Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB4D1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbdL1Vdv (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:33:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751008AbdL1Vdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:33:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56D6BCC08F;
        Thu, 28 Dec 2017 16:33:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GYe7kXaMV55ZdVutztRS2YuauTI=; b=eGp5An
        Xmf+Q6AO5wxF2ApMBS34LZqVfJb0S/UwD4gOaVAACqhCCKC3L2i6fLtELXm8M9aU
        AYsIKx1rCv9qpvThrQkyDic1D55K+tNvKG8QMhWhoC3gJ9O2wi7tHUsdrEJSHHA0
        QWeBy1CFMyRd1AkckkBaMC2DAGxmQPa8kX6VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SkzL2nWuUlXwCnunHfpg8gMsGp20k8Wg
        riuhhFKrHhSaXHHsZMloNqo2AG+gzCoWBiDxpWj2qU1NuUlmGkv3AIIwoHGLYWEC
        8o9+GfInLfO8f4ihndrqUDdKG+pHuzaIW3yuKSeGYegmPP9lfZjgg7KvgwLQ4JAN
        iEmW/43MPtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DE96CC08E;
        Thu, 28 Dec 2017 16:33:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0507CC08D;
        Thu, 28 Dec 2017 16:33:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 1/1] diffcore: add a pickaxe option to find a specific blob
References: <20171228000003.34539-1-sbeller@google.com>
        <20171228000003.34539-2-sbeller@google.com>
Date:   Thu, 28 Dec 2017 13:33:47 -0800
In-Reply-To: <20171228000003.34539-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 27 Dec 2017 16:00:03 -0800")
Message-ID: <xmqqy3lmill0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA722FD4-EC16-11E7-A020-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static int parse_objfind_opt(struct diff_options *opt, const char *arg)
> +{
> +	struct object_id oid;
> +
> +	if (get_oid(arg, &oid))
> +		return error("unable to resolve '%s'", arg);
> +
> +	if (!opt->objfind)
> +		opt->objfind = xcalloc(1, sizeof(*opt->objfind));
> +
> +	opt->pickaxe = ""; /* trigger pickaxe */

Hmmm.  This feels like an ugly hack to me.  Do we declare that "git
log -S''" never matches anything right now (if that is the case the
I do not think there is any compatibility issues)?

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 9476bd2108..0d0c697ae7 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -124,13 +124,21 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>  	mmfile_t mf1, mf2;
>  	int ret;
>  
> -	if (!o->pickaxe[0])
> -		return 0;
> -
>  	/* ignore unmerged */
>  	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
>  		return 0;
>  
> +	if (o->objfind) {
> +		if ((DIFF_FILE_VALID(p->one) &&
> +		     oidset_contains(o->objfind, &p->one->oid)) ||
> +		    (DIFF_FILE_VALID(p->two) &&
> +		     oidset_contains(o->objfind, &p->two->oid)))
> +			return 1;
> +	}
> +
> +	if (!o->pickaxe[0])
> +		return 0;
> +

Very nice.  With just one place, the code covers both cases with and
without pickaxe-all option in effect.

