Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF7BC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A0961090
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 05:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhJHF0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:26:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62757 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJHF0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 01:26:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CFA11468B8;
        Fri,  8 Oct 2021 01:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1PZVLulVw8Oy6YXpdiVR7OzCCByA4zcbVIpDJbci8+A=; b=K/7J
        JzPHEoGg2vTbz10rpuYdIFJ2Z0hYKlR3pTIktopvmpasZrjj0qivS94hyoEwRTtv
        +wvNcWGaUkovuVO4PDJUKEk0oMVe66HKZhQ/oua4/yurjxvYBNrWCnHencegGRXf
        d6eotz73laZCfgJjvJfho6ISPG4l6jM6lv79uWg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9574B1468B7;
        Fri,  8 Oct 2021 01:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04EC51468B6;
        Fri,  8 Oct 2021 01:24:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 22:24:14 -0700
Message-ID: <xmqq35pcm6m9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAD67E70-27F7-11EC-A673-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * If --force-full-index is set, the command should skip manually
> +	 * setting `command_requires_full_index`.
> +	 */

Hmph, doesn't that feel unnaturally backwards, though?

The settings.command_requires_full_index bit forces read-cache to
call ensure_full_index() immediately after the in-core index is read
from the disk.  If we are forcing operating on the full index, I'd
imagine that we'd be making sure that ensure_full_index() to be
called.

I do not see anything in the code that ensures active_cache_changed
to be flipped on.  So the new test that says

    git -C sparse-index -c core.fsmonitor="" update-index --force-full-index

may not call ensure_full_index(), but because nothing marks
the_index as changed, I think we won't call write_locked_index() at
the end of cmd_update_index().  IOW, what we have in the test patch
may be an expensive noop, no?

Or perhaps I am reading the patch completely incorrectly.  I dunno.

> +	prepare_repo_settings(r);
> +	if (!use_default_full_index)
> +		r->settings.command_requires_full_index = 1;
> +
>  	entries = read_cache();
>  	if (entries < 0)
>  		die("cache corrupted");
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 889079f55b8..4aa4fef7b4f 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -635,7 +635,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
>  	init_repos &&
>  
>  	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -		git -C sparse-index -c core.fsmonitor="" reset --hard &&
> +		git -C sparse-index -c core.fsmonitor="" update-index --force-full-index &&
>  	test_region index convert_to_sparse trace2.txt &&
>  	test_region index ensure_full_index trace2.txt
>  '
