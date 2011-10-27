From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
	working on Git for Windows
Date: Thu, 27 Oct 2011 11:05:30 +0200
Message-ID: <20111027090530.GA23424@goldbirke>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
	<1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org, gitster@pobox.com
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 11:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJLu9-0006ci-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 11:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab1J0JFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 05:05:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:49742 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab1J0JFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 05:05:36 -0400
Received: from localhost6.localdomain6 (p5B1310B5.dip0.t-ipconnect.de [91.19.16.181])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0Lo3GS-1QmSv51UXg-00gcDN; Thu, 27 Oct 2011 11:05:31 +0200
Content-Disposition: inline
In-Reply-To: <1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:s92jjYS9AzTDKdYgUzmYYN58VDao90X4vC2wa1J25WX
 OYCioAVzn2oZlX+oodKn+gau56MyhzAU52Qak1Yd8En1wwUg0R
 yjZbJbgS+GdTEbGz7LOu39V2tXluI8wwh7KAj55vWYHyTPscFY
 Q5k8mSUleIZJtMYxw4OcfGzaFUWfEc9V/uMq3AdBEBl+shLVXI
 89+KmoxIN2LMYPCDjZWN70dYNfnXwqsy/UUTDtXSLllqM+NJWW
 Lnq0bf54vXDATqzpkMgCyk7xS7TOxr/uiG+xhPvVkpnflbtDeF
 wfyn8/IZTqrldnSPdzKDqXBHRWvb5EjimEsIkymgAuv1IR0lgm
 IJq0WBPt0Od2a4Au65rssaZPY+TjoRVhJ4/I3d1OF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184290>

On Wed, Oct 26, 2011 at 09:13:09PM +0200, Stefan Naewe wrote:
> Git for Windows comes with a bash that doesn't support process substi=
tution.
> It issues the following error when using git-completion.bash with
> GIT_PS1_SHOWUPSTREAM set:
>=20
> $ export GIT_PS1_SHOWUPSTREAM=3D1
> sh.exe": cannot make pipe for process substitution: Function not impl=
emented
> sh.exe": cannot make pipe for process substitution: Function not impl=
emented
> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.sh=
owupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
>=20
> Replace the process substitution with a 'here string'.
>=20
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 8648a36..0b3d47e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -110,6 +110,7 @@ __git_ps1_show_upstream ()
>  	local upstream=3Dgit legacy=3D"" verbose=3D""
> =20
>  	# get some config options from git-config
> +	output=3D"$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\=
=2Eshowupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
>  	while read key value; do
>  		case "$key" in
>  		bash.showupstream)
> @@ -125,7 +126,7 @@ __git_ps1_show_upstream ()
>  			upstream=3Dsvn+git # default upstream is SVN if available, else g=
it
>  			;;
>  		esac
> -	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.sh=
owupstream)$' 2>/dev/null | tr '\0\n' '\n ')
> +	done <<< "$output"

The $output variable is not declared as local and therefore it leaks
into the environment.  But instead of declaring it local, why not
eliminate it altogether, and use the "$(git config ....)" command
substitution as here string?


G=E1bor
