From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Fri, 6 Mar 2009 08:04:52 -0800
Message-ID: <20090306160452.GH16213@spearce.org>
References: <cover.1236314073.git.jaysoffian@gmail.com> <2d83927582e9eed004b9fd12b77105a184277229.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcZ5-0003dD-Sd
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZCFQE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbZCFQEz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:04:55 -0500
Received: from george.spearce.org ([209.20.77.23]:40641 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZCFQEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:04:54 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9A54938211; Fri,  6 Mar 2009 16:04:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2d83927582e9eed004b9fd12b77105a184277229.1236314073.git.jaysoffian@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112456>

Jay Soffian <jaysoffian@gmail.com> wrote:
> The code to complete --strategy was duplicated between _git_rebase and
> _git_merge, and is about to gain a third caller (_git_pull). This patch
> factors it into its own function.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

Looks OK to me, but I had to squash this in to get it to work.
Without this the patch breaks git merge completion entirely:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e16576..80d464b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -449,15 +449,15 @@ __git_complete_strategy ()
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
 		__gitcomp "$(__git_merge_strategies)"
-		return 1
+		return 0
 	esac
 	case "$cur" in
 	--strategy=*)
 		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
-		return 1
+		return 0
 		;;
 	esac
-	return 0
+	return 1
 }
 
 __git_all_commands ()
@@ -1111,9 +1111,8 @@ _git_log ()
 
 _git_merge ()
 {
-	__git_complete_strategy && return
-
 	local cur="${COMP_WORDS[COMP_CWORD]}"
+	__git_complete_strategy && return
 	case "$cur" in
 	--*)
 		__gitcomp "

> ---
>  contrib/completion/git-completion.bash |   37 ++++++++++++++++---------------
>  1 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b347fdd..8924185 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -440,6 +440,22 @@ __git_complete_remote_or_refspec ()
>  	esac
>  }
>  
> +__git_complete_strategy ()
> +{
> +	case "${COMP_WORDS[COMP_CWORD-1]}" in
> +	-s|--strategy)
> +		__gitcomp "$(__git_merge_strategies)"
> +		return 1
> +	esac
> +	case "$cur" in
> +	--strategy=*)
> +		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
> +		return 1
> +		;;
> +	esac
> +	return 0
> +}
> +
>  __git_all_commands ()
>  {
>  	if [ -n "$__git_all_commandlist" ]; then
> @@ -1086,17 +1102,10 @@ _git_log ()
>  
>  _git_merge ()
>  {
> +	__git_complete_strategy && return
> +
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> -	case "${COMP_WORDS[COMP_CWORD-1]}" in
> -	-s|--strategy)
> -		__gitcomp "$(__git_merge_strategies)"
> -		return
> -	esac
>  	case "$cur" in
> -	--strategy=*)
> -		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
> -		return
> -		;;
>  	--*)
>  		__gitcomp "
>  			--no-commit --no-stat --log --no-log --squash --strategy
> @@ -1165,16 +1174,8 @@ _git_rebase ()
>  		__gitcomp "--continue --skip --abort"
>  		return
>  	fi
> -	case "${COMP_WORDS[COMP_CWORD-1]}" in
> -	-s|--strategy)
> -		__gitcomp "$(__git_merge_strategies)"
> -		return
> -	esac
> +	__git_complete_strategy && return
>  	case "$cur" in
> -	--strategy=*)
> -		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
> -		return
> -		;;
>  	--*)
>  		__gitcomp "--onto --merge --strategy --interactive"
>  		return
> -- 
> 1.6.2.rc2.332.g5d21b
> 

-- 
Shawn.
