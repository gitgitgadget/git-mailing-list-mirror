Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A01202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 08:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdJXIUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 04:20:33 -0400
Received: from ikke.info ([178.21.113.177]:42108 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdJXIUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 04:20:31 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id B8F34440393; Tue, 24 Oct 2017 10:20:29 +0200 (CEST)
Date:   Tue, 24 Oct 2017 10:20:29 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: do not get confused by submodules in excluded
 directories
Message-ID: <20171024082029.GB7987@alpha.vpn.ikke.info>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 03:10:11PM +0200, Johannes Schindelin wrote:
> We meticulously pass the `exclude` flag to the `treat_directory()`
> function so that we can indicate that files in it are excluded rather
> than untracked when recursing.
> 
> But we did not yet treat submodules the same way.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/submodule-in-excluded-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git submodule-in-excluded-v1
>  dir.c                      |  2 +-
>  t/t7061-wtstatus-ignore.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index 1d17b800cf3..9987011da57 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1392,7 +1392,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  		if (!(dir->flags & DIR_NO_GITLINKS)) {
>  			unsigned char sha1[20];
>  			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
> -				return path_untracked;
> +				return exclude ? path_excluded : path_untracked;
>  		}
>  		return path_recurse;
>  	}
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index fc6013ba3c8..8c849a4cd2f 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -272,4 +272,18 @@ test_expect_success 'status ignored tracked directory with uncommitted file in t
>  	test_cmp expected actual
>  '
>  
> +cat >expected <<\EOF
> +!! tracked/submodule/
> +EOF
> +
> +test_expect_success 'status ignores submodule in excluded directory' '
> +	git init tracked/submodule &&
> +	(
> +		cd tracked/submodule &&
> +		test_commit initial
> +	) &&

Could this use test_commit -C tracked/submodule initial?

> +	git status --porcelain --ignored -u tracked/submodule >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
> 
> base-commit: 111ef79afe185f8731920569450f6a65320f5d5f
> -- 
> 2.14.2.windows.3
