From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 12/45] parse_pathspec: support prefixing original patterns
Date: Sun, 9 Jun 2013 21:41:13 -0400
Message-ID: <CAPig+cROo-yPcY7614yc5B+Q-tV6iJdRqukZ-d7i7GKNikCshg@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulr6l-00009E-RR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3FJBlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:41:16 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48680 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3FJBlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:41:15 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so4748006lbv.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sBf+L6DaEvhVBKExKkCP5ebva7eWNxoPrzWkIyk1axg=;
        b=RI0vlWcvxGWvkNA7Ww9viUm0tnqVjKE2bAd1PQapT56kdUMzo5ILFwRmX7HQ7teUyL
         Zkc8ri0AT3vDLepdSSrFwfEjUcAHbmq8vzusoiZBO6lqiFdGycrsCekhQgJt3hZC2+tA
         sQXVbubEF4MqXp/67mZC1yY87faUZI9gYYS42Zp93yKFv1hvQHMiLrZytYisrpWu5T65
         KuO04nGhmsQKEi921QWQTfmJRJ6qyIK0UHRvLMZowc5NznpTeiFYoqFuD0KAqpilkAQu
         +1mnnqW8o9VlKButF5MjELrWbJtihvWerYOF7lmiKg0jdQo/zlGZcZ7xgSYriu1my+Pw
         /31Q==
X-Received: by 10.112.181.71 with SMTP id du7mr5431072lbc.24.1370828473648;
 Sun, 09 Jun 2013 18:41:13 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:41:13 -0700 (PDT)
In-Reply-To: <1370759178-1709-13-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 1yrwdU39S3kiLq7eWp9Z1Hi5lkI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227228>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This makes 'original' suitable for passing to an external command
> because all pathspec magic is left in place, provided that the
> external command understands pathspec. The prefixing is needed becaus=
e
> we usually launch a subcommand at worktree's top directory and the
> subcommand can no longer calculate the prefix itself.
>
> This slightly affects the original purpose of 'original'
> (i.e. reporting). We should report without prefixing. So only turn
> this flag on when you know you are about to pass the result straight
> away to an external command.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/pathspec.c b/pathspec.c
> index 9aaec36..ba0a41d 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -203,7 +203,17 @@ static unsigned prefix_pathspec(struct pathspec_=
item *item,
>         else
>                 match =3D prefix_path(prefix, prefixlen, copyfrom);
>         *raw =3D item->match =3D match;
> -       item->original =3D elt;
> +       /*
> +        * Prefix the pathspec (keep all magic) and put to

s/put/assign/ perhaps?

> +        * original. Useful for passing to another command.
> +        */
> +       if (flags & PATHSPEC_PREFIX_ORIGIN) {
> +               struct strbuf sb =3D STRBUF_INIT;
> +               strbuf_add(&sb, elt, copyfrom - elt);
> +               strbuf_addstr(&sb, match);
> +               item->original =3D strbuf_detach(&sb, NULL);
> +       } else
> +               item->original =3D elt;
>         item->len =3D strlen(item->match);
>
>         if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
