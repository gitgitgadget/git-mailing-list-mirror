From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 27/32] prune: strategies for linked checkouts
Date: Wed, 9 Jul 2014 07:24:22 -0400
Message-ID: <CAPig+cTcwuwnndOBeNbOqc4oTmyC3GW2+RsAXPDRznUVvLp8Ew@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1404891197-18067-28-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4pzH-0006XM-6I
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 13:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbaGILY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 07:24:26 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:63979 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaGILYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 07:24:24 -0400
Received: by mail-la0-f44.google.com with SMTP id ty20so4978841lab.31
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=rz5VxUHd70J0Pg8o1+S+p7FOa2ICNZqMUzxLnTkZGZ0=;
        b=o9AjEqCxApvKZwiElylnneyMSdL+jKR4tqQvR2AJebyuORLT1IRkSoKbQovAIORQ8W
         baGpLTFr/Q704Bxc4rB5jtO12DSLY+hYpsqVN2EItkfQy2n7nO3y62pTvN4VomNnr58b
         0kXPORTqBVZgRVZo7JsYx8twSf0uIWehAD0rJKr2MaTyd3IedeQgeXzB6UX1QMRoAdwp
         YD5J1LhNJOEMi+FFOTr0qi16nCXpQW1nmJD7BoWa5HtqvXQTG3jM+gCXEic6bBQ3uKtm
         D0QY5xrFGmd1yM3R1BqCd8FkyXmrjjR87KatrklFE0eoHFYDo5y7j7PnVjH5d6yBsFsq
         Ml9A==
X-Received: by 10.112.167.105 with SMTP id zn9mr30303935lbb.10.1404905062496;
 Wed, 09 Jul 2014 04:24:22 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Wed, 9 Jul 2014 04:24:22 -0700 (PDT)
In-Reply-To: <1404891197-18067-28-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: T71X0mShrGKYz_RTiAXA6ylVlSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253117>

On Wed, Jul 9, 2014 at 3:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> (alias R=3D$GIT_COMMON_DIR/repos/<id>)
>
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>
>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>    $R/gitdir's mtime is older than a limit, and it points to nowhere,
>    repos/<id> is to be pruned.
>
>  - If $R/locked exists, repos/<id> is not supposed to be pruned. If
>    $R/locked exists and $R/gitdir's mtime is older than a really long
>    limit, warn about old unused repo.
>
>  - "git checkout --to" is supposed to make a hard link named $R/link
>    pointing to the .git file on supported file systems to help detect
>    the user manually deleting the checkout. If $R/link exists and its
>    link count is greated than 1, the repo is kept.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 144a3bd..6db6bcc 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -112,6 +112,70 @@ static void prune_object_dir(const char *path)
>         }
>  }
>
> +static const char *prune_repo_dir(const char *id, struct stat *st)
> +{
> +       char *path;
> +       int fd, len;
> +       if (file_exists(git_path("repos/%s/locked", id)))
> +               return NULL;
> +       if (stat(git_path("repos/%s/gitdir", id), st)) {
> +               st->st_mtime =3D expire;
> +               return _("gitdir does not exist");

If a plain file exists in 'repos' for some reason, it will be caught
by this case. Would it make sense, however, to handle that specially
and report a more accurate message, such as "not a repo" or some such?

> +       }
> +       fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);

If 'gitdir' fails to open for some reason (lack of permissions, it's a
directory, etc.), the subsequent read_in_full() will crash.

> +       len =3D st->st_size;
> +       path =3D xmalloc(len + 1);
> +       read_in_full(fd, path, len);
> +       close(fd);

strbuf_readfile() might make this a bit cleaner (though has higher over=
head).

> +       while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
)
> +               len--;

If, for some reason, 'gitdir' content is empty or consists only of CR
and LF, this will access memory outside of the allocated region.
Probably want:

    while (len > 0 && (... || ...))

