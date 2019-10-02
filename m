Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DB41F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 19:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfJBT4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 15:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfJBT4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 15:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CC27AD4E;
        Wed,  2 Oct 2019 19:56:48 +0000 (UTC)
Date:   Wed, 2 Oct 2019 21:56:46 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
Message-ID: <20191002195646.GF17916@kitsune.suse.cz>
References: <pull.373.git.gitgitgadget@gmail.com>
 <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 02, 2019 at 11:05:13AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When parsing the diffs, `range-diff` expects to see the prefixes `a/`
> and `b/` in the diff headers.
> 
> These prefixes can be forced off via the config setting
> `diff.noprefix=true`. As `range-diff` is not prepared for that
> situation, this will cause a segmentation fault.
> 
> Let's avoid that by forcing `diff.noprefix=false` just for that all to
> `git log` that generates the diffs that `range-diff` wants to parse.
> 
> Noticed-by: Michal Suchánek <msuchanek@suse.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Tested-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal
> ---
>  range-diff.c          | 3 ++-
>  t/t3206-range-diff.sh | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/range-diff.c b/range-diff.c
> index ba1e9a4265..8cc348b4cb 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -50,7 +50,8 @@ static int read_patches(const char *range, struct string_list *list)
>  	int offset, len;
>  	size_t size;
>  
> -	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> +	argv_array_pushl(&cp.args, "-c", "diff.noprefix=false",
> +			"log", "--no-color", "-p", "--no-merges",
>  			"--reverse", "--date-order", "--decorate=no",
>  			/*
>  			 * Choose indicators that are not used anywhere
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 0120f769f1..64b66f2094 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -461,4 +461,8 @@ test_expect_success 'format-patch --range-diff as commentary' '
>  	grep "> 1: .* new message" 0001-*
>  '
>  
> +test_expect_success 'range-diff overrides diff.noprefix internally' '
> +	git -c diff.noprefix=true range-diff HEAD^...
> +'
> +
>  test_done
> -- 
> gitgitgadget
