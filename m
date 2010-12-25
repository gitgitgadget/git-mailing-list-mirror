From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect
 diff.ignoreSubmodules config variable
Date: Sat, 25 Dec 2010 13:33:14 +0100
Message-ID: <4D15E48A.9050805@web.de>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Zapped <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Sat Dec 25 13:34:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWTKc-0007ZE-Hi
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 13:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab0LYMeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 07:34:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:57897 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0LYMeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 07:34:37 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id D31ED183D6F35;
	Sat, 25 Dec 2010 13:33:16 +0100 (CET)
Received: from [93.246.60.252] (helo=[192.168.178.53])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PWTJE-0005bd-00; Sat, 25 Dec 2010 13:33:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1293240049-7744-3-git-send-email-zapped@mail.ru>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX189uqym1eAtRU2D/VbcsVWgGndAgXC79J4EuHAD
	2N13xZ7I5QPuS+bis6y/P9PxZA1IFdWn+kV/lZexRokzR7CgOf
	ZsJo4tVUU5EOD4vMxPRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164172>

Am 25.12.2010 02:20, schrieb Zapped:
> Signed-off-by: Zapped <zapped@mail.ru>
> ---
>  contrib/completion/git-completion.bash |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d3037fc..50fc385 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -280,7 +280,8 @@ __git_ps1 ()
>  		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
>  			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
>  				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
> -					git diff --no-ext-diff --quiet --exit-code || w="*"
> +					is=$(git config diff.ignoreSubmodules)
> +					git diff --no-ext-diff --quiet --exit-code --ignore-submodules=$is || w="*"
>  					if git rev-parse --quiet --verify HEAD >/dev/null; then
>  						git diff-index --cached --quiet HEAD -- || i="+"
>  					else

Thanks for resubmitting this as an inline patch for review (although
it would have been easier for me if the commit message would have
described the problem you tried to fix a bit more in detail ;-).

After testing this patch it looks like it has a few issues:

1) it will break any per-submodule configuration done via
   the 'submodule.<name>.ignore' setting in .git/config or
   .gitmodules, as using the --ignore-submodules option
   overrides those while only setting 'diff.ignoreSubmodules'
   should not do that.

2) If diff.ignoreSubmodules is unset it leads to an error
   every time the prompt is displayed:
   'fatal: bad --ignore-submodules argument:'

3) And for me it didn't change the behavior at all:

   - The '*' in the prompt vanishes as I set diff.ignoreSubmodules
     as expected with or without your patch.
     Am I missing something here?

   - The real problem here is that the '+' never goes away even
     when 'diff.ignoreSubmodules' is set to 'all'. This is due
     to the fact that 'diff.ignoreSubmodules' is only honored by
     "git diff", but not by "git diff-index".

So the real issue here seems to be the "git diff-index" call, which
doesn't honor the 'diff.ignoreSubmodules' setting. In commit 37aea37
Dscho (CCed) introduced this configuration setting while explicitly
stating that it only affects porcelain. As the other config options
always influence porcelain and plumbing, it looks like we would want
to have this option honored by plumbing too, no?

So are there any reasons for the plumbing diff commands not to honor
the diff.ignoreSubmodules setting?
