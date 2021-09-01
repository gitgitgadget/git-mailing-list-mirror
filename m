Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC3C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B437E61075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346742AbhIASJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 14:09:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54811 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbhIASJA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 14:09:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60165CEE45;
        Wed,  1 Sep 2021 14:08:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U9XhOq1CxmFgsuNm1ZHfD5urVebcfOvq4Y73d4
        TpWNI=; b=NDjtfdJFid0HMgiOZIDEnuz61OqvhD0ZB8PYtvTYCL/sq1i601WnCT
        GvfYt/Q7n/W/p6V8MnQPr4+KP2xz/8/dkjvi9CdmyaiRVstcj+g8WnQncdpGS/un
        UqdC+6Y2yvvPyA/jhGRpthC7ALC8QiHUNIlmtgGQQORcRRURYyZN8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE2FACEE44;
        Wed,  1 Sep 2021 14:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A7D7CEE43;
        Wed,  1 Sep 2021 14:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 00/27] multi-pack reachability bitmaps
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1630443072.git.me@ttaylorr.com>
Date:   Wed, 01 Sep 2021 11:07:59 -0700
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 31 Aug 2021 16:51:33 -0400")
Message-ID: <xmqq5yvkqidc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B795C7E-0B4F-11EC-BA9E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is another version of the multi-pack reachability bitmaps series. It is
> virtually unchanged since last time.
>
> The changes that did occur is that I integrated Johannes' patch from [1] to fix
> cleaning up MIDX .rev and .bitmap files when using `--object-dir`. That inspired
> a lengthy discussion [2] about `--object-dir`, alternates, object-format and
> running the MIDX builtin outside of a Git repository.
>
> This series resolves that discussion by leaving everything as-is, and only
> changing the following:
>
>   - `git multi-pack-index` will not run when outside of a Git
>     repository.
>
>   - The `--object-dir` argument will only recognize object directories
>     belonging to an alternate of the current repository.
>
>   - Using `--object-dir` to point to a repository which uses a
>     different hash than the repository in the current working directory
>     will continue to not work (as was the case before this series).
>
> And because this incorporates [1], we will also not accidentally clean `.rev`
> files from the wrong object directory.
>
> I think that this version is ready-to-go, and that we can turn our attention to
> squashing some of these cross-alternate buglets, and integrating MIDX bitmaps
> with `git repack`.

Thanks.

>     +@@ Documentation/git-multi-pack-index.txt: OPTIONS
>     + 	Use given directory for the location of Git objects. We check
>     + 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
>     + 	`<dir>/packs` for the pack-files to index.
>     +++
>     ++`<dir>` must be an alternate of the current repository.

After replacing the previous round with this round and running "git
diff @{1}" on the branch, I noticed this documentation update, but
did't find any new code that tries to ensure that the requirement is
met.  It's a bit curious omission.

I think it is OK to allow running this command on <dir> and then add
it as a new alternate (iow, the <dir> being an alternate is not a
strict requirement for correct computation and writing of the midx,
even though it may be a requirement for correct use of the resulting
midx), so perhaps that is where the lack of validation comes from?

THanks.

