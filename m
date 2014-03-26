From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/17] ls-files: buffer full item in strbuf before printing
Date: Wed, 26 Mar 2014 15:22:03 -0400
Message-ID: <CAPig+cRpL9PYKLEH8DocKWo2-ZnqtD6j30TLES1NyOnk52D+Mw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:22:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStOt-0008Q0-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbaCZTWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:22:06 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:36405 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbaCZTWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 15:22:03 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so2556369yho.15
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2j/vDxKRpaLbKKfIFVsOVaddPMosqwl7e450I492O+s=;
        b=mbHV+V+FgmHGnzbUEjjJAqCM2BMRLuuzYAji6oLy6BNmvhy2memy6YPacI4ndoRs4K
         XyEPsvlkGe5DcBSpTayff5Lio+PrsrdGD+wEhO1RK0eOiz+000bB66ZpPKmL0/A0xJyV
         yuxIpty16idFlFVhFgAlNOJodoZ4fT/SGGgpGqvH1/md5FoP23LpTfvth+gbfTxxBv7d
         u98FTVl6mK53oJkDClhXMQFgMxkhit98nidxvqFLxR47iV/f7NcwQQ5WiDjqswTKOG7+
         5FxLwjr+ijzjHxro/N8Oln0eitjcMFVV7cYy0qtk8njaogg8wRb8YMrkpbCLXazYNtq7
         ZhiA==
X-Received: by 10.236.147.10 with SMTP id s10mr37135925yhj.88.1395861723286;
 Wed, 26 Mar 2014 12:22:03 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 12:22:03 -0700 (PDT)
In-Reply-To: <1395841697-11742-6-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: sldXkeQobSALr0CDsf2V8jHzwjs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245214>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Buffering so that we can manipulate the strings (e.g. coloring)
> further before finally printing them.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/ls-files.c | 48 +++++++++++++++++++++++++++++++++++---------=
----
>  1 file changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 47c3880..6e30592 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -47,18 +47,30 @@ static const char *tag_modified =3D "";
>  static const char *tag_skip_worktree =3D "";
>  static const char *tag_resolve_undo =3D "";
>
> -static void write_name(const char *name)
> +static void write_name(struct strbuf *sb, const char *name)
>  {
>         /*
>          * With "--full-name", prefix_len=3D0; this caller needs to p=
ass
>          * an empty string in that case (a NULL is good for "").
>          */
> -       write_name_quoted_relative(name, prefix_len ? prefix : NULL,
> -                                  stdout, line_terminator);
> +       const char *real_prefix =3D prefix_len ? prefix : NULL;
> +       if (!line_terminator) {
> +               struct strbuf sb2 =3D STRBUF_INIT;
> +               strbuf_addstr(sb, relative_path(name, real_prefix, &s=
b2));
> +               strbuf_release(&sb2);
> +       } else
> +               quote_path_relative(name, real_prefix, sb);
> +       strbuf_addch(sb, line_terminator);
> +}
> +
> +static void strbuf_fputs(struct strbuf *sb, FILE *fp)
> +{
> +       fwrite(sb->buf, sb->len, 1, fp);
>  }
>
>  static void show_dir_entry(const char *tag, struct dir_entry *ent)
>  {
> +       static struct strbuf sb =3D STRBUF_INIT;
>         int len =3D max_prefix_len;
>
>         if (len >=3D ent->len)
> @@ -67,8 +79,10 @@ static void show_dir_entry(const char *tag, struct=
 dir_entry *ent)
>         if (!dir_path_match(ent, &pathspec, len, ps_matched))
>                 return;
>
> -       fputs(tag, stdout);
> -       write_name(ent->name);
> +       strbuf_reset(&sb);
> +       strbuf_addstr(&sb, tag);
> +       write_name(&sb, ent->name);
> +       strbuf_fputs(&sb, stdout);

strbuf_release(&sb);

>  }
>
>  static void show_other_files(struct dir_struct *dir)
> @@ -134,6 +148,7 @@ static void show_killed_files(struct dir_struct *=
dir)
>
>  static void show_ce_entry(const char *tag, const struct cache_entry =
*ce)
>  {
> +       static struct strbuf sb =3D STRBUF_INIT;
>         int len =3D max_prefix_len;
>
>         if (len >=3D ce_namelen(ce))
> @@ -161,16 +176,18 @@ static void show_ce_entry(const char *tag, cons=
t struct cache_entry *ce)
>                 tag =3D alttag;
>         }
>
> +       strbuf_reset(&sb);

'sb' is empty at this point. Why reset it?

>         if (!show_stage) {
> -               fputs(tag, stdout);
> +               strbuf_addstr(&sb, tag);
>         } else {
> -               printf("%s%06o %s %d\t",
> -                      tag,
> -                      ce->ce_mode,
> -                      find_unique_abbrev(ce->sha1,abbrev),
> -                      ce_stage(ce));
> +               strbuf_addf(&sb, "%s%06o %s %d\t",
> +                           tag,
> +                           ce->ce_mode,
> +                           find_unique_abbrev(ce->sha1,abbrev),
> +                           ce_stage(ce));
>         }
> -       write_name(ce->name);
> +       write_name(&sb, ce->name);
> +       strbuf_fputs(&sb, stdout);

strbuf_release(&sb);

>         if (debug_mode) {
>                 const struct stat_data *sd =3D &ce->ce_stat_data;
>
> @@ -206,7 +223,12 @@ static void show_ru_info(void)
>                         printf("%s%06o %s %d\t", tag_resolve_undo, ui=
->mode[i],
>                                find_unique_abbrev(ui->sha1[i], abbrev=
),
>                                i + 1);
> -                       write_name(path);
> +                       /*
> +                        * With "--full-name", prefix_len=3D0; this c=
aller needs to pass
> +                        * an empty string in that case (a NULL is go=
od for "").
> +                        */
> +                       write_name_quoted_relative(path, prefix_len ?=
 prefix : NULL,
> +                                                  stdout, line_termi=
nator);
>                 }
>         }
>  }
> --
> 1.9.1.345.ga1a145c
