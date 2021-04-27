Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD43C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F7061029
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhD0FrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 01:47:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42162 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhD0FrR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 01:47:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5A6371F5AE;
        Tue, 27 Apr 2021 05:46:32 +0000 (UTC)
Date:   Tue, 27 Apr 2021 05:46:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: allow empty patch text
Message-ID: <20210427054632.GA31347@dcvr>
References: <20210427011246.28054-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427011246.28054-1-jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> wrote:
> "git diff" produces no patch text if
> there is no diff, but "git apply" exits
> with code 128 if the patch text is empty.
> 
> Since every valid "git diff" should
> result in a successful patch application
> when applied to the same preimage as
> the diff,

Should it result in successful patch application? (Why?)

I fear this change can cause errors in pipelines to go
undetected (since "set -o pipefail" is not POSIX).
In my experience, zero-byte files is also a common failure mode
for some filesystems, even after fsck marked them as clean.

Perhaps guarding this behavior with --allow-empty (as commit and
cherry-pick do) is safer.

> diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
> index ceb6a79fe0..37351be609 100755
> --- a/t/t4126-apply-empty.sh
> +++ b/t/t4126-apply-empty.sh
> @@ -31,6 +31,13 @@ test_expect_success 'apply empty' '
>  	test_cmp expect empty
>  '
>  
> +test_expect_success 'apply empty diff' '
> +	git reset --hard &&
> +	git diff >empty.patch &&
> +	git apply empty.patch &&
> +	git diff | git apply -
> +'

It shouldn't be necessary to use "git diff" to generate empty
output.  Tests are too slow for me on Linux, even.  Something
like:

	>empty.patch &&
	git apply empty.patch &&
	git apply - <empty.patch

...ought to be realistic enough, but /dev/null in place of
empty.patch is probably portable enough, too.  Thanks.
