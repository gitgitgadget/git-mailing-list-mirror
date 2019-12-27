Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF574C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 20:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE9520828
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfL0Uj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 15:39:28 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:29235 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfL0Uj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 15:39:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47kzFp1Cvjz5tlB;
        Fri, 27 Dec 2019 21:39:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D6463125;
        Fri, 27 Dec 2019 21:39:24 +0100 (CET)
Subject: Re: [PATCH 12/16] t3504: don't use `test_must_fail test_cmp`
To:     Denton Liu <liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
 <b3e4f1698fd86f75f650c7928f2107ea0edd3600.1577454401.git.liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <41175b96-37d7-f550-b9c2-41d569145b91@kdbg.org>
Date:   Fri, 27 Dec 2019 21:39:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <b3e4f1698fd86f75f650c7928f2107ea0edd3600.1577454401.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.12.19 um 14:47 schrieb Denton Liu:
> The test_must_fail function should only be used for git commands since
> we should assume that external commands work sanely. Since test_cmp() just
> wraps an external command, replace `test_must_fail test_cmp` with
> `! test_cmp`.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3504-cherry-pick-rerere.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
> index a267b2d144..c31141c471 100755
> --- a/t/t3504-cherry-pick-rerere.sh
> +++ b/t/t3504-cherry-pick-rerere.sh
> @@ -95,7 +95,7 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
>  test_expect_success 'cherry-pick conflict without rerere' '
>  	test_config rerere.enabled false &&
>  	test_must_fail git cherry-pick master &&
> -	test_must_fail test_cmp expect foo
> +	! test_cmp expect foo

This is VERY suspicious. It is not reliable to check that something
is not exactly equal to something else.

Feel free to replace this patch by the following.

----- 8< -----
t3504: do check for conflict marker after failed cherry-pick

The test with disabled rerere should make sure that the cherry-picked
result does not have the conflict replaced with a recorded resolution.

It attempts to do so by ensuring that the file content is _not_ equal
to some other file. That by itself is a very dubious check because just
about every random result of an incomplete cherry-pick would satisfy
the condition.

In this case, the intent was to check that the conflicting file does
_not_ contain the resolved content. But the check actually uses the
wrong reference file, but not the resolved content. Needless to say
that the non-equality is satisfied. And, on top of it, it uses a commit
that does not even touch the file that is checked.

Do check for the expected result, which is content from both sides of
the merge and merge conflicts. (The latter we check for just the
middle separator for brevity.)

As a side-effect, this also removes an incorrect use of test_must_fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3504-cherry-pick-rerere.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index a267b2d144..80a0d08706 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -94,8 +94,10 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
-	test_must_fail git cherry-pick master &&
-	test_must_fail test_cmp expect foo
+	test_must_fail git cherry-pick foo-master &&
+	grep ===== foo &&
+	grep foo-dev foo &&
+	grep foo-master foo
 '
 
 test_done
-- 
2.24.1.524.gae569673ff
