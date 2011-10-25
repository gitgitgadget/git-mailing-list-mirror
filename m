From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] completion: fix issue with process substitution not working
 on Git for Windows
Date: Tue, 25 Oct 2011 22:39:40 +0200
Message-ID: <4EA71E8C.8010704@kdbg.org>
References: <1319565695-5976-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org, gitster@pobox.com
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 22:40:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RInmz-0006ut-QU
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 22:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab1JYUjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 16:39:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:12683 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750943Ab1JYUjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 16:39:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C47912C4003;
	Tue, 25 Oct 2011 22:39:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 65F7319F4A7;
	Tue, 25 Oct 2011 22:39:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <1319565695-5976-1-git-send-email-stefan.naewe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184237>

Am 25.10.2011 20:01, schrieb Stefan Naewe:
> Git for Windows comes with a bash that doesn't support process substitution.
> It issues the following error when using git-completion.bash with
> GIT_PS1_SHOWUPSTREAM set:
> 
> $ export GIT_PS1_SHOWUPSTREAM=1
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": cannot make pipe for process substitution: Function not implemented
> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
> 
> Replace the process substitution with a simple "echo $var | while...".
> 
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8648a36..926db80 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -110,6 +110,8 @@ __git_ps1_show_upstream ()
>  	local upstream=git legacy="" verbose=""
>  
>  	# get some config options from git-config
> +	output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
> +	echo "$output" | \
>  	while read key value; do
>  		case "$key" in
>  		bash.showupstream)
> @@ -125,7 +127,7 @@ __git_ps1_show_upstream ()
>  			upstream=svn+git # default upstream is SVN if available, else git
>  			;;
>  		esac
> -	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
> +	done
>  
>  	# parse configuration values
>  	for option in ${GIT_PS1_SHOWUPSTREAM}; do

Are you sure that the result still works as intended? The while loop
sets a few variables. When you place it in a pipe, the loop runs in a
subshell, and subsequent code will not see the modified values. Unless
bash knows how to optimize away the subshell, that is.

OTOH, when you use while ...; do ...; done < <(...), the while loop is
not in a subshell.

An alternative is to use:  while ...; do ...; done <<< "$output"

BTW, you don't need to protect the end-of-line with a backslash if the
line ends with the pipe symbol.

-- Hannes
