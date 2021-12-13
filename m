Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF62C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhLMTQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:16:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57514 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhLMTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:16:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04B1815D28A;
        Mon, 13 Dec 2021 14:16:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j0ekmeI4UzXMZ3jn/juz0dkvwiMNRTpMxJPx5O
        QMvtc=; b=yLlwxLs7KWxw1maj/y/yZCSZcapIABuylRjwW0n84i5Amdjrk+DDXo
        mbKlSYPz7bnIX4ruEeTeIYbmKWbFVTYZoMf16SM6aKEvWAN5rWabTqt2E6wpvmyI
        +WphbkcpefJj9n/x53VyS0Q54VdNdsCawHrh+yKmCaLaoyri9JxV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F081215D289;
        Mon, 13 Dec 2021 14:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C47915D288;
        Mon, 13 Dec 2021 14:16:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
        <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
        <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
        <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
        <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
        <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
        <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
        <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
        <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com>
Date:   Mon, 13 Dec 2021 11:16:22 -0800
In-Reply-To: <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com> (Derrick
        Stolee's message of "Fri, 10 Dec 2021 08:57:29 -0500")
Message-ID: <xmqq7dc8co3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29ADC1B0-5C49-11EC-B132-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> You're talking about this hunk, right?
>
> if test -z "$GIT_TEST_CMP"
> then
> 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
> 	then
> 		GIT_TEST_CMP="$DIFF -c"
> 	else
> 		GIT_TEST_CMP="$DIFF -u"
> 	fi
> fi
>
> This only switches from "diff -u" to "diff -c" if the
> GIT_TEST_CMP_USE_COPIED_CONTEXT variable is set, but it is not set
> by default. Thus, we are using "diff -u" by default throughout.

That it can be set merely means that somebody needed to work around
the lack of "-u" format in their implementation of "diff".  It came
to POSIX only at the Issue 7 of the standard (cf. [*1*]).

Unconditional use of "diff -u" is a breaking change for them.

If these people still exist, that is ;-)


[Reference]

*1* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
The Open Group Base Specifications Issue 7, 2018 edition
