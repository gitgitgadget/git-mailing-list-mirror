From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4 19/27] wrapper.c: wrapper to open a file, fprintf then
 close
Date: Sat, 01 Mar 2014 18:11:24 +0100
Message-ID: <531214BC.3070704@web.de>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com> <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 18:11:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJnRl-00074a-Pq
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 18:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbaCARL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 12:11:28 -0500
Received: from mout.web.de ([212.227.15.4]:64540 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbaCARL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 12:11:28 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M0Qxx-1XENZT2CFB-00uWJX for <git@vger.kernel.org>;
 Sat, 01 Mar 2014 18:11:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1393675983-3232-20-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:O9dRoH38AtE+bwkgWKuwTIU/IVMCXzw9Jqr5VYMhKTG8ZSTGfbI
 ZXfGm39fC6jdHoHcpM+LbgSOCbtfVPkEGRJf/pvILmMWEj5FmMXH2I9qfECWrbi9UaUe201
 IeeDNqBPhIQISFXBibNQETTNJhEApZEIIuqGpI1pPYjn1Rf3FvjcTYsEvllkECKmu/4HeUy
 B/DpcT+iUvI/KUxtmOdUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243105>

On 2014-03-01 13.12, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h   |  2 ++
>  wrapper.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/cache.h b/cache.h
> index 98b5dd3..99b86d9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1239,6 +1239,8 @@ static inline ssize_t write_str_in_full(int fd,=
 const char *str)
>  {
>  	return write_in_full(fd, str, strlen(str));
>  }
> +__attribute__((format (printf,3,4)))
> +extern int write_file(const char *path, int fatal, const char *fmt, =
=2E..);
> =20
>  /* pager.c */
>  extern void setup_pager(void);
> diff --git a/wrapper.c b/wrapper.c
> index 0cc5636..5ced50d 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -455,3 +455,34 @@ struct passwd *xgetpwuid_self(void)
>  		    errno ? strerror(errno) : _("no such user"));
>  	return pw;
>  }
> +
> +int write_file(const char *path, int fatal, const char *fmt, ...)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int fd =3D open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +	va_list params;
> +	if (fd < 0) {
> +		if (fatal)
> +			die_errno(_("could not open %s for writing"), path);
> +		return -1;
> +	}
> +	va_start(params, fmt);
> +	strbuf_vaddf(&sb, fmt, params);
> +	va_end(params);
> +	if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
> +		int err =3D errno;
> +		close(fd);
> +		errno =3D err;
> +		strbuf_release(&sb);
Micro nit:
Today we now what strbuf_release() is doing, but if we ever change the
implementation, it is 3% safer to keep err a little bit longer like thi=
s:
> +		strbuf_release(&sb);
> +		errno =3D err;
