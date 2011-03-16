From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2-3/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 17:59:03 +0100
Message-ID: <4D80EC57.4050704@drmicha.warpmail.net>
References: <1300294266-26875-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzu7N-0001yT-VM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 18:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1CPRCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 13:02:35 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52267 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752362Ab1CPRCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 13:02:34 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C177B20E51;
	Wed, 16 Mar 2011 13:02:33 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 16 Mar 2011 13:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ME5WXRLdw/OgKdI60sEsV0kOxgQ=; b=d1Ps9h2x7pYot/5ZpMOTxuGdqpqZObXMVLGuSbjrDz+8kcm1yV4yp6+tbd7V6VsBBzbEcpZ67Wgcn5EbUubEH/EvQs2pS2lUm71HiqNRmGqzw8HSHxdIOsn5HBEvfwFSmo1z65FGAPLM+B5Oimxae6flupAycdTQ5W7HuiJzovg=
X-Sasl-enc: 2kKrNAqcsIM31+bRy/ItNKZk0g8uRukzgeicDlh2hZx6 1300294953
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FBDB4413A6;
	Wed, 16 Mar 2011 13:02:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1300294266-26875-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169177>

Carlos Mart=C3=ADn Nieto venit, vidit, dixit 16.03.2011 17:51:
> Rename the make_*_path functions so it's clearer what they do, in
> particlar make clear what the differnce between make_absolute_path an=
d
> make_nonrelative_path is by renaming them real_path and absolute_path
> respectively. make_relative_path has an understandable name and is
> renamed to relative_path to maintain the name convention.
>=20
> The function calls have been replaced 1-to-1 in their usage.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>=20
> This supercedes the 2/3 and 3/3 patches.=20
>=20
>  abspath.c              |   22 +++++++++++++++++++---
>  builtin/clone.c        |   12 ++++++------
>  builtin/init-db.c      |    8 ++++----
>  builtin/receive-pack.c |    2 +-
>  cache.h                |    6 +++---
>  dir.c                  |    4 ++--
>  environment.c          |    4 ++--
>  exec_cmd.c             |    2 +-
>  lockfile.c             |    4 ++--
>  path.c                 |    2 +-
>  setup.c                |   14 ++++++--------
>  t/t0000-basic.sh       |   10 +++++-----
>  test-path-utils.c      |    4 ++--
>  13 files changed, 54 insertions(+), 40 deletions(-)
>=20
> diff --git a/abspath.c b/abspath.c
> index ff14068..47bc73e 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -14,7 +14,14 @@ int is_directory(const char *path)
>  /* We allow "recursive" symbolic links. Only within reason, though. =
*/
>  #define MAXDEPTH 5
> =20
> -const char *make_absolute_path(const char *path)
> +/*
> + * Use this to get the real path, i.e. resolve links. If you want an
> + * absolute path but don't mind links, use absolute_path.
> + *
> + * If path is our buffer, then return path, as it's already what the
> + * user wants.
> + */
> +const char *real_path(const char *path)
>  {
>  	static char bufs[2][PATH_MAX + 1], *buf =3D bufs[0], *next_buf =3D =
bufs[1];
>  	char cwd[1024] =3D "";
> @@ -104,13 +111,22 @@ static const char *get_pwd_cwd(void)
>  	return cwd;
>  }
> =20
> -const char *make_nonrelative_path(const char *path)
> +/*
> + * Use this to get an absolute path from a relative one. If you want
> + * to resolve links, you should use real_path.
> + *
> + * If the path is already absolute, then return path. As the user is
> + * never meant to free the return value, we're safe.
> + */
> +const char *absolute_path(const char *path)
>  {
>  	static char buf[PATH_MAX + 1];
> =20
>  	if (is_absolute_path(path)) {
> -		if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> +		if (strlen(path) >=3D PATH_MAX)
>  			die("Too long path: %.*s", 60, path);
> +		else
> +			return path;
>  	} else {
>  		size_t len;
>  		const char *fmt;

This is not simply a renaming change that you're sneaking in here. What
is it about?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 60d9a64..780809d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -100,7 +100,7 @@ static char *get_repo_path(const char *repo, int =
*is_bundle)
>  		path =3D mkpath("%s%s", repo, suffix[i]);
>  		if (is_directory(path)) {
>  			*is_bundle =3D 0;
> -			return xstrdup(make_nonrelative_path(path));
> +			return xstrdup(absolute_path(path));
>  		}
>  	}
> =20
> @@ -109,7 +109,7 @@ static char *get_repo_path(const char *repo, int =
*is_bundle)
>  		path =3D mkpath("%s%s", repo, bundle_suffix[i]);
>  		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
>  			*is_bundle =3D 1;
> -			return xstrdup(make_nonrelative_path(path));
> +			return xstrdup(absolute_path(path));
>  		}
>  	}
> =20
> @@ -203,7 +203,7 @@ static void setup_reference(const char *repo)
>  	struct transport *transport;
>  	const struct ref *extra;
> =20
> -	ref_git =3D make_absolute_path(option_reference);
> +	ref_git =3D real_path(option_reference);
> =20
>  	if (is_directory(mkpath("%s/.git/objects", ref_git)))
>  		ref_git =3D mkpath("%s/.git", ref_git);
> @@ -411,9 +411,9 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
> =20
>  	path =3D get_repo_path(repo_name, &is_bundle);
>  	if (path)
> -		repo =3D xstrdup(make_nonrelative_path(repo_name));
> +		repo =3D xstrdup(absolute_path(repo_name));
>  	else if (!strchr(repo_name, ':'))
> -		repo =3D xstrdup(make_absolute_path(repo_name));
> +		repo =3D xstrdup(real_path(repo_name));
>  	else
>  		repo =3D repo_name;
>  	is_local =3D path && !is_bundle;
> @@ -466,7 +466,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
> =20
>  	if (safe_create_leading_directories_const(git_dir) < 0)
>  		die("could not create leading directories of '%s'", git_dir);
> -	set_git_dir(make_absolute_path(git_dir));
> +	set_git_dir(real_path(git_dir));
> =20
>  	if (0 <=3D option_verbosity)
>  		printf("Cloning into %s%s...\n",
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index fbeb380..63cf259 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -501,7 +501,7 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
>  		const char *git_dir_parent =3D strrchr(git_dir, '/');
>  		if (git_dir_parent) {
>  			char *rel =3D xstrndup(git_dir, git_dir_parent - git_dir);
> -			git_work_tree_cfg =3D xstrdup(make_absolute_path(rel));
> +			git_work_tree_cfg =3D xstrdup(real_path(rel));
>  			free(rel);
>  		}
>  		if (!git_work_tree_cfg) {
> @@ -510,7 +510,7 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
>  				die_errno ("Cannot access current working directory");
>  		}
>  		if (work_tree)
> -			set_git_work_tree(make_absolute_path(work_tree));
> +		  set_git_work_tree(real_path(work_tree));
>  		else
>  			set_git_work_tree(git_work_tree_cfg);
>  		if (access(get_git_work_tree(), X_OK))
> @@ -519,10 +519,10 @@ int cmd_init_db(int argc, const char **argv, co=
nst char *prefix)
>  	}
>  	else {
>  		if (work_tree)
> -			set_git_work_tree(make_absolute_path(work_tree));
> +			set_git_work_tree(real_path(work_tree));
>  	}
> =20
> -	set_git_dir(make_absolute_path(git_dir));
> +	set_git_dir(real_path(git_dir));
> =20
>  	return init_db(template_dir, flags);
>  }
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 760817d..d883585 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -740,7 +740,7 @@ static int add_refs_from_alternate(struct alterna=
te_object_database *e, void *un
>  	const struct ref *extra;
> =20
>  	e->name[-1] =3D '\0';
> -	other =3D xstrdup(make_absolute_path(e->base));
> +	other =3D xstrdup(real_path(e->base));
>  	e->name[-1] =3D '/';
>  	len =3D strlen(other);
> =20
> diff --git a/cache.h b/cache.h
> index c7b0a28..dbc87be 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -716,9 +716,9 @@ static inline int is_absolute_path(const char *pa=
th)
>  	return path[0] =3D=3D '/' || has_dos_drive_prefix(path);
>  }
>  int is_directory(const char *);
> -const char *make_absolute_path(const char *path);
> -const char *make_nonrelative_path(const char *path);
> -const char *make_relative_path(const char *abs, const char *base);
> +const char *real_path(const char *path);
> +const char *absolute_path(const char *path);
> +const char *relative_path(const char *abs, const char *base);
>  int normalize_path_copy(char *dst, const char *src);
>  int longest_ancestor_length(const char *path, const char *prefix_lis=
t);
>  char *strip_path_suffix(const char *path, const char *suffix);
> diff --git a/dir.c b/dir.c
> index 570b651..5a9372a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1023,8 +1023,8 @@ char *get_relative_cwd(char *buffer, int size, =
const char *dir)
>  	if (!getcwd(buffer, size))
>  		die_errno("can't find the current directory");
> =20
> -	if (!is_absolute_path(dir))
> -		dir =3D make_absolute_path(dir);
> +	/* getcwd resolves links and gives us the real path */
> +	dir =3D real_path(dir);

