From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 16/25] list-files: add --unmerged
Date: Mon, 6 Apr 2015 17:34:41 -0400
Message-ID: <CAPig+cTs-rXcohvrm40ThSGtGYZvquF2q=jR245LyKsNW+NAQw@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:34:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEfP-0005pr-GQ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbbDFVen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:34:43 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:34188 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbbDFVem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:34:42 -0400
Received: by laat2 with SMTP id t2so21636014laa.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=dKZKoJuYJ6JfRl5tiCAc6AQj2k2SeWCnbJhzI/EOW/o=;
        b=ciGBcFNMv1iVuO6bzNDhtFD42u8H0nlPEZJFHZRqpbdoX7ImQcw05oskX/eLxKhRt6
         zVP82nafl2kwjm002lFD5y51QfyUA/KMbiUIfuAfPimTmu9R/3EGCBE9abP64t6X53Pa
         2wilnrhcjCMMC+xV03ZBopT3osTIVMEbEOIbG8JYc4ojBT6tV/MnL5RObPQMnbVZMvX9
         eNV8bU+AKA0BX9dZZ2bTem3zwZHekjEQo12f7soVGI3aAVTiVHOdvOr3ffDeOpn0QjAd
         u2xHvOkD0VWj+lRsig+8PcPkclTFgj5htoAJAv3/v5rfdsHxM73wul2ksfMhBsHhpYjg
         bCqw==
X-Received: by 10.152.219.2 with SMTP id pk2mr15043738lac.107.1428356081054;
 Mon, 06 Apr 2015 14:34:41 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:34:41 -0700 (PDT)
In-Reply-To: <1428328354-14897-17-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: yu6iDhuc5HK7do1tCkGIwvmJoHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266884>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 31991a4..fe15417 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -225,12 +229,46 @@ static void populate_untracked(struct item_list=
 *result,
>         }
>  }
>
> +static void populate_unmerged(struct item_list *result,
> +                             const struct string_list *change)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < change->nr; i++) {
> +               const struct string_list_item *it =3D change->items +=
 i;
> +               struct wt_status_change_data *d =3D it->util;
> +               const char *name =3D it->string;
> +               const char *tag;
> +               struct stat st;
> +
> +               switch (d->stagemask) {
> +               case 1: tag =3D "DD"; break; /* both deleted */
> +               case 2: tag =3D "AU"; break; /* added by us */
> +               case 3: tag =3D "UD"; break; /* deleted by them */
> +               case 4: tag =3D "UA"; break; /* added by them */
> +               case 5: tag =3D "DU"; break; /* deleted by us */
> +               case 6: tag =3D "AA"; break; /* both added */
> +               case 7: tag =3D "UU"; break; /* both modified */
> +               default: continue;

Does the 'default' case represent a "cannot happen" situation? If so,
does it deserve some sort of "BUG" diagnostic message or something?

More below.

> +               }
> +
> +               if (lstat(name, &st))
> +                       /* color_filename() treats this as an orphan =
file */
> +                       st.st_mode =3D 0;
> +
> +               if (!matched(result, name, st.st_mode))
> +                       continue;
> +
> +               add_wt_item(result, IS_UNMERGED, name, tag, &st);
> +       }
> +}
> +
> diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
> index 6b76d1f..7fe9673 100755
> --- a/t/t7013-list-files.sh
> +++ b/t/t7013-list-files.sh
> @@ -218,4 +218,39 @@ test_expect_success '--classify' '
>         )
>  '
>
> +test_expect_success 'list-files unmerged' '
> +       (
> +       add_stage() {
> +               echo "100644 $1 $2      $3" | git update-index --inde=
x-info
> +       }
> +       git init 3 &&
> +       cd 3 &&
> +       test_commit 1 &&
> +       SHA1=3D`echo 1 | git hash-object -w --stdin` &&

    SHA1=3D$(echo 1 | git hash-object -w --stdin) &&

> +       add_stage $SHA1 1 deleted-by-both &&
> +       add_stage $SHA1 2 added-by-us &&
> +       add_stage $SHA1 1 deleted-by-them &&
> +       add_stage $SHA1 2 deleted-by-them &&
> +       add_stage $SHA1 3 added-by-them &&
> +       add_stage $SHA1 3 deleted-by-us &&
> +       add_stage $SHA1 1 deleted-by-us &&
> +       add_stage $SHA1 2 added-by-both &&
> +       add_stage $SHA1 3 added-by-both &&
> +       add_stage $SHA1 1 modified-by-both &&
> +       add_stage $SHA1 2 modified-by-both &&
> +       add_stage $SHA1 3 modified-by-both &&
> +       git list-files -u >actual &&
> +       cat >expected <<-\EOF &&
> +       AA added-by-both
> +       UA added-by-them
> +       AU added-by-us
> +       DD deleted-by-both
> +       UD deleted-by-them
> +       DU deleted-by-us
> +       UU modified-by-both
> +       EOF
> +       test_cmp expected actual
> +       )
> +'
> +
>  test_done
> --
> 2.3.0.rc1.137.g477eb31
