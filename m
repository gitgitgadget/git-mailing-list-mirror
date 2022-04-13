Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D6C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiDMQ1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiDMQ1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:27:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F123156
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:24:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9DE9173ED1;
        Wed, 13 Apr 2022 12:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JjXZoVSBSebNKmmrgwvUD0ObEU0vj1NpSk/v5o
        3OjeQ=; b=h1mvp2yU96PyPF2Y3a9FmVbTT9VDOkoRUqnofnTpSyCDzNT7Iz1rpM
        6EKpacq23gCftnfN8jd0fFMySWta+0GXKTfjtXQ7QZnWCRfnxRemgM1YJES1hS5I
        9vuKS25Om/Z4cSQy/78jwKiiFPoNXqTNmG4Zg4wXOfObCanFM2xiU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BB72173ED0;
        Wed, 13 Apr 2022 12:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0DF3173ECF;
        Wed, 13 Apr 2022 12:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] t0033: add tests for safe.directory
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 09:24:35 -0700
In-Reply-To: <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 13 Apr 2022
        15:32:29 +0000")
Message-ID: <xmqqwnft9cjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3604EF5E-BB46-11EC-BCE4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> It is difficult to change the ownership on a directory in our test
> suite, so insert a new GIT_TEST_ASSUME_DIFFERENT_OWNER environment
> variable to trick Git into thinking we are in a differently-owned
> directory. This allows us to test that the config is parsed correctly.

OK.

> -	if (is_path_owned_by_current_user(path))
> +	if (is_path_owned_by_current_user(path) &&
> +	    !git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0))
>  		return 1;

Shouldn't the overriding "GIT_TEST_BLAH" be checked before the
real logic kicks in, I wonder?

> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> new file mode 100755
> index 00000000000..9380ff3d017
> --- /dev/null
> +++ b/t/t0033-safe-directory.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='verify safe.directory checks'
> +
> +. ./test-lib.sh
> +
> +GIT_TEST_ASSUME_DIFFERENT_OWNER=1
> +export GIT_TEST_ASSUME_DIFFERENT_OWNER
> +
> +expect_rejected_dir () {
> +	test_must_fail git status 2>err &&
> +	grep "safe.directory" err
> +}
> +...
> +test_expect_success 'safe.directory matches' '
> +	git config --global --add safe.directory "$(pwd)" &&
> +	git status
> +'

Just double checking, as I know you are much closer to the affected
platform than I'd ever be ;-) but is the use of $(pwd) safe and
correct here?

I always get confused between $(pwd) and $PWD, which does not make
any difference on platforms I have access to, but makes difference
to hurt Windows users.

> +test_expect_success 'safe.directory matches, but is reset' '
> +	git config --global --add safe.directory "" &&
> +	expect_rejected_dir
> +'
> +
> +test_done

Thanks.  This step should apply to maint-2.30 cleanly, I would
think.
