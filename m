Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AE7C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1ED61D86
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhF2Oof (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:44:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhF2Oof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 10:44:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB0A1129D6B;
        Tue, 29 Jun 2021 10:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CIVyImywSPGYWpz8KxzZo0clrJAE+Z4cuToZB5
        flqfU=; b=mbeWqcTdw8vmjD/a/Uj/zJWwmzfn5tL+R5XPd48G/C9fg2QkEpl2nj
        2/RJtJwGJ6q1qiasZwB2/r+xODfhhJdeZbYfRvXtmtGkThfhBt9qRtXkW2rF/IaF
        LVyANmLP8d5A6TjNPsFt0ss06Hh7tOgvX94YhFoPCxZKSQ1nMnrYM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2AD6129D6A;
        Tue, 29 Jun 2021 10:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11A76129D69;
        Tue, 29 Jun 2021 10:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 5/5] oidtree: a crit-bit tree for odb_loose_cache
References: <20210627024718.25383-1-e@80x24.org>
        <20210627024718.25383-6-e@80x24.org>
Date:   Tue, 29 Jun 2021 07:42:03 -0700
In-Reply-To: <20210627024718.25383-6-e@80x24.org> (Eric Wong's message of
        "Sun, 27 Jun 2021 02:47:18 +0000")
Message-ID: <xmqqzgv8ybpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C392260-D8E8-11EB-BD66-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> This saves 8K per `struct object_directory', meaning it saves
> around 800MB in my case involving 100K alternates (half or more
> of those alternates are unlikely to hold loose objects).
>
> This is implemented in two parts: a generic, allocation-free
> `cbtree' and the `oidtree' wrapper on top of it.  The latter
> provides allocation using alloc_state as a memory pool to
> improve locality and reduce free(3) overhead.

This seems to break CI test, with "fatal: not a hexadecimal oid",
perhaps because there is hardcoded 40 here?

> index 0000000000..bb4229210c
> --- /dev/null
> +++ b/t/t0069-oidtree.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='basic tests for the oidtree implementation'
> +. ./test-lib.sh
> +
> +echoid () {
> +	prefix="${1:+$1 }"
> +	shift
> +	while test $# -gt 0
> +	do
> +		echo "$1"
> +		shift
> +	done | awk -v prefix="$prefix" '{
> +		printf("%s%s", prefix, $0);
> +		need = 40 - length($0);
> +		for (i = 0; i < need; i++)
> +			printf("0");
> +		printf "\n";
> +	}'
