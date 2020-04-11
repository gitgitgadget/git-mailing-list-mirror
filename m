Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F5C2BA19
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177422084D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BDUeRUuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDKVkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:40:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53843 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgDKVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 17:40:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68AF8CD09F;
        Sat, 11 Apr 2020 17:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cMO7HmFxfhSnXs4cuaqpj/kL/Bs=; b=BDUeRU
        uvPNYLrhw7LyRc14bYcs8Yjg5mDW72DHW0YvEexSCE2hAdZqFwAzmLusT5IC5GWQ
        sq5RzLRmJoaSz7UlubfOisYl5dZqKUubJTHonv/t+KbMzpbareF7ZitxqcS2MXH+
        mrp53zn3Mzu9kAuxksUxjPtQi7Sxbgs+6eeEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=in+sa3xrL1AI/bqka8GzWc+O0L99ZoOY
        LNDXwfFloELLBhvRTPVIWZP6oqojd1Kbiyz1MJD4xFmz1myHwolMMhtdUhRdTHn0
        hqAyt3iiFB8KTn6a5UqdheBjoxmONxTFXkmtZ53KAHXJTcXVczuTDXr87bdboXkX
        8MFbY0dBkgk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60FDFCD09E;
        Sat, 11 Apr 2020 17:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FC2DCD09B;
        Sat, 11 Apr 2020 17:40:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 14:40:04 -0700
In-Reply-To: <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sat, 11 Apr 2020
        01:02:59 +0000")
Message-ID: <xmqqeesthfbf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0299F41A-7C3D-11EA-BAB7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The changed-path Bloom filters work only when we can compute an
> explicit Bloom filter key in advance. When a pathspec is given
> that allows case-insensitive checks or wildcard matching, we
> must disable the Bloom filter performance checks.

How often do we want to do case-insensitive path matching, I wonder.

As somebody who never touches case-insensitive filesystem, I would
be a bad judge, and I would imagine that I would be looking for a
pathspec "[Mm]akefile" rather than ":(icase)makefile" myself if
there are projects that may have either/both, so I do not mind
disabling the bloom filter for case insensitivity myself.

But if users may use icase pathspec very often, it may be worth
considering to build the bloom filter after downcasing the paths,
perhaps?  Given that many projects extract their source code to a
case insensitive filesystem, I would imagine that downcasing paths
would map two originally different paths into the same thing only
rarely, if ever, so there may not be much downside to do so.

> By checking the pathspec in prepare_to_use_bloom_filters(), we
> avoid setting up the Bloom filter data and thus revert to the
> usual logic.
>
> Before this change, the following tests would fail*:
>
> 	t6004-rev-list-path-optim.sh (Tests 6-7)
> 	t6130-pathspec-noglob.sh (Tests 3-6)
> 	t6131-pathspec-icase.sh (Tests 3-5)
>
> *These tests would fail when using GIT_TEST_COMMIT_GRAPH and
> GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS except that the latter
> environment variable was not set up correctly to write the changed-
> path Bloom filters in the test suite. That will be fixed in the
> next change.

Thanks.  This is exciting.
