Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4726C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 23:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB22061357
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhHWXd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 19:33:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65477 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhHWXd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 19:33:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0238713B3A4;
        Mon, 23 Aug 2021 19:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDHQrHfkhTecmvC3kmUgf5pDUvG2cLbTLgeUdN
        0aHKw=; b=Hov8+m5keRfGCNzkCqDIrgqUOqJ2fG/K8mHIaId2i5qIp1MkHKg+vS
        xs0esfph/8AFVfbCg+qG6IgDhHPjI4iC+nvoAjJ0QXEAX1zBVN68byDExPh86JHr
        P+XBdCkQqAABhbf5ZGdcizT2JwcvHlx7eh5tprHKQzBFWKmqJujYw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EEDC413B3A3;
        Mon, 23 Aug 2021 19:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4149513B3A1;
        Mon, 23 Aug 2021 19:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mickey Endito <mickey.endito.2323@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
Date:   Mon, 23 Aug 2021 16:32:39 -0700
In-Reply-To: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
        (Mickey Endito's message of "Mon, 23 Aug 2021 20:12:40 +0000")
Message-ID: <xmqq8s0rpwiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68CB7C98-046A-11EC-95E7-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mickey Endito <mickey.endito.2323@protonmail.com> writes:

> The variable D is never defined in test t5582, more severely the test
> fails if D is defined by something outside the test suite, so remove
> this spurious line.

Wow.  Well spotted.

When D is left unset, we end up executing

	cd "" && ...

and it explains why nobody noticed the breakage for nearly a year
since c0192df6 (refspec: add support for negative refspecs,
2020-09-30) was written.


Unlike the apparent
copy-and-paste source, this is a more modern script that limits the
chdir inside subshells to avoid moving around in the main flow of
the test, and the fix proposed here looks the most sensible.  

> Signed-off-by: Mickey Endito <mickey.endito.2323@protonmail.com>
> ---
> To reproduce a failure do
> D=/some/path/which/does/not/exist t/t5582-fetch-negative-refspec.sh
>
> Note: The variable D seems to be a reminiscent similar to t/t5510-fetch.sh,
> which defines "D=$(pwd)". If you want to adopt that way, then you have
> to code a fix yourself. ;-)
>
>  t/t5582-fetch-negative-refspec.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> index e5d2e79ad3..7a80e47c2b 100755
> --- a/t/t5582-fetch-negative-refspec.sh
> +++ b/t/t5582-fetch-negative-refspec.sh
> @@ -105,7 +105,6 @@ test_expect_success "fetch with negative pattern refspec does not expand prefix"
>  '
>
>  test_expect_success "fetch with negative refspec avoids duplicate conflict" '
> -	cd "$D" &&
>  	(
>  		cd one &&
>  		git branch dups/a &&
> --
> 2.30.2
