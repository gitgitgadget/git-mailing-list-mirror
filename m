From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Mon, 25 May 2009 08:16:13 +0200
Message-ID: <4A1A37AD.4080309@viscovery.net>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> <1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> <4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> <20090523092603.GA7420@dektop> <20090523145042.GA13139@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlsrc.navy.mil>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 08:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8TUX-0007gA-E3
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 08:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbZEYGQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZEYGQ0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 02:16:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36452 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbZEYGQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 02:16:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8TTp-0001Ia-Hh; Mon, 25 May 2009 08:16:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4D4DA54D; Mon, 25 May 2009 08:16:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090523145042.GA13139@dektop>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119885>

Nguyen Thai Ngoc Duy schrieb:
> On Sat, May 23, 2009 at 07:26:03PM +1000, Nguyen Thai Ngoc Duy wrote:
>> On Fri, May 22, 2009 at 05:30:31PM +1000, Nguyen Thai Ngoc Duy wrote=
:
>>> 2009/5/22 Johannes Sixt <j.sixt@viscovery.net>:
>>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
@gmail.com>
>>>> Is it possible for you to test this series on Windows? Many rebase=
 tests
>>>> fail, but I haven't investigated why.
>>> I'll try it this weekend.
>> This patch makes t3*rebase*.sh pass for me except t3412 (more exactl=
y
>> t3412.8). That test failed even with git-rebase.sh. Hmm... Anyway
>> could you try again to see what tests still fail?
>=20
> Someone with better Windows knowledge than me should explain how this=
 works. Windows'
> snprintf() just cuts out the last character in this statement:
>=20
> snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--on=
to'

This doesn't happen for me: neither with Windows's original snprintf no=
r
with the version from compat/. Are you using the latest msysgit
environment to compile, i.e. gcc 4.4? There was a change regarding
SNPRINTF_SIZE_CORR; perhaps that's the culprit?

I don't undertand what this patch does, anyway. Where is the detail tha=
t I
am missing?

> All rebase tests now pass for me on Windows (Vista something, I have
> yet to find where it hides its "uname" command)

They also pass for me with your earlier fix-up patch, but with or witho=
ut
this patch to compat/snprintf.c.

> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 357e733..1cea768 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -13,7 +13,7 @@
>  int git_vsnprintf(char *str, size_t maxsize, const char *format, va_=
list ap)
>  {
>  	char *s;
> -	int ret =3D -1;
> +	int size, ret =3D -1;
> =20
>  	if (maxsize > 0) {
>  		ret =3D vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> @@ -26,18 +26,19 @@ int git_vsnprintf(char *str, size_t maxsize, cons=
t char *format, va_list ap)
>  		return ret;
> =20
>  	s =3D NULL;
> -	if (maxsize < 128)
> -		maxsize =3D 128;
> +	size =3D maxsize < 128 ? 128 : maxsize;
> =20
>  	while (ret =3D=3D -1) {
> -		maxsize *=3D 4;
> -		str =3D realloc(s, maxsize);
> -		if (! str)
> +		size *=3D 4;
> +		s =3D realloc(s, size);
> +		if (!s)
>  			break;
> -		s =3D str;
> -		ret =3D vsnprintf(str, maxsize-SNPRINTF_SIZE_CORR, format, ap);
> -		if (ret =3D=3D maxsize-1)
> +		s =3D s;
> +		ret =3D vsnprintf(s, size-SNPRINTF_SIZE_CORR, format, ap);
> +		if (ret =3D=3D size-1)
>  			ret =3D -1;
> +		else
> +			memcpy(str, s, maxsize-1);
>  	}
>  	free(s);
>  	return ret;
