From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/45] parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
Date: Sun, 9 Jun 2013 21:29:58 -0400
Message-ID: <CAPig+cQuDEa-zGWa5JkeFAksu6PkwEXzWY2sEP-+-MfEY+AV8Q@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:30:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulqvt-0003Ss-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab3FJBaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:30:00 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:48955 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3FJB37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:29:59 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so5278597lab.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xpQEbdQ4uX/jhgS206i7DB/ZJXnNmZYomjbn1cOm2tw=;
        b=XPxXF6ZhKAcFikVKAOyPLU6LscSs/Qmbp9l8otObwspYyGXnDu9jh04cA3pn6LQ1VA
         Y2su2MUP72HCmWBysfCGr+s4oAC+HVdxAO5I+gg6MEa0A0gkIatxdoctD7xgVg8An9jj
         D4Om03gmrNtzRWV5Q/xxYzysBiM616nI3UiCDHa85wxaZfA8g3EOeAVGmB+MRsNIqID0
         Z+Fkolywr4ObzbvXfnglv1NDW1Vk2mGWO44Ytz3lMZ9MKOE0Hx4lCTmGBFeKtKLnZD9d
         tfFZW888kSX3+Go16hqlzOFILIIecFAKZtwdkYS/CR+rmOjdD4Xje17gl22T6JxIX7BY
         smkw==
X-Received: by 10.112.204.231 with SMTP id lb7mr5239714lbc.4.1370827798055;
 Sun, 09 Jun 2013 18:29:58 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:29:58 -0700 (PDT)
In-Reply-To: <1370759178-1709-8-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: _605O8uf4IR04jv9sEF2O5vl10I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227225>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> diff --git a/pathspec.c b/pathspec.c
> index 89bdc7f..9e68321 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -271,10 +271,20 @@ void parse_pathspec(struct pathspec *pathspec,
>         if (!entry && !prefix)
>                 return;
>
> +       if ((flags & PATHSPEC_PREFER_CWD) &&
> +           (flags & PATHSPEC_PREFER_FULL))
> +               die("BUG: PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FUL=
L are incompatible");
> +
>         /* No arguments with prefix -> prefix pathspec */
>         if (!entry) {
>                 static const char *raw[2];
>
> +               if (flags & PATHSPEC_PREFER_FULL)
> +                       return;
> +
> +               if (!(flags & PATHSPEC_PREFER_CWD))
> +                       die("BUG: parse_pathspec cannot take no argum=
ents in this case");

"in this case" is a bit nebulous. Perhaps:

    die("BUG: PATHSPEC_PREFER_CWD requires arguments");

>                 pathspec->items =3D item =3D xmalloc(sizeof(*item));
>                 memset(item, 0, sizeof(*item));
>                 item->match =3D prefix;
> @@ -340,7 +350,8 @@ const char **get_pathspec(const char *prefix, con=
st char **pathspec)
>         struct pathspec ps;
>         parse_pathspec(&ps,
>                        PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
> -                      0, prefix, pathspec);
> +                      PATHSPEC_PREFER_CWD,
> +                      prefix, pathspec);
>         return ps.raw;
>  }
