Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3663E1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfHYWcb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 18:32:31 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:33106 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbfHYWca (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 18:32:30 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i213j-0002LA-C8; Sun, 25 Aug 2019 23:32:28 +0100
Subject: Re: [PATCH] t7300-clean: demonstrate deleting nested repo with an
 ignored file breakage
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Samuel Lijin <sxlijin@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <20f71f02-4895-fe57-8704-a44494b971b9@iee.email>
Date:   Sun, 25 Aug 2019 23:32:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825185918.3909-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Szeder,

On 25/08/2019 19:59, SZEDER Gábor wrote:
> 'git clean -fd' must not delete an untracked directory if it belongs
s/untracked//
I don't believe it should matter either way for a sub-module 
(sub-directory).
> to a different Git repository or worktree.
msybr split the assertion from the fault explanation.
>   Unfortunately, if a
> '.gitignore' rule in the outer repository happens to match a file in a
> nested repository or worktree, then something goes awry and 'git clean
> -fd' does delete the content of the nested repository's worktree
good so far.
> except that ignored file, potentially leading to data loss.
this appears at cross purposes as the description has changed from 
'ignored/untracked directory' to 'ignored file'. I'm not sure which part 
the data loss is meant to refer to.
>
> Add a test to 't7300-clean.sh' to demonstrate this breakage.
>
> This issue is a regression introduced in 6b1db43109 (clean: teach
> clean -d to preserve ignored paths, 2017-05-23).
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>
> BEWARE: Our toplevel '.gitignore' currently contains the '*.manifest'
> rule [1], which ignores the file 'compat/win32/git.manifest' [2], so
> if you use nested worktrees in your git repo, then a 'git clean -fd'
> will delete them.
>
> [1] 516dfb8416 (.gitignore: touch up the entries regarding Visual
>      Studio, 2019-07-29)
> [2] fe90397604 (mingw: embed a manifest to trick UAC into Doing The
>      Right Thing, 2019-06-27)
>
>
>   t/t7300-clean.sh | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index a2c45d1902..d01fd120ab 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -669,6 +669,28 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
>   	test_path_is_missing foo/b/bb
>   '
>   
> +test_expect_failure 'git clean -d skips nested repo containing ignored files' '
> +	test_when_finished "rm -rf nested-repo-with-ignored-file" &&
> +
> +	git init nested-repo-with-ignored-file &&
> +	(
> +		cd nested-repo-with-ignored-file &&
> +		>file &&
> +		git add file &&
> +		git commit -m Initial &&
> +
> +		# This file is ignored by a .gitignore rule in the outer repo
> +		# added in the previous test.
> +		>ignoreme
> +	) &&
> +
> +	git clean -fd &&
> +
> +	test_path_is_file nested-repo-with-ignored-file/.git/index &&
> +	test_path_is_file nested-repo-with-ignored-file/ignoreme &&
> +	test_path_is_file nested-repo-with-ignored-file/file
> +'
> +
>   test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
>   	test_config core.longpaths false &&
>   	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&

