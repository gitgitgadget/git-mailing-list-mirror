Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9AC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiCBHhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiCBHho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 02:37:44 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F545ADC
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 23:37:01 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A22C8174670;
        Wed,  2 Mar 2022 02:37:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6jcd/s/8H/cjwjxAspdBMX3ff1hgtFjpcwltD
        /F8qg=; b=ObUr+gp2y2MqsMJ2gyDJDjrkbPRM+1SK+Vjb+TE82QDlteZmDfjlFF
        M1kHh0Z8Ub170nRr1fcrT11zoXqX279VDfMVh+N4+0iCCpYgtjXeX5KDz3p5pa/M
        BDOpXJiauh33/UWKI6T49rMZAN6LRqROjTtoZ0oLZeCnqT68EUqfk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99EE717466F;
        Wed,  2 Mar 2022 02:37:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2162017466D;
        Wed,  2 Mar 2022 02:36:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v5] repo_read_index: add config to expect files outside
 sparse patterns
References: <20220226061222.797107-1-newren@gmail.com>
        <20220302043301.1620188-1-newren@gmail.com>
Date:   Tue, 01 Mar 2022 23:36:58 -0800
In-Reply-To: <20220302043301.1620188-1-newren@gmail.com> (Elijah Newren's
        message of "Tue, 1 Mar 2022 20:33:01 -0800")
Message-ID: <xmqq1qzkolet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B1F1760-99FB-11EC-96A9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Typically with sparse checkouts, we expect files outside the sparsity
> patterns to be marked as SKIP_WORKTREE and be missing from the working
> tree.  Sometimes this expectation would be violated however; including
> in cases such as:
>   * users grabbing files from elsewhere and writing them to the worktree
>     (perhaps by editing a cached copy in an editor, copying/renaming, or
>      even untarring)
>   * various git commands having incomplete or no support for the
>     SKIP_WORKTREE bit[1,2]
>   * users attempting to "abort" a sparse-checkout operation with a
>     not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
>     working tree is not atomic)[3].
> When the SKIP_WORKTREE bit in the index did not reflect the presence of
> the file in the working tree, it traditionally caused confusion and was
> difficult to detect and recover from.  So, in a sparse checkout, since
> af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files present
> in worktree", 2022-01-06), Git automatically clears the SKIP_WORKTREE

The reference is a bit off here.  Here is what I get locally:

    af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
    present in worktree, 2022-01-14)

and that is in the version I have locally in 'next'.

> [1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
> [2] The three long paragraphs in the middle of
>     https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
> [3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
> [4] such as the vfsd described in

Here is another difference from the version I have locally in
'next', which I didn't notice that this [4] was misspelt as [1]
before applying.

Everything else seems the same, so let's not bother reverting the
old one out of 'next' and merging this version after fixing this
version up.  What we have is good enough modulo [4] vs [1].

Thanks.

