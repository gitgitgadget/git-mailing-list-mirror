From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: fix completion of certain aliases
Date: Fri, 13 Dec 2013 15:16:24 +0100
Message-ID: <20131213141624.GA28369@goldbirke>
References: <1386421873-27863-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 15:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrTXc-0005ZL-HA
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 15:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab3LMOQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 09:16:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:57165 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab3LMOQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 09:16:26 -0500
Received: from localhost6.localdomain6 (g226129228.adsl.alicedsl.de [92.226.129.228])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M7A1q-1Vf0ak2xjK-00wuzF; Fri, 13 Dec 2013 15:16:24 +0100
Content-Disposition: inline
In-Reply-To: <1386421873-27863-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:bt4POWcpPzr0fpWY5K0di2JJwQqb5yUF/DsQ+1FeYO1
 bsUKlYMJ6SnlL4NbPSO5IBilfbXJWElCpdF7TrzuusvTuh8pPF
 y8/XvyYACBaBoYEmQKlSQt8k0xaFG89b6u8JpzsyRx7rL9uRl8
 djx7+s3qMxkI3dJ7J/9sPf5VEuw4oniqiOa8BpI+aK0uzhiFqL
 QcxK33clcTmbKz8lvNnoMrYh9uI1Q8E0xAIC/ervXZYm+Fwgv/
 xx9C5uLh9+mkZpyQvnijW88URFgRwgIDRRXL9pdxCYlZvfTKZe
 QKvUB6K5kCS4km59OhIbRGcUR+/Bson/2VXXxWWCnB3Ij2s6Up
 23ZrfGAB1Mpp12CMDRWDkLeRcb7fgNrtqq8uCt8EE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239258>

Hi,

On Sat, Dec 07, 2013 at 07:11:13AM -0600, Felipe Contreras wrote:
> Some commands need the first word to determine the actual action that=
 is
> being executed, however, the command is wrong when we use an alias,

This first sentence was hard to understand for me because of the wrong
terminology used.  How about this instead:

  Some completion helper functions need to know the name of the git
  command to act properly.  However, ...

> for
> example 'alias.p=3Dpush', if we try to complete 'git p origin ', the
> result would be wrong because __git_complete_remote_or_refspec() does=
n't
> know where it come from.

Are there other helper functions that are affected?  After a quick
glance I didn't find any.  In this case we could even write the above
as

  The __git_complete_remote_or_refspec() completion helper function
  needs to know ...


> So let's override words[1], so the alias 'p' is override by the actua=
l
> command, 'push'.

words[1] is not always the name of the git command, it can also be an
option to the main git command, e.g. in case of 'git -c key=3Dvalue pus=
h
=2E..' with this patch '-c' would be overwritten.


Best,
G=E1bor

> Reported-by: Aymeric Beaumet <aymeric.beaumet@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  contrib/completion/git-completion.zsh  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index dba3c15..c14bac4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2530,6 +2530,7 @@ __git_main ()
> =20
>  	local expansion=3D$(__git_aliased_command "$command")
>  	if [ -n "$expansion" ]; then
> +		words[1]=3D$expansion
>  		completion_func=3D"_git_${expansion//-/_}"
>  		declare -f $completion_func >/dev/null && $completion_func
>  	fi
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completi=
on/git-completion.zsh
> index fac5e71..3eeb7f8 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -96,6 +96,7 @@ __git_zsh_bash_func ()
> =20
>  	local expansion=3D$(__git_aliased_command "$command")
>  	if [ -n "$expansion" ]; then
> +		words[1]=3D$expansion
>  		completion_func=3D"_git_${expansion//-/_}"
>  		declare -f $completion_func >/dev/null && $completion_func
>  	fi
> --=20
> 1.8.4.2+fc1
>=20
>=20
