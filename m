From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 03/10] setup: convert setup_git_directory_gently_1
 et al. to strbuf
Date: Sat, 16 Aug 2014 22:14:05 +0200
Message-ID: <53EFBB8D.20600@web.de>
References: <53D694A2.8030007@web.de> <53D695E0.2050209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 22:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIkMt-0000io-Ae
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 22:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbaHPUOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Aug 2014 16:14:23 -0400
Received: from mout.web.de ([212.227.15.3]:59036 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbaHPUOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 16:14:22 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LsQQK-1WGq5K3r4q-0123Z9; Sat, 16 Aug 2014 22:14:11
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D695E0.2050209@web.de>
X-Provags-ID: V03:K0:ZjtaqZWNgr+XS8IH4+vcYE+Oiu2wO8dOEroNqttFDJISvXKg+/2
 fzdN0/leOQMQA2HviwU/YuUtDm1zHR8g9GFLGqInng6Ygd+l9Gkm9zcB+9B4EhqonAlUybc
 ld6bLjcddrFOi297oIhfi2olw7N4Fdc8IRivprrb4LiUGUZ+I+W2tY+SgAFxhqBExIOzhq5
 7sShRMxAufRv2g8c0gAkg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255339>

On 2014-07-28 20.26, Ren=C3=A9 Scharfe wrote:
> Convert setup_git_directory_gently_1() and its helper functions
> setup_explicit_git_dir(), setup_discovered_git_dir() and
> setup_bare_git_dir() to use a struct strbuf to hold the current worki=
ng
> directory.  Replacing the PATH_MAX-sized buffer used before removes a
> path length limition on some file systems.  The functions are convert=
ed
> all in one go because they all read and write the variable cwd.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  setup.c | 85 +++++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 43 insertions(+), 42 deletions(-)
>=20
> diff --git a/setup.c b/setup.c
> index 0a22f8b..c8b8a97 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -387,7 +387,7 @@ const char *read_gitfile(const char *path)
>  }
> =20
>  static const char *setup_explicit_git_dir(const char *gitdirenv,
> -					  char *cwd, int len,
> +					  struct strbuf *cwd,
>  					  int *nongit_ok)
>  {
>  	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
> @@ -441,7 +441,7 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
>  				die_errno("Could not chdir to '%s'", git_work_tree_cfg);
>  			if (!getcwd(core_worktree, PATH_MAX))
>  				die_errno("Could not get directory '%s'", git_work_tree_cfg);
> -			if (chdir(cwd))
> +			if (chdir(cwd->buf))
>  				die_errno("Could not come back to cwd");
>  			set_git_work_tree(core_worktree);
>  		}
> @@ -459,21 +459,20 @@ static const char *setup_explicit_git_dir(const=
 char *gitdirenv,
>  	worktree =3D get_git_work_tree();
> =20
>  	/* both get_git_work_tree() and cwd are already normalized */
> -	if (!strcmp(cwd, worktree)) { /* cwd =3D=3D worktree */
> +	if (!strcmp(cwd->buf, worktree)) { /* cwd =3D=3D worktree */
>  		set_git_dir(gitdirenv);
>  		free(gitfile);
>  		return NULL;
>  	}
> =20
> -	offset =3D dir_inside_of(cwd, worktree);
> +	offset =3D dir_inside_of(cwd->buf, worktree);
>  	if (offset >=3D 0) {	/* cwd inside worktree? */
>  		set_git_dir(real_path(gitdirenv));
>  		if (chdir(worktree))
>  			die_errno("Could not chdir to '%s'", worktree);
> -		cwd[len++] =3D '/';
> -		cwd[len] =3D '\0';
> +		strbuf_addch(cwd, '/');
>  		free(gitfile);
> -		return cwd + offset;
> +		return cwd->buf + offset;
>  	}
> =20
>  	/* cwd outside worktree */
> @@ -483,7 +482,7 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
>  }
> =20
>  static const char *setup_discovered_git_dir(const char *gitdir,
> -					    char *cwd, int offset, int len,
> +					    struct strbuf *cwd, int offset,
>  					    int *nongit_ok)
>  {
>  	if (check_repository_format_gently(gitdir, nongit_ok))
> @@ -491,17 +490,17 @@ static const char *setup_discovered_git_dir(con=
st char *gitdir,
> =20
>  	/* --work-tree is set without --git-dir; use discovered one */
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> -		if (offset !=3D len && !is_absolute_path(gitdir))
> +		if (offset !=3D cwd->len && !is_absolute_path(gitdir))
>  			gitdir =3D xstrdup(real_path(gitdir));
> -		if (chdir(cwd))
> +		if (chdir(cwd->buf))
>  			die_errno("Could not come back to cwd");
> -		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
> +		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
>  	}
> =20
>  	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
>  	if (is_bare_repository_cfg > 0) {
> -		set_git_dir(offset =3D=3D len ? gitdir : real_path(gitdir));
> -		if (chdir(cwd))
> +		set_git_dir(offset =3D=3D cwd->len ? gitdir : real_path(gitdir));
> +		if (chdir(cwd->buf))
>  			die_errno("Could not come back to cwd");
>  		return NULL;
>  	}
> @@ -512,18 +511,18 @@ static const char *setup_discovered_git_dir(con=
st char *gitdir,
>  		set_git_dir(gitdir);
>  	inside_git_dir =3D 0;
>  	inside_work_tree =3D 1;
> -	if (offset =3D=3D len)
> +	if (offset =3D=3D cwd->len)
>  		return NULL;
> =20
>  	/* Make "offset" point to past the '/', and add a '/' at the end */
>  	offset++;
> -	cwd[len++] =3D '/';
> -	cwd[len] =3D 0;
> -	return cwd + offset;
> +	strbuf_addch(cwd, '/');
> +	return cwd->buf + offset;
>  }
> =20
>  /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
> -static const char *setup_bare_git_dir(char *cwd, int offset, int len=
, int *nongit_ok)
> +static const char *setup_bare_git_dir(struct strbuf *cwd, int offset=
,
> +				      int *nongit_ok)
>  {
>  	int root_len;
> =20
> @@ -536,20 +535,20 @@ static const char *setup_bare_git_dir(char *cwd=
, int offset, int len, int *nongi
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
>  		const char *gitdir;
> =20
> -		gitdir =3D offset =3D=3D len ? "." : xmemdupz(cwd, offset);
> -		if (chdir(cwd))
> +		gitdir =3D offset =3D=3D cwd->len ? "." : xmemdupz(cwd->buf, offse=
t);
> +		if (chdir(cwd->buf))
>  			die_errno("Could not come back to cwd");
> -		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
> +		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
>  	}
> =20
>  	inside_git_dir =3D 1;
>  	inside_work_tree =3D 0;
> -	if (offset !=3D len) {
> -		if (chdir(cwd))
> +	if (offset !=3D cwd->len) {
> +		if (chdir(cwd->buf))
>  			die_errno("Cannot come back to cwd");
> -		root_len =3D offset_1st_component(cwd);
> -		cwd[offset > root_len ? offset : root_len] =3D '\0';
> -		set_git_dir(cwd);
> +		root_len =3D offset_1st_component(cwd->buf);
> +		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
> +		set_git_dir(cwd->buf);
>  	}
>  	else
>  		set_git_dir(".");
> @@ -617,10 +616,10 @@ static const char *setup_git_directory_gently_1=
(int *nongit_ok)
>  {
>  	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRON=
MENT);
>  	struct string_list ceiling_dirs =3D STRING_LIST_INIT_DUP;
> -	static char cwd[PATH_MAX + 1];
> +	static struct strbuf cwd =3D STRBUF_INIT;


Is there a chance to squueze this in:


$ git diff
diff --git a/setup.c b/setup.c
index 526cdf6..fb61860 100644
--- a/setup.c
+++ b/setup.c
@@ -734,7 +734,7 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
                string_list_clear(&ceiling_dirs, 0);
        }

-       if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
+       if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
                ceil_offset =3D 1;
