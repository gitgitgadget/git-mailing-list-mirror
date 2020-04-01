Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68953C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF220737
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A8Y47PEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgDATt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:49:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60306 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732314AbgDATt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:49:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4D5E473E9;
        Wed,  1 Apr 2020 15:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H68i9mX+2LpJEgo6J1UlaDU3nEE=; b=A8Y47P
        EWIqIckzf1jQscvVnR/86v97FXmTJG1+jehwWCyJeA7go39WV0b7hNjPV1aOhLx3
        KStdCk1WYcnsKoPP/7TOvCVLQUKrh37LPoC1wphmM+n2AdnWyCC6PEdZmIbdppxV
        ewYaXC3lBq0mOdYT1eE7NAaCKD2BW21PRcyS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ci4b1GXcoG5wxEskNswqZsOfrDeobAFm
        De669/iHKVd6OVO+OrbYRQtE7qOrzjef3gnzTM8BFx+B1VDbTCR9scjg9Q5G45LX
        WrrV5c0UjXlCn3FyaN2qxS/u4k3vhDka2yBZejUZlI0OFfTg5BVzfVn6x1K/IuR3
        dzYQYLtGdHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC6B5473E8;
        Wed,  1 Apr 2020 15:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C0FB473E6;
        Wed,  1 Apr 2020 15:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 12:49:25 -0700
In-Reply-To: <pull.596.git.1585764695643.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 01 Apr 2020 18:11:35
        +0000")
Message-ID: <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4844158-7451-11EA-8D9F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 53b2e6b4555..4e4efcaff22 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>  		git config core.commitGraph true &&
>  		test_line_count = 2 $graphdir/commit-graph-chain &&
>  		test_commit 15 &&
> -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
> +		touch -m -t 201801010000.00 $graphdir/extra.graph &&

We have "test-tool chmtime" since 17e48368 (Add test-chmtime: a
utility to change mtime on files, 2007-02-24) and refrained from
using "touch -t" anywhere in our tests.  Can we use it here, too?

Especially with its "relative" form, can't we make the test to
stay correct not just for 40 years but forever ;-)?
