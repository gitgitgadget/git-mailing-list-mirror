Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA9C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E2861139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347833AbhIHQUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:20:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64399 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347729AbhIHQUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:20:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E6EA165D56;
        Wed,  8 Sep 2021 12:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPoIn6/NBH7VQ5rErmun+Q20zhHTfNrw5sjMx8
        bgVRk=; b=xp16ppbYjZKP7M5nQYqKbr/mIGvJCA3QhP9V4f8VF3tzRA9VGr2euS
        mZLULCB3BJX8fpbE/BkmOeqduYJB0yioif8jpS6rWNQK3iWjcTQVsKCcKYyQn4Bg
        qqTebCP18zcALcz24FV6wygzbTR70gJyeOB3qpNQKxfOLNBxo6hBE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97194165D55;
        Wed,  8 Sep 2021 12:19:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCD59165D54;
        Wed,  8 Sep 2021 12:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] t3903: document a pair of directory/file bugs
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
        <bc66a6ae75d03858f48634612bb60062cc78f5eb.1631065427.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:19:22 -0700
In-Reply-To: <bc66a6ae75d03858f48634612bb60062cc78f5eb.1631065427.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 08 Sep 2021
        01:43:44 +0000")
Message-ID: <xmqqfsuf59bp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87C475D4-10C0-11EC-9EB1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3903-stash.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 873aa56e359..0727a494aa4 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1307,4 +1307,42 @@ test_expect_success 'stash -c stash.useBuiltin=false warning ' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_failure 'git stash succeeds despite directory/file change' '
> +	test_create_repo directory_file_switch_v1 &&
> +	(
> +		cd directory_file_switch_v1 &&
> +		test_commit init &&
> +
> +		test_write_lines this file has some words >filler &&
> +		git add filler &&
> +		git commit -m filler &&
> +
> +		git rm filler &&
> +		mkdir filler &&
> +		echo contents >filler/file &&
> +		cp filler/file expect &&
> +		git stash push

Creating 'expect' that is not used---perhaps this side also wants to
apply the created stash and check the result, like the other side
does, or something?

Of course, an obvious alternative is to stop making a needless
'expect'.

> +	)
> +'
> +
> +test_expect_failure 'git stash can pop directory/file saved changes' '
> +	test_create_repo directory_file_switch_v2 &&
> +	(
> +		cd directory_file_switch_v2 &&
> +		test_commit init &&
> +
> +		test_write_lines this file has some words >filler &&
> +		git add filler &&
> +		git commit -m filler &&
> +
> +		git rm filler &&
> +		mkdir filler &&
> +		echo contents >filler/file &&
> +		cp filler/file expect &&
> +		git stash push --include-untracked &&
> +		git stash apply --index &&
> +		test_cmp expect filler/file
> +	)
> +'
> +
>  test_done
