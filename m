Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06255C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 22:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiHAWWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiHAWWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 18:22:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0B3AE52
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 15:22:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66E4D13B51E;
        Mon,  1 Aug 2022 18:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VmMZwxaeCD706a9CdwkIVanEYfJobClpOxfpHh
        nmMQM=; b=g95tzuCMPhOht9zExvlECgp+mom9mMrcT0hAsxgL3dwnYHS3kTedgc
        QCAfyYT5VFh8/NLsrNltJiewxnXGYUcrp3lff+qHMjE53E4Qbuqudb1aXfzwFMMe
        riNnZjzRxA8fFXea13tRkfkkxpwLdCNhJOWIw/xqPjGVKmYLNxqRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D4C113B51C;
        Mon,  1 Aug 2022 18:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C4E313B51B;
        Mon,  1 Aug 2022 18:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 4/7] builtin/bugreport.c: add directory to archiver more
 gently
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <4bc290fbf43e0193aae288b79249014d899ea34a.1659388498.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 15:22:47 -0700
In-Reply-To: <4bc290fbf43e0193aae288b79249014d899ea34a.1659388498.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:55
        +0000")
Message-ID: <xmqqles7mwnc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 797C739E-11E8-11ED-A3BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	int at_root = !*path;
> -	DIR *dir = opendir(at_root ? "." : path);
> +	DIR *dir;
>  	struct dirent *e;
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t len;
>  	int res = 0;
>  
> +	if (!file_exists(at_root ? "." : path)) {
> +		warning(_("directory '%s' does not exist, will not be archived"), path);
> +		return 0;
> +	}
> +
> +	dir = opendir(at_root ? "." : path);
>  	if (!dir)
>  		return error_errno(_("could not open directory '%s'"), path);

I am not sure if TOCTTOU is how we want to be more gentle.  Do we
rather want to do something like this

	dir = opendir(...);
	if (!dir) {
		if (errno == ENOENT) {
			warning(_("not archiving missing directory '%s'", path);
		        return 0;
		}
                return error_errno(_("cannot open directory '%s'"), path);
	}

or am I missing something subtle?

Thanks.

> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 3cf983aa67f..e9db89ef2c8 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -78,7 +78,7 @@ test_expect_success 'indicates populated hooks' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
> +test_expect_success UNZIP '--diagnose creates diagnostics zip archive' '
>  	test_when_finished rm -rf report &&
>  
>  	git bugreport --diagnose -o report -s test >out &&
> @@ -98,4 +98,13 @@ test_expect_failure UNZIP '--diagnose creates diagnostics zip archive' '
>  	grep "^Total: [0-9][0-9]*" out
>  '
>  
> +test_expect_success '--diagnose warns when archived dir does not exist' '
> +	test_when_finished rm -rf report &&
> +
> +	# Remove logs - not guaranteed to exist
> +	rm -rf .git/logs &&
> +	git bugreport --diagnose -o report -s test 2>err &&
> +	grep "directory .\.git/logs. does not exist, will not be archived" err
> +'
> +
>  test_done
