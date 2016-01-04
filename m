From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 20/20] fetch: add --deepen=<N> to extend shallow boundary
 by <N> commits
Date: Mon, 4 Jan 2016 04:45:05 -0500
Message-ID: <CAPig+cTiN+y0KXLjoK0EeyxXk6DOMG16A2gQ_a9PsU__DA-LUg@mail.gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
	<1451391043-28093-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Dongcan Jiang <dongcan.jiang@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 10:45:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG1hQ-0005Yd-HR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 10:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbcADJpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2016 04:45:09 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36082 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbcADJpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2016 04:45:06 -0500
Received: by mail-vk0-f51.google.com with SMTP id f2so207323192vkb.3
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=sitM6ZxtNYheKW4UYPk4lbnCtrImPBSC/FAu0TJH3L0=;
        b=Pu9gSTzgAzze0Oh/ihlFhX9cWJPDu6Bk2itEyQa/rotHwBb26f9bvspQKzrzHh2nhv
         uUExnnLO0RRumbmmFRJTPMe25Yvod5wzkhkJyNkQI+L5ATqWHNnRRXsIbu7w4LW9OxWP
         EhQGNPdXeFbZtq7YXSvK96atnxbLLPGmeOyKxIuBo2BLaiLf+I+MoFjRpueV2xj8hmBo
         miARw31t4+9vbbaEYVssjxvAEuP0IEjyMlyZH9+xFUgf7kbh6E9LFc87VQ+uc2s2GIwZ
         qMyiaFpMnMjOToV1492eMr+6PxESxA28h+ztWl0mgmeYSfhHkfALNGjUjjTCaFMRIpyq
         gA0g==
X-Received: by 10.31.164.78 with SMTP id n75mr27319614vke.14.1451900705881;
 Mon, 04 Jan 2016 01:45:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 4 Jan 2016 01:45:05 -0800 (PST)
In-Reply-To: <1451391043-28093-21-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 3GUypj-yi_lch7BUWKLLiBIXyuE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283293>

On Tue, Dec 29, 2015 at 7:10 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> In git-fetch, --depth argument is always relative with the latest
> remote refs. This makes it a bit difficult to cover this use case,
> where the user wants to make the shallow history, say 3 levels
> deeper. It would work if remote refs have not moved yet, but nobody
> can guarantee that, especially when that use case is performed a
> couple months after the last clone or "git fetch --depth". Also,
> modifying shallow boundary using --depth does not work well with
> clones created by --since or --not.
> [...]
>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Helped-By: Eric Sunshine <sunshine@sunshineco.com>

s/By/by/

> Helped-By: Junio C Hamano <gitster@pobox.com>

Ditto.

> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-op=
tions.txt
> @@ -13,6 +13,11 @@
> +--deepen=3D<depth>::
> +       Similar to --depth, except it specifies the number of commits
> +       from the current shallow boundary instead of from the tip of
> +       reach remote branch history.

Did you mean s/reach/each/ ?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> @@ -1185,6 +1189,15 @@ int cmd_fetch(int argc, const char **argv, con=
st char *prefix)
>         /* no need to be strict, transport_set_option() will validate=
 it again */
>         if (depth && atoi(depth) < 1)
>                 die(_("depth %s is not a positive number"), depth);
> +       if (deepen_relative) {
> +               struct strbuf sb =3D STRBUF_INIT;
> +               if (deepen_relative < 0)
> +                       die(_("Negative depth in --deepen is not supp=
orted"));
> +               if (depth)
> +                       die(_("--deepen and --depth are mutually excl=
usive"));
> +               strbuf_addf(&sb, "%d", deepen_relative);
> +               depth =3D strbuf_detach(&sb, NULL);

Maybe replace:

    struct strbuf sb =3D STRBUF_INIT;
    ...
    strbuf_addf(&sb, "%d", deepen_relative);
    depth =3D strbuf_detach(&sb, NULL);

with:

    depth =3D xstrfmt("%d", deepen_relative);

?

> +       }
>         if (depth || deepen_since || deepen_not.nr)
>                 deepen =3D 1;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -708,4 +708,16 @@ test_expect_success 'fetching a one-level ref wo=
rks' '
> +test_expect_success 'fetching deepen' '
> +       git clone . deepen --depth=3D1 && (

Style: ( on its own line.

> +               cd deepen &&
> +               git fetch .. foo --depth=3D1
> +               git show foo

Are these git-show instances merely for checking if a ref is valid? If
so, perhaps git-rev-parse would be clearer?

> +               test_must_fail git show foo~
> +               git fetch .. foo --deepen=3D1
> +               git show foo~
> +               test_must_fail git show foo~2

&&-chain heavily broken in subshell.

> +       )
> +'
