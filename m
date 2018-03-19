Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F861F404
	for <e@80x24.org>; Mon, 19 Mar 2018 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933750AbeCSWjv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 18:39:51 -0400
Received: from avasout06.plus.net ([212.159.14.18]:40083 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbeCSPrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:21 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2018 11:47:20 EDT
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id xwt0e35zuy3jixwt1eUlBd; Mon, 19 Mar 2018 15:39:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fL8XI6Se c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=rIbfA5mB_Exxa7A2eHYA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <charles@hashpling.org>)
        id 1exwt0-0002J5-33; Mon, 19 Mar 2018 15:39:46 +0000
Date:   Mon, 19 Mar 2018 15:39:46 +0000
From:   CB Bailey <charles@hashpling.org>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: use printf instead of echo -e
Message-ID: <20180319153945.kchupu43cpcbg25n@hashpling.org>
References: <20180319144905.11564-1-michele@locati.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319144905.11564-1-michele@locati.it>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfEEX+ob5MjvrpUx5baNY8uFzR5E06j9neLH9eIvINULyId/sRsr7t6J+UO6A637NN/9zNPjoqXvrw/HzQB767Lkgx2CU9sMsJ6rU1dyJmXzfrP6z90dZ
 aihM85HUYnKDGo9ICT3nftEtWbo8n/9563vqOFqNKZwq02xCUdRFJ2hDhTbEaoPCaUF+9V98KV+vRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 03:49:05PM +0100, Michele Locati wrote:
> In order to echo a tab character, it's better to use printf instead of
> "echo -e", because it's more portable (for instance, "echo -e" doesn't work
> as expected on a Mac).
> 
> This solves the "fatal: Not a valid object name" error in git-filter-branch
> when using the --state-branch option.
> 
> Signed-off-by: Michele Locati <michele@locati.it>
> ---
>  git-filter-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 1b7e4b2cd..21d84eff3 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -627,7 +627,7 @@ then
>  				print H "$_:$f\n" or die;
>  			}
>  			close(H) or die;' || die "Unable to save state")
> -	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
> +	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
>  	if test -n "$state_commit"
>  	then
>  		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")

I think the change from 'echo -e' to printf is good because of the
better portability reason that you cite.

Looking at the change, I am now curious as to why '/bin/echo' is used.
Testing on a Mac, bash's built in 'echo' recognizes '-e' whereas
'/bin/echo' does not. This is just an observation, I still prefer the
move to 'printf' that you suggest.

There are two further uses of '/bin/echo' in git-filter-branch.sh which
are portable (no "-e", just printing a word that cannot be confused for
an option). One is visible in your diff context and the other is just
below it. For consistency with other echos in git-filter-branch.sh, I
think that these should probably use simple 'echo' rather than
'/bin/echo' to use a builtin where available.

CB
