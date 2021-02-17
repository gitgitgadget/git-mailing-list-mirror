Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDAEC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 22:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BDC64E7A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 22:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhBQWVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:21:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56967 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBQWVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 17:21:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D16B71215C7;
        Wed, 17 Feb 2021 17:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YPRa75P5y1WmoUshFVWzoAndPec=; b=WMrchU
        oqNnrSj/Sd6UUchJXOWXZgQBgIukaEpTZMXqPEbvoVIyxvgE4OgdfLi1akT99f9M
        jL+4ooEscp1+jXFt5BhI1iLJU+HXnnM8vURcokHZVlcz3WurgLcY9ovUp7uchvpi
        jwWMheoP06Nvmjyy2hNxxMg++agElXavAMZLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NlSSaf+bclwQ0u1UXf8SKr1Y7mrd64ga
        xLe4FV3sah5FDAVVXPR5hzXzTcbygclp5/LMi98Nyx7g+fwp00E+9uoyeoPipxOF
        ZIkMHgCYN2Ubf6iQ9dlcgZBXzEcPn71UHWTzo2v3IrCNhq+POr4Iey150rI1/ccT
        pm+oEx87ep4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAE4B1215C6;
        Wed, 17 Feb 2021 17:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C4261215C5;
        Wed, 17 Feb 2021 17:20:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 2/7] add: include magic part of pathspec on
 --refresh error
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <970b7156c2697e65778ec85751733a3adc53c1be.1613593946.git.matheus.bernardino@usp.br>
Date:   Wed, 17 Feb 2021 14:20:22 -0800
In-Reply-To: <970b7156c2697e65778ec85751733a3adc53c1be.1613593946.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 17 Feb 2021 18:02:25 -0300")
Message-ID: <xmqq5z2qjpzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5466C558-716E-11EB-9634-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> When `git add --refresh <pathspec>` doesn't find any matches for the
> given pathspec, it prints an error message using the `match` field of
> the `struct pathspec_item`. However, this field doesn't contain the
> magic part of the pathspec. Instead, let's use the `original` field.

I assume that this is what already happens when there is no
"--refresh" on the command line?  I.e.

    $ cd t
    $ git add ':(icase)foo'
    fatal: pathspec ':(icase)foo' did not match any files
    $ git add --refresh ':(icase)foo'
    fatal: pathspec 't/foo' did not match any files

and you are unifying the discrepancy between the two to match the
former.

Makes sense.

>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/add.c  | 2 +-
>  t/t3700-add.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index f757de45ea..8c96c23778 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -180,7 +180,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
>  	for (i = 0; i < pathspec->nr; i++) {
>  		if (!seen[i])
>  			die(_("pathspec '%s' did not match any files"),
> -			    pathspec->items[i].match);
> +			    pathspec->items[i].original);
>  	}
>  	free(seen);
>  }
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index fc81f2ef00..fe72204066 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -196,6 +196,12 @@ test_expect_success 'git add --refresh with pathspec' '
>  	grep baz actual
>  '
>  
> +test_expect_success 'git add --refresh correctly reports no match error' "
> +	echo \"fatal: pathspec ':(icase)nonexistent' did not match any files\" >expect &&
> +	test_must_fail git add --refresh ':(icase)nonexistent' 2>actual &&
> +	test_i18ncmp expect actual
> +"
> +
>  test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
>  	git reset --hard &&
>  	date >foo1 &&
