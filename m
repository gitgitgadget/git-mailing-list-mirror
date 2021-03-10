Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F218C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2767B64DAE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCJXJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:09:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58847 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 18:09:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9A88B54EE;
        Wed, 10 Mar 2021 18:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xiz1R44F8rZ58OYuYolQNMaq9ZU=; b=Eb5Q1y
        n61HXAiG7LSMjKtW2XeBA759EOtazb0biJUTBSjem2qxoySts6zqiXl27P2gXlpO
        brQ1sOqYIMvoatUKc+BrNnuK/roJohNCC3uB2DlDgQltvKJ7QIQGgUPhWFrdFbBq
        00BRnASFsugLBWF0+iCxWX7bLpyshck3qtmV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cEozxe55cG/YDRlJ2vOJ00d9XRAYRoPQ
        ZZvx0JLslf4K97Wc6f6qylKGEReCoT/BI7f2t4OJj+ebp3qqHAtkwfzxwAXZa7uM
        QHCreLkb55S8tpYcOdZqS/iSo/AuNSq8YOJBmx6D1++HjKqLiABosISmg9NiPO0h
        NapRsY4iw7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2856B54ED;
        Wed, 10 Mar 2021 18:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E3E7B54EB;
        Wed, 10 Mar 2021 18:09:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, jvusich@amazon.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] builtin/init-db: handle bare clones when core.bare
 set to false
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
        <20210310011120.1151749-1-sandals@crustytoothpaste.net>
Date:   Wed, 10 Mar 2021 15:09:32 -0800
In-Reply-To: <20210310011120.1151749-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 10 Mar 2021 01:11:20 +0000")
Message-ID: <xmqq7dmeip1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD04A4A4-81F5-11EB-9955-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 52e5789fb0..c2b71e78c5 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -104,6 +104,14 @@ test_expect_success 'redirected clone -v does show progress' '
>  
>  '
>  
> +test_expect_success 'clone does not segfault with --bare and core.bare=false' '
> +	test_config_global core.bare false &&
> +	git clone --bare parent clone-bare &&

Because "git clone" does so many different things from the normal
codepath in the "local" codepath, I'd prefer to see this one done
with the "--no-local" option (or alternatively, we could test both,
but that may be overkill).

> +	echo true >expect &&
> +	git -C clone-bare rev-parse --is-bare-repository >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'chooses correct default initial branch name' '
>  	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>  	git -c init.defaultBranch=foo init --bare empty &&
