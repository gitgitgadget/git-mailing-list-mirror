From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 16/17] ls: do not show duplicate cached entries
Date: Fri, 28 Mar 2014 00:04:35 -0400
Message-ID: <CAPig+cRurqCHyFtpCFOisc=1u06JSpmE9rHQa0ioLxrQMuJ4Dw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 05:04:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTO25-0003am-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 05:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaC1EEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2014 00:04:36 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:62639 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbaC1EEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2014 00:04:35 -0400
Received: by mail-yk0-f179.google.com with SMTP id 9so307893ykp.24
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 21:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=s/sGPfdZI+yRbVRDppXo4qVdoYEUiG67Pp/jRf63gEk=;
        b=QMSGtnhEAC7FJgfSto2FxZfRkp7FOHHn3kXWtg2Kkr0dNx4AWOSR+MwbvHJpz/H4JN
         Ka7MHsuyetyn7ZbbNF7puLZSq0BTzosYzP85tqzrQPhtDUNhyCLLPYIyABm9UohrKhib
         v4/xZTX2l9bH7vgKsT2IVD0zONgtsuv0VHZIN1WIrVr7/5jq51sDpq/EGiwUmm84SDir
         ZorDpe/a7ORBKsXXj5Njk2cZyjz/11LpU8IN8u0CWp6Q+tS58MACvWEIbmykC0zJ23Dh
         kmXaMSU17LyW7jT8E10lDghBywFi2LxYLiNm5yEjyxPZmLBiQphC5L2MKNJZaDu6MKw3
         +88g==
X-Received: by 10.236.83.6 with SMTP id p6mr8037401yhe.56.1395979475245; Thu,
 27 Mar 2014 21:04:35 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 21:04:35 -0700 (PDT)
In-Reply-To: <1395841697-11742-17-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 4oouWBbnhYCramlo_WrBFFhWnd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245362>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> With the current show_files() "ls -tcm" will show
>
>   foo.c
> M foo.c
>
> The first item is redundant. If "foo.c" is modified, we know it's in
> the cache. Introduce show_files_compact to do that because ls-files i=
s
> plumbing and scripts may already depend on current display behavior.
>
> Another difference in show_files_compact() is it does not show
> skip-worktree (aka outside sparse checkout) entries anymore, which
> makes sense in porcelain context.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/ls-files.c | 52 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 709d8b1..cd8e35c 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -337,6 +337,53 @@ static void show_files(struct dir_struct *dir)
>         }
>  }
>
> +static void show_files_compact(struct dir_struct *dir)
> +{
> +       int i;
> +
> +       /* For cached/deleted files we don't need to even do the read=
dir */
> +       if (show_others || show_killed) {
> +               if (!show_others)
> +                       dir->flags |=3D DIR_COLLECT_KILLED_ONLY;
> +               fill_directory(dir, &pathspec);
> +               if (show_others)
> +                       show_other_files(dir);
> +               if (show_killed)
> +                       show_killed_files(dir);
> +       }
> +       if (!(show_cached || show_stage || show_deleted || show_modif=
ied))
> +               return;
> +       for (i =3D 0; i < active_nr; i++) {
> +               const struct cache_entry *ce =3D active_cache[i];
> +               struct stat st;
> +               int err, shown =3D 0;
> +               if ((dir->flags & DIR_SHOW_IGNORED) &&
> +                   !ce_excluded(dir, ce))
> +                       continue;
> +               if (show_unmerged && !ce_stage(ce))
> +                       continue;
> +               if (ce->ce_flags & CE_UPDATE)
> +                       continue;
> +               if (ce_skip_worktree(ce))
> +                       continue;
> +               err =3D lstat(ce->name, &st);
> +               if (show_deleted && err) {
> +                       show_ce_entry(tag_removed, ce);
> +                       shown =3D 1;
> +               }
> +               if (show_modified && ce_modified(ce, &st, 0)) {

Is it possible for the lstat() to have failed for some reason when we
get here? If so, relying upon 'st' is unsafe, isn't it?

> +                       show_ce_entry(tag_modified, ce);
> +                       shown =3D 1;
> +               }
> +               if (ce_stage(ce)) {
> +                       show_ce_entry(tag_unmerged, ce);
> +                       shown =3D 1;
> +               }
> +               if (!shown && show_cached)
> +                       show_ce_entry(tag_cached, ce);
> +       }
> +}
> +
>  /*
>   * Prune the index to only contain stuff starting with "prefix"
>   */
> @@ -606,7 +653,10 @@ static int ls_files(const char **argv, const cha=
r *prefix)
>                 refresh_index(&the_index, REFRESH_QUIET, &pathspec, N=
ULL, NULL);
>                 setup_pager();
>         }
> -       show_files(&dir);
> +       if (porcelain)
> +               show_files_compact(&dir);
> +       else
> +               show_files(&dir);
>         if (show_resolve_undo)
>                 show_ru_info();
>
> --
> 1.9.1.345.ga1a145c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
