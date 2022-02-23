Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195CC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiBWVL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiBWVL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:11:28 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377244DF79
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:11:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83C1E11F406;
        Wed, 23 Feb 2022 16:10:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dPcgBHDktPJcr4d018kbVIH8EbYhlQde2rUNRK
        v4uR8=; b=SnaXR/ANOhzVmYW/GhNw0nJ5DY0b9+++GnpEYxOVD96jK+IgJ6a1eC
        E8CHcI9fF7IgdvG+xb1H0stywdYsaM6Z4sbiOd4XFRETc3B0op3CJXNiSKisbVSA
        ABAqBpfmUsRaPPMiZGA7EYWwkkOUWnDj2JVkwvVNUHITXQUP1pe1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BD6F11F405;
        Wed, 23 Feb 2022 16:10:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E10E911F404;
        Wed, 23 Feb 2022 16:10:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
References: <20220222114313.14921-1-shivam828787@gmail.com>
        <20220223115347.3083-1-shivam828787@gmail.com>
        <20220223115347.3083-2-shivam828787@gmail.com>
Date:   Wed, 23 Feb 2022 13:10:57 -0800
In-Reply-To: <20220223115347.3083-2-shivam828787@gmail.com> (Shubham Mishra's
        message of "Wed, 23 Feb 2022 17:23:46 +0530")
Message-ID: <xmqqo82xthjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19022784-94ED-11EC-B61E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shubham Mishra <shivam828787@gmail.com> writes:

> Pipes ignore error codes of LHS command and thu`s we should not use
> them with Git in tests. As an alternative, use a 'tmp' file to write
> the Git output so we can test the exit code.

I do not know what thu`s is, but the above describes a sensible
criterion to decide which pipe to touch and which pipe to leave
alone.

> -		find .git/worktrees -print | sort >expected &&
> +		find .git/worktrees -print >tmp &&
> +		sort tmp >expected &&

And this change or ...

>  		git -C ../linked-worktree init &&
>  		test_cmp expected-exclude .git/info/exclude &&
>  		test_cmp expected-config .git/config &&
> -		find .git/worktrees -print | sort >actual &&
> +		find .git/worktrees -print >tmp &&
> +		sort tmp >actual &&

... this change squarely contradict the reasoning written in the
proposed log message.  These pipelines place "find" on the upstream
of their pipe, and "find" is not something we are worried about
introducing new bug into.

>  		test_cmp expected actual
>  	)
>  '
