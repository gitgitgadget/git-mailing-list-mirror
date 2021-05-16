Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90939C433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 05:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CD1611BE
	for <git@archiver.kernel.org>; Sun, 16 May 2021 05:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhEPFD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 01:03:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51134 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhEPFDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 01:03:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E773B8B86;
        Sun, 16 May 2021 01:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T2zFmkiFlQh9Hn5CvRPsZCH6Ig0dkzuv+H0Uwk
        4kuRA=; b=LuaS1zPz1DsGSHOLNEnoPNoUqkA4n4REx528kT9WMZ5wc3peyt/7bq
        ugT27KNsyvsvAS7LMRyecI9QMWWLR6AAeq1k2fNk2JWkiD7wqY2W7E37PPJ9qaqU
        Y2Jk1HsxKx9eHieYluCfmB7jgaz6Qc89psi2Y1JDMJXJkbQ+/TRrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 072AFB8B85;
        Sun, 16 May 2021 01:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C779B8B84;
        Sun, 16 May 2021 01:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t: use test_config whenever possible
References: <20210514065508.247044-1-firminmartin24@gmail.com>
        <20210515152721.885728-1-firminmartin24@gmail.com>
        <20210515152721.885728-3-firminmartin24@gmail.com>
Date:   Sun, 16 May 2021 14:02:09 +0900
In-Reply-To: <20210515152721.885728-3-firminmartin24@gmail.com> (Firmin
        Martin's message of "Sat, 15 May 2021 17:27:21 +0200")
Message-ID: <xmqqbl9b6zla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEE8F23A-B603-11EB-98E2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

"whenever possible" in the subject is not wrong per-se but because
we do not want to accept a patch that uses it where it is impossible
to be used anyway, it does not mean all that much.

Use of test_config to replace #1 below is a correctness improvement,
and use of test_config to replace #2 below is a readability thing.

    t: use more test_config for correctness and readability

perhaps?

> Replace patterns of the form
> 1.
>         git config <config-option> <value> &&
>         ...
>         git config --unset <config-option> &&

Adding "because this form fails to unset the config if an earlier
step fails." would be helpful to the readers to clarify that this is
a correctness "fix".

> 2.
>         test_when_finished "git config --unset <config-option>" &&
>         git config <config-option> <value> &&
>         ...
>
> to the concise
>
>         test_config <config-option> <value>

Nice.

> In t5526, two tests have been further simplified as the output file is
> written before "git config --global --unset".

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index ed11569d8d..ff18263171 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> ...
@@ -429,11 +429,7 @@ test_expect_success "'fetch.recurseSu
>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules on-demand &&
> -		git fetch >../actual.out 2>../actual.err
> -	) &&
> -	git config --global --unset fetch.recurseSubmodules &&
> -	(
> -		cd downstream &&
> +		git fetch >../actual.out 2>../actual.err &&
>  		git config --unset fetch.recurseSubmodules
>  	) &&
>  	test_must_be_empty actual.out &&

The original seems to be making sure that the config set in
"downstream" repository is used successfully before it is unset from
the global configuration and then the same fetch in the downstream
will work even when the configuration is removed from the global
configuration.  The squashing of the two tests into one would change
what is being tested, wouldn't it?

Surely, the actual.out and actual.err in the first invocation *was*
overwritten without being looked at, but the exit status of that
fetch (i.e. fetch before global config gets unset) was still checked
in the original.  So I'd call this a "simplification"

>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules on-demand &&
> -		git fetch >../actual.out 2>../actual.err
> +		git fetch
> 	) &&
> 	git config --global --unset fetch.recurseSubmodules &&

I.e. these redirected output files were not used and the next fetch
will overwrite them.

The patch I am responding to claims that 

 - "make sure it succeeds with global set, and then without global
   set, make sure it still works" is not worth testing.

 - it is OK to replace it with a single "it succeeds without
   unsetting the global config".

It is not clear if either is true.  Same for the other hunk that
squashes two tests into one for this path.
