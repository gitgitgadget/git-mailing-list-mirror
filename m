From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH for maint branch] git-completion: fix zsh support
Date: Thu, 5 May 2011 20:59:07 +0200
Message-ID: <20110505185907.GD1377@goldbirke>
References: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3le-0003Ac-Tl
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab1EES7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:59:13 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55529 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1EES7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:59:12 -0400
Received: from localhost6.localdomain6 (p5B130B4D.dip0.t-ipconnect.de [91.19.11.77])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M6P87-1PXMzX1qXL-00xlad; Thu, 05 May 2011 20:59:08 +0200
Content-Disposition: inline
In-Reply-To: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:U7TOKChZHOlFZRsfaPilN41j5rcqVXthC0ylJ728RUB
 uhPrJ/ys9hIiKiy3c0Cl95FVCoLS8/nZKL+9/RR3mzaL6+ofZq
 5LMn3zsE9eQ7JR1/RhpBP3CczFoNtWkkoj1+T49+B//pnkIYTX
 +LQlSnwBviya2b3wvJaqCRSpOFTt5zJMapHF2RZMUdEL8hr/si
 3eVwW0RNVnpOHe2bA4VJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172879>

Hi,

On Thu, May 05, 2011 at 05:24:18PM +0300, Felipe Contreras wrote:
> It turns out 'words' is a special variable used by zsh completion.
> 
> There's probably a bug in zsh's bashcompinit:
> http://article.gmane.org/gmane.comp.shells.zsh.devel/22546
> 
> But in the meantime we can workaround it this way.

I would prefer some details about this "workaround it this way" in the
commit message (i.e. that you used "typedef -h", what it does in zsh,
and why it fixes the issue; my zsh-fu is, well, not particularly
large, so I have no idea), so when someone later runs 'git log --
contrib/completion' then he will easier understand what's going on
without the need to look at the patch.

> Currently zsh is completely broken after commit da48616 (bash: get
> --pretty=m<tab> completion to work with bash v4), which introduced
> _get_comp_words_by_ref() that comes from debian's bash_completion
> scripts, and relies on the 'words' variable to behave like any normal
> variable.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> This patch is meant for the maintenance branch, so Szeder's patches are not
> needed.

My first two patches are cleanups, they definitely worth
keeping, even when this patch alone would fix the zsh issues.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 840ae38..8d5eae7 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2710,6 +2710,9 @@ _git ()
>  	if [[ -n ${ZSH_VERSION-} ]]; then
>  		emulate -L bash
>  		setopt KSH_TYPESET
> +
> +		# 'words' has special meaning in zsh; override that
> +		typeset -h words

You have to do the same in _gitk(), too.  Although _gitk() itself
doesn't use $words, it invokes __git_has_doubledash(), which does,
hence it's still broken.

>  	fi
>  
>  	local cur words cword
> -- 
> 1.7.5.1.1.g638e6
> 
