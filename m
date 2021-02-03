Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFF5C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E10864D90
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhBCV5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:57:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhBCV5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:57:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FEEA10DE51;
        Wed,  3 Feb 2021 16:56:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tpuDZg2W/xnA12zmRqo3CKKDZV0=; b=jFoMIi
        dVe+hrtkqQG7kjrVUr8TkyOmHrakbO8pNHIaYEuHpnBP2GUVWdvPrWf0wJIyqxfx
        uEPe+rOp9cjq45F87LQPUy293YCanAP2AHU1KIywOuObQ0rMJ2GF6KNqQim1JmIZ
        YP3GwNbYJXsVyu5mxQ4rxHPY9LqbERo+8zcsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Maqr5Kg7M5K6NcGm/hF4wQfGV33eeiBf
        fyqaLmo7/pLxbnFXWBBEA3xkhFmecHt/zU5XnOCOj7uNcO0tSYVIOUnozmF4NtYG
        OMmkKO6Om3Zklfs3XKoOyAOqBE4pxjK92iH/EgrBy6GCPYp5DHhnAbNquwfHhSAt
        WbHnXnMOGBQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8824F10DE50;
        Wed,  3 Feb 2021 16:56:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C299010DE4E;
        Wed,  3 Feb 2021 16:56:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimization batch 6: make full use of exact
 renames
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
        <pull.842.v2.git.1612382628.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 13:56:21 -0800
In-Reply-To: <pull.842.v2.git.1612382628.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 03 Feb 2021 20:03:45
        +0000")
Message-ID: <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A787109E-666A-11EB-9CE8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series depends on en/merge-ort-perf and makes full use of exact
> renames; see commit messages for details.
>
> Thanks to Stolee and Junio for reviewing v1.
>
> Changes since v1:
>
>  * Update rename_src_nr when updating rename_src
>  * Introduce want_copies in the first patch and use it in a few more places
>  * Move a comment below a few exit-early if-checks.
>
> Elijah Newren (2):
>   diffcore-rename: no point trying to find a match better than exact
>   diffcore-rename: filter rename_src list when possible
>
>  diffcore-rename.c | 69 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 8 deletions(-)

Thanks, these look bettrer.

With these changes, I guess there are only two things I find myself
somewhat embarrassing in the rename machinery that is still there
since I invented it.

 - We still need to go full matrix while finding the "best"
   pairing.  I cannot think of a way to avoid it (that is what makes
   it embarrassing) but wish there were some way to.

   In an early attempt, I tried to retire rename_src[j], once
   rename_dst[i] has been found to be a "good enough" match for it,
   from the pool of rename src candidates to find a good match for
   rename_dst[k] for i < k, but naive implementation of it would not
   work well for obvious reasons---rename_src[j] may match a lot
   better with rename_dst[k] than rename_dst[i] but we do not know
   that until we try to estimate similarity with rename_dst[k].


 - The .cnt_data member was designed to be a concise summary of the
   blob characteristics so that two .cnt_data can be "compared"
   fairly cheaply to see how "similar" two blobs are [*], but (1) it
   is rather big to be called a "concise summary", and (2) it was
   not chosen after real performance measurement, and we've been
   using it for the past 15 years without revisiting its design.

   Side note: In a very early prototype, the approach to assess
   similarity between two blobs was very different---there was no
   attempt to compute "concise summary" for each blob, but we just
   attempted to create delta (as in the pack data) between src and
   dst blobs and measured how small a delta we can use to transform
   from src to dst.

