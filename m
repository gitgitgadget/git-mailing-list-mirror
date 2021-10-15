Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901ADC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710E461053
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhJOQFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:05:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54706 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbhJOQFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:05:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D47FEB8C;
        Fri, 15 Oct 2021 12:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SPlkOLTBQGcW
        8usSr+Sj8o1wKmt3Ww9e0ln6rMfW6+w=; b=ZNzauiaOLtXiMbGqXy03JJd/d/4C
        DdXaOcI+eyPgIG9rnR+JCwVxzzPVCIft6II8rjmBPOANptAW2/d5BU72hbZGflJK
        g28noR9or/2oFYPSdDbKLLHbNUxDN7snltlJ60cB/u5fUw5dPIUp0fwg32fLWR0q
        fz4CvFvupwoEisY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E49FEB8B;
        Fri, 15 Oct 2021 12:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76D61FEB8A;
        Fri, 15 Oct 2021 12:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] commit-graph tests: fix error-hiding
 graph_git_two_modes() helper
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
        <patch-1.3-f74cc32ceea-20211014T233343Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 09:03:10 -0700
In-Reply-To: <patch-1.3-f74cc32ceea-20211014T233343Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Oct
 2021 01:37:14 +0200")
Message-ID: <xmqq1r4m9sxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65728A42-2DD1-11EC-89C1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The graph_git_two_modes() helper added in 177722b3442 (commit:
> integrate commit graph with commit parsing, 2018-04-10) didn't
> &&-chain its "git commit-graph" invocations, which as can be seen with
> SANITIZE=3Dleak will happily mark tests as passing if both of these
> commands die, since test_cmp() will be comparing two empty files.

As the chains the four invocation of this helper with &&- correctly,
this does make a difference.  Nicely spotted.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t5318-commit-graph.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 295c5bd94d2..88fbe004a38 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -70,8 +70,8 @@ test_expect_success 'create commits and repack' '
>  '
> =20
>  graph_git_two_modes() {
> -	git -c core.commitGraph=3Dtrue $1 >output
> -	git -c core.commitGraph=3Dfalse $1 >expect
> +	git -c core.commitGraph=3Dtrue $1 >output &&
> +	git -c core.commitGraph=3Dfalse $1 >expect &&
>  	test_cmp expect output
>  }
