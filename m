Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE3161100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347959AbhIHHDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:03:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64170 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbhIHHDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:03:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA338E335B;
        Wed,  8 Sep 2021 03:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LLxMbAckFLjVY+R72DuGCTW2Mj0D57w/+0pnVn
        aYjME=; b=j6J3FTpG60aoZ5u1Rcq7VtLEOtPO/C2yTTABD5nfKLcgtAoJe6Q+nC
        eoqY4jZcOg8X8W+yV0KrtxFFIbKGVQ++fFWoeGW7FPFdU/72ewFSF3NkSbdV+mht
        8mZ1OnUrBv75Nw5OHJdc7UC2h8S05NdiQ8GPGQXuJw2R+slf7o5Tg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E20E0E335A;
        Wed,  8 Sep 2021 03:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 643F3E3359;
        Wed,  8 Sep 2021 03:02:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] t4151: document a pair of am --abort bugs
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 00:02:25 -0700
In-Reply-To: <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 08 Sep 2021
        02:17:08 +0000")
Message-ID: <xmqq8s077doe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B963B12A-1072-11EC-B286-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_failure 'git am --abort returns us to a clean state' '
> +	git checkout changes &&
> +	git format-patch -1 --stdout conflicting >changes.mbox &&
> +	test_must_fail git am --3way changes.mbox &&
> +
> +	# Make a change related to the rest of the am work
> +	echo related change >>file-2 &&
> +
> +	# Abort, and expect the related change to go away too
> +	git am --abort &&
> +	git status --porcelain -uno >actual &&
> +	test_must_be_empty actual

This test makes me worried.  It is perfectly normal for "am" to be
asked to work in a dirty working tree as long as the index is clean
and the working tree files that are involved in the patch are
unmodified.  Even though you may want "am --abort" to restore the
paths that the operation touched to their original state, I am not
sure if that is always possible, given that there may have been
dirty working tree files to begin with.

And the above test would succeed if "git am --abort" internally
called "git reset --hard", which definitely is not what we want to
see.  We want the local changes in dirty working tree files that
weren't involved in the patch application to stay, even after
running "am --abort".
