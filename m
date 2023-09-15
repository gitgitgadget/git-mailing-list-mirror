Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29FEED61E
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjIOSZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjIOSZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:25:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA02210A
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:25:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FC542EE4D;
        Fri, 15 Sep 2023 14:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/eTCAZho8CvE
        pXqNZJa4WvSvO2cruUA/g0VdrG/mcwo=; b=C6OeyiY/djf9kv+VU01DbggJcxaw
        i3dzwo75kTfzeBoHF0yvfEgalT1Fi42tEpPuUsfzA/C/ENvgUGpXHPfn2juoZW33
        A5bjY4ZaC70qtfpdbxH6G3+AU3wWJa3KTd1hpp6IZTvx0gGYx5HCQnZFwsWv9XK8
        by1/b+8puvS6fas=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 349C92EE4C;
        Fri, 15 Sep 2023 14:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2D1F12EE46;
        Fri, 15 Sep 2023 14:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        derrickstolee@github.com
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
In-Reply-To: <20230911223157.446269-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 11 Sep 2023 15:31:56 -0700")
References: <20230911223157.446269-1-jonathantanmy@google.com>
Date:   Fri, 15 Sep 2023 11:25:09 -0700
Message-ID: <xmqqled7e1kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34BD76AE-53F5-11EE-8638-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is following the discussion about adding a new changed path filter
> version due to the current implementation of murmur3 not matching the
> algorithm. [1]
>
> SZEDER G=C3=A1bor suggested [2] that we change the revision walk to rea=
d
> changed path filters also for root commits, but I don't think that's
> possible - we have to tie reading changed path filters to when we read
> trees, and right now, we don't seem to read trees when evaluating root
> commits (rev_compare_tree() in revision.c is in the only code path that
> uses changed path filters, and it itself is only called per-parent and
> thus not called for root commits). The alternative is to not generate
> changed path filters for root commits (or what I did in this patch,
> which is to generate an all-1 filter), which seems reasonable to me.

I know this is a very silly question, but if the filter is not read
for root commits at runtime, does it matter if a filter is created
for them beforehand (or not)?  They will not be read whether if they
exist or not, no?  One observation in the thread [2] appears in was:

    In several of the above test cases test_bloom_filters_used is invoked
    in a repository with only a root commit, so they don't check that
    the output is the same with and without Bloom filters.

i.e. the check would be ineffective with the current system that we
know does not use the filter for a root commit even if it existed.
But would it be an improvement to add a filter to a root commit and
test with the filter enabled and disabled to compare the results, if
we know the filter is not used anyway?
