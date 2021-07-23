Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D56C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24D360C51
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGWQ7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:59:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61950 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhGWQ7j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:59:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CBD71395EC;
        Fri, 23 Jul 2021 13:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UD2WaRZvTcHbF9vg+811TNzRlP1z4V6ASBCJ62
        sT3SU=; b=JbOmbyLMf8QTWIrZyjxPaN9RjJ0Ia6wZ2ZmZzADVgyAl/GpRchAlOl
        Lk7h+ijTVeZAltVOq8MfRuTBaM4V63QiqBtmOXwL6xd58WnrEVdOTYSU6qJKVSgn
        ldXqoLN/+50FBmJFc8XJC4NBkzRPU+qe9bPQn7sYLFEwzhXGD5k+Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 253C21395EB;
        Fri, 23 Jul 2021 13:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 187881395E9;
        Fri, 23 Jul 2021 13:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 11/11] t6001: avoid direct file system access
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <81e46f955363fee8576b378f22273436e28b3675.1626989327.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:40:07 -0700
In-Reply-To: <81e46f955363fee8576b378f22273436e28b3675.1626989327.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021
        21:28:47 +0000")
Message-ID: <xmqqfsw5nd3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 065049E0-EBDD-11EB-8D4D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t6001-rev-list-graft.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
> index 90d93f77fa7..7294147334a 100755
> --- a/t/t6001-rev-list-graft.sh
> +++ b/t/t6001-rev-list-graft.sh
> @@ -23,7 +23,8 @@ test_expect_success setup '
>  	git commit -a -m "Third in one history." &&
>  	A2=$(git rev-parse --verify HEAD) &&
>  
> -	rm -f .git/refs/heads/main .git/index &&
> +	git update-ref -d refs/heads/main &&
> +	rm -f .git/index &&

Makes sense.  We might want a further clean-up to avoid removing the
index file by hand but that is totally outside the scope of the
"refs" series.

Thanks.
