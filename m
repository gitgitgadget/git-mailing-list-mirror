Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A061C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFBB206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W+8D2aaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEDVTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:19:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgEDVTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:19:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBEDFDC7A6;
        Mon,  4 May 2020 17:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nSCKJhV0gF5XBv79vNd/DxBqxVc=; b=W+8D2a
        aWIkrWDrKeU0Pw74EFGQvtYgXPM1CPjLcrKbEAi0NUUvWc3tM9/IGlQw3IjeLtWZ
        CT5mfTyPlm9xDvefJnDbARvyO1/7HM09qvJ1vdEx404F69Yuzo9tGuL+uCEzFmB+
        U7zEorDVCN3B7zQ9MYP3DlWrwrKrwNf7VPnZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VOCPc7iiMPV0kGBzjOlXbxd0npNYT5VQ
        CRt71ORUuvzM/zvp/5aKtES7PzuQB9no5jCPr3Fp+NVTWGQlLi7sfHhgV47aycOS
        ljKfPn2VzBxKvjHeRpqM7ZZP17wVKwEkjVOGb2+Fn0qcPqjHvcYwgSyEsrE+XtMA
        gAGxKV1BXN0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3FA4DC7A5;
        Mon,  4 May 2020 17:19:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04AC6DC7A4;
        Mon,  4 May 2020 17:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 14:19:26 -0700
In-Reply-To: <pull.625.git.1588624804554.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 04 May 2020 20:40:04
        +0000")
Message-ID: <xmqq4ksvflep.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFD12958-8E4C-11EA-871D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/sequencer.c b/sequencer.c
> index e528225e787..0d4d53d2a49 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5266,8 +5266,17 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
>  				TODO_FIXUP : TODO_SQUASH;
>  			if (next[i2] < 0)
>  				next[i2] = i;
> -			else
> +			else if (tail[i2] >= 0)
>  				next[tail[i2]] = i;
> +			else {
> +				/*
> +				 * i2 refers to a fixup commit in the middle of
> +				 * a fixup chain
> +				 */
> +				next[i] = next[i2];
> +				next[i2] = i;
> +				continue;

OK, this would catch the case even when fixing up a fix-up of
antoher fix-up, so we won't need further "else if" in the future ;-)

I suspect that this breakage is as old as 2.14, introduced by
c44a4c65 (rebase -i: rearrange fixup/squash lines using the
rebase--helper, 2017-07-14), but perhaps we won't need to backmerge
the fix that far.  We don't even backport security fixes beyond 2.17
(which is two years old).

Just in case I'll queue this immediately on top of f2a04904
(sequencer: refactor rearrange_squash() to work on a todo_list,
2019-03-05); that would give us a potential to cover as far back to
2.20 series.

Thanks.

> +			}
>  			tail[i2] = i;
>  		} else if (!hashmap_get_from_hash(&subject2item,
>  						strhash(subject), subject)) {
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 093de9005b7..ca135349346 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -424,4 +424,18 @@ test_expect_success 'abort last squash' '
>  	! grep first actual
>  '
>  
> +test_expect_success 'fixup a fixup' '
> +	echo 0to-fixup >file0 &&
> +	test_tick &&
> +	git commit -m "to-fixup" file0 &&
> +	test_tick &&
> +	git commit --squash HEAD -m X --allow-empty &&
> +	test_tick &&
> +	git commit --squash HEAD^ -m Y --allow-empty &&
> +	test_tick &&
> +	git commit -m "squash! $(git rev-parse HEAD^)" -m Z --allow-empty &&
> +	git rebase -ki --autosquash HEAD~4 &&
> +	test XZY = $(git show | tr -cd X-Z)
> +'
> +
>  test_done
>
> base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
