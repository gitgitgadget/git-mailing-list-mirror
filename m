Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C86C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354476AbiCXUuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348813AbiCXUtw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:49:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05888DF1F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:48:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26B73105B6A;
        Thu, 24 Mar 2022 16:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ibo/9y6xxuZKfxAGddrH4yFJGi9t8h8QpihvjI
        wBrQA=; b=gVBshJpUz5iWA7oxoPU47b8OeBwOu51Nf9a1Mfzi/9Im2mmGJwrCD5
        P0mEEKy8WQ/4TN7YbSicrPl1gukf4dujXBs067JxhlKdgLD/n73hFLj4IJLcOqTD
        hT31CKujSD+t/fEA/NYckCNz9laaydF9c28X5afL4PHso/0lwW+bM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EB48105B68;
        Thu, 24 Mar 2022 16:48:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DC2D105B66;
        Thu, 24 Mar 2022 16:48:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/2] test-lib-functions: fix test_subcommand_inexact
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 13:48:15 -0700
In-Reply-To: <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Mar 2022
        18:34:57 +0000")
Message-ID: <xmqqtubnf568.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAF8063A-ABB3-11EC-8BFF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The implementation of test_subcommand_inexact() was originally
> introduced in e4d0c11c0 (repack: respect kept objects with '--write-midx
> -b', 2021-12-20) with the intention to allow finding a subcommand based
> on an initial set of arguments. The inexactness was intended as a way to
> allow flexible options beyond that initial set, as opposed to
> test_subcommand() which requires that the full list of options is
> provided in its entirety.
>
> The implementation began by copying test_subcommand() and replaced the
> repeated argument 'printf' statement to append ".*" instead of "," to
> each argument. This has a few drawbacks:
>
> 1. Most importantly, this repeats the use of ".*" within 'expr', so the
>    inexact match is even more flexible than expected. It allows the list
>    of arguments to exist as a subsequence (with any other items included
>    between those arguments).
>
> 2. The line 'expr="$(expr%,}"' that previously removed a trailing comma
>    now no longer does anything, since the string ends with ".*".
>
> Both of these issues are fixed by keeping the addition of the comma in
> the printf statement, then adding ".*" after stripping out the trailing
> comma.
>
> All existing tests continue to pass with this change. There was one
> instance from t7700-repack.sh that was taking advantage of this
> flexibility, but it was removed in the previous change.

Of course all existing tests continue to pass, as we no longer have
any user of test_subcommand_inexact after the previous step ;-).

Among

 (1) doing nothing,
 (2) removing, and
 (3) clarifying the implementation,

my preference would be 2 > 1 > 3.  If we add

 (4) clarify the implementation and document what kind of inexactness we
     tolerate with an updated comment"

to the mix, that would come before all 3 others, though.

Perhaps squash something like this in?

 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
index 0f439c99d6..6f6afae847 100644
--- i/t/test-lib-functions.sh
+++ w/t/test-lib-functions.sh
@@ -1789,8 +1789,8 @@ test_subcommand () {
 }
 
 # Check that the given command was invoked as part of the
-# trace2-format trace on stdin, but without an exact set of
-# arguments.
+# trace2-format trace on stdin, but only require that the
+# initial arguments are given as specified.
 #
 #	test_subcommand [!] <command> <args>... < <trace>
 #
