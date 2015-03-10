From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/16] list-files: delete redundant cached entries
Date: Tue, 10 Mar 2015 02:28:54 -0400
Message-ID: <CAPig+cS6F6aD_3fLfmBHx+4CxRRrAyLDM3C2HRE55a3S9mJs=A@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
	<1425896314-10941-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@drmicha.warpmail.net" <git@drmicha.warpmail.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:29:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVDf1-0007xU-RF
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 07:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbCJG2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 02:28:55 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:37041 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbCJG2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 02:28:55 -0400
Received: by yks20 with SMTP id 20so5009831yks.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5bQmdZkdl/US/pHkz9XFxlbs2aAzPD0nqlVxEYOOMGQ=;
        b=xuptw8O3U+Mho2pb7J1/kukLBMLhfdd9XdLb0QQDKi75EZ1nGQ+bVmI3NybWn8Uopa
         jfCO+XGldQKdQwgkDr81dccoEhEk/nT1kocAsUHjhFIrEy9wzfm1rB4d6sOcPeH0Q8CY
         foHrSvpHtJUaBrpJh/0BO2ncdlQ3UX3gBh0KVRLJx1tY2FPdWcV85LocOx2njtC3hL0o
         5RC566AsxqqSaLsnIhZwkIF9UlwZ4+IrIwewH9WVXeLS9TyuGTmgaJVFgLRL8PL1FZyJ
         giH4uVsRdA2FGvzFtrHmFg4aLM8fixrVJfSm5/zRXCqNip0EYdnu7zlY8s7oXIwPQ2n2
         PBXg==
X-Received: by 10.236.41.78 with SMTP id g54mr16857209yhb.112.1425968934420;
 Mon, 09 Mar 2015 23:28:54 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Mon, 9 Mar 2015 23:28:54 -0700 (PDT)
In-Reply-To: <1425896314-10941-16-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: kucVlf6iTY3Eb4Ozq8bhqD8bHhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265211>

On Monday, March 9, 2015, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
> When both --cached and one of -amdAMD is used together we may have tw=
o
> entries of the same path, e.g. "  foo" and "MM foo". In this case it'=
s
> pretty clear that "foo" must be tracked, no need to display "   foo".
> The new function does that.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 74836f6..49fb820 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -305,6 +308,34 @@ static void wt_status_populate(struct string_lis=
t *result,
>         string_list_remove_duplicates(result, 0);
>  }
>
> +static void delete_duplicate_cached_entries(struct string_list *resu=
lt)
> +{
> +       struct string_list_item *src, *dst;
> +
> +       if (show_unmerged || !show_cached || !show_changed)
> +               return;
> +
> +       src =3D dst =3D result->items;
> +       while (src + 1 < result->items + result->nr) {
> +               const char *s0 =3D dst->string;
> +               const char *s1 =3D src[1].string;
> +
> +               if (s0[0] =3D=3D ' ' && s0[1] =3D=3D ' ' &&
> +                   !strcmp(s0 + 3, s1 + 3)) {
> +                       src++;
> +               } else {
> +                       dst++;
> +                       src++;
> +               }
> +               if (src !=3D dst)
> +                       *dst =3D *src;
> +       }
> +       if (src !=3D dst)
> +               *dst =3D *src;

Do you want to take some action here (and just above) to ensure that
the item being overwritten gets deleted properly rather than leaked?

> +       result->nr =3D dst - result->items;
> +
> +}
> +
