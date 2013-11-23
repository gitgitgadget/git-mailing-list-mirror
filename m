From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Sat, 23 Nov 2013 15:42:47 +0100
Message-ID: <5290BEE7.2070901@kdbg.org>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de
To: Heikki Hokkanen <hoxu@users.sf.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 15:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkEQV-0000N4-1k
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 15:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab3KWOnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 09:43:11 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:24803 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753485Ab3KWOnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 09:43:09 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.108])
	by lbmfmo03.bon.at (Postfix) with ESMTP id A68CACE1CD
	for <git@vger.kernel.org>; Sat, 23 Nov 2013 15:43:07 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0213313005E;
	Sat, 23 Nov 2013 15:42:48 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2FFBE19F43C;
	Sat, 23 Nov 2013 15:42:48 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238234>

Am 23.11.2013 14:18, schrieb Heikki Hokkanen:
> If bash.prompt is set to false, disable the prompt. This is useful
> for huge repositories like the home directory.
> 
> Signed-off-by: Heikki Hokkanen <hoxu@users.sf.net>
> ---
> git-prompt.sh performance seems to be quite bad for big repositories, so
> without a way to disable it selectively for repositories, it becomes unusable
> for people who have their homedir under git. This patch generalizes the problem
> a bit by allowing the prompt to be disabled by setting bash.prompt to false in
> any repository.
> 
>  contrib/completion/git-prompt.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
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
> +	if [ -n "$prompt_setting" ] && [ "$prompt_setting" == "false" ]; then
> +		return
> +	fi
> +

Gah! This adds a fork+exec each time the prompt is shown. Not good,
particularly on Windows.

Since your intent is to disable the prompt in the home directory,
wouldn't that mean that most of the time you *don't* want the prompt?
Wouldn't you be better served with a method that *turns on* the prompt?
For example, a shell function that sets PS1 and another one that unsets
it? Or a wrapper that inspects a shell variable and calls __git_ps1 only
when you want a prompt.

>  	local short_sha
>  	if [ "$rev_parse_exit_code" = "0" ]; then
>  		short_sha="${repo_info##*$'\n'}"
> 

-- Hannes
