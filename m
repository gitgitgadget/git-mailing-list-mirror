From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Mon, 24 Mar 2014 15:52:13 +0100
Message-ID: <5330469D.9020008@web.de>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com> <1392730814-19656-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:52:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS6FA-0003oV-CA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 15:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbaCXOwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 10:52:18 -0400
Received: from mout.web.de ([212.227.15.3]:64499 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbaCXOwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 10:52:17 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M9os0-1WLXjK1fEe-00B26T; Mon, 24 Mar 2014 15:52:14
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <1392730814-19656-19-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:OZF7HXXPYizRC7McYueZwp/nz++pPxtowkQcJ24CFqGTiwn1RMY
 8v7timNjwNXQHcTLyK86XQ/QQxoMnwxPPdrK7iNO8EAZoDs5dMtu1zRwTcnzT3kApRiEkkp
 cQcDILxE+7QoK9d0yOScGsTfqr40UgFqpx0h6f0+tQvhlf//OnRWxeyxXsj75/5QxoCYyWf
 x1bysGh+DD6vF62I7CSHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244822>

On 02/18/2014 02:40 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> The repo setup procedure is updated to detect $GIT_DIR/commondir and
> set $GIT_COMMON_DIR properly.
>
> The core.worktree is ignored when $GIT_DIR/commondir presents. This i=
s
> because "commondir" repos are intended for separate/linked checkouts
> and pointing them back to a fixed core.worktree just does not make
> sense.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt        |  3 +-
>  Documentation/git-rev-parse.txt |  3 ++
>  builtin/rev-parse.c             |  4 +++
>  cache.h                         |  1 +
>  environment.c                   |  8 ++---
>  setup.c                         | 33 +++++++++++++-----
>  t/t1501-worktree.sh             | 76 +++++++++++++++++++++++++++++++=
++++++++++
>  t/t1510-repo-setup.sh           |  1 +
>  trace.c                         |  1 +
>  9 files changed, 115 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5f4d793..cbf4d97 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -381,7 +381,8 @@ false), while all other repositories are assumed =
to be bare (bare
> =20
>  core.worktree::
>  	Set the path to the root of the working tree.
> -	This can be overridden by the GIT_WORK_TREE environment
> +	This can be overridden by the GIT_WORK_TREE
> +	or GIT_COMMON_DIR environment
>  	variable and the '--work-tree' command line option.
>  	The value can be an absolute path or relative to the path to
>  	the .git directory, which is either specified by --git-dir
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-=
parse.txt
> index 33e4e90..8e6ad32 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -215,6 +215,9 @@ If `$GIT_DIR` is not defined and the current dire=
ctory
>  is not detected to lie in a Git repository or work tree
>  print a message to stderr and exit with nonzero status.
> =20
> +--git-common-dir::
> +	Show `$GIT_COMMON_DIR` if defined, else `$GIT_DIR`.
> +
>  --is-inside-git-dir::
>  	When the current working directory is below the repository
>  	directory print "true", otherwise "false".
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index e50bc65..c7057ce 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -744,6 +744,10 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>  				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "")=
;
>  				continue;
>  			}
> +			if (!strcmp(arg, "--git-common-dir")) {
> +				puts(get_git_common_dir());
> +				continue;
> +			}
>  			if (!strcmp(arg, "--resolve-git-dir")) {
>  				const char *gitdir =3D resolve_gitdir(argv[i+1]);
>  				if (!gitdir)
> diff --git a/cache.h b/cache.h
> index 51ade32..98b5dd3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -407,6 +407,7 @@ extern char *get_object_directory(void);
>  extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
> +extern int get_common_dir(struct strbuf *sb, const char *gitdir);
>  extern const char *get_git_namespace(void);
>  extern const char *strip_namespace(const char *namespaced_ref);
>  extern const char *get_git_work_tree(void);
> diff --git a/environment.c b/environment.c
> index c998120..0999fc1 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -126,6 +126,7 @@ static char *expand_namespace(const char *raw_nam=
espace)
> =20
>  static void setup_git_env(void)
>  {
> +	struct strbuf sb =3D STRBUF_INIT;
>  	const char *gitfile;
>  	const char *shallow_file;
> =20
> @@ -134,12 +135,9 @@ static void setup_git_env(void)
>  		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
>  	gitfile =3D read_gitfile(git_dir);
>  	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
> -	git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
> -	if (git_common_dir) {
> +	if (get_common_dir(&sb, git_dir))
>  		git_common_dir_env =3D 1;
> -		git_common_dir =3D xstrdup(git_common_dir);
> -	} else
> -		git_common_dir =3D git_dir;
> +	git_common_dir =3D strbuf_detach(&sb, NULL);
>  	git_object_dir =3D getenv(DB_ENVIRONMENT);
>  	if (!git_object_dir) {
>  		git_object_dir =3D xmalloc(strlen(git_common_dir) + 9);
> diff --git a/setup.c b/setup.c
> index e56ec11..d4ac878 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -170,14 +170,15 @@ void verify_non_filename(const char *prefix, co=
nst char *arg)
>  	    "'git <command> [<revision>...] -- [<file>...]'", arg);
>  }
> =20
> -static void get_common_dir(struct strbuf *sb, const char *gitdir)
> +int get_common_dir(struct strbuf *sb, const char *gitdir)
>  {
>  	struct strbuf data =3D STRBUF_INIT;
>  	struct strbuf path =3D STRBUF_INIT;
>  	const char *git_common_dir =3D getenv(GIT_COMMON_DIR_ENVIRONMENT);
> +	int ret =3D 0;
>  	if (git_common_dir) {
>  		strbuf_addstr(sb, git_common_dir);
> -		return;
> +		return 1;
>  	}
>  	strbuf_addf(&path, "%s/commondir", gitdir);
>  	if (file_exists(path.buf)) {
> @@ -189,10 +190,12 @@ static void get_common_dir(struct strbuf *sb, c=
onst char *gitdir)
>  			strbuf_addf(&path, "%s/", gitdir);
>  		strbuf_addbuf(&path, &data);
>  		strbuf_addstr(sb, real_path(path.buf));
> +		ret =3D 1;
>  	} else
>  		strbuf_addstr(sb, gitdir);
>  	strbuf_release(&data);
>  	strbuf_release(&path);
> +	return ret;
>  }
> =20
>  /*
> @@ -279,13 +282,26 @@ void setup_work_tree(void)
>  	initialized =3D 1;
>  }
> =20
> +static int check_repo_format(const char *var, const char *value, voi=
d *cb)
> +{
> +	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
> +		repository_format_version =3D git_config_int(var, value);
> +	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
> +		shared_repository =3D git_config_perm(var, value);
> +	return 0;
> +}
> +
>  static int check_repository_format_gently(const char *gitdir, int *n=
ongit_ok)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
>  	const char *repo_config;
> +	config_fn_t fn;
>  	int ret =3D 0;
> =20
> -	get_common_dir(&sb, gitdir);
> +	if (get_common_dir(&sb, gitdir))
> +		fn =3D check_repo_format;
> +	else
> +		fn =3D check_repository_format_version;
>  	strbuf_addstr(&sb, "/config");
>  	repo_config =3D sb.buf;
> =20
> @@ -298,7 +314,7 @@ static int check_repository_format_gently(const c=
har *gitdir, int *nongit_ok)
>  	 * Use a gentler version of git_config() to check if this repo
>  	 * is a good one.
>  	 */
> -	git_config_early(check_repository_format_version, NULL, repo_config=
);
> +	git_config_early(fn, NULL, repo_config);
>  	if (GIT_REPO_VERSION < repository_format_version) {
>  		if (!nongit_ok)
>  			die ("Expected git repo version <=3D %d, found %d",
> @@ -770,11 +786,10 @@ int git_config_perm(const char *var, const char=
 *value)
> =20
>  int check_repository_format_version(const char *var, const char *val=
ue, void *cb)
>  {
> -	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
> -		repository_format_version =3D git_config_int(var, value);
> -	else if (strcmp(var, "core.sharedrepository") =3D=3D 0)
> -		shared_repository =3D git_config_perm(var, value);
> -	else if (strcmp(var, "core.bare") =3D=3D 0) {
> +	int ret =3D check_repo_format(var, value, cb);
> +	if (ret)
> +		return ret;
> +	if (strcmp(var, "core.bare") =3D=3D 0) {
>  		is_bare_repository_cfg =3D git_config_bool(var, value);
>  		if (is_bare_repository_cfg =3D=3D 1)
>  			inside_work_tree =3D -1;
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 8f36aa9..d8bdaf4 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -346,4 +346,80 @@ test_expect_success 'relative $GIT_WORK_TREE and=
 git subprocesses' '
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success 'Multi-worktree setup' '
> +	mkdir work &&
> +	mkdir -p repo.git/repos/foo &&
> +	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> +	unset GIT_DIR GIT_CONFIG GIT_WORK_TREE
> +'
> +
> +test_expect_success 'GIT_DIR set (1)' '
> +	echo "gitdir: repo.git/repos/foo" >gitfile &&
> +	echo ../.. >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
> +		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'GIT_DIR set (2)' '
> +	echo "gitdir: repo.git/repos/foo" >gitfile &&
> +	echo "$TRASH_DIRECTORY/repo.git" >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
> +		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Auto discovery' '
> +	echo "gitdir: repo.git/repos/foo" >.git &&
> +	echo ../.. >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		git rev-parse --git-common-dir >actual &&
> +		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test_cmp expect actual &&
> +		echo haha >data1 &&
> +		git add data1 &&
> +		git ls-files --full-name :/ | grep data1 >actual &&
> +		echo work/data1 >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '$GIT_DIR/common overrides core.worktree' '
> +	mkdir elsewhere &&
> +	git --git-dir=3Drepo.git config core.worktree "$TRASH_DIRECTORY/els=
ewhere" &&
> +	echo "gitdir: repo.git/repos/foo" >.git &&
> +	echo ../.. >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		git rev-parse --git-common-dir >actual &&
> +		echo "$TRASH_DIRECTORY/repo.git" >expect &&
> +		test_cmp expect actual &&
> +		echo haha >data2 &&
> +		git add data2 &&
> +		git ls-files --full-name :/ | grep data2 >actual &&
> +		echo work/data2 >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
> +	echo "gitdir: repo.git/repos/foo" >.git &&
> +	echo ../.. >repo.git/repos/foo/commondir &&
> +	(
> +		cd work &&
> +		echo haha >data3 &&
> +		git --git-dir=3D../.git --work-tree=3D. add data3 &&
> +		git ls-files --full-name -- :/ | grep data3 >actual &&
> +		echo data3 >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index cf2ee78..c211ef5 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -106,6 +106,7 @@ setup_env () {
>  expect () {
>  	cat >"$1/expected" <<-EOF
>  	setup: git_dir: $2
> +	setup: git_common_dir: $2
>  	setup: worktree: $3
>  	setup: cwd: $4
>  	setup: prefix: $5
> diff --git a/trace.c b/trace.c
> index 08180a9..a594761 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -173,6 +173,7 @@ void trace_repo_setup(const char *prefix)
>  		prefix =3D "(null)";
> =20
>  	trace_printf_key(key, "setup: git_dir: %s\n", quote_crnl(get_git_di=
r()));
> +	trace_printf_key(key, "setup: git_common_dir: %s\n", quote_crnl(get=
_git_common_dir()));
>  	trace_printf_key(key, "setup: worktree: %s\n", quote_crnl(git_work_=
tree));
>  	trace_printf_key(key, "setup: cwd: %s\n", quote_crnl(cwd));
>  	trace_printf_key(key, "setup: prefix: %s\n", quote_crnl(prefix));

Did I report that t1501  fails when  there is a softlink in $PWD ?
/home/tb/projects is a softlink to /disc5/projects/
(And in total 4 TC failed)
--------------

expecting success:
        echo "gitdir: repo.git/repos/foo" >gitfile &&
        echo ../.. >repo.git/repos/foo/commondir &&
        (
                cd work &&
                GIT_DIR=3D../gitfile git rev-parse --git-common-dir >ac=
tual &&
                echo "$TRASH_DIRECTORY/repo.git" >expect &&
                test_cmp expect actual
        )

--- expect      2014-03-24 07:55:29.895870540 +0000
+++ actual      2014-03-24 07:55:29.895870540 +0000
@@ -1 +1 @@
-/home/tb/projects/git/git.pu/t/trash directory.t1501-worktree/repo.git
+/disc5/projects/git/git.pu/t/trash directory.t1501-worktree/repo.git
not ok 33 - GIT_DIR set (1)
