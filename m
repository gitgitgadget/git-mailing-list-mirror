From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 07/13] utf8.c: add reencode_string_len() that can
 handle NULs in string
Date: Tue, 16 Apr 2013 18:30:28 +1000
Message-ID: <CACsJy8D9+4gPmevygE+5qVjoNLb6E3tppeayZ89qGBsGbdmZ8w@mail.gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com> <1366100702-31745-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1II-0003iX-L9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935752Ab3DPIbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:31:06 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:60606 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934736Ab3DPIbB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 04:31:01 -0400
Received: by mail-oa0-f47.google.com with SMTP id n9so230941oag.20
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=nHB46SMka5ggsjh44jaO/3R9jsEY0uI/S38vOCfAzQM=;
        b=dTyYGFh+DboUlEr0/0/Rr31FRdgRkJNdixfHCeECyQP1uI7rzkkR/3nHaFi1dFZmco
         wdq+u7cpLWo5QmldUah4Ns+MGgi7nJYpZaxkUSt2I1x0r1kP9BN+rgu3DcpNqto/Yzp0
         hboWsLeZEwbCzu1Q5gJdlU1oyMiYQsvLZXCSh+PQrsThni+t4mXmsCwp2EOaxA6xou/y
         2aZPNKnDdkjc2cn9tXzOH6m/JztkHsr9oJiSefAG3d2/NNxgZ2kR08CMyS6nfwKTRVdr
         Cb/Z/+2nt+uMMydJuMjqJ8b2fl5VKvbiah5UpIkvi/ALXQ5JnM2LEOjMTS/GOjuD4hUd
         1IVg==
X-Received: by 10.60.135.103 with SMTP id pr7mr477137oeb.142.1366101058968;
 Tue, 16 Apr 2013 01:30:58 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Tue, 16 Apr 2013 01:30:28 -0700 (PDT)
In-Reply-To: <1366100702-31745-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221393>

Torsten,

I can't compile compat/precomposed_utf8.c on linux even though I make
some changes there. Can you check if I break something? I'm pretty
sure I don't, but just in case.

On Tue, Apr 16, 2013 at 6:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  compat/precompose_utf8.c |  2 +-
>  utf8.c                   | 10 +++++++---
>  utf8.h                   | 19 ++++++++++++++++---
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 8cf5955..d9203d0 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -78,7 +78,7 @@ void precompose_argv(int argc, const char **argv)
>                 size_t namelen;
>                 oldarg =3D argv[i];
>                 if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
> -                       newarg =3D reencode_string_iconv(oldarg, name=
len, ic_precompose);
> +                       newarg =3D reencode_string_iconv(oldarg, name=
len, ic_precompose, NULL);
>                         if (newarg)
>                                 argv[i] =3D newarg;
>                 }
> diff --git a/utf8.c b/utf8.c
> index 9df087f..ac630bc 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -468,7 +468,7 @@ int utf8_fprintf(FILE *stream, const char *format=
, ...)
>  #else
>         typedef char * iconv_ibp;
>  #endif
> -char *reencode_string_iconv(const char *in, size_t insz, iconv_t con=
v)
> +char *reencode_string_iconv(const char *in, size_t insz, iconv_t con=
v, int *outsz_p)
>  {
>         size_t outsz, outalloc;
>         char *out, *outpos;
> @@ -502,13 +502,17 @@ char *reencode_string_iconv(const char *in, siz=
e_t insz, iconv_t conv)
>                 }
>                 else {
>                         *outpos =3D '\0';
> +                       if (outsz_p)
> +                               *outsz_p =3D outpos - out;
>                         break;
>                 }
>         }
>         return out;
>  }
>
> -char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding)
> +char *reencode_string_len(const char *in, int insz,
> +                         const char *out_encoding, const char *in_en=
coding,
> +                         int *outsz)
>  {
>         iconv_t conv;
>         char *out;
> @@ -534,7 +538,7 @@ char *reencode_string(const char *in, const char =
*out_encoding, const char *in_e
>                         return NULL;
>         }
>
> -       out =3D reencode_string_iconv(in, strlen(in), conv);
> +       out =3D reencode_string_iconv(in, insz, conv, outsz);
>         iconv_close(conv);
>         return out;
>  }
> diff --git a/utf8.h b/utf8.h
> index d3da96f..a43ef9a 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -17,12 +17,25 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf,=
 const char *data, int len,
>                              int indent, int indent2, int width);
>
>  #ifndef NO_ICONV
> -char *reencode_string_iconv(const char *in, size_t insz, iconv_t con=
v);
> -char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding);
> +char *reencode_string_iconv(const char *in, size_t insz,
> +                           iconv_t conv, int *outsz);
> +char *reencode_string_len(const char *in, int insz,
> +                         const char *out_encoding,
> +                         const char *in_encoding,
> +                         int *outsz);
>  #else
> -#define reencode_string(a,b,c) NULL
> +#define reencode_string_len(a,b,c,d,e) NULL
>  #endif
>
> +static inline char *reencode_string(const char *in,
> +                                   const char *out_encoding,
> +                                   const char *in_encoding)
> +{
> +       return reencode_string_len(in, strlen(in),
> +                                  out_encoding, in_encoding,
> +                                  NULL);
> +}
> +
>  int mbs_chrlen(const char **text, size_t *remainder_p, const char *e=
ncoding);
>
>  #endif
> --
> 1.8.2.82.gc24b958
>
--
Duy
