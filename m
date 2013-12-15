From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/21] path.c: avoid PATH_MAX as buffer size from get_pathname()
Date: Sun, 15 Dec 2013 09:35:32 +0100
Message-ID: <52AD69D4.30605@web.de>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com> <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 15 09:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vs7Av-0007Pk-Fa
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 09:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3LOIfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Dec 2013 03:35:41 -0500
Received: from mout.web.de ([212.227.15.3]:59387 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab3LOIfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Dec 2013 03:35:40 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MPaxV-1VwFtw3Bzt-004ma4 for <git@vger.kernel.org>;
 Sun, 15 Dec 2013 09:35:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1387018507-21999-2-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:mDZ11/Lm/QxD41FaO5MmACOLTrq5Uxc7BDG3Uy6hMG5n/hUtqA6
 8E1kwPIdZBoC2QeRWlKdP+nPTZlrwcnkqEfglFgiAwK4XentMKYpG3Dj32lI1EmHZ+Q3pKg
 U6YfVxUyP0mjxayR4NvIUIjA/omFtvqi78/v+aq184hCkrrzw0MnXoO+Dsh+52M44Q00/FM
 XWovuUPaeSi5Acsn0LcKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239324>

On 2013-12-14 11.54, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> We've been avoiding PATH_MAX whenever possible. This patch avoids
> PATH_MAX in get_pathname() and gives it enough room not to worry abou=
t
> really long paths.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  path.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/path.c b/path.c
> index 24594c4..4c1c144 100644
> --- a/path.c
> +++ b/path.c
> @@ -16,10 +16,11 @@ static int get_st_mode_bits(const char *path, int=
 *mode)
> =20
>  static char bad_path[] =3D "/bad-path/";
> =20
> -static char *get_pathname(void)
> +static char *get_pathname(size_t *len)
>  {
> -	static char pathname_array[4][PATH_MAX];
> +	static char pathname_array[4][4096];
The PATH_MAX doesn't seem to be that bad:
http://pubs.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html
Or do we have a an OS where PATH_MAX does not work ?

Windows uses MAX_PATH=3D260 PATH_MAX=3D259
<http://msdn.microsoft.com/en-us/library/windows/desktop/aa365247%28v=3D=
vs.85%29.aspx>

Which means that the current implementation of git can not use path nam=
es longer than
259 (260 including the trailing \0)
(Please correct me if this is wrong)

Which means that the code working with the buffers must make sure to st=
ay within range,
and not to write beyond the buffers.

If we really want to go away from PATH_MAX, is a hard-coded value of 40=
96 so attractive ?
Because we can either

a) Re-define PATH_MAX in git-compat-util.h
b) Use an own  #define in git-compat-util.h, like e.g. GIT_PATH_MAX
c) Change the code to use a "strbuf" which can grow on demand.

I would prefer c) over b) over a)




>  	static int index;
> +	*len =3D sizeof(pathname_array[0]);
>  	return pathname_array[3 & ++index];
>  }
> =20
> @@ -108,24 +109,26 @@ char *mkpath(const char *fmt, ...)
>  {
>  	va_list args;
>  	unsigned len;
> -	char *pathname =3D get_pathname();
> +	size_t n;
> +	char *pathname =3D get_pathname(&n);
> =20
>  	va_start(args, fmt);
> -	len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
> +	len =3D vsnprintf(pathname, n, fmt, args);
Renaming "n" into something like "max" or "max_len" could
make this line 5% easier to read.
(And similar at some places below)
/Torsten