> +       path[len] =3D '\0';
> +       if (!file_exists(path)) {

What happens if 'path' ends up empty (due to hand-editing of 'gitdir'
by the user, for instance)? Does this case deserve an appropriate
diagnostic ("corrupt 'gitdir' file" or something)?

> +               struct stat st_link;
> +               free(path);
> +               /*
> +                * the repo is moved manually and has not been
> +                * accessed since?
> +                */
> +               if (!stat(git_path("repos/%s/link", id), &st_link) &&
> +                   st_link.st_nlink > 1)
> +                       return NULL;
> +               return _("gitdir points to non-existing file");

s/existing/existent/
s/file/location/

> +       }
> +       free(path);
> +       return NULL;
> +}
> +
> +static void prune_repos_dir(void)
> +{
> +       const char *reason;
> +       DIR *dir =3D opendir(git_path("repos"));
> +       struct dirent *d;
> +       int removed =3D 0;
> +       struct stat st;
> +       if (!dir)
> +               return;
> +       while ((d =3D readdir(dir)) !=3D NULL) {
> +               if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, "..=
"))
> +                       continue;
> +               if ((reason =3D prune_repo_dir(d->d_name, &st)) !=3D =
NULL &&
> +                   st.st_mtime <=3D expire) {
> +                       struct strbuf sb =3D STRBUF_INIT;
> +                       if (show_only || verbose)
> +                               printf(_("Removing repos/%s: %s\n"), =
d->d_name, reason);
> +                       if (show_only)
> +                               continue;
> +                       strbuf_addstr(&sb, git_path("repos/%s", d->d_=
name));
> +                       remove_dir_recursively(&sb, 0);

What happens if this entry in 'repos' is a plain file (or other
non-directory)? Based upon my reading of remove_dir_recursively(), it
won't be deleted, yet the logic of prune_repo_dir() implies that such
an entry should be pruned. Perhaps handle this case specially with
unlink()?

> +                       strbuf_release(&sb);
> +                       removed =3D 1;
> +               }
> +       }
> +       closedir(dir);
> +       if (removed)
> +               rmdir(git_path("repos"));

This works, but at first glance it seems strange not to be checking
'show_only' before calling destructive rmdir().

However, stepping back, it's not quite clear what the intent is.
Ignoring the return value of rmdir() implies that you trust it to Do
The Right Thing: succeed when 'repos' is empty and fail when not. This
assumption of behavior applies regardless of whether or not any
content of 'repos' was removed, so the 'removed' flag does not seem
beneficial.

Moreover, the 'removed' flag actively prevents the 'repos' directory
from being pruned in the corner case where the user manually emptied
the content of 'repos' before invoking "git prune". Therefore, it
might be simpler to drop the 'removed' variable altogether and
rephrase as:

    if (!show_only)
        rmdir(git_path("repos"));

> +}
> +
>  /*
>   * Write errors (particularly out of space) can result in
>   * failed temporary packs (and more rarely indexes and other
> @@ -138,10 +202,12 @@ int cmd_prune(int argc, const char **argv, cons=
t char *prefix)
>  {
>         struct rev_info revs;
>         struct progress *progress =3D NULL;
> +       int prune_repos =3D 0;
>         const struct option options[] =3D {
>                 OPT__DRY_RUN(&show_only, N_("do not remove, show only=
")),
>                 OPT__VERBOSE(&verbose, N_("report pruned objects")),
>                 OPT_BOOL(0, "progress", &show_progress, N_("show prog=
ress")),
> +               OPT_BOOL(0, "repos", &prune_repos, N_("prune .git/rep=
os/")),
>                 OPT_EXPIRY_DATE(0, "expire", &expire,
>                                 N_("expire objects older than <time>"=
)),
>                 OPT_END()
> @@ -154,6 +220,14 @@ int cmd_prune(int argc, const char **argv, const=
 char *prefix)
>         init_revisions(&revs, prefix);
>
>         argc =3D parse_options(argc, argv, prefix, options, prune_usa=
ge, 0);
> +
> +       if (prune_repos) {
> +               if (argc)
> +                       die(_("--repos does not take extra arguments"=
));
> +               prune_repos_dir();
> +               return 0;
> +       }
> +
>         while (argc--) {
>                 unsigned char sha1[20];
>                 const char *name =3D *argv++;
> diff --git a/setup.c b/setup.c
> index 8f90bc3..da2d669 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -390,6 +390,17 @@ static int check_repository_format_gently(const =
char *gitdir, int *nongit_ok)
>         return ret;
>  }
>
> +static void update_linked_gitdir(const char *gitfile, const char *gi=
tdir)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +       struct stat st;
> +
> +       strbuf_addf(&path, "%s/gitfile", gitdir);
> +       if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NUL=
L))
> +               write_file(path.buf, 0, "%s\n", gitfile);
> +       strbuf_release(&path);
> +}
> +
>  /*
>   * Try to read the location of the git directory from the .git file,
>   * return path to git directory if found.
> @@ -438,6 +449,8 @@ const char *read_gitfile(const char *path)
>
>         if (!is_git_directory(dir))
>                 die("Not a git repository: %s", dir);
> +
> +       update_linked_gitdir(path, dir);
>         path =3D real_path(dir);
>
>         free(buf);
> --
> 1.9.1.346.ga2b5940
