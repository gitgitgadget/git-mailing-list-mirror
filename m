Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C7C4332F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719D461090
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhJOQRo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:17:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51647 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhJOQRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:17:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D078FEC96;
        Fri, 15 Oct 2021 12:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KRe8S6bHdOYK
        xtRbMMPWaJuVwapjdY1+zQ2I8HL26hk=; b=xTmE/G7anTReF1HlHQs1sfYektLg
        QwqEWLLM+iPqM5X7bDG21+7IcBu5YLG7fuwVQAgoaC2OwmgR5PEKIzZyVHYRWnxt
        OFQz68xPjo2pBBt5l66rrlnJfH10iD5XtLurRSFwX2IYUJF3Hsn9QtVJYCtZx2O1
        tWCp25zgUNtwMa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43F6DFEC95;
        Fri, 15 Oct 2021 12:15:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2248FEC93;
        Fri, 15 Oct 2021 12:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] commit-graph tests: fix another
 graph_git_two_modes() helper
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
        <patch-2.3-d6934031882-20211014T233343Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 09:15:34 -0700
In-Reply-To: <patch-2.3-d6934031882-20211014T233343Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Oct
 2021 01:37:15 +0200")
Message-ID: <xmqqwnme8dsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2102AA34-2DD3-11EC-BAF2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In 135a7123755 (commit-graph: add --split option to builtin,
> 2019-06-18) this function was copy/pasted to the split commit-graph
> tests, as in the preceding commit we need to fix this to use
> &&-chaining, so it won't be hiding errors.
>
> Unlike its sister function in "t5318-commit-graph.sh", which we got
> lucky with, this one was hiding a real test failure. A tests added in
> c523035cbd8 (commit-graph: allow cross-alternate chains, 2019-06-18)
> has never worked as intended. Unlike most other graph_git_behavior
> uses in this file it clones the repository into a sub-directory, so
> we'll need to refer to "commits/6" as "origin/commits/6".

Interesting.  The original created "fork" prepared the alternates
structure in the preceding test, but tested the "behavour" of the
commands outside the "fork" it just prepared?

>  graph_git_two_modes() {
> -	git -c core.commitGraph=3Dtrue $1 >output
> -	git -c core.commitGraph=3Dfalse $1 >expect
> +	git ${2:+ -C "$2"} -c core.commitGraph=3Dtrue $1 >output &&
> +	git ${2:+ -C "$2"} -c core.commitGraph=3Dfalse $1 >expect &&

OK, it was a bit curious to see :+ (instead of just +), but the
caller unconditionally passes "$DIR" (with double quotes), so it is
understandable.  Much more concise than having the caller to repeat
${4+"$4"} where it says "$DIR".

>  	test_cmp expect output
>  }
> =20
> @@ -64,12 +64,13 @@ graph_git_behavior() {
>  	MSG=3D$1
>  	BRANCH=3D$2
>  	COMPARE=3D$3
> +	DIR=3D$4
>  	test_expect_success "check normal git operations: $MSG" '
> -		graph_git_two_modes "log --oneline $BRANCH" &&
> -		graph_git_two_modes "log --topo-order $BRANCH" &&
> -		graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
> -		graph_git_two_modes "branch -vv" &&
> -		graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
> +		graph_git_two_modes "log --oneline $BRANCH" "$DIR" &&
> +		graph_git_two_modes "log --topo-order $BRANCH" "$DIR" &&
> +		graph_git_two_modes "log --graph $COMPARE..$BRANCH" "$DIR" &&
> +		graph_git_two_modes "branch -vv" "$DIR" &&
> +		graph_git_two_modes "merge-base -a $BRANCH $COMPARE" "$DIR"
>  	'
>  }
> =20
> @@ -187,7 +188,10 @@ test_expect_success 'create fork and chain across =
alternate' '
>  	)
>  '
> =20
> -graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
> +if test -d fork
> +then
> +	graph_git_behavior 'alternate: commit 13 vs 6' commits/13 origin/comm=
its/6 "fork"
> +fi
> =20
>  test_expect_success 'test merge stragety constants' '
>  	git clone . merge-2 &&
