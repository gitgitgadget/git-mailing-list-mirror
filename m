From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 1/9] compat/mingw.c: expand MinGW support for sigaction
Date: Mon, 02 Jun 2014 07:57:35 +0200
Message-ID: <538C124F.2010103@viscovery.net>
References: <cover.1401645403.git.jmmahler@gmail.com> <d5fc7d72b2d51d1b90fb7f238eff120cb4c6d0e7.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:57:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrLFi-0001uD-9l
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 07:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaFBF5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2014 01:57:41 -0400
Received: from so.liwest.at ([212.33.55.24]:34240 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbaFBF5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 01:57:41 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WrLFY-0004el-2K; Mon, 02 Jun 2014 07:57:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CC33516613;
	Mon,  2 Jun 2014 07:57:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <d5fc7d72b2d51d1b90fb7f238eff120cb4c6d0e7.1401645403.git.jmmahler@gmail.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250550>

Am 6/1/2014 20:10, schrieb Jeremiah Mahler:
> Due to portability issues across UNIX versions sigaction(2) should be=
 used
> instead of signal(2).
>=20
>>From the signal(2) man page:
>=20
>   The behavior of signal() varies across UNIX versions, and has also =
var=E2=80=90
>   ied historically across different versions of Linux.   Avoid  its  =
use:
>   use sigaction(2) instead.
>=20
> Unfortunately MinGW under Windows has limited support for signal and =
no
> support for sigaction.  And this prevents sigaction from being used a=
cross
> the entire Git project.
>=20
> In compat/mingw.c there is a faux sigaction function but it only supp=
orts
> SIGALARM.  Hence the need for continuing to use signal() in other cas=
es.
>=20
> This patch expands the faux sigaction function so that it calls signa=
l in
> cases other than SIGALRM.  Now sigaction can be used across the entir=
e Git
> project and MinGW will still work with signal as it did before.
>=20
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  compat/mingw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e9892f8..e504cef 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1651,14 +1651,15 @@ int setitimer(int type, struct itimerval *in,=
 struct itimerval *out)
> =20
>  int sigaction(int sig, struct sigaction *in, struct sigaction *out)
>  {
> -	if (sig !=3D SIGALRM)
> -		return errno =3D EINVAL,
> -			error("sigaction only implemented for SIGALRM");
>  	if (out !=3D NULL)
>  		return errno =3D EINVAL,
>  			error("sigaction: param 3 !=3D NULL not implemented");

A fix for this missing implementation is needed before patch 9/9 can be
applied.

> =20
> -	timer_fn =3D in->sa_handler;
> +	if (sig =3D=3D SIGALRM)
> +		timer_fn =3D in->sa_handler;
> +	else
> +		signal(sig, in->sa_handler);
> +
>  	return 0;
>  }
> =20
>=20

-- Hannes
