Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EDDC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiBASVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:21:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59841 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBASVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:21:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC0B016E4DC;
        Tue,  1 Feb 2022 13:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZcvFa7D0teJqq6ZJl1wa0X9GJ28EmnvB9LgNax
        zK0vo=; b=N+yUw06cBwY2cx9qQYW8oYcuvkUo41BtRemoAxs3Cg8mWytm7QPe4u
        nH/WxLMAwLCai0l/HH/ORfAp6lBqNL0iPp010/l06tvU0/bvq4QK3h+mfVcLAddV
        s8MYGhUXixH/aFSi9LEPsDHG6CFMh+LRI4A4hGznaB4pFgHPCwCho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E403816E4DB;
        Tue,  1 Feb 2022 13:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5824E16E4DA;
        Tue,  1 Feb 2022 13:21:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 2/3] repo-settings: fix error handling for unknown
 values
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <23f692b81be26072f44609df8c78d1b8d81f01d3.1643734828.git.gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 10:21:47 -0800
In-Reply-To: <23f692b81be26072f44609df8c78d1b8d81f01d3.1643734828.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 01 Feb 2022
        17:00:27 +0000")
Message-ID: <xmqqzgnae9c4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1B74822-838B-11EC-B217-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In commit af3a67de01 ("negotiator: unknown fetch.negotiationAlgorithm
> should error out", 2018-08-01), error handling for an unknown
> fetch.negotiationAlgorithm was added with the code die()ing.  This was
> also added to the documentation for the fetch.negotiationAlgorithm
> option, to make it explicit that the code would die on unknown values.
>
> This behavior was lost with commit aaf633c2ad ("repo-settings: create
> feature.experimental setting", 2019-08-13).  Restore it so that the
> behavior again matches the documentation.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  repo-settings.c       | 2 ++
>  t/t5500-fetch-pack.sh | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/repo-settings.c b/repo-settings.c
> index 38c10f9977b..41e1c30845f 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -87,6 +87,8 @@ void prepare_repo_settings(struct repository *r)
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
>  		else if (!strcasecmp(strval, "default"))
>  			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
> +		else
> +			die("unknown fetch negotiation algorithm '%s'", strval);
>  	}

Makes sense.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 666502ed832..41ea9f25de6 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -971,6 +971,13 @@ test_expect_success 'same as last but with config overrides' '
>  		-c fetch.negotiationAlgorithm=default
>  '
>  
> +test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
> +	test_when_finished rm -rf clientv0 &&
> +	cp -r client clientv0 &&
> +	test_must_fail git -C clientv0 --fetch.negotiationAlgorithm=bogus \
> +		       fetch origin server_has both_have_2
> +'
> +
>  test_expect_success 'filtering by size' '
>  	rm -rf server client &&
>  	test_create_repo server &&
