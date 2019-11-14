Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4801F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKNCPs (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:15:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63056 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNCPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:15:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98339357E3;
        Wed, 13 Nov 2019 21:15:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uvTtqywUK/UGOqD4eBJjagqW8yY=; b=siDQXx
        i84uiakzOk5I+bHYSmVzDn1MkBHtL4+HTDVzjwQwSYYJQhPFarDCw6LIrLwZTslq
        E0xT55vIhhTsZ8g+RfCCcDUR56M2SmfwfEkS/ovEY8OlbvHNCPlGyUWYxlQzi+xa
        3P8ICec4OM4SZ41cRieXZC4Lmvn+izOYC871Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p04v9pfB9kxt2gW1eK0Fb1RDN/7j6j4x
        ap2zOrPmk6L0F1tSgRRT5hHNgvZ5HimOvU3WU4U3VXIptHc1lngYkJbhskC4Vxqv
        IY2YnXbnRpR1XNX5g6R/K+kqcAWbvICBtlmwJ5F2CpoD5mgOFvTV/mmai96ffnNg
        u78BEe1VCAo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F806357E2;
        Wed, 13 Nov 2019 21:15:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0348B357E1;
        Wed, 13 Nov 2019 21:15:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <5d9962d4344fa182b37cd8d969da01bc603414be.1573648866.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Nov 2019 11:15:46 +0900
In-Reply-To: <5d9962d4344fa182b37cd8d969da01bc603414be.1573648866.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Nov 2019
        12:40:57 +0000")
Message-ID: <xmqqimnn9p9p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB75F446-0684-11EA-8740-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The very real downside of the approach we have to take here is that the
> test suite won't pass with `GIT_TEST_ADD_I_USE_BUILTIN=true` until the
> conversion is complete (the `--helper` approach would have let it pass,
> even at each of the incremental conversion steps).

That actually is an issue of the quality of the tests you add for
this series.  If they are organized along the arc of run_add_i()
gaining features, the invocation of "git add -i" in the tests can
selectively use USE_BUILTIN=true to verify what has been rewritten
so far.

In any case, I think I've seen the patches in this part of the
metaseries enough and I think they are quickly stabilizing.  Let's
see if others can find and raise issues and otherwise start cooking
in 'next' sometime next week.

Thanks.
