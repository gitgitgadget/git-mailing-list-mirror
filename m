From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] git-prompt: preserve value of $? inside shell prompt
Date: Wed, 14 Jan 2015 00:57:26 +0100
Message-ID: <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
References: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com>
 <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 01:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBBaW-0006lu-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 01:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbbANAN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2015 19:13:26 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39352 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086AbbANANR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 19:13:17 -0500
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jan 2015 19:13:16 EST
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YBBLA-00044e-S5; Wed, 14 Jan 2015 00:57:40 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YBBKw-0005qu-AY; Wed, 14 Jan 2015 00:57:26 +0100
Received: from tmo-102-36.customers.d1-online.com
 (tmo-102-36.customers.d1-online.com [80.187.102.36]) by
 webmail.informatik.kit.edu (Horde Framework) with HTTP; Wed, 14 Jan 2015
 00:57:26 +0100
In-Reply-To: <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1421193460.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1421194392.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262365>

Hi,

Quoting Tony Finch <dot@dotat.at>:
> If you have a prompt which displays the command exit status,
> __git_ps1 without this change corrupts it, although it has
> the correct value in the parent shell:
>
> 	~/src/git (master) 0 $ set | grep ^PS1
> 	PS1=3D'\w$(__git_ps1) $? \$ '
> 	~/src/git (master) 0 $ false
> 	~/src/git (master) 0 $ echo $?
> 	1
> 	~/src/git (master) 0 $
>
> There is a slightly ugly workaround:
>
> 	~/src/git (master) 0 $ set | grep ^PS1
> 	PS1=3D'\w$(x=3D$?; __git_ps1; exit $x) $? \$ '
> 	~/src/git (master) 0 $ false
> 	~/src/git (master) 1 $
>
> This change makes the workaround unnecessary.
>
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>    contrib/completion/git-prompt.sh | 4 ++++
>    1 file changed, 4 insertions(+)
>
> I hope that explains it properly :-)
>
> diff --git a/contrib/completion/git-prompt.sh
> b/contrib/completion/git-prompt.sh
> index c5473dc..5fe69d0 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -288,6 +288,7 @@ __git_eread ()
>    # In this mode you can request colored hints using
> GIT_PS1_SHOWCOLORHINTS=3Dtrue
>    __git_ps1 ()
>    {
> +	local exit=3D$?
>    	local pcmode=3Dno
>    	local detached=3Dno
>    	local ps1pc_start=3D'\u@\h:\w '
> @@ -511,4 +512,7 @@ __git_ps1 ()
>    	else
>    		printf -- "$printf_format" "$gitstring"
>    	fi
> +
> +	# preserve exit status
> +	return $exit
>    }
> --
> 2.2.1.68.g56d9796

Makes sense, but the patch doesn't cover all cases, because =20
__git_ps1() can exit early, off the top of my head without actually =20
having a git clone at hand to look at the code, if:

  * pwd is not in a git repo, which is a quite common case to worry abo=
ut.
  * .git/HEAD becomes unreadable while __git_ps1() is being executed.  =
=20
It's an unlikely race condition so I wouldn't worry much about it, but =
=20
for consistency's sake I think it's better to return $? there as well.

Best,
G=C3=A1bor
