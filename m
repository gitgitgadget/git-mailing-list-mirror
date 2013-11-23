From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Sat, 23 Nov 2013 17:35:59 +0100
Message-ID: <20131123163559.GB13824@goldbirke>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Hokkanen <hoxu@users.sf.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 17:36:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkGBq-0007BB-F1
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 17:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab3KWQgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 11:36:11 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:53998 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3KWQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 11:36:08 -0500
Received: from localhost6.localdomain6 (f051129155.adsl.alicedsl.de [78.51.129.155])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MWhTP-1W9Dwp1Qfj-00Xzlp; Sat, 23 Nov 2013 17:36:00 +0100
Content-Disposition: inline
In-Reply-To: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:4jyrmww5UjEpeoCDCeYE6x+M7kGHfINPQtgqNQKx75a
 OwvVnVDj7K6/gSSrDgqAzUQSFIzaDjQDurgVb4oEK7CRjSyGub
 qO5IdDy3xmTH4rEYI7PUnF0HYybU8j6/cjMPwNsCaHLeYl+LmY
 yC99uN2Q5y4d10Ld+HoXA8qW7SjVb+J0V9S0fEmRnjv8qOzr6f
 Gu/ubNoWnM/BTL9p5Pq3flhiQlPRDSJmatjEII5GKM0U15Tt1k
 3+8MVxUgIcJ3fGH9FGybjovF1PxqbxkNqh6pdP/uG8qJ7DgTvT
 gc7qz5cz6u7ssjqiY7LF+ZSaZS4m4kG7P8xsyXZ4Zox3kqsGV9
 ru2sv7xwKbmUJKDC3HwDPaTrkhOtxdvlL4mhwhTSM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238241>

Hi,

On Sat, Nov 23, 2013 at 03:18:23PM +0200, Heikki Hokkanen wrote:
> If bash.prompt is set to false, disable the prompt. This is useful
> for huge repositories like the home directory.
> 
> Signed-off-by: Heikki Hokkanen <hoxu@users.sf.net>
> ---
> git-prompt.sh performance seems to be quite bad for big repositories,

Hm, strange.  I wonder what can cause performance problems in big
repositories.

Sure, there are status indicators that can be expensive, in particular
the indicators for dirty index/worktree, untracked files, and
divergence from upstream.  However, these must be enabled globally by
environment variables and even then can already be disabled on a
per-repo basis by configuration variables.  And the rest of the prompt
code should perform pretty much independently from the repository
size.

> so
> without a way to disable it selectively for repositories, it becomes unusable
> for people who have their homedir under git. This patch generalizes the problem
> a bit by allowing the prompt to be disabled by setting bash.prompt to false in
> any repository.
> 
>  contrib/completion/git-prompt.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)

No tests.

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 7b732d2..c982fde 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,8 @@
>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
>  # the colored output of "git status -sb" and are available only when
>  # using __git_ps1 for PROMPT_COMMAND or precmd.
> +#
> +# To disable prompt for a repository, run "git config bash.prompt false"
>  
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -304,6 +306,12 @@ __git_ps1 ()
>  		return
>  	fi
>  
> +	local prompt_setting
> +	prompt_setting=$(git config --bool bash.prompt)

I spent quite some time eliminating fork()s and exec()s from the
prompt, so a fork() for the command substitution's subshell and a
fork()+exec() for running a git command in the main code path saddens
me deeply ;)

> +	if [ -n "$prompt_setting" ] && [ "$prompt_setting" == "false" ]; then

If $prompt_setting must be false, then checking its non-emptyness is
superfluous.

> +		return

You can't just return from __git_ps1(), you must update PS1 in prompt
command mode.  See the few lines just above this hunk.

> +	fi
> +
>  	local short_sha
>  	if [ "$rev_parse_exit_code" = "0" ]; then
>  		short_sha="${repo_info##*$'\n'}"
> -- 
> 1.8.4
> 
