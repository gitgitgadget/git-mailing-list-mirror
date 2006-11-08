X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Return non-zero status from pull if merge fails.
Date: Tue, 07 Nov 2006 16:05:27 -0800
Message-ID: <7vy7qmzttk.fsf@assigned-by-dhcp.cox.net>
References: <20061107181053.GA26856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 00:05:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061107181053.GA26856@spearce.org> (Shawn O. Pearce's message
	of "Tue, 7 Nov 2006 13:10:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31102>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghawe-00055X-So for gcvg-git@gmane.org; Wed, 08 Nov
 2006 01:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753753AbWKHAF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 19:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbWKHAF3
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 19:05:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22479 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1753753AbWKHAF3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 19:05:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061108000528.RJID13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 19:05:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id k0551V0011kojtg0000000; Tue, 07 Nov 2006
 19:05:05 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/git-merge.sh b/git-merge.sh
> index cb09438..7725908 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -203,7 +203,7 @@ f,*)
>  	git-update-index --refresh 2>/dev/null
>  	new_head=$(git-rev-parse --verify "$1^0") &&
>  	git-read-tree -u -v -m $head "$new_head" &&
> -	finish "$new_head" "Fast forward"
> +	finish "$new_head" "Fast forward" || exit 1
>  	dropsave
>  	exit 0
>  	;;

The shell function "finish" itself exits when there is an error;
is this needed?

> @@ -214,7 +214,7 @@ f,*)
> +	git var GIT_COMMITTER_IDENT >/dev/null || exit 1
> @@ -225,7 +225,7 @@ f,*)
> +	    ) || exit 1
> @@ -253,7 +253,7 @@ f,*)
> +git var GIT_COMMITTER_IDENT >/dev/null || exit 1
> @@ -327,7 +327,7 @@ done
> +    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit 1

Are these needed?  Wouldn't "something || exit" already exit non-zero
when something exits non-zero?

> diff --git a/git-pull.sh b/git-pull.sh
> index ed04e7d..d10fcdd 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -102,6 +102,6 @@ case "$strategy_args" in
>  esac
>  
>  merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
> -git-merge "--reflog-action=pull $*" \
> +exec git-merge "--reflog-action=pull $*" \
>  	$no_summary $no_commit $squash $strategy_args \
>  	"$merge_name" HEAD $merge_head

I think this is a good change.
