From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from
	breaking when CWD is .git
Date: Wed, 11 Feb 2009 08:26:12 -0800
Message-ID: <20090211162612.GG30949@spearce.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com> <1234366634-17900-3-git-send-email-ted@tedpavlic.com> <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 17:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHwE-0006nb-Rb
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 17:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbZBKQ0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 11:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756152AbZBKQ0O
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 11:26:14 -0500
Received: from george.spearce.org ([209.20.77.23]:43091 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003AbZBKQ0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 11:26:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A9CA938210; Wed, 11 Feb 2009 16:26:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109439>

Ted Pavlic <ted@tedpavlic.com> wrote:
> The GIT_PS1_DIRTYSTATE support uses a "git diff" to see if a "*" should
> be placed after the branch name. The "git diff" fails with an ugly error
> if the user has just changed directory into GIT_DIR.
> 
> This patch uses "git rev-parse --is-inside-work-tree" to determine
> whether a "--work-tree=.." should be added to the "git diff".

I think it makes more sense to just drop the work tree stuff from
the prompt if we aren't inside the work tree anymore.  Meaning,
we should behave as though bash.showDirtyState is false.

 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
> ---
>  contrib/completion/git-completion.bash |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6772be7..ffde82a 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -115,10 +115,14 @@ __git_ps1 ()
>  
>  		local w
>  		local i
> +		local worktreestr
>  
>  		if test -n "${GIT_PS1_SHOWDIRTYSTATE-}"; then
>  			if test "$(git config --bool bash.showDirtyState)" != "false"; then
> -				git diff --no-ext-diff --ignore-submodules \
> +				if test "false" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)"; then
> +					worktreestr="--work-tree=.."
> +				fi
> +				git ${worktreestr} diff --no-ext-diff --ignore-submodules \
>  					--quiet --exit-code || w="*"
>  				if git rev-parse --quiet --verify HEAD >/dev/null; then
>  					git diff-index --cached --quiet \
> -- 
> 1.6.1.2.390.gba743
> 

-- 
Shawn.
