Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA5C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ABF61002
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhEQUMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 16:12:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56941 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhEQULv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 16:11:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C791A13E5D6;
        Mon, 17 May 2021 16:10:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uWAv947TBBkDpRcGaEJtt8OVRqm1cLffWOvXX2
        n5dso=; b=gePuvKspFa1dY5q7glcQDCJO8SqI0ZNnE73W3nrHBKhCO16N9zQzLU
        w7QHrXj2e1+zxofTpwVCSWkeWoGaqVSx38KQWklrgtByP14AuTWStrBZpV5qXnQ3
        /JMF51DWOmn5giLcLKIoDJ8cWzOiYjE3TBVraQXYUYZ4ufnCVnJq8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEDED13E5D5;
        Mon, 17 May 2021 16:10:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02E2713E5D4;
        Mon, 17 May 2021 16:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 5/9] diff-merges: move specific diff-index "-m"
 handling to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <20210517155818.32224-6-sorganov@gmail.com>
Date:   Tue, 18 May 2021 05:10:28 +0900
In-Reply-To: <20210517155818.32224-6-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 17 May 2021 18:58:14 +0300")
Message-ID: <xmqqwnrx5dfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED853ADA-B74B-11EB-9A68-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Move specific handling of "-m" for diff-index to diff-index.c, so
> diff-merges is left to handle only diff for merges options.
>
> Being a better design by itself, this is especially essential in
> preparation for letting -m imply -p, as "diff-index -m" obviously
> should not imply -p, as it's entirely unrelated.
>
> To handle this, in addition to moving specific diff-index "-m" code
> out of diff-merges, we introduce new
>
>   diff_merges_suppress_options_parsing()
>
> and call it before generic options processing in cmd_diff_index().

This change has a small but obvious fallout.

    $ git diff-index -c --cached HEAD^

now starts failing loudly.  Earlier, it silently fell back to
"combined" diff of one parent, which is "-p".

I think the end result is good (and luckily, "DIFF FORMAT FOR
MERGES" section explicitly limits "-c" and "--cc" to diff-tree,
diff-files and diff (and by implication excludes diff-index) so I am
sure there are small but non-zero number of people somewhere in the
world who has "diff-index -c" in their scripts that suddenly starts
failing with the version of Git with this change, but we can just
say their use was broken ;-)
