Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B873C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiE0VU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiE0VUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:20:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506166205
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:20:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E0CD1A77B7;
        Fri, 27 May 2022 17:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BmUACCVXOOA5Bbr6hxqash8AFeL5LFipqJ6pl7
        z83zU=; b=Putmkf0G9p61J1W7MPO9SItcTnuE3xu6z4u2wBZNJQpMh+ZzuEeEX3
        R9V8pWDKAiXYNrY+m8IxofTQvWzoVjckbxv7pCeJbkrcEPZBRKRdq2Lu79/m79i6
        V3vRk4uUL1xvNT/civrcX9BG29x7QbE8N+7/6EC4WqUKWkwPnSJxQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9782E1A77B6;
        Fri, 27 May 2022 17:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40EDB1A77B5;
        Fri, 27 May 2022 17:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 14:20:19 -0700
In-Reply-To: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 27 May 2022 20:52:51 +0000")
Message-ID: <xmqqzgj21xm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D00304B8-DE02-11EC-A0E1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> In order to allow users to use one executable for multiple hooks,
> provide a GIT_HOOK variable that is set to the hook event that triggered
> it.

I agree it would be handy to give hooks to play multiple roles by
dispatching on its name, just like our "git" potty can dispatch
built-ins when called "git-foo".

I do not think GIT_HOOK is a good name for the environment variable
that is used for that purpose, though.  It is easily mistaken as if
end users can set GIT_HOOK environment themselves to point at a
program and cause "git" to run it whenever it may want to run any
hook, for example.  IOW, the name is overly broad.

How about calling it with a name with "HOOK" and "NAME" in it?

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 26ed5e11bc8..a22c1a82a5e 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -38,6 +38,18 @@ test_expect_success 'git hook run: basic' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git hook run: $GIT_HOOK' '
> +	test_hook test-hook <<-EOF &&
> +	printenv GIT_HOOK
> +	EOF

This will introduce the first hit from "git grep printenv".

It is not even in POSIX.  Do we absolutely need to?

Perhaps

    echo "$GIT_HOOK"

is sufficient, or if you want to distinguish an unset and set to
empty string:

    if test "${GIT_HOOK+set}" = "set"
    then
        echo "GIT_HOOK is set to '$GIT_HOOK'"
    else
        echo "GIT_HOOK is unset"
	exit 1
    fi

may be another way.

> +	cat >expect <<-\EOF &&
> +	test-hook
> +	EOF

For one-liner, 

	echo test-hook >expect &&

should be a more compact and equally understandable way to write this.

> +	git hook run test-hook 2>actual &&
> +	test_cmp expect actual
> +'
