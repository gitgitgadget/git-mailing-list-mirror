Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC4EC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009952245C
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+14x2B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKTBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:07:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKTBH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 20:07:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FEBF21DF1;
        Tue, 19 Nov 2019 20:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c8C2Tuu9y036706FDrwhAzAPHKs=; b=P+14x2
        B9jZdLG55gYkt8bziEzMJHVc2HnM1Qt9LhEopu1Phkt5qoS0TX/9DPzOe0+6Go0k
        DVKarxomAmbPv1ksN+2cgvBbUP759tXrUSe2EqZseLcqemzNJopfCUWtw8nhHbn6
        71C3SjQ+131NiVc37nqgUFX/GRSg+Arsja42Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e7EmpkY+N098bEl9K1UfwI6rZ3wWjgd0
        49fDsf7opO+ruG4ZbefgMiC8ICze1ACh8ebH6/7VE07ptxXdtD426vUYuNCLhoWz
        Tl8H7rDDdRoZbX3Y94RvAT60G3hPtV6mDrNCgH3pSKYkgyPA798oWfQ0ZC6AftfZ
        sfR+T8Dr/Po=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 786C921DEF;
        Tue, 19 Nov 2019 20:07:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEE4121DEE;
        Tue, 19 Nov 2019 20:07:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Chen <erikchen@chromium.org>
Subject: Re: [PATCH v5 1/1] fetch: add trace2 instrumentation
References: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
        <pull.451.v5.git.1574204529.gitgitgadget@gmail.com>
        <d7bf1849ce8430beed3619fb9d87b58746424a54.1574204529.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Nov 2019 10:07:53 +0900
In-Reply-To: <d7bf1849ce8430beed3619fb9d87b58746424a54.1574204529.git.gitgitgadget@gmail.com>
        (Erik Chen via GitGitGadget's message of "Tue, 19 Nov 2019 23:02:09
        +0000")
Message-ID: <xmqqr223e4nq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EC7485C-0B32-11EA-BF58-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Erik Chen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Erik Chen <erikchen@chromium.org>
>
> Add trace2 regions to fetch-pack.c to better track time spent in the various
> phases of a fetch:
>
>     * parsing remote refs and finding a cutoff
>     * marking local refs as complete
>     * marking complete remote refs as common
>
> All stages could potentially be slow for repositories with many refs.
>
> Signed-off-by: Erik Chen <erikchen@chromium.org>
> ---
>  fetch-pack.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Thanks, will queue.
