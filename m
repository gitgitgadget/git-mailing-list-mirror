From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass
 strbuf as base
Date: Sat, 8 Nov 2014 22:56:28 -0500
Message-ID: <CAPig+cQretAzbabEh=+RxHi5KtLLfqsyvteiPF2jPD3K+_7Lpw@mail.gmail.com>
References: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 04:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnJc9-0006tS-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 04:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbaKID4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 22:56:30 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:45807 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaKID43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 22:56:29 -0500
Received: by mail-yk0-f176.google.com with SMTP id 9so1620927ykp.35
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 19:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NQ8RgqbWVsHpysb1fb+4OcBLM+bWrixqn3R7tu/C7I8=;
        b=OjUKk+SjsVhYOvGJpDMzR5n8LqjKeOud/FSlYNAs8gWVQxc1ix2DxA3ULS3K5OG0TV
         Fx3w1K1cC7hrzf2wbFXhvmm1fhQl2oNlkTWChoD+R85VvDXsZiYz7WVcc7hxhAdBeaqw
         VMrv0TluY4i0AsnAwHeQcTZA/LBgmRdBMZ5xbufdSZB3uzhhOVehp0TXKcrQCM5K0pHF
         wN+BNgkv/TO6+wwRDPIKgSoJ3XkO7IxDXwvWUmdQ3sya7b6WoF6Zddvai/Wkq+v09xLJ
         XqOisVyIFkH32FvMgsyvEdZ+FPkGH6wuFKx3mMJTDzOM+hkBr9IBl+DCSlVJ0smJkcrK
         m5fw==
X-Received: by 10.170.128.16 with SMTP id u16mr12466193ykb.51.1415505388598;
 Sat, 08 Nov 2014 19:56:28 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sat, 8 Nov 2014 19:56:28 -0800 (PST)
In-Reply-To: <1415444432-18596-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: qAe0tO871o72my0IU-SB5NdO59M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 8, 2014 at 6:00 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This allows the callback to use 'base' as a temporary buffer to
> quickly assemble full path "without" extra allocation. The caller has
> to restore it afterwards of course.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1d332b8..1bd8c0d 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -276,23 +276,20 @@ struct tree *write_tree_from_memory(struct merg=
e_options *o)
>  }
>
>  static int save_files_dirs(const unsigned char *sha1,
> -               const char *base, int baselen, const char *path,
> +               struct strbuf *base, const char *path,
>                 unsigned int mode, int stage, void *context)
>  {
> -       int len =3D strlen(path);
> -       char *newpath =3D xmalloc(baselen + len + 1);
> +       int base_len =3D base->len;

Nit: The removed function argument was named 'baselen'. Also, patch
3/3 introduces a variable 'baseline' for the same purpose. Thus,
'base_len' here is a bit inconsistent.

>         struct merge_options *o =3D context;
>
> -       memcpy(newpath, base, baselen);
> -       memcpy(newpath + baselen, path, len);
> -       newpath[baselen + len] =3D '\0';
> +       strbuf_addstr(base, path);
>
>         if (S_ISDIR(mode))
> -               string_list_insert(&o->current_directory_set, newpath=
);
> +               string_list_insert(&o->current_directory_set, base->b=
uf);
>         else
> -               string_list_insert(&o->current_file_set, newpath);
> -       free(newpath);
> +               string_list_insert(&o->current_file_set, base->buf);
>
> +       strbuf_setlen(base, base_len);
>         return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>  }
>
> diff --git a/tree.c b/tree.c
> index bb02c1c..58ebfce 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -30,9 +30,12 @@ static int read_one_entry_opt(const unsigned char =
*sha1, const char *base, int b
>         return add_cache_entry(ce, opt);
>  }
>
> -static int read_one_entry(const unsigned char *sha1, const char *bas=
e, int baselen, const char *pathname, unsigned mode, int stage, void *c=
ontext)
> +static int read_one_entry(const unsigned char *sha1, struct strbuf *=
base,
> +                         const char *pathname, unsigned mode, int st=
age,
> +                         void *context)
>  {
> -       return read_one_entry_opt(sha1, base, baselen, pathname, mode=
, stage,
> +       return read_one_entry_opt(sha1, base->buf, base->len, pathnam=
e,
> +                                 mode, stage,
>                                   ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_=
DFCHECK);
>  }
>
> @@ -40,9 +43,12 @@ static int read_one_entry(const unsigned char *sha=
1, const char *base, int basel
>   * This is used when the caller knows there is no existing entries a=
t
>   * the stage that will conflict with the entry being added.
>   */
> -static int read_one_entry_quick(const unsigned char *sha1, const cha=
r *base, int baselen, const char *pathname, unsigned mode, int stage, v=
oid *context)
> +static int read_one_entry_quick(const unsigned char *sha1, struct st=
rbuf *base,
> +                               const char *pathname, unsigned mode, =
int stage,
> +                               void *context)
>  {
> -       return read_one_entry_opt(sha1, base, baselen, pathname, mode=
, stage,
> +       return read_one_entry_opt(sha1, base->buf, base->len, pathnam=
e,
> +                                 mode, stage,
>                                   ADD_CACHE_JUST_APPEND);
>  }
>
> @@ -70,7 +76,7 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
>                                 continue;
>                 }
>
> -               switch (fn(entry.sha1, base->buf, base->len,
> +               switch (fn(entry.sha1, base,
>                            entry.path, entry.mode, stage, context)) {
>                 case 0:
>                         continue;
> diff --git a/tree.h b/tree.h
> index d84ac63..d24125f 100644
> --- a/tree.h
> +++ b/tree.h
> @@ -4,6 +4,7 @@
>  #include "object.h"
>
>  extern const char *tree_type;
> +struct strbuf;
>
>  struct tree {
>         struct object object;
> @@ -22,7 +23,7 @@ void free_tree_buffer(struct tree *tree);
>  struct tree *parse_tree_indirect(const unsigned char *sha1);
>
>  #define READ_TREE_RECURSIVE 1
> -typedef int (*read_tree_fn_t)(const unsigned char *, const char *, i=
nt, const char *, unsigned int, int, void *);
> +typedef int (*read_tree_fn_t)(const unsigned char *, struct strbuf *=
, const char *, unsigned int, int, void *);
>
>  extern int read_tree_recursive(struct tree *tree,
>                                const char *base, int baselen,
> --
> 2.1.0.rc0.78.gc0d8480
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
