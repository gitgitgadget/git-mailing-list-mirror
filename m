From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 17/21] list-files: show directories as well as files
Date: Sun, 25 Jan 2015 14:16:36 -0500
Message-ID: <CAPig+cTwcAWUiJGViYDjeRifd2ERojQR+f+cpSB806RwYHoCCw@mail.gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
	<1422189476-7518-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 20:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFSft-0000wE-0v
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 20:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbbAYTQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 14:16:40 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:55941 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936AbbAYTQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2015 14:16:37 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so2121724yho.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=nhUKMooQ+OQwU2Ei+xlmgGF5SEAAOUWEJTrAo4k7R3o=;
        b=ao7X6peQ9AarJXTY2IkwZUszS/vSQArKh+1qVTvG2W4oH9m7w9wqU0u1EKmCRIjHb0
         CaA3Cf/VDTcOVCU7Ph7FwuPCRYnlqHHOVspEjCh0E/9tepoZN4+Low8Ym6+f4FDTSLtH
         7sAncnoX75QcnUAfY4AJnnbMSdSs8HiYqQzqdLeMCk56WTCJUsSYHeL/HGpZiYZE8VT3
         BJgeVuAYW0iQoIFpUukgYtpgRX5uEyTiKdsjYK0W7as09R7LQxwg4/CQJp/2r92wIO8f
         g82jUZ5U5LLF3y6zz/N3XiZj4/FqwmieaidVNf1HdeBeVvlraaJxb++2aH3gVH3owGWc
         QZZA==
X-Received: by 10.236.202.238 with SMTP id d74mr7686222yho.166.1422213396565;
 Sun, 25 Jan 2015 11:16:36 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 25 Jan 2015 11:16:36 -0800 (PST)
In-Reply-To: <1422189476-7518-18-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: HGiJtm0w9uYE0tOcD-y9nG37gl0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263019>

On Sun, Jan 25, 2015 at 7:37 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The index does not store directories explicitly (except submodules) s=
o
> we have to figure them out from file list when output lis depth-limit=
ed.
>
> The function show_as_directory() deliberately generates duplicate
> directories and expects the previous patch to remove duplicates.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 1a1c9c8..29b5c2e 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -179,6 +181,35 @@ static void show_killed_files(struct dir_struct =
*dir)
>         }
>  }
>
> +static int show_as_directory(const struct cache_entry *ce)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char *p;
> +
> +       strbuf_add(&sb, ce->name, ce_namelen(ce));
> +       while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
> +               struct strbuf sb2 =3D STRBUF_INIT;
> +               strbuf_setlen(&sb, p - sb.buf);
> +               if (!match_pathspec(&pathspec, sb.buf, sb.len,
> +                                   max_prefix_len, NULL, 1))
> +                       continue;
> +               write_name(&sb2, sb.buf);
> +               if (want_color(use_color)) {
> +                       struct strbuf sb3 =3D STRBUF_INIT;
> +                       color_filename(&sb3, ce->name, sb2.buf, S_IFD=
IR, 1);
> +                       strbuf_release(&sb2);
> +                       sb2 =3D sb3;

Although more expensive, would it be a bit more idiomatic and obvious
to phrase this as

    strbuf_swap(&sb2, &sb3);
    strbuf_release(&sb3);

or is it not worth it?

> +               }
> +               if (show_tag)
> +                       strbuf_insert(&sb2, 0, tag_cached, strlen(tag=
_cached));
> +               strbuf_fputs(&sb2, strbuf_detach(&sb, NULL), NULL);

The detached strbuf content gets assigned to the 'util' field of the
'struct string_list output' item and is eventually leaked, however,
the program exits soon after. Okay.

> +               strbuf_release(&sb2);
> +               return 1;
> +       }
> +       strbuf_release(&sb);
> +       return 0;
> +}
> +
>  static void write_ce_name(struct strbuf *sb, const struct cache_entr=
y *ce)
>  {
>         struct strbuf quoted =3D STRBUF_INIT;
