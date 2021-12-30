Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C6C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhL3W4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:56:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53489 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbhL3W4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:56:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 450FB10D1CC;
        Thu, 30 Dec 2021 17:56:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=22A6ZU50osSnnBQzwpB/269SK4JeBTPibCHhkmNRTIw=; b=gINL
        oueFzlsUC1q/EdQAKqe9SJSDLkmKAw97aZHVjxWu4Yk/08xG0fRl82OZWFbcjg4S
        yRV2x/mPJgv+WCIHuudCyc6tcANf6w1rk0rIXEn4aphnxRHIxPZgOdFZ8PLDrwjn
        PKE7j7n0bmoxPF5TnYlqFn/v75q4AXpydHdaG6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CE5010D1CB;
        Thu, 30 Dec 2021 17:56:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 974D710D1CA;
        Thu, 30 Dec 2021 17:56:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: fix bug with renormalization and
 rename/delete conflicts
References: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
        <78ba0d99-246b-d90c-b725-c084c8304f02@gmail.com>
Date:   Thu, 30 Dec 2021 14:56:42 -0800
Message-ID: <xmqqa6ghog5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C206F04E-69C3-11EC-855D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> This breakdown of the cases is informative, and I like how self-contained
> the change is.
>  ....
>
> This patch looks good to me. Thanks!
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both.

A related tangent, but I was looking at the data structure involved
and noticed that the casting between structure types "merged_info"
and "conflict_info" looked a bit ugly.  It might be worth cleaning
them up into 

 (A) a union with two struct, with "clean" member in the union to
     switch between the two structures; or

 (B) a single structure that looks like "conflict_info" but inlines
     members of "merged_info" into it.

The latter may be cleaner and simpler, and the unified data type
would be the "merge info", which may be representing cleanly merged
path, or conflicted path, and would justify conditional use of some
members based on the value of the .clean member.

