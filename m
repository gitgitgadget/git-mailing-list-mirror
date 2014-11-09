From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 21/22] mingw32: add uname()
Date: Sat, 8 Nov 2014 22:32:08 -0500
Message-ID: <CAPig+cS2FzL6kXTvoG6cTX1yUjmGUkEm5mAHNxmtU5-=ngcoFg@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-1-git-send-email-pclouds@gmail.com>
	<1415439595-469-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 04:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnJEd-0001lK-OU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 04:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaKIDcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 22:32:10 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:38963 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaKIDcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 22:32:09 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so2436752yhl.23
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 19:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=awyx9HL1HB59yad/phkU0mxTw9kiCn4pD8iXTTsuJgc=;
        b=gEVM7frKKnMPlo4f9q0RL0zp66YUUBIu+0cqwEDCkFcpEzb8z6E/9hSmP0O9a/fmCw
         gLAw13RiR20zOGEdbEOj91NT+t/9T0N2ulHOIgY1zGgOeTb9X5U9OMCiV49WFMHibvnz
         CAbX4C8RMGcwD22Q5TjCNx0wo7Ms9E54fGHArT1fDdjI7pTKyY+S/Urr2kE5ml3ssuQu
         28l7NO9EQ/e9hlfBIfCAXm7EcwNgC6wGVtq5IIk+jXm34h+MDwvhfjQtvTiGkPAhuo4C
         U82ftOtrISMj96u1KLljrFLs/ylZzvkdCt0tKBA7lFMtoF+u9qXKPLgiA90hVOKYygLt
         U5Qg==
X-Received: by 10.236.53.197 with SMTP id g45mr21097914yhc.134.1415503928587;
 Sat, 08 Nov 2014 19:32:08 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sat, 8 Nov 2014 19:32:08 -0800 (PST)
In-Reply-To: <1415439595-469-22-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 74iFd4OOhfpv58hSUbryJhVxAGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 8, 2014 at 4:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> index c5c37e5..b817678 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2128,3 +2128,14 @@ void mingw_startup()
>         /* initialize Unicode console */
>         winansi_init();
>  }
> +
> +int uname(struct utsname *buf)
> +{
> +       DWORD v =3D GetVersion();
> +       memset(buf, 0, sizeof(*buf));
> +       sprintf(buf->sysname, "Windows");

strcpy() maybe?

> +       sprintf(buf->release, "%u.%u", v & 0xff, (v >> 8) & 0xff);
> +       /* assuming NT variants only.. */
> +       sprintf(buf->version, "%u", (v >> 16) & 0x7fff);
> +       return 0;
> +}
> diff --git a/compat/mingw.h b/compat/mingw.h
> index df0e320..d00ba7a 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -77,6 +77,14 @@ struct itimerval {
>  };
>  #define ITIMER_REAL 0
>
> +struct utsname {
> +       char sysname[16];
> +       char nodename[1];
> +       char release[16];
> +       char version[16];
> +       char machine[1];
> +};
> +
>  /*
>   * sanitize preprocessor namespace polluted by Windows headers defin=
ing
>   * macros which collide with git local versions
> @@ -166,6 +174,7 @@ struct passwd *getpwuid(uid_t uid);
>  int setitimer(int type, struct itimerval *in, struct itimerval *out)=
;
>  int sigaction(int sig, struct sigaction *in, struct sigaction *out);
>  int link(const char *oldpath, const char *newpath);
> +int uname(struct utsname *buf);
>
>  /*
>   * replacements of existing functions
> --
> 2.1.0.rc0.78.gc0d8480
