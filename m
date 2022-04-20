Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D877C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 04:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354172AbiDTE0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTE0O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 00:26:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE4312A9B
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 21:23:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61799134948;
        Wed, 20 Apr 2022 00:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=kk7WB/mPVxnvnIbU6aTeWmR7G
        6kyqrtRc2OwLl50ij8=; b=GM8qgCTcY2CBKsFTNi1dTnyl9NNADoc4w9fiDKn9N
        SDNkLTuXiwjnvszk9T7caIayb+SUMIZY/15G7iyN3wzFIJQCkZRhc7VShMXPejIH
        5hjLR9Grvbbp1VRgyw4GuZCJZl1cqsVUWl5ps8+YPa203s3TVMl3wr2AqE1rzTdi
        pA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59C58134947;
        Wed, 20 Apr 2022 00:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BB6A134946;
        Wed, 20 Apr 2022 00:23:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Anthony Sottile <asottile@umich.edu>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
Date:   Tue, 19 Apr 2022 21:23:24 -0700
Message-ID: <xmqqy200s7r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F235BB8-C061-11EC-88A2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> here's the shortest reproduction --
>
> ```console
> $ cat ../testrepo/.git/hooks/pre-commit
> #!/usr/bin/env bash
> if [ -t 1 ]; then
>     echo GOOD
> fi
> ```

> f443246b9f29b815f0b98a07bb2d425628ae6522 is the first bad commit
> commit f443246b9f29b815f0b98a07bb2d425628ae6522
> Author: Emily Shaffer <emilyshaffer@google.com>
> Date:   Wed Dec 22 04:59:40 2021 +0100
>
>     commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>
>     Move these hooks hook away from run-command.h to and over to the ne=
w
>     hook.h library.
>
>     Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>     Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
>     Acked-by: Emily Shaffer <emilyshaffer@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>  commit.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> bisect run success

Nicely bisected.  Thanks.

I have a feeling that it may have been a deliberate design decision
when =C3=86var revamped the code that drives the hook invocation based on
Emily's code.  =C3=86var, Emily, do any of you remember why we did this,
or is this a mere regression?

Thanks.
