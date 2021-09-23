Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4CC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FD60FE6
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhIWVWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:22:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62869 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbhIWVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:22:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B042D1609A8;
        Thu, 23 Sep 2021 17:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MasJSzb5ZfhEHx15oT6RdO3Oh/4C6+nF0BnkXl
        2ihH4=; b=tycvg0lcpsw6KXTWbsg39QV9hMmHkK8w2VIs4NJnJ82L0O85qUO4ht
        eXa3ufwMeijmtHtR2xuwP63SVXsChIk8oYeBiMhCzYz1lvgsPIg6fnn0gXIOVzJb
        dbqZ7AS41RGkhqPM5OazDu/dTfJwpdrVFFGHV5iKIgHtabwlCq6q4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8CA11609A7;
        Thu, 23 Sep 2021 17:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9B981609A6;
        Thu, 23 Sep 2021 17:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
Date:   Thu, 23 Sep 2021 14:20:28 -0700
In-Reply-To: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com> (Andrzej
        Hunt via GitGitGadget's message of "Sat, 18 Sep 2021 13:14:32 +0000")
Message-ID: <xmqq4kabyoo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 142B8202-1CB4-11EC-93B0-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/connect.c b/connect.c
> index aff13a270e6..eaf7d6d2618 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -557,6 +557,8 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
>  			if (!*value || isspace(*value)) {
>  				if (lenp)
>  					*lenp = 0;
> +				if (offset)
> +					*offset = found + len - feature_list;
>  				return value;
>  			}
>  			/* feature with a value (e.g., "agent=git/1.2.3") */
> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> index 5c941949b98..34538cebf01 100755
> --- a/t/t5704-protocol-violations.sh
> +++ b/t/t5704-protocol-violations.sh
> @@ -32,4 +32,17 @@ test_expect_success 'extra delim packet in v2 fetch args' '
>  	test_i18ngrep "expected flush after fetch arguments" err
>  '
>  
> +test_expect_success 'bogus symref in v0 capabilities' '
> +	test_commit foo &&
> +	oid=$(git rev-parse HEAD) &&
> +	{
> +		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> +			test-tool pkt-line pack-raw-stdin &&
> +		printf "0000"
> +	} >input &&
> +	git ls-remote --upload-pack="cat input ;:" . >actual &&
> +	printf "%s\tHEAD\n" "$oid" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: 186eaaae567db501179c0af0bf89b34cbea02c26

I've been seeing an occasional and not-reliably-reproducible test
failure from t5704 in 'seen' these days---since this is the only
commit that touches t5704, I am suspecting if there is something
racy about it, but I am coming up empty after staring at it for a
few minutes.

Building 87446480 (connect: also update offset for features without
values, 2021-09-18), which is an application of the patch directly on
top of v2.33.0, and doing

    $ cd t
    $ while sh t5704-*.sh; do :; done

I can get it fail in a dozen iterations or so when the box is
loaded, so it does seem timing dependent.

