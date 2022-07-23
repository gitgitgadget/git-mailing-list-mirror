Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1689C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 05:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGWFfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 01:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWFft (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 01:35:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E812ACE
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:35:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B644144D9C;
        Sat, 23 Jul 2022 01:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N4qp5/1O1cvPiKJ6SKGgD722zvprECacFgr26X
        FJywc=; b=HgmFaJ8Gspm1s0wGvL7XUAUxi1wLi1eW8TCFvrN5nurqBein4snpKp
        6U0kadHUKP6ykaB3FhxNXiBIjOrQiP486Gl+NlOzQX+D8ZHGxe4UrjyUIrjzjP2N
        xLENN4XGU4xgyKzp+DT/cys4qEqJaC/3VL7bW+AEx5xC3SWTU4Lu4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D46D144D9A;
        Sat, 23 Jul 2022 01:35:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AFA5144D99;
        Sat, 23 Jul 2022 01:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
References: <cover.1658532524.git.me@ttaylorr.com>
        <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
Date:   Fri, 22 Jul 2022 22:35:43 -0700
In-Reply-To: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 22 Jul 2022 19:29:05 -0400")
Message-ID: <xmqq4jz8bdcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C182C46-0A49-11ED-AD2E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -14,7 +14,7 @@ SYNOPSIS
>  'git cat-file' (-t | -s) [--allow-unknown-type] <object>
>  'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
>  	     [--buffer] [--follow-symlinks] [--unordered]
> -	     [--textconv | --filters]
> +	     [--textconv | --filters] [-z]

Is "-z" useful with any other option, or is it useful only in
combination with one of the three --batch-*?  The above suggests the
former.

> +test_expect_success '--batch, -z with multiple sha1s gives correct format' '
> +	echo_without_newline_nul "$batch_input" >in &&

I I recall [1/2] correctly, the input lacked the LF at the end.  In
the original "LF terminated" use converted to use these variables,
because $batch_*_input is "echo"ed to create the file "in", the lack
of LF at the end is a GOOD thing.

But here, echo_without_newline_nul is just a glorified "printf %s"
piped into tr to turn LF into NUL.  What is fed by printf into the
pipe lacks LF at the end, so the output from tr will not have NUL at
the end, either.

That might happen to work (because the EOF may be enough to signal
the end of the entire input, thus the last input item), but it does
not make the test case for "-z" exactly parallel to the line oriented
input.

> +test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
> +    echo_without_newline_nul "$batch_check_input" >in &&
> +    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
> +'
> +
> +test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> +	touch -- "newline${LF}embedded" &&
> +	git add -- "newline${LF}embedded" &&
> +	git commit -m "file with newline embedded" &&
> +	test_tick &&
> +
> +	printf "HEAD:newline${LF}embedded" >in &&
> +	git cat-file --batch-check -z <in >actual &&

As I already said, I suspect that new users who know how our path
quoting works would expect c-quoted path would work just fine
without using "-z".  It is not a reason to refuse "-z" to exist,
though.

> @@ -436,6 +465,11 @@ test_expect_success '--batch-command with multiple info calls gives correct form
>  	echo "$batch_command_multiple_info" >in &&
>  	git cat-file --batch-command --buffer <in >actual &&
>  
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_info" | tr "\n" "\0" >in &&

This is what I would expect.  The _info variable lacks final LF,
which is supplied by "echo", so output from tr ends with NUL, which
mirrors the line-oriented input we used above.

> +	git cat-file --batch-command --buffer -z <in >actual &&
> +
>  	test_cmp expect actual
>  '
>  
> @@ -459,6 +493,12 @@ test_expect_success '--batch-command with multiple command calls gives correct f
>  	echo "$batch_command_multiple_contents" >in &&
>  	git cat-file --batch-command --buffer <in >actual_raw &&
>  
> +	remove_timestamp <actual_raw >actual &&
> +	test_cmp expect actual &&
> +
> +	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
> +	git cat-file --batch-command --buffer -z <in >actual_raw &&
> +

Likewise.
