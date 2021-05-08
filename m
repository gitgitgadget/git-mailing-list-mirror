Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05AC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 11:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5063761426
	for <git@archiver.kernel.org>; Sat,  8 May 2021 11:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhEHLOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 07:14:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56348 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhEHLOd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 07:14:33 -0400
Received: from host-92-1-139-132.as13285.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lfKtl-000BMX-3j; Sat, 08 May 2021 12:13:29 +0100
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <2b4e818f-9429-83f1-51d6-d8eb0ba618ff@iee.email>
Date:   Sat, 8 May 2021 12:13:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/2021 05:04, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> PNPM 

for me, this was a UNA (un-named abbreviation), can we clarify it, e.g
s/PNPM/& package manager/

> is apparently creating deeply nested (but ignored) directory
> structures; traversing them is costly performance-wise, unnecessary, and
> in some cases is even throwing warnings/errors because the paths are too
> long to handle on various platforms.  Add a testcase that demonstrates
> this problem.
>
> Initial-test-by: Jason Gore <Jason.Gore@microsoft.com>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7300-clean.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index a74816ca8b46..5f1dc397c11e 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_failure 'avoid traversing into ignored directories' '
> +	test_when_finished rm -f output error &&
> +	test_create_repo avoid-traversing-deep-hierarchy &&
> +	(
> +		cd avoid-traversing-deep-hierarchy &&
> +
> +		>directory-random-file.txt &&
> +		# Put this file under directory400/directory399/.../directory1/
> +		depth=400 &&
> +		for x in $(test_seq 1 $depth); do
> +			mkdir "tmpdirectory$x" &&
> +			mv directory* "tmpdirectory$x" &&
> +			mv "tmpdirectory$x" "directory$x"
> +		done &&
> +
> +		git clean -ffdxn -e directory$depth >../output 2>../error &&
> +
> +		test_must_be_empty ../output &&
> +		# We especially do not want things like
> +		#   "warning: could not open directory "
> +		# appearing in the error output.  It is true that directories
> +		# that are too long cannot be opened, but we should not be
> +		# recursing into those directories anyway since the very first
> +		# level is ignored.
> +		test_must_be_empty ../error &&
> +
> +		# alpine-linux-musl fails to "rm -rf" a directory with such
> +		# a deeply nested hierarchy.  Help it out by deleting the
> +		# leading directories ourselves.  Super slow, but, what else
> +		# can we do?  Without this, we will hit a
> +		#     error: Tests passed but test cleanup failed; aborting
> +		# so do this ugly manual cleanup...
> +		while test ! -f directory-random-file.txt; do
> +			name=$(ls -d directory*) &&
> +			mv $name/* . &&
> +			rmdir $name
> +		done
> +	)
> +'
> +
>  test_done

