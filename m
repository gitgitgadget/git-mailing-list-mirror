From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 20:18:08 +0700
Message-ID: <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 19 15:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrG2-0005D9-BV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab2DSNSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 09:18:42 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50851 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2DSNSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 09:18:41 -0400
Received: by wibhj6 with SMTP id hj6so1771690wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cqULcYG8aCNg3fm1WZPZR0Mr1hM+ERM3iK+roJZfMdU=;
        b=RZNTUa3UqhwOX3ebZrDY+grX+Vu6w0OnXMwXaCsrB37V5Ac0Qh78X4J71uENSMkIed
         icCGWWY4bkLCbNtO+46R7sUvaVrWmLG5XUHP3CjnHi99pvvRboOU8sDsebKvZLm5UrSE
         BIOIczsQwO/arWDWuFC/ZlneZB+Sc09YlTS75lYH2Qjwd2DIxd8BaAFkeAdf9SYXzJDc
         i8D/eibdTU1reKUf2IkFNAfnOSuiZ2GppuLpaXWATpX3wC01NX7HB7ohaUod0OvBE+VS
         MMDgN+Tx6iFDqA0JB2HEq41BwD9UWLmVkDby+g0fT1n7vPRqbQn09/wOm3Eb2qaFC7cX
         qs0A==
Received: by 10.180.24.7 with SMTP id q7mr26477101wif.11.1334841520133; Thu,
 19 Apr 2012 06:18:40 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Thu, 19 Apr 2012 06:18:08 -0700 (PDT)
In-Reply-To: <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195942>

On Thu, Apr 19, 2012 at 7:58 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> This approach has the problem that file-operations apart from pread
> might (at least in theory) modify the position. To prevent that, we'd
> either need to use the same locking-mechanism as the CRT use, or use
> ReadFile with an OVERLAPPED struct, which allows us specify the offse=
t
> explicitly. The latter seems better to me, and should look something
> like this (note: untested):

Yeah. I read about ReadFile [1] but dismissed it when I got to async
i/o mode. Reading again, sync i/o ReadFile with OVERLAPPED struct
should work fine. It's not clear though if file offset is changed
(pread man page says it does not change).

Also this approach deals with Windows only. There's still another
NO_PREAD user, HP-UX something, and NO_PREAD comment mentions cygwin
before v1.5.22. I personally don't care, just wanted to point out.

[1] http://msdn.microsoft.com/en-us/library/windows/desktop/aa365467(v=3D=
vs.85).aspx

> diff --git a/Makefile b/Makefile
> index 2626216..31a5621 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1153,7 +1153,6 @@ endif
> =C2=A0ifeq ($(uname_S),Windows)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_VERSION :=3D $(GIT_VERSION).MSVC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pathsep =3D ;
> - =C2=A0 =C2=A0 =C2=A0 NO_PREAD =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NEEDS_CRYPTO_WITH_SSL =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_LIBGEN_H =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_SYS_POLL_H =3D YesPlease
> @@ -1250,7 +1249,6 @@ ifeq ($(uname_S),Minix)
> =C2=A0endif
> =C2=A0ifneq (,$(findstring MINGW,$(uname_S)))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pathsep =3D ;
> - =C2=A0 =C2=A0 =C2=A0 NO_PREAD =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NEEDS_CRYPTO_WITH_SSL =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_LIBGEN_H =3D YesPlease
> =C2=A0 =C2=A0 =C2=A0 =C2=A0NO_SYS_POLL_H =3D YesPlease
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 309fa1d..63783db 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -617,6 +617,28 @@ static inline void time_t_to_filetime(time_t t,
> FILETIME *ft)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ft->dwHighDateTime =3D winTime >> 32;
> =C2=A0}
>
> +ssize_t mingw_pread(int fd, void *buf, size_t size, off_t offset)
> +{
> + =C2=A0 =C2=A0 =C2=A0 OVERLAPPED overlapped =3D { 0 };
> + =C2=A0 =C2=A0 =C2=A0 DWORD ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
> + =C2=A0 =C2=A0 =C2=A0 if (fh =3D=3D INVALID_HANDLE_VALUE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D EBADF;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 overlapped.Offset =3D (DWORD)offset;
> + =C2=A0 =C2=A0 =C2=A0 overlapped.OffsetHigh =3D (DWORD)(offset >> 32=
);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!ReadFile(fh, buf, size, &ret, &overlapped=
)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D err_win_=
to_posix(GetLastError());
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> =C2=A0int mingw_utime (const char *file_name, const struct utimbuf *t=
imes)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0FILETIME mft, aft;
> diff --git a/compat/mingw.h b/compat/mingw.h
> index c7b2cec..da47302 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -285,6 +285,9 @@ int mingw_fstat(int fd, struct stat *buf);
> =C2=A0#define _stati64(x,y) mingw_stat(x,y)
> =C2=A0#endif
>
> +ssize_t mingw_pread(int fd, void *buf, size_t count, off_t offset);
> +#define pread mingw_pread
> +
> =C2=A0int mingw_utime(const char *file_name, const struct utimbuf *ti=
mes);
> =C2=A0#define utime mingw_utime



--=20
Duy
