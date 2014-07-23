From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 11/31] $GIT_COMMON_DIR: a new environment variable
Date: Wed, 23 Jul 2014 01:21:58 -0400
Message-ID: <CAPig+cQPqzvQ7wVSJf_h3UB75eqsg378Zw=YVN-exHVpVFs-mg@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 07:22:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9p09-0005PM-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 07:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbaGWFWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 01:22:00 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:34603 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbaGWFV7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 01:21:59 -0400
Received: by mail-yh0-f52.google.com with SMTP id t59so475268yho.25
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 22:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BH+WEKy8qmIXlLAzq6rbZw/JqyLnO27b/eTm70JIBZU=;
        b=kMj380xEU9MZWm6FtLA2ZCacDyVd8SDefuLRqrKo9VJxoK3davlLyyCGi/jnTJp6m4
         UM7K30aN30p3eEOLfY7D6R1iGZXRsF0ahv7QJQJGxX72F+3qx2dDktxOPc/CommSvIWl
         qps+mmsznAUR8VeojYofRfVFio1Uecn4wo0F6PVYqY87huzmjq2tXWOdD0aSGeTVy4CH
         HVqdogYqE3feec+TAxG4hXObSZoVS4oKUVN4g/hOVSGOGD4JNXDRlmdUE/oy7KHbPpxX
         95kQHMVbQHeZis+faj6W42rhja1h62eAvirRIh41kKi8zgfVv7j1V1dyzERpvB058rgf
         G//A==
X-Received: by 10.236.38.71 with SMTP id z47mr25224099yha.18.1406092918343;
 Tue, 22 Jul 2014 22:21:58 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Tue, 22 Jul 2014 22:21:58 -0700 (PDT)
In-Reply-To: <1405227068-25506-12-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: cgfrEZ34MgzWdaGSeU7duZo2Apg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254058>

On Sun, Jul 13, 2014 at 12:50 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> This variable is intended to support multiple working directories
> attached to a repository. Such a repository may have a main working
> directory, created by either "git init" or "git clone" and one or mor=
e
> linked working directories. These working directories and the main
> repository share the same repository directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index 17d2ea6..7629e38 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -133,6 +138,11 @@ being a symref to point at the current branch.  =
Such a state
>  is often called 'detached HEAD.'  See linkgit:git-checkout[1]
>  for details.
>
> +config::
> +       Repository specific configuration file. This file is ignored

s/ignored/ignored if/

> +       $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
> +       used instead.
> +
>  branches::
>         A slightly deprecated way to store shorthands to be used
>         to specify a URL to 'git fetch', 'git pull' and 'git push'.
> diff --git a/environment.c b/environment.c
> index fee12a6..6b74f68 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -149,9 +149,18 @@ static void setup_git_env(void)
>                 git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
>         gitfile =3D read_gitfile(git_dir);
>         git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
> -       git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, "objects=
", &git_db_env);
> -       git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, "inde=
x", &git_index_env);
> -       git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, "info=
/grafts", &git_graft_env);
> +       git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
> +       if (git_common_dir) {
> +               git_common_dir_env =3D 1;
> +               git_common_dir =3D xstrdup(git_common_dir);
> +       } else
> +               git_common_dir =3D git_dir;
> +       git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, git_comm=
on_dir,
> +                                          "objects", &git_db_env);
> +       git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, git_d=
ir,
> +                                          "index", &git_index_env);
> +       git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_d=
ir,
> +                                          "info/grafts", &git_graft_=
env);

Replacement refs come from git_common_dir, but grafts come from
git_dir. Is the inconsistency intentional?

>         if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
>                 check_replace_refs =3D 0;
>         namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONME=
NT));
> diff --git a/path.c b/path.c
> index 3deb80c..8a6586c 100644
> --- a/path.c
> +++ b/path.c
> @@ -90,6 +90,38 @@ static void replace_dir(struct strbuf *buf, int le=
n, const char *newdir)
>                 buf->buf[newlen] =3D '/';
>  }
>
> +static const char *common_list[] =3D {
> +       "/branches", "/hooks", "/info", "/logs", "/lost-found", "/mod=
ules",
> +       "/objects", "/refs", "/remotes", "/rr-cache", "/svn",
> +       "config", "gc.pid", "packed-refs", "shallow",
> +       NULL
> +};
> +
> +static void update_common_dir(struct strbuf *buf, int git_dir_len)
> +{
> +       char *base =3D buf->buf + git_dir_len;
> +       const char **p;
> +
> +       if (is_dir_file(base, "logs", "HEAD"))
> +               return; /* keep this in $GIT_DIR */
> +       for (p =3D common_list; *p; p++) {
> +               const char *path =3D *p;
> +               int is_dir =3D 0;
> +               if (*path =3D=3D '/') {
> +                       path++;
> +                       is_dir =3D 1;
> +               }
> +               if (is_dir && dir_prefix(base, path)) {
> +                       replace_dir(buf, git_dir_len, get_git_common_=
dir());
> +                       return;
> +               }
> +               if (!is_dir && !strcmp(base, path)) {
> +                       replace_dir(buf, git_dir_len, get_git_common_=
dir());
> +                       return;
> +               }

The bodies of these two conditionals are identical. Would it make
sense to combine them (or does a later patch take advantage of the
distinction)?

    if ((is_dir && dir_prefix(base, path)) ||
       (!is_dir && !strcmp(base, path))) {
        replace_dir(buf, git_dir_len, get_git_common_dir());
        return;
    }

> +       }
> +}
> +
>  static void adjust_git_path(struct strbuf *buf, int git_dir_len)
>  {
>         const char *base =3D buf->buf + git_dir_len;
