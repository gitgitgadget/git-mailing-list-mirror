Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E995EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 21:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGEVRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjGEVRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 17:17:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43A1700
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 14:17:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71FBB3394C;
        Wed,  5 Jul 2023 17:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2w38XcyDWHVK4eoCBpeBAFJKVRSP1Urstjn+Sx
        oKQ5I=; b=C/GEMTRgkxVRYSg4ovwWYRTsQfu5gygvwmrxdS5q0YXlHcgm2hkDMn
        +2ywnY+MxhWqDMpVR3VfIrqBJVIZNJf5cL4uJvEdp0njaIAS+L4sb70oEHB/Y7z0
        DD2b4PZzTcBVAG7AC8YJ0ALJhQRBs02tFWdOfp/vHBdYUnJejGYXI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69DDA3394B;
        Wed,  5 Jul 2023 17:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 018E63394A;
        Wed,  5 Jul 2023 17:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: Re: [PATCH v2 1/4] diff --no-index: refuse to compare stdin to a
 directory
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
        <cover.1688586536.git.phillip.wood@dunelm.org.uk>
        <5e65a15223bc42293516308eb31ade5395609c55.1688586536.git.phillip.wood@dunelm.org.uk>
Date:   Wed, 05 Jul 2023 14:17:12 -0700
In-Reply-To: <5e65a15223bc42293516308eb31ade5395609c55.1688586536.git.phillip.wood@dunelm.org.uk>
        (Phillip Wood's message of "Wed, 5 Jul 2023 20:49:27 +0100")
Message-ID: <xmqqmt0axdlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FE1AE28-1B79-11EE-920F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When the user runs
>
>     git diff --no-index file directory
>
> we follow the behavior of POSIX diff and rewrite the arguments as
>
>     git diff --no-index file directory/file
>
> Doing that when "file" is "-" (which means "read from stdin") does not
> make sense so we should error out if the user asks us to compare "-" to
> a directory. This matches the behavior of GNU diff and diff on *BSD.

"git diff --no-index directory file" would also be the same way.

Makes sense.

> -	if (path[0] == file_from_standard_input ||
> -	    path[1] == file_from_standard_input)
> -		return;
> -	isdir0 = is_directory(path[0]);
> -	isdir1 = is_directory(path[1]);

We used to silently did nonsense, I guess.

> +	isdir0 = path[0] != file_from_standard_input && is_directory(path[0]);
> +	isdir1 = path[1] != file_from_standard_input && is_directory(path[1]);
> +
> +	if ((path[0] == file_from_standard_input && isdir1) ||
> +	    (isdir0 && path[1] == file_from_standard_input))
> +		die(_("cannot compare stdin to a directory"));

OK.  It is much better than turning "diff - D" into "diff - D/-".
If D were a missing or a misspelt directory name, the rest of the
function will just leave the original intact and let comparison
between the standard input and D that does not exist, and will fail
correctly anyway.  Good.

>  	if (isdir0 == isdir1)
>  		return;
>  	if (isdir0) {
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 4e9fa0403d..5bfb282e98 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -205,4 +205,9 @@ test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not lik
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
> +	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
> +	grep "fatal: cannot compare stdin to a directory" err
> +'
> +
>  test_done
