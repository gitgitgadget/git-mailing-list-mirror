From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: complete full refs
Date: Thu, 27 Nov 2008 16:51:36 -0800
Message-ID: <20081128005136.GE23984@spearce.org>
References: <1227792947-4055-1-git-send-email-szeder@ira.uka.de> <20081127212938.GB23984@spearce.org> <20081128004638.GA6854@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SZEDER GGGbor <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5rbR-00019t-GY
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYK1Avi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYK1Avh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:51:37 -0500
Received: from george.spearce.org ([209.20.77.23]:41634 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYK1Avh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:51:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DE4A038200; Fri, 28 Nov 2008 00:51:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081128004638.GA6854@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101851>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> Sometimes it's handy to complete full refs, e.g. the user has some
> refs outside of refs/{heads,remotes,tags} or the user wants to
> complete some git command's special refs (like 'git show
> refs/bisect/bad').
...
> On Thu, Nov 27, 2008 at 01:29:38PM -0800, Shawn O. Pearce wrote:
> > I wonder if the pattern shouldn't be:
> > 
> > 	refs|refs/*)
> > 
> > to reduce the risk of matching "refs-" and trying to do a full ref
> > match instead of a short ref match.
> Good point.  Adjusted the code and commit message accordingly.

Thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

 
>  contrib/completion/git-completion.bash |   19 +++++++++++++++----
>  1 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0ee071b..244ed41 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -188,11 +188,22 @@ __git_tags ()
>  
>  __git_refs ()
>  {
> -	local cmd i is_hash=y dir="$(__gitdir "$1")"
> +	local i is_hash=y dir="$(__gitdir "$1")"
> +	local cur="${COMP_WORDS[COMP_CWORD]}" format refs
>  	if [ -d "$dir" ]; then
> -		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
> -		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
> -			refs/tags refs/heads refs/remotes
> +		case "$cur" in
> +		refs|refs/*)
> +			format="refname"
> +			refs="${cur%/*}"
> +			;;
> +		*)
> +			if [ -e "$dir/HEAD" ]; then echo HEAD; fi
> +			format="refname:short"
> +			refs="refs/tags refs/heads refs/remotes"
> +			;;
> +		esac
> +		git --git-dir="$dir" for-each-ref --format="%($format)" \
> +			$refs
>  		return
>  	fi
>  	for i in $(git ls-remote "$dir" 2>/dev/null); do
> -- 
> 1.6.0.4.814.gfe502
> 

-- 
Shawn.
