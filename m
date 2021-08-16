Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B4C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AB760BD3
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhHPQhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:37:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56136 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPQhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:37:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C318A13CAA0;
        Mon, 16 Aug 2021 12:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbdUYBbiFlu1w+6W+ckpQkPD3Uled89kidc3rM
        Uo9P8=; b=WQb5kS/PqrqUEiaVbzpd9HHyRWbx9d2ftqejbdyJF1+hFGu+2lMMF8
        PoevsiKPDGc9d7HXwsxEa+JU7RQaHEY1IZlX1MJC78rU1c39JF/uKExMFnZlrcVK
        iJzf5g/FiZgGqb6GnGyBFp9KouhmkOYbsy57pwODNT/k3/AoY8N+w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBF5F13CA9E;
        Mon, 16 Aug 2021 12:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA13E13CA9D;
        Mon, 16 Aug 2021 12:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
        <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
        <xmqq5ywddtsn.fsf@gitster.g>
        <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
        <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet>
        <xmqqsfzasj80.fsf@gitster.g>
        <043edd52-c666-0939-bf6d-51b0d225157e@gmail.com>
Date:   Mon, 16 Aug 2021 09:36:43 -0700
In-Reply-To: <043edd52-c666-0939-bf6d-51b0d225157e@gmail.com> (Phillip Wood's
        message of "Sun, 15 Aug 2021 21:04:36 +0100")
Message-ID: <xmqq8s11s5wk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25393944-FEB0-11EB-BFDF-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I wonder if it would be better to hard code the author in this test rather
> than rather than relying on git log like this

To be quite honest, I am pretty happy with the tests as posted, and
the choice among various ways we are discussing depends on what the
likely mode of breakage we expect.

The breakage we are expecting to catch in the second hunk of your
patch is somehow "rebase -i" fails to keep the authorship of
amended-goodbye and ends up making the commit at HEAD under
different authorship.

 - A likely source of a different authorship information that would
   be recorded, when such a bug gets introduced, is from the
   environment (i.e. GIT_AUTHOR_NAME etc. that test-lib.sh sets up).
   This can happen by a new bug in the test added before the second
   hunk of your patch we see below, and with or without this patch,
   such a bug in the test will not be caught.

 - Or amended-goodbye may by a test bug have been recorded under a
   wrong authorship information to begin with, and if it were done
   as the default author we use in our tests (i.e. the bug you fixed
   in your patch that started this thread).  If we reintroduced such
   a bug, the second hunk of this patch will help.

 - Or the variable $another_author gets clobbered in a future change
   between the two hunks of this patch, and the check in the second
   hunk would be broken.

Overall, I do not think any of the above breakage is so likely to
happen, and that is why I am happy with the tests as posted.  The
necessity for a plain shell variable to retain its value for such a
long haul across tests the patch below introduces may be making the
test more brittle than safer.

So...

> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> index e26762d0b2..c90e32817f 100755
> --- a/t/t3403-rebase-skip.sh
> +++ b/t/t3403-rebase-skip.sh
> @@ -34,9 +34,10 @@ test_expect_success setup '
>         git tag reverted-goodbye &&
>         git checkout goodbye &&
>         test_tick &&
> -       GIT_AUTHOR_NAME="Another Author" \
> -               GIT_AUTHOR_EMAIL="another.author@example.com" \
> -               git commit --amend --no-edit -m amended-goodbye &&
> +       another_author="Another Author <another.author@example.com>" &&
> +       git commit --amend --no-edit -m amended-goodbye \
> +               --author="$another_author" --date="$GIT_AUTHOR_DATE" &&
> +       another_author="$another_author $GIT_AUTHOR_DATE" &&
>         test_tick &&
>         git tag amended-goodbye &&
>  @@ -110,8 +111,10 @@ test_expect_success 'correct authorship when
> committing empty pick' '
>         test_must_fail git rebase -i --onto goodbye \
>                 amended-goodbye^ amended-goodbye &&
>         git commit --allow-empty &&
> -       git log --pretty=format:"%an <%ae>%n%ad%B" -1 amended-goodbye >expect &&
> -       git log --pretty=format:"%an <%ae>%n%ad%B" -1 HEAD >actual &&
> +       git log --pretty=format:"$another_author%n%B" -1 amended-goodbye \
> +                >expect &&
> +       git log --date=raw --pretty=format:"%an <%ae> %ad%n%B" -1 HEAD \
> +               >actual &&
>         test_cmp expect actual
>  '
>  