Why remove the check? Again, this is not just renaming.

> =20
>  	while (*dir && *dir =3D=3D *cwd) {
>  		dir++;
> diff --git a/environment.c b/environment.c
> index c3efbb9..cc670b1 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -139,7 +139,7 @@ static int git_work_tree_initialized;
>  void set_git_work_tree(const char *new_work_tree)
>  {
>  	if (git_work_tree_initialized) {
> -		new_work_tree =3D make_absolute_path(new_work_tree);
> +		new_work_tree =3D real_path(new_work_tree);
>  		if (strcmp(new_work_tree, work_tree))
>  			die("internal error: work tree has already been set\n"
>  			    "Current worktree: %s\nNew worktree: %s",
> @@ -147,7 +147,7 @@ void set_git_work_tree(const char *new_work_tree)
>  		return;
>  	}
>  	git_work_tree_initialized =3D 1;
> -	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
> +	work_tree =3D xstrdup(real_path(new_work_tree));
>  }
> =20
>  const char *get_git_work_tree(void)
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 38545e8..171e841 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -89,7 +89,7 @@ static void add_path(struct strbuf *out, const char=
 *path)
>  		if (is_absolute_path(path))
>  			strbuf_addstr(out, path);
>  		else
> -			strbuf_addstr(out, make_nonrelative_path(path));
> +			strbuf_addstr(out, absolute_path(path));
> =20
>  		strbuf_addch(out, PATH_SEP);
>  	}
> diff --git a/lockfile.c b/lockfile.c
> index b0d74cd..c6fb77b 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -164,10 +164,10 @@ static char *unable_to_lock_message(const char =
*path, int err)
>  		    "If no other git process is currently running, this probably m=
eans a\n"
>  		    "git process crashed in this repository earlier. Make sure no =
other git\n"
>  		    "process is running and remove the file manually to continue."=
,
> -			    make_nonrelative_path(path), strerror(err));
> +			    absolute_path(path), strerror(err));
>  	} else
>  		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
> -			    make_nonrelative_path(path), strerror(err));
> +			    absolute_path(path), strerror(err));
>  	return strbuf_detach(&buf, NULL);
>  }
> =20
> diff --git a/path.c b/path.c
> index 8951333..4d73cc9 100644
> --- a/path.c
> +++ b/path.c
> @@ -397,7 +397,7 @@ int set_shared_perm(const char *path, int mode)
>  	return 0;
>  }
> =20
> -const char *make_relative_path(const char *abs, const char *base)
> +const char *relative_path(const char *abs, const char *base)
>  {
>  	static char buf[PATH_MAX + 1];
>  	int i =3D 0, j =3D 0;
> diff --git a/setup.c b/setup.c
> index dadc666..8cb1ad3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -216,9 +216,7 @@ void setup_work_tree(void)
>  	if (initialized)
>  		return;
>  	work_tree =3D get_git_work_tree();
> -	git_dir =3D get_git_dir();
> -	if (!is_absolute_path(git_dir))
> -		git_dir =3D make_absolute_path(git_dir);
> +	git_dir =3D real_path(get_git_dir());

Check removed, why?

>  	if (!work_tree || chdir(work_tree))
>  		die("This operation must be run in a work tree");
> =20
> @@ -229,7 +227,7 @@ void setup_work_tree(void)
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
>  		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
> =20
> -	set_git_dir(make_relative_path(git_dir, work_tree));
> +	set_git_dir(relative_path(git_dir, work_tree));
>  	initialized =3D 1;
>  }
> =20
> @@ -309,7 +307,7 @@ const char *read_gitfile_gently(const char *path)
> =20
>  	if (!is_git_directory(dir))
>  		die("Not a git repository: %s", dir);
> -	path =3D make_absolute_path(dir);
> +	path =3D real_path(dir);
> =20
>  	free(buf);
>  	return path;
> @@ -389,7 +387,7 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
> =20
>  	if (!prefixcmp(cwd, worktree) &&
>  	    cwd[strlen(worktree)] =3D=3D '/') { /* cwd inside worktree */
> -		set_git_dir(make_absolute_path(gitdirenv));
> +		set_git_dir(real_path(gitdirenv));
>  		if (chdir(worktree))
>  			die_errno("Could not chdir to '%s'", worktree);
>  		cwd[len++] =3D '/';
> @@ -414,7 +412,7 @@ static const char *setup_discovered_git_dir(const=
 char *gitdir,
>  	/* --work-tree is set without --git-dir; use discovered one */
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
>  		if (offset !=3D len && !is_absolute_path(gitdir))
> -			gitdir =3D xstrdup(make_absolute_path(gitdir));
> +			gitdir =3D xstrdup(real_path(gitdir));
>  		if (chdir(cwd))
>  			die_errno("Could not come back to cwd");
>  		return setup_explicit_git_dir(gitdir, cwd, len, nongit_ok);
> @@ -422,7 +420,7 @@ static const char *setup_discovered_git_dir(const=
 char *gitdir,
> =20
>  	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
>  	if (is_bare_repository_cfg > 0) {
> -		set_git_dir(offset =3D=3D len ? gitdir : make_absolute_path(gitdir=
));
> +		set_git_dir(offset =3D=3D len ? gitdir : real_path(gitdir));
>  		if (chdir(cwd))
>  			die_errno("Could not come back to cwd");
>  		return NULL;
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 8deec75..f4e8f43 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -435,7 +435,7 @@ test_expect_success 'update-index D/F conflict' '
>  	test $numpath0 =3D 1
>  '
> =20
> -test_expect_success SYMLINKS 'absolute path works as expected' '
> +test_expect_success SYMLINKS 'real path works as expected' '
>  	mkdir first &&
>  	ln -s ../.git first/.git &&
>  	mkdir second &&
> @@ -443,14 +443,14 @@ test_expect_success SYMLINKS 'absolute path wor=
ks as expected' '
>  	mkdir third &&
>  	dir=3D"$(cd .git; pwd -P)" &&
>  	dir2=3Dthird/../second/other/.git &&
> -	test "$dir" =3D "$(test-path-utils make_absolute_path $dir2)" &&
> +	test "$dir" =3D "$(test-path-utils real_path $dir2)" &&
>  	file=3D"$dir"/index &&
> -	test "$file" =3D "$(test-path-utils make_absolute_path $dir2/index)=
" &&
> +	test "$file" =3D "$(test-path-utils real_path $dir2/index)" &&
>  	basename=3Dblub &&
> -	test "$dir/$basename" =3D "$(cd .git && test-path-utils make_absolu=
te_path "$basename")" &&
> +	test "$dir/$basename" =3D "$(cd .git && test-path-utils real_path "=
$basename")" &&
>  	ln -s ../first/file .git/syml &&
>  	sym=3D"$(cd first; pwd -P)"/file &&
> -	test "$sym" =3D "$(test-path-utils make_absolute_path "$dir2/syml")=
"
> +	test "$sym" =3D "$(test-path-utils real_path "$dir2/syml")"
>  '
> =20
>  test_expect_success 'very long name in the index handled sanely' '
> diff --git a/test-path-utils.c b/test-path-utils.c
> index d261398..e767159 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -11,9 +11,9 @@ int main(int argc, char **argv)
>  		return 0;
>  	}
> =20
> -	if (argc >=3D 2 && !strcmp(argv[1], "make_absolute_path")) {
> +	if (argc >=3D 2 && !strcmp(argv[1], "real_path")) {
>  		while (argc > 2) {
> -			puts(make_absolute_path(argv[2]));
> +			puts(real_path(argv[2]));
>  			argc--;
>  			argv++;
>  		}

I think you should strictly separate the renaming issue from other
patches (and describe/motivate the latter). It's fine to have a large
patch with mechanical changes (renaming) if you stick to just those.

Cheers,
Michael
