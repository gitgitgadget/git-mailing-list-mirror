Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DAAC20899
	for <e@80x24.org>; Mon, 14 Aug 2017 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdHNUcs (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 16:32:48 -0400
Received: from ikke.info ([178.21.113.177]:52898 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752124AbdHNUcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 16:32:47 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 71E64440119; Mon, 14 Aug 2017 22:32:46 +0200 (CEST)
Date:   Mon, 14 Aug 2017 22:32:46 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: prevent warning about null bytes in input
Message-ID: <20170814203246.GA3839@alpha.vpn.ikke.info>
References: <20170814050801.7158-1-me@ikke.info>
 <xmqq7ey6udvl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ey6udvl.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 12:51:26PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > The no_changes function calls the untracked_files function through
> > command substitution. untracked_files will return null bytes because it
> > runs ls-files with the '-z' option.
> >
> > Bash since version 4.4 warns about these null bytes. As they are not
> > required for the test that is being done, remove null bytes from the
> > input.
> 
> That's an interesting one ;-)
> 
> I wonder if you considered giving an option to untracked_files
> helper function, though.  After all, it has only two callers,
> and it feels a bit suboptimal to ask the command to do a special
> thing (i.e. "-z") only to clean it up with a pipe.

As a matter of fact, I did not consider that option. I do agree that's a
much better approach.

> 
> IOW, something along the lines of (totally untested)...
> 

How should I proceed with this? Resubmit it after testing with the
appropriate attribution?


>  git-stash.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index 9b6c2da7b4..5f09a47f0a 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -43,9 +43,16 @@ no_changes () {
>  }
>  
>  untracked_files () {
> +	if test "$1" = "-z"
> +	then
> +		shift
> +		z=-z
> +	else
> +		z=
> +	fi
>  	excl_opt=--exclude-standard
>  	test "$untracked" = "all" && excl_opt=
> -	git ls-files -o -z $excl_opt -- "$@"
> +	git ls-files -o $z $excl_opt -- "$@"
>  }
>  
>  clear_stash () {
> @@ -114,7 +121,7 @@ create_stash () {
>  		# Untracked files are stored by themselves in a parentless commit, for
>  		# ease of unpacking later.
>  		u_commit=$(
> -			untracked_files "$@" | (
> +			untracked_files -z "$@" | (
>  				GIT_INDEX_FILE="$TMPindex" &&
>  				export GIT_INDEX_FILE &&
>  				rm -f "$TMPindex" &&
> 
> 
