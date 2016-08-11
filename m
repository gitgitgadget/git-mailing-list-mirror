Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F1620193
	for <e@80x24.org>; Thu, 11 Aug 2016 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbcHKOHX (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 10:07:23 -0400
Received: from josefsipek.net ([71.174.113.7]:1657 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbcHKOHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 10:07:22 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Aug 2016 10:07:21 EDT
Received: from meili (meili.valhalla.31bits.net [172.27.0.10])
	by josefsipek.net (Postfix) with ESMTPSA id B5939554D8;
	Thu, 11 Aug 2016 10:01:07 -0400 (EDT)
Date:	Thu, 11 Aug 2016 10:01:04 -0400
From:	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] guilt: update reflog with annotations of guilt-command
 being run
Message-ID: <20160811140104.GC1483@meili>
References: <1468102565-326-1-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468102565-326-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 09, 2016 at 18:16:05 -0400, Theodore Ts'o wrote:
> Many of the updates made by guilt use git update-ref, which means that
> the output of "git reflog" is extremely unedifying, e.g:

This has been an annoyance for me as well.  Thanks for fixing it.  I'll give
it a test run, and likely push it out later today.

Jeff.

> ff0031d HEAD@{177}: reset: moving to ff0031d848a0cd7002606f9feef958de8d5edf19
> 90f4305 HEAD@{178}:
> a638d43 HEAD@{179}:
> ff0031d HEAD@{180}:
> 079788d HEAD@{181}:
> 87a6280 HEAD@{182}:
> 5b9554d HEAD@{183}:
> de9e918 HEAD@{184}: reset: moving to de9e9181bc066d63d78b768e95b5d949e2a8673a
> 5b9554d HEAD@{185}:
> 
> So teach guilt to use the "set_reflog_action" helper, and since
> git-update-ref doesn't respect the GIT_REFLOG_ACTION environment
> variable, use its -m option so that "git reflog" can look like this
> instead:
> 
> 1eaa566 HEAD@{11}: guilt-push: track-more-dependencies-on-transaction-commit
> ab714af HEAD@{12}: guilt-push: move-lockdep-tracking-to-journal_s
> 7a4b188 HEAD@{13}: guilt-push: move-lockdep-instrumentation-for-jbd2-handles
> 78d9625 HEAD@{14}: guilt-push: respect-nobarrier-mount-option-in-nojournal-mode
> d08854f HEAD@{15}: guilt-pop: updating HEAD
> d08854f HEAD@{16}: guilt-pop: updating HEAD
> d08854f HEAD@{17}: guilt-push: optimize-ext4_should_retry_alloc-to-improve-ENOSPC-performance
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
> ---
>  guilt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/guilt b/guilt
> index 35177b9..38d426b 100755
> --- a/guilt
> +++ b/guilt
> @@ -114,6 +114,7 @@ if [ $# -ne 0 ]; then
>  		disp "" >&2
>  		exit 1
>  	fi
> +	set_reflog_action "guilt-$CMDNAME"
>  
>  	shift
>  else
> @@ -640,7 +641,7 @@ commit()
>  		commitish=`git commit-tree $treeish -p $2 < "$TMP_MSG"`
>  		if $old_style_prefix || git rev-parse --verify --quiet refs/heads/$GUILT_PREFIX$branch >/dev/null
>  		then
> -			git update-ref HEAD $commitish
> +			git update-ref -m "$GIT_REFLOG_ACTION" HEAD $commitish
>  		else
>  			git branch $GUILT_PREFIX$branch $commitish
>  			git symbolic-ref HEAD refs/heads/$GUILT_PREFIX$branch
> @@ -687,7 +688,8 @@ push_patch()
>  			fi
>  		fi
>  
> -		commit "$pname" HEAD
> +		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: $pname" \
> +			commit "$pname" HEAD
>  
>  		echo "$pname" >> "$applied"
>  
> -- 
> 2.5.0
> 

-- 
Real Programmers consider "what you see is what you get" to be just as bad a
concept in Text Editors as it is in women. No, the Real Programmer wants a
"you asked for it, you got it" text editor -- complicated, cryptic,
powerful, unforgiving, dangerous.
