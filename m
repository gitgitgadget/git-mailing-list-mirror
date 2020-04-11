Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B2C2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979AA20769
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4bIPnVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDKWDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 18:03:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63215 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDKWDY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 18:03:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5867A4159B;
        Sat, 11 Apr 2020 18:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xQJL37fMUdsWvtlN8WkPIgxl4iQ=; b=C4bIPn
        Vuy/kRRPC5hRPoMLfLP1lCwZgYKgVn7lBj3G+3HC30su+f0OHvdoaIrhyaVbyL4i
        JBFtigMJCwhLMzRAFM1DMnZMhlk3d2zdojCZQ0jwdMKmR8Tov6aV5VXwgYTgOyQt
        LVZumC5ZDZUM9egHKS5qknW7z3bwZloFOz6Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mYJrJFQ+BaW7mMULD1TxSMLFEh/7wrMq
        jUZilPQgiiG4Ov6cua51Br5uDwnRWjz9qEuxB3nIs1ypoNKpiibDYhc/QfzRvyc8
        d8oGFys5F74ypjMcS62/J9u+QvPMU6jK6IiKnThFXOarDrFKSLyWsfCEgonVzUTr
        wymFqkieCE8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F71E41598;
        Sat, 11 Apr 2020 18:03:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0C9841597;
        Sat, 11 Apr 2020 18:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/3] blame: use changed-path Bloom filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <431fde6803140398eec0744c866616a0a78f9433.1586566981.git.gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 15:03:19 -0700
In-Reply-To: <431fde6803140398eec0744c866616a0a78f9433.1586566981.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sat, 11 Apr 2020
        01:03:01 +0000")
Message-ID: <xmqq5ze5he8o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41039DCA-7C40-11EA-B989-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
> Subject: Re: [PATCH 3/3] blame: use changed-path Bloom filters

Ahh, I almost forgot we spell Bloom with capital B, so I should go
back and amend the title of [2/3].

> When computing a blame, there is a section in find_origin() that
> computes a diff between a commit and one of its parents. When this
> is the first parent, we can check the Bloom filters before calling
> diff_tree_oid().
>
> In order to make this work with the blame machinery, we need to
> initialize a struct bloom_key with the initial path. But also, we
> need to add more keys to a list if a rename is detected. We then
> check to see if _any_ of these keys answer "maybe" in the diff.

Yes.  I think after gaining experience with this technique, we may
be able to speed up the "git log --follow" while correcting its
semantics at the same time.  The prospect is unnervingly exciting.

> Generally, this is a performance enhancement and should not
> change the behavior of 'git blame' in any way.

Absolutely.

> The lack of improvement for the MAINTAINERS file and the relatively
> modest improvement for the other examples can be easily explained.
> The blame machinery needs to compute line-level diffs to determine
> which lines were changed by each commit. That makes up a large
> proportion of the computation time, and this change does not
> attempt to improve on that section of the algorithm. The
> MAINTAINERS file is large and changed often, so it takes time to
> determine which lines were updated by which commit. In contrast,
> the code files are much smaller, and it takes longer to comute
> the line-by-line diff for a single patch on the Linux mailing
> lists.

Yup, tree-diff for a deeper path would benefit the most, and your
numbers were indeed impressive.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  blame.c         | 139 ++++++++++++++++++++++++++++++++++++++++++++----
>  blame.h         |   6 +++
>  builtin/blame.c |  10 ++++
>  3 files changed, 146 insertions(+), 9 deletions(-)

I am kind-a surprised how little additional code it takes to do
this.  Good job.
