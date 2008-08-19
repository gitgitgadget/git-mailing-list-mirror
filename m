From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 07:18:32 -0700
Message-ID: <20080819141832.GA20947@spearce.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com> <20080819132803.GA26201@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVS3d-0004LH-FO
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYHSOSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbYHSOSd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:18:33 -0400
Received: from george.spearce.org ([209.20.77.23]:53249 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYHSOSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:18:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A003C38375; Tue, 19 Aug 2008 14:18:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080819132803.GA26201@laptop>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92863>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>   > __git_merge_strategies ()
>   > {
>   >         if [ -n "$__git_merge_strategylist" ]; then
>   >                 echo "$__git_merge_strategylist"
>   >                 return
>   >         fi
>   >         sed -n "/^all_strategies='/{
>   >                 s/^all_strategies='//
>   >                 s/'//
>   >                 p
>   >                 q
>   >                 }" "$(git --exec-path)/git-merge"
>   > }
>   > 
>   > It takes several seconds to finish that function.

Youch.
 
>   Maybe something like this?

Yea, this looks reasonable.  ACK from me, though the bigger change
is to builtin-merge and not the completion. Miklos?  Dscho?

> diff --git a/builtin-merge.c b/builtin-merge.c
> index de025ac..613c96a 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -802,6 +802,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	const char *best_strategy = NULL, *wt_strategy = NULL;
>  	struct commit_list **remotes = &remoteheads;
>  
> +	/* needed for git bash completion and similar tools */
> +	if (argc == 2 && !strcmp(argv[1], "--show-strategies")) {
> +		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
> +			printf("%s\n", all_strategy[i].name);
> +		return 0;
> +	}
> +
>  	setup_work_tree();
>  	if (unmerged_cache())
>  		die("You are in the middle of a conflicted merge.");
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 158b912..1eea49a 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -271,12 +271,7 @@ __git_merge_strategies ()
>  		echo "$__git_merge_strategylist"
>  		return
>  	fi
> -	sed -n "/^all_strategies='/{
> -		s/^all_strategies='//
> -		s/'//
> -		p
> -		q
> -		}" "$(git --exec-path)/git-merge"
> +	$(git --exec-path)/git-merge --show-strategies
>  }
>  __git_merge_strategylist=
>  __git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"

-- 
Shawn.
