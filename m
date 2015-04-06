From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/25] list-files: delete redundant cached entries
Date: Mon, 6 Apr 2015 17:35:24 -0400
Message-ID: <CAPig+cTDHf5Wh92SLHfQ0_GRY0cbpz+ALfiukJJHed6d=QmLdg@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:35:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEg6-0006Jx-TV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbbDFVf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:35:26 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36008 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbbDFVf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:35:26 -0400
Received: by lagv1 with SMTP id v1so28694531lag.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=dhgtrSLNqI5SQaK2DoOuXOOpundkOQI1BGfjQrA9A50=;
        b=RMcckomkX2DHR61uzjyl9ap3lpKa8rVaRzilddzj0gSU6D6sabYnGEOFYVIdauXlCj
         DsJRsS6Y7MsVr2YEfamG5ME9U4ewUL39w8z6HlAJ5RcGqhfSyf4N89pqaYe96ERuMGzx
         P65Yut8fwLNegfNqYi76LL5JdH1htOQq5hE1JmNN0ThOITAs8rkJUWx3BZ4FwZFgsZOD
         cIJx7ScffL9f2IYPxahbPKnQuScGdA/HhUbLnJisjtr10IDYofTBrTiCZmrCLHRp3zwP
         aNDeN907uCRCaUsmeRfq7txpvVd127TgyGCJzCJLcOkF/IfyUR0XL41CD/P1DbwTcEYy
         PHWQ==
X-Received: by 10.112.9.236 with SMTP id d12mr15670856lbb.102.1428356124973;
 Mon, 06 Apr 2015 14:35:24 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:35:24 -0700 (PDT)
In-Reply-To: <1428328354-14897-19-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Qi4bhAKtn2Wde32znfjv1Gugvc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266886>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> When both --cached and one of -amdAMD is used together we may have tw=
o
> entries of the same path, e.g. "  foo" and "MM foo". In this case it'=
s
> pretty clear that "foo" must be tracked, no need to display "   foo".
> The new function does that.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 14ffd62..31c2336 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -93,7 +93,10 @@ static int compare_item(const void *a_, const void=
 *b_)
>  {
>         const struct item *a =3D a_;
>         const struct item *b =3D b_;
> -       return strcmp(a->path, b->path);
> +       int ret =3D strcmp(a->path, b->path);
> +       if (ret)
> +               return ret;
> +       return strncmp(a->tag, b->tag, 2);
>  }
>
>  static void free_item(struct item *item)
> @@ -132,7 +135,12 @@ static void remove_duplicates(struct item_list *=
list)
>         for (src =3D dst =3D 1; src < list->nr; src++) {
>                 if (!compare_item(list->items + dst - 1, list->items =
+ src))
>                         free_item(list->items + src);
> -               else
> +               else if ((list->items[dst - 1].tag[0] =3D=3D ' ' &&
> +                         list->items[dst - 1].tag[1] =3D=3D ' ' &&
> +                         !strcmp(list->items[src].path, list->items[=
dst - 1].path))) {
> +                       free_item(list->items + dst - 1);
> +                       list->items[dst - 1] =3D list->items[src];

I was wondering if you could drop this backward-patching case by
having tag=3D=3D"  " items sort after tag=3D"xx" items and just fold ou=
t the
tag=3D=3D"  " items normally in the preceding 'if', however, when I
started coding it, I found that the resulting code wasn't any more
pleasant.

> +               } else
>                         list->items[dst++] =3D list->items[src];
>         }
>         list->nr =3D dst;
