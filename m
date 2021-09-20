Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069BC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A489600D4
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380010AbhITSbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:31:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56359 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379569AbhITS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 14:29:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CADE314826B;
        Mon, 20 Sep 2021 14:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dsBVCXC47O/ry/ZYnITmO4LYp+pfSn4Y4z5pPX
        jn0DI=; b=b+2zf5ykpFlb8bRRSWHiWgwtMnqBP4lFJRMrHILHcbSGJAWshmlwg5
        BCUyd9zELTEkCxjXjfMdEslIi01oW/WCtI7FA26myMCo72ygHA/vhNZISRJHJuHY
        Cl8B8LXaTetVbVV8PN/Q3qTIi9LTvVI0cmXfUNBskUHmNGJ4QlyUI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C381314826A;
        Mon, 20 Sep 2021 14:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A550148268;
        Mon, 20 Sep 2021 14:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 1/4] t7800-difftool: cleanup temporary repositories used
 by tests
References: <20210919015729.98323-1-davvid@gmail.com>
Date:   Mon, 20 Sep 2021 11:28:05 -0700
In-Reply-To: <20210919015729.98323-1-davvid@gmail.com> (David Aguilar's
        message of "Sat, 18 Sep 2021 18:57:26 -0700")
Message-ID: <xmqqv92vayq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8026A516-1A40-11EC-A31C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> The "dirlinks" and "growing" repositories should not outlive the
> tests that use them.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  t/t7800-difftool.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a173f564bc..a923f193da 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -414,6 +414,7 @@ test_expect_success 'setup change in subdirectory' '
>  test_expect_success 'difftool -d with growing paths' '
>  	a=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
>  	git init growing &&
> +	test_when_finished rm -rf growing &&

If "git init" fails after it created the directory, it will be left
behind because test_when_finished hasn't been called yet.  The same
problem exists in the other hunk.  Moving it above "git init" may
trigger "rm -rf X" where X does not exist yet, but that is what you
are giving the 'f'orce option there for.

Not a huge deal and no need to resend only to fix them alone,
though.

>  	(
>  		cd growing &&
>  		echo "test -f \"\$2/b\"" | write_script .git/test-for-b.sh &&
> @@ -646,6 +647,7 @@ test_expect_success 'difftool properly honors gitlink and core.worktree' '
>  test_expect_success SYMLINKS 'difftool --dir-diff symlinked directories' '
>  	test_when_finished git reset --hard &&
>  	git init dirlinks &&
> +	test_when_finished rm -rf dirlinks &&
>  	(
>  		cd dirlinks &&
>  		git config diff.tool checktrees &&
