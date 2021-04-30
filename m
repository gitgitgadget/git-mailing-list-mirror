Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D464C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404C361441
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 03:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhD3DU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 23:20:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54151 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhD3DUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 23:20:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 911B6A83DC;
        Thu, 29 Apr 2021 23:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vlbT4/zkcucmbfMaWRmeG1mUEvvdTr8Tt0oR5o
        pVmlI=; b=Ix/UtoVnUrSiTDjABLnpi+gLprCyI3Y6+1p9WSW0fvPcxNdtozIthm
        j0aIySLQxtspjDuQYLNbksWV9taKMH4pBtGEVoE7gg7c+L2dMXzRHZaNPkqpoFMF
        /yLA/hlf/7hz1OTWGdtKgcxHZDtQAK+4+cGJMTR1x0hQIYlwMWuq8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ECAFA83DA;
        Thu, 29 Apr 2021 23:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97101A83D8;
        Thu, 29 Apr 2021 23:20:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
        <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210423164118.693197-4-lukeshu@lukeshu.com>
        <xmqqfszbcazc.fsf@gitster.g> <87o8dwq2hv.wl-lukeshu@lukeshu.com>
        <CABPp-BHhfT3b=UyWOXACrBb6nw86n74thNAx7DUDF0YNOcA-yA@mail.gmail.com>
        <xmqqim44fyjj.fsf@gitster.g>
        <CABPp-BGUrOtHcu-o2xq-3xc3f=9wy2oxcL_4-ays+ejCg8i+sA@mail.gmail.com>
Date:   Fri, 30 Apr 2021 12:20:05 +0900
In-Reply-To: <CABPp-BGUrOtHcu-o2xq-3xc3f=9wy2oxcL_4-ays+ejCg8i+sA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 29 Apr 2021 19:23:13 -0700")
Message-ID: <xmqq7dkke9wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6246888-A962-11EB-84D4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, if it's just for filter-repo, then I'd say just change
> fast-export's default now.  If you're concerned with
> --signed-commit=abort being a changed default being too drastic for
> other users or tools, then the environment variable escape hatch
> sounds reasonable to me.

I wasn't specifically worried about any single tool.  It is largely
third-party's business, and my job is to make sure it won't be too
hard for them to adjust to our changes.

Even existing users of filter-repo would probably need such an
escape hatch, as it may not necessarily be possible to update
filter-repo at the same time they update Git.

Unless filter-repo refuses to work with a version of Git that is
newer than what it knows about (which is not quite how I would
prepare a tool for external change, though), that is.

> Combine all these "normalizations" that fast-export/fast-import do
> with the ability for users to process the stream from fast-export to
> fast-import and it becomes clear that the only stage in the pipeline
> that can check the validity of the gpg signatures for the imported
> history is the fast-import step.

Yup.  So I guess we two are in agreement wrt the "ideal world".
