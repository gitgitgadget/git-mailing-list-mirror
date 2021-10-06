Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC2C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B305B610E5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 16:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhJFRBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:01:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63730 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJFRBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 13:01:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B8E9DC549;
        Wed,  6 Oct 2021 12:59:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zECnAcdW264d
        7c72yeTQNA2L91vjEkU03XmFhUHvSgY=; b=XDgd57mhIy1yjnrxdFqiPyBNV6Ld
        zm4r0kWQ0d82uuaCrYemsJ3IU+ZC+AQ9XG2B3wluwFYvAQ9xHHjvI9GzzM6yN2ry
        mWm8ND7OIWhPA1vft1V5lawwAV8Mm/Tk7w6Ul9zQGiWYzxmTBlbfbEaEW0BNfueJ
        DfgmJQBpcgG1I0U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 636F5DC547;
        Wed,  6 Oct 2021 12:59:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2708DC546;
        Wed,  6 Oct 2021 12:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: p2000 failure due to empty reflog
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
        <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
        <581663a7-9b16-e464-ada7-368f20c99ff1@web.de>
Date:   Wed, 06 Oct 2021 09:59:45 -0700
In-Reply-To: <581663a7-9b16-e464-ada7-368f20c99ff1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 5 Oct 2021 22:28:40 +0200")
Message-ID: <xmqqsfxersvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF874C68-26C6-11EC-8143-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Good point.  I have gc.auto=3D0 in my config, but the tests use their o=
wn,
> empty config.  A trace shows that "git gc --auto --no-quiet" is started=
.
> The following patch turns that off and allows the tests to succeed.
>
> Not doing maintenance in parallel to a performance test is a good idea
> anyway,

Sounds like a sensible analysis, and I agree that it is a good idea
to by default disable the maintenance tasks in t/perf (possibly at a
more centralized place).

> but I still don't understand why it would empty the reflog --
> that seems excessive, dangerous even.
>
> One of the maintenance commands from the trace is "git reflog expire
> --all".  If I put that in before the "checkout -" test (on top of the
> patch below) then the reflog is emptied again and the test fails.
>
> Ren=C3=A9
>
> ---
>  t/perf/p2000-sparse-operations.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-op=
erations.sh
> index 597626276f..9a06904247 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -105,6 +105,13 @@ test_perf_on_all () {
>  	done
>  }
>
> +test_expect_success 'disable housekeeping' '
> +	for repo in full-v3 full-v4 sparse-v3 sparse-v4
> +	do
> +		git -C $repo config gc.auto 0
> +	done
> +'
> +
>  test_perf_on_all git status
>  test_perf_on_all git add -A
>  test_perf_on_all git add .
> --
> 2.33.0
