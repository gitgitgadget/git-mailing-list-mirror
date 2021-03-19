Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BDFC433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50816194C
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCSSEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:04:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61840 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSSEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 14:04:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4CF2117138;
        Fri, 19 Mar 2021 14:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DizlNPEfpMZObRPsBcr2C8z+C5Q=; b=H1U0eo
        DmzDALkgETLSUL6fqoKYZWm1VRvkdlBLNJB1beRyB5uUAsE9bl8EuicjOrHPuHJd
        9l8Ovm27bxio/ZlHW2c7lmASe6vK5trkx/rggEGmbqDbIFqBkKJizNGHOrNXbFeU
        lgiLG0eGx8Bp2+u1flegR8Douhe9avU9a8O5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v2tHrA4JoqeNtrIiMYH0HAJ0Rxoa7sgx
        YRkZCUhbemvJN7D+40eN16hoB54I9+lbtjvhmp7ilAMW3uaQW7IeF2f7IM6X1XCT
        dIkEWjmgh3Hqvt8Bb4MDarQEPzlEpZsdoygOIq8UfRa+b/mdAROzOvSVh9QUeJGC
        qg9juaFdIQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDB67117137;
        Fri, 19 Mar 2021 14:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2902117136;
        Fri, 19 Mar 2021 14:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Krushnal Patel via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Krushnal Patel <krushnalpatel11@gmail.com>
Subject: Re: [PATCH] replace test -f with test_path_is_file
References: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 11:04:28 -0700
In-Reply-To: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com> (Krushnal
        Patel via GitGitGadget's message of "Fri, 19 Mar 2021 09:52:06 +0000")
Message-ID: <xmqqr1kbm34j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CE8BD42-88DD-11EB-BE8F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Krushnal Patel via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: krush11 <krushnalpatel11@gmail.com>
>
> Although  has the same functionality as test_path_is_file(), in
> the case where test_path_is_file() fails, we get much better debugging
> information.
>
> Replace  with test_path_is_file so that future developers
> will have a better experience debugging these test cases.

While this change is not wrong per-se, in the context of this test
script, I think the original use of "test -f" is not quite right to
begin with.  These are all "even after running 'git clean', these
paths should exist without getting removed by mistake", so the
intent of these "test -f" invocations are actually "test -e".

Similarly, the invocations of "test ! -f" we see (and there also is
at least one "! test -d") mean to say "these paths should be gone as
the result of running 'git clean'".  If by some accident a directory
exists at the path that is checked with "test ! -f" due to a bug in
'git clean', these tests will not catch such a bug, because a directory
does not pass "test -f".

So most likely these negative tests this patch does not convert are
better off being spelled as "! test -e", too.

It would be more appropriate to use test_path_exists and
test_path_is_missing to replace these "must exist as a file" and
"must not exist as a file".

Thanks.
