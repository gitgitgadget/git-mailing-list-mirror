Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16CD1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfIZWgn (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 18:36:43 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55759 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIZWgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 18:36:42 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8F6AB40006;
        Thu, 26 Sep 2019 22:36:40 +0000 (UTC)
Date:   Fri, 27 Sep 2019 04:06:38 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
Message-ID: <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
References: <pull.361.git.gitgitgadget@gmail.com>
 <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 26/09/19 02:17PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Since v2.9.0, Git knows about the config variable core.hookspath
> that allows overriding the path to the directory containing the
> Git hooks.
> 
> Since v2.10.0, the `--git-path` option respects that config
> variable, too, so we may just as well use that command.
> 
> For Git versions older than v2.5.0 (which was the first version to
> support the `--git-path` option for the `rev-parse` command), we
> simply fall back to the previous code.
> 
> This fixes https://github.com/git-for-windows/git/issues/1755
> 
> Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index fd476b6999..b2c6e7a1db 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -623,7 +623,11 @@ proc git_write {args} {
>  }
>  
>  proc githook_read {hook_name args} {
> -	set pchook [gitdir hooks $hook_name]
> +	if {[package vcompare $::_git_version 2.5.0] >= 0} {
> +		set pchook [git rev-parse --git-path "hooks/$hook_name"]
> +	} else {
> +		set pchook [gitdir hooks $hook_name]
> +	}

gitdir is used in a lot of places, and I think all those would also 
benefit from using --git-path. So I think it is a better idea to move 
this to the procedure gitdir. It would have to be refactored to take any 
number of arguments, instead of the two it takes here.

Other than that, looks good. Thanks.

-- 
Regards,
Pratyush Yadav
