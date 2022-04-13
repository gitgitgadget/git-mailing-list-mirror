Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E8C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiDMQhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDMQg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:36:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22BA29C96
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:34:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96E9919A595;
        Wed, 13 Apr 2022 12:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tRENEJAOV2I8pJgGHaej6JKiBysBDnX28XULkS
        9qj8c=; b=W15gwUmtYJqBbnJ91gB1RE/L9zzFUgFPfBx0hOh1ekqVnuqI0Jl7zM
        8ap5VviiB0ZO9XT5+5F+wkfBlmPZZiPSQf1Q9bTHy4yBZf98evpkglnYaDD26w8H
        XzFbQq8dxiX6jO59voB2sg0fwKeHp+HiQEaa9bRI7oJoFiFq7tOfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F62319A594;
        Wed, 13 Apr 2022 12:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E131819A593;
        Wed, 13 Apr 2022 12:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matheus Valadares via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Matheus Valadares <me@m28.io>
Subject: Re: [PATCH 2/3] setup: fix safe.directory key not being checked
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <8a06688c121195f21472e3e49efd2b034b1537fc.1649863951.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 09:34:32 -0700
In-Reply-To: <8a06688c121195f21472e3e49efd2b034b1537fc.1649863951.git.gitgitgadget@gmail.com>
        (Matheus Valadares via GitGitGadget's message of "Wed, 13 Apr 2022
        15:32:30 +0000")
Message-ID: <xmqqr1619c2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99D1DB72-BB47-11EC-ADB1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matheus Valadares via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matheus Valadares <me@m28.io>
>
> It seems that nothing is ever checking to make sure the safe directories
> in the configs actually have the key safe.directory, so some unrelated
> config that has a value with a certain directory would also make it a
> safe directory.

Good finding, and the fix is straight-forward and obviously correct.
Thanks.

> Signed-off-by: Matheus Valadares <me@m28.io>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  setup.c                   | 3 +++
>  t/t0033-safe-directory.sh | 5 +++++
>  2 files changed, 8 insertions(+)

> diff --git a/setup.c b/setup.c
> index f54f449008a..a995c359c32 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1100,6 +1100,9 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
>  {
>  	struct safe_directory_data *data = d;
>  
> +	if (strcmp(key, "safe.directory"))
> +		return 0;
> +
>  	if (!value || !*value)
>  		data->is_safe = 0;
>  	else {
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index 9380ff3d017..6f33c0dfefa 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -21,6 +21,11 @@ test_expect_success 'safe.directory does not match' '
>  	expect_rejected_dir
>  '
>  
> +test_expect_success 'path exist as different key' '
> +	git config --global foo.bar "$(pwd)" &&
> +	expect_rejected_dir
> +'
> +
>  test_expect_success 'safe.directory matches' '
>  	git config --global --add safe.directory "$(pwd)" &&
>  	git status
