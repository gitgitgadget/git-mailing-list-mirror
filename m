From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 2/7] git-rebase--interactive.sh: extract function for
 adding "pick" line
Date: Wed, 18 Jul 2012 08:48:27 -0400
Message-ID: <20120718124827.GD25563@hmsreliant.think-freely.org>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTgC-0002zL-8A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab2GRMsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:48:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:50373 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2GRMsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:48:31 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SrTg4-0002mc-0s; Wed, 18 Jul 2012 08:48:30 -0400
Content-Disposition: inline
In-Reply-To: <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201688>

On Wed, Jul 18, 2012 at 12:27:30AM -0700, Martin von Zweigbergk wrote:
> Extract the code that adds a possibly commented-out "pick" line to the
> todo file. This lets us reuse it more easily later.
> ---
>  git-rebase--interactive.sh | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index bef7bc0..fa722b6 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -828,23 +828,26 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -git rev-list $merges_option --pretty=oneline --abbrev-commit \
> -	--abbrev=7 --reverse --left-right --topo-order \
> -	$revisions | \
> -	sed -n "s/^>//p" |
> -while read -r shortsha1 rest
> -do
>  
> -	if test -z "$keep_empty" && is_empty_commit $shortsha1
> +add_pick_line () {
> +	if test -z "$keep_empty" && is_empty_commit $1
>  	then
>  		comment_out="# "
>  	else
>  		comment_out=
>  	fi
> +	printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
> +}
>  
> +git rev-list $merges_option --pretty=oneline --abbrev-commit \
> +	--abbrev=7 --reverse --left-right --topo-order \
> +	$revisions | \
> +	sed -n "s/^>//p" |
> +while read -r shortsha1 rest
> +do
>  	if test t != "$preserve_merges"
>  	then
> -		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
> +		add_pick_line $shortsha1 "$rest"
>  	else
>  		sha1=$(git rev-parse $shortsha1)
>  		if test -z "$rebase_root"
> @@ -863,7 +866,7 @@ do
>  		if test f = "$preserve"
>  		then
>  			touch "$rewritten"/$sha1
> -			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
> +			add_pick_line $shortsha1 "$rest"
>  		fi
>  	fi
>  done
> -- 
> 1.7.11.1.104.ge7b44f1
> 
> 

Thanks!
Acked-by: Neil Horman <nhorman@tuxdriver.com>
