From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] untracked-cache: fix subdirectory handling
Date: Sun, 16 Aug 2015 19:16:24 +0700
Message-ID: <CACsJy8C=rnqrJHqMBSQcBsD1ihSvztVCnQ46N2mzoeh=HFM6qw@mail.gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 14:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQwsI-0006Wu-61
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 14:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbbHPMQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2015 08:16:55 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33718 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbHPMQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2015 08:16:54 -0400
Received: by iods203 with SMTP id s203so125249850iod.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 05:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E7ZIAr+AZjqTRzdpSsuSekGFyW8OXenRrwfi/CntOA8=;
        b=vf2WoT0YmcmPgRYDKnAzaVMe/NpSTGU3DCrm40t1IaBxL2lhVOuCp0pxz/KrvRenbn
         xrK776fTA5nxSoKr1/1SN2tt3sieh8AOd4PbgkKwpfyq1u22fPdTBbDYnVmMib1Y0E9u
         o9+zWCaDQZ6XeHUwOE84U1WEj6PRytyy97sHEZnnHlCvC+9qphgEvtkECH/eSnpcqblS
         2g8e3XAIUbpJOvIunE2mWKDr5JfGz+T8Kd+X4Z8MH5G+yLCYSdtc17ov+FmEyPnZ1zw9
         1+l8s0iWM+efd5byoaXko5nfPTh/obVf+VShPtosOrKlU9uosQExLD68mWSsS/MRd9Sj
         kJBg==
X-Received: by 10.107.4.1 with SMTP id 1mr50789780ioe.10.1439727413633; Sun,
 16 Aug 2015 05:16:53 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sun, 16 Aug 2015 05:16:24 -0700 (PDT)
In-Reply-To: <1439702227-15453-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276019>

On Sun, Aug 16, 2015 at 12:17 PM, David Turner <dturner@twopensource.co=
m> wrote:
> Previously, some calls lookup_untracked would pass a full path.  But
> lookup_untracked assumes that the portion of the path up to and
> including to the untracked_cache_dir has been removed.  So
> lookup_untracked would be looking in the untracked_cache for 'foo' fo=
r
> 'foo/bar' (instead of just looking for 'bar').  This would cause
> untracked cache corruption.
>
> Instead, treat_directory learns to track the base length of the paren=
t
> directory, so that only the last path component is passed to
> lookup_untracked.

Your v2 also fixes untracked_cache_invalidate_path(), which is not
included here. Maybe it's in another patch?

> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>
> This version incorporates Duy's version of the dir.c code, and his
> suggested test speedup.
>
> ---
>  dir.c                             | 14 ++++----
>  t/t7063-status-untracked-cache.sh | 74 +++++++++++++++++++++++++++++=
++++++++--
>  2 files changed, 80 insertions(+), 8 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index e7b89fe..cd4ac77 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1297,7 +1297,7 @@ static enum exist_status directory_exists_in_in=
dex(const char *dirname, int len)
>   */
>  static enum path_treatment treat_directory(struct dir_struct *dir,
>         struct untracked_cache_dir *untracked,
> -       const char *dirname, int len, int exclude,
> +       const char *dirname, int len, int baselen, int exclude,
>         const struct path_simplify *simplify)
>  {
>         /* The "len-1" is to strip the final '/' */
> @@ -1324,7 +1324,8 @@ static enum path_treatment treat_directory(stru=
ct dir_struct *dir,
>         if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
>                 return exclude ? path_excluded : path_untracked;
>
> -       untracked =3D lookup_untracked(dir->untracked, untracked, dir=
name, len);
> +       untracked =3D lookup_untracked(dir->untracked, untracked,
> +                                    dirname + baselen, len - baselen=
);
>         return read_directory_recursive(dir, dirname, len,
>                                         untracked, 1, simplify);
>  }
> @@ -1444,6 +1445,7 @@ static int get_dtype(struct dirent *de, const c=
har *path, int len)
>  static enum path_treatment treat_one_path(struct dir_struct *dir,
>                                           struct untracked_cache_dir =
*untracked,
>                                           struct strbuf *path,
> +                                         int baselen,
>                                           const struct path_simplify =
*simplify,
>                                           int dtype, struct dirent *d=
e)
>  {
> @@ -1495,8 +1497,8 @@ static enum path_treatment treat_one_path(struc=
t dir_struct *dir,
>                 return path_none;
>         case DT_DIR:
>                 strbuf_addch(path, '/');
> -               return treat_directory(dir, untracked, path->buf, pat=
h->len, exclude,
> -                       simplify);
> +               return treat_directory(dir, untracked, path->buf, pat=
h->len,
> +                                      baselen, exclude, simplify);
>         case DT_REG:
>         case DT_LNK:
>                 return exclude ? path_excluded : path_untracked;
> @@ -1557,7 +1559,7 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
>                 return path_none;
>
>         dtype =3D DTYPE(de);
> -       return treat_one_path(dir, untracked, path, simplify, dtype, =
de);
> +       return treat_one_path(dir, untracked, path, baselen, simplify=
, dtype, de);
>  }
>
>  static void add_untracked(struct untracked_cache_dir *dir, const cha=
r *name)
> @@ -1827,7 +1829,7 @@ static int treat_leading_path(struct dir_struct=
 *dir,
>                         break;
>                 if (simplify_away(sb.buf, sb.len, simplify))
>                         break;
> -               if (treat_one_path(dir, NULL, &sb, simplify,
> +               if (treat_one_path(dir, NULL, &sb, baselen, simplify,
>                                    DT_DIR, NULL) =3D=3D path_none)
>                         break; /* do not recurse into it */
>                 if (len <=3D baselen) {
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untra=
cked-cache.sh
> index ff23f4e..6716f69 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -402,13 +402,14 @@ test_expect_success 'set up sparse checkout' '
>         echo "done/[a-z]*" >.git/info/sparse-checkout &&
>         test_config core.sparsecheckout true &&
>         git checkout master &&
> -       git update-index --untracked-cache &&
> +       git update-index --untracked-cache --force-untracked-cache &&
>         git status --porcelain >/dev/null && # prime the cache
>         test_path_is_missing done/.gitignore &&
>         test_path_is_file done/one
>  '
>
> -test_expect_success 'create files, some of which are gitignored' '
> +test_expect_success 'create/modify files, some of which are gitignor=
ed' '
> +       echo two bis >done/two &&
>         echo three >done/three && # three is gitignored
>         echo four >done/four && # four is gitignored at a higher leve=
l
>         echo five >done/five # five is not gitignored
> @@ -420,6 +421,7 @@ test_expect_success 'test sparse status with untr=
acked cache' '
>         GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
>         git status --porcelain >../status.actual &&
>         cat >../status.expect <<EOF &&
> + M done/two
>  ?? .gitignore
>  ?? done/five
>  ?? dtwo/
> @@ -459,6 +461,7 @@ test_expect_success 'test sparse status again wit=
h untracked cache' '
>         GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
>         git status --porcelain >../status.actual &&
>         cat >../status.expect <<EOF &&
> + M done/two
>  ?? .gitignore
>  ?? done/five
>  ?? dtwo/
> @@ -473,4 +476,71 @@ EOF
>         test_cmp ../trace.expect ../trace
>  '
>
> +test_expect_success 'set up for test of subdir and sparse checkouts'=
 '
> +       mkdir done/sub &&
> +       mkdir done/sub/sub &&
> +       echo "sub" > done/sub/sub/file
> +'
> +
> +test_expect_success 'test sparse status with untracked cache and sub=
dir' '
> +       avoid_racy &&
> +       : >../trace &&
> +       GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
> +       git status --porcelain >../status.actual &&
> +       cat >../status.expect <<EOF &&
> + M done/two
> +?? .gitignore
> +?? done/five
> +?? done/sub/
> +?? dtwo/
> +EOF
> +       test_cmp ../status.expect ../status.actual &&
> +       cat >../trace.expect <<EOF &&
> +node creation: 2
> +gitignore invalidation: 0
> +directory invalidation: 1
> +opendir: 3
> +EOF
> +       test_cmp ../trace.expect ../trace
> +'
> +
> +test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
> +       test-dump-untracked-cache >../actual &&
> +       cat >../expect <<EOF &&
> +info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
> +core.excludesfile 0000000000000000000000000000000000000000
> +exclude_per_dir .gitignore
> +flags 00000006
> +/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
> +.gitignore
> +dtwo/
> +/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
> +five
> +sub/
> +/done/sub/ 0000000000000000000000000000000000000000 recurse check_on=
ly valid
> +sub/
> +/done/sub/sub/ 0000000000000000000000000000000000000000 recurse chec=
k_only valid
> +file
> +/dthree/ 0000000000000000000000000000000000000000 recurse check_only=
 valid
> +/dtwo/ 0000000000000000000000000000000000000000 recurse check_only v=
alid
> +two
> +EOF
> +       test_cmp ../expect ../actual
> +'
> +
> +test_expect_success 'test sparse status again with untracked cache a=
nd subdir' '
> +       avoid_racy &&
> +       : >../trace &&
> +       GIT_TRACE_UNTRACKED_STATS=3D"$TRASH_DIRECTORY/trace" \
> +       git status --porcelain >../status.actual &&
> +       test_cmp ../status.expect ../status.actual &&
> +       cat >../trace.expect <<EOF &&
> +node creation: 0
> +gitignore invalidation: 0
> +directory invalidation: 0
> +opendir: 0
> +EOF
> +       test_cmp ../trace.expect ../trace
> +'
> +
>  test_done
> --
> 2.4.2.622.gac67c30-twtrsrc
>



--=20
Duy
