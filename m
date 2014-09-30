From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Tue, 30 Sep 2014 16:44:19 -0400
Message-ID: <542B1623.2070109@bbn.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: =?windows-1252?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Julien Carsique <julien.carsique@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 23:28:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ4yK-0000V8-K0
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 23:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbaI3V2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 17:28:32 -0400
Received: from smtp.bbn.com ([128.33.0.80]:22142 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbaI3V2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 17:28:31 -0400
X-Greylist: delayed 2645 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Sep 2014 17:28:31 EDT
Received: from socket.bbn.com ([192.1.120.102]:60256)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1XZ4HU-0005i0-G1; Tue, 30 Sep 2014 16:44:20 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 32ED04070E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257684>

On 2014-09-30 11:36, Julien Carsique wrote:
> From: Julien Carsique <julien.carsique@gmail.com>
> 
> When using the "name" option of GIT_PS1_SHOWUPSTREAM to show the upstream
> abbrev name, if the upstream name is the same as the local name, then some
> space could be saved in the prompt. This is especially needed on long branch
> names.
> 
> Replace the upstream name with the sign '=' if equal to the local one.
> Example:    [master * u= origin/=]$
> instead of: [master * u= origin/master]$

Seems like a good idea to me.

> 
> Signed-off-by: Julien Carsique <julien.carsique@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 7 +++++++
>  1 file changed, 7 insertions(+)

Please add some new tests in t/9903-bash-prompt.sh.  In particular:
  * upstream ref in refs/heads
  * upstream is git-svn
  * branch names containing slashes

> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c5473dc..a9aba20 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -209,6 +209,13 @@ __git_ps1_show_upstream ()
>  		if [[ -n "$count" && -n "$name" ]]; then
>  			__git_ps1_upstream_name=$(git rev-parse \
>  				--abbrev-ref "$upstream" 2>/dev/null)
> +
> +			__head=${b##refs/heads/}

To avoid colliding with other stuff, this variable should either be
local or prefixed with '__git_ps1'.

> +			if [ "$__head" = "${__git_ps1_upstream_name##*/}" ]; then

This comparison breaks on branches containing a slash (e.g., foo/bar).

Also, how does this interact with git-svn?  (I don't use git-svn so I'm
not very familiar with how it manages refs.)

Assuming remote names can't contain a slash (which I think is true), a
safer approach might be parse the full ref and special-case refs/remotes:

    __git_ps1_upstream_name=$(git rev-parse \
        --abbrev-ref "${upstream}" 2>/dev/null)
    local tmp
    tmp=$(git rev-parse --symbolic-full-name "${upstream}" 2>/dev/null)
    case ${tmp} in
    refs/remotes/*)
        # todo: can ${b} be something other than refs/heads/* here?
        [ "${__git_ps1_upstream_name#*/}" != "${b#refs/heads/}" ] \
            || __git_ps1_upstream_name=${__git_ps1_upstream_name%%/*}/\=
        ;;
    esac

Additional cases could be added to handle git-svn if needed.

> +				__git_ps1_upstream_name=${__git_ps1_upstream_name/$__head/=}

  * This could break if ${__head} contains any pattern-special
    characters.

  * While this syntax works in both Bash and Zsh (assuming no
    pattern-special characters), my preference is to stick to POSIX[1]
    when possible.  For example, assuming the upstream name is
    always in refs/remotes (which is not true, but this is an example)
    and remote names can't contain a '/', you could do this:

        __git_ps1_upstream_name=${__git_ps1_upstream_name%%/*}/\=

  * I don't think the CodingGuidelines explicitly prohibit long lines
    for shell code, and this file already contains plenty of long
    lines, but I really dislike lines longer than 80 characters.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html

> +			fi
> +			unset __head
> +
>  			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
>  				p="$p \${__git_ps1_upstream_name}"
>  			else

-Richard
