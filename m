From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Mon, 22 Sep 2014 17:06:06 -0400
Message-ID: <54208F3E.1030609@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-24-git-send-email-pclouds@gmail.com> <5411C16C.9010406@xiplink.com> <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com> <CACsJy8BLEfB6RQZTxqF82-tJmKQgnNC12QvKu8KZq=Vr059s3g@mail.gmail.com> <CAPig+cRX6z2ReKqES_2SP4mVruCDNRyo62_deo3ukuUYcYaKiw@mail.gmail.com> <20140921102936.GA9438@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWAnv-0006Ms-C1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 23:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbaIVVFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2014 17:05:47 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:40962 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbaIVVFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 17:05:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 59395380232;
	Mon, 22 Sep 2014 17:05:45 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp21.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 029BC38021B;
	Mon, 22 Sep 2014 17:05:44 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Mon, 22 Sep 2014 21:05:45 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140921102936.GA9438@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257382>

On 14-09-21 06:29 AM, Duy Nguyen wrote:
> Here we go again. Thanks both for the suggestions.

The documentation looks good to me.

=46WIW:
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

		M.


> -- 8< --
> Subject: [PATCH] prune: strategies for linked checkouts
>=20
> (alias R=3D$GIT_COMMON_DIR/worktrees/<id>)
>=20
>  - linked checkouts are supposed to keep its location in $R/gitdir up
>    to date. The use case is auto fixup after a manual checkout move.
>=20
>  - linked checkouts are supposed to update mtime of $R/gitdir. If
>    $R/gitdir's mtime is older than a limit, and it points to nowhere,
>    worktrees/<id> is to be pruned.
>=20
>  - If $R/locked exists, worktrees/<id> is not supposed to be pruned. =
If
>    $R/locked exists and $R/gitdir's mtime is older than a really long
>    limit, warn about old unused repo.
>=20
>  - "git checkout --to" is supposed to make a hard link named $R/link
>    pointing to the .git file on supported file systems to help detect
>    the user manually deleting the checkout. If $R/link exists and its
>    link count is greated than 1, the repo is kept.
>=20
> Helped-by: Marc Branchaud <marcnarc@xiplink.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-checkout.txt             | 20 +++++++
>  Documentation/git-prune.txt                |  3 +
>  Documentation/gitrepository-layout.txt     | 19 ++++++
>  builtin/checkout.c                         | 19 +++++-
>  builtin/prune.c                            | 95 ++++++++++++++++++++=
++++++++++
>  setup.c                                    | 13 ++++
>  t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++++=
++++++
>  7 files changed, 251 insertions(+), 2 deletions(-)
>  create mode 100755 t/t2026-prune-linked-checkouts.sh
>=20
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index c101575..0fd3bab 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -434,6 +434,26 @@ thumb is do not make any assumption about whethe=
r a path belongs to
>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
> =20
> +When you are done with a linked working tree you can simply delete i=
t.
> +You can clean up any stale $GIT_DIR/worktrees entries via `git prune
> +--worktrees` in the main worktree or any linked worktree.
> +
> +If you move a linked working directory to another file system, or
> +within a file system that does not support hard links, you need to r=
un
> +at least one git command inside the linked working directory
> +(e.g. `git status`) in order to update its entry in $GIT_DIR/worktre=
es
> +so that it does not get automatically removed.
> +
> +To prevent `git prune --worktrees` from deleting a $GIT_DIR/worktree=
s
> +entry (which can be useful in some situations, such as when the
> +entry's working tree is stored on a portable device), add a file nam=
ed
> +'locked' to the entry's directory. The file contains the reason in
> +plain text. For example, if a linked working tree's `.git` file poin=
ts
> +to `/path/main/.git/worktrees/test-next` then a file named
> +`/path/main/.git/worktrees/test-next/locked` will prevent the
> +`test-next` entry from being pruned.  See
> +linkgit:gitrepository-layout[5] for details.
> +
>  EXAMPLES
>  --------
> =20
> diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.tx=
t
> index 7a493c8..a0ea381 100644
> --- a/Documentation/git-prune.txt
> +++ b/Documentation/git-prune.txt
> @@ -48,6 +48,9 @@ OPTIONS
>  --expire <time>::
>  	Only expire loose objects older than <time>.
> =20
> +--worktrees::
> +	Prune stale worktree information in $GIT_DIR/worktrees.
> +
>  <head>...::
>  	In addition to objects
>  	reachable from any of our references, keep objects
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index 8228450..2b30a92 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -259,6 +259,25 @@ worktrees::
>  	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
>  	used instead.
> =20
> +worktrees/<id>/gitdir::
> +	A text file containing the absolute path back to the .git file
> +	that points to here. This is used to check if the linked
> +	repository has been manually removed and there is no need to
> +	keep this directory any more. mtime of this file should be
> +	updated every time the linked repository is accessed.
> +
> +worktrees/<id>/locked::
> +	If this file exists, the linked repository may be on a
> +	portable device and not available. It does not mean that the
> +	linked repository is gone and `worktrees/<id>` could be
> +	removed. The file's content contains a reason string on why
> +	the repository is locked.
> +
> +worktrees/<id>/link::
> +	If this file exists, it is a hard link to the linked .git
> +	file. It is used to detect if the linked repository is
> +	manually removed.
> +
>  SEE ALSO
>  --------
>  linkgit:git-init[1],
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ad10f99..ab46af9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -826,7 +826,7 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
>  	const char *path =3D opts->new_worktree, *name;
>  	struct stat st;
>  	struct child_process cp;
> -	int counter =3D 0, len;
> +	int counter =3D 0, len, ret;
> =20
>  	if (!new->commit)
>  		die(_("no branch specified"));
> @@ -857,11 +857,21 @@ static int prepare_linked_checkout(const struct=
 checkout_opts *opts,
>  	if (mkdir(sb_repo.buf, 0777))
>  		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
> =20
> +	/*
> +	 * lock the incomplete repo so prune won't delete it, unlock
> +	 * after the preparation is over.
> +	 */
> +	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> +	write_file(sb.buf, 1, "initializing\n");
> +
>  	strbuf_addf(&sb_git, "%s/.git", path);
>  	if (safe_create_leading_directories_const(sb_git.buf))
>  		die_errno(_("could not create leading directories of '%s'"),
>  			  sb_git.buf);
> =20
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
> +	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
>  	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
>  		   real_path(get_git_common_dir()), name);
>  	/*
> @@ -870,6 +880,7 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
>  	 * value would do because this value will be ignored and
>  	 * replaced at the next (real) checkout.
>  	 */
> +	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
>  	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1)=
);
>  	strbuf_reset(&sb);
> @@ -885,7 +896,11 @@ static int prepare_linked_checkout(const struct =
checkout_opts *opts,
>  	memset(&cp, 0, sizeof(cp));
>  	cp.git_cmd =3D 1;
>  	cp.argv =3D opts->saved_argv;
> -	return run_command(&cp);
> +	ret =3D run_command(&cp);
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> +	unlink_or_warn(sb.buf);
> +	return ret;
>  }
> =20
>  static int git_checkout_config(const char *var, const char *value, v=
oid *cb)
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 144a3bd..cf56110 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -112,6 +112,91 @@ static void prune_object_dir(const char *path)
>  	}
>  }
> =20
> +static int prune_worktree(const char *id, struct strbuf *reason)
> +{
> +	struct stat st;
> +	char *path;
> +	int fd, len;
> +
> +	if (!is_directory(git_path("worktrees/%s", id))) {
> +		strbuf_addf(reason, _("Removing worktrees/%s: not a valid director=
y"), id);
> +		return 1;
> +	}
> +	if (file_exists(git_path("worktrees/%s/locked", id)))
> +		return 0;
> +	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
> +		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not=
 exist"), id);
> +		return 1;
> +	}
> +	fd =3D open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
> +	if (fd < 0) {
> +		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdi=
r file (%s)"),
> +			    id, strerror(errno));
> +		return 1;
> +	}
> +	len =3D st.st_size;
> +	path =3D xmalloc(len + 1);
> +	read_in_full(fd, path, len);
> +	close(fd);
> +	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\=
r'))
> +		len--;
> +	if (!len) {
> +		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"=
), id);
> +		free(path);
> +		return 1;
> +	}
> +	path[len] =3D '\0';
> +	if (!file_exists(path)) {
> +		struct stat st_link;
> +		free(path);
> +		/*
> +		 * the repo is moved manually and has not been
> +		 * accessed since?
> +		 */
> +		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
> +		    st_link.st_nlink > 1)
> +			return 0;
> +		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points t=
o non-existent location"), id);
> +		return 1;
> +	}
> +	free(path);
> +	return st.st_mtime <=3D expire;
> +}
> +
> +static void prune_worktrees(void)
> +{
> +	struct strbuf reason =3D STRBUF_INIT;
> +	struct strbuf path =3D STRBUF_INIT;
> +	DIR *dir =3D opendir(git_path("worktrees"));
> +	struct dirent *d;
> +	int ret;
> +	if (!dir)
> +		return;
> +	while ((d =3D readdir(dir)) !=3D NULL) {
> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +			continue;
> +		strbuf_reset(&reason);
> +		if (!prune_worktree(d->d_name, &reason))
> +			continue;
> +		if (show_only || verbose)
> +			printf("%s\n", reason.buf);
> +		if (show_only)
> +			continue;
> +		strbuf_reset(&path);
> +		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
> +		ret =3D remove_dir_recursively(&path, 0);
> +		if (ret < 0 && errno =3D=3D ENOTDIR)
> +			ret =3D unlink(path.buf);
> +		if (ret)
> +			error(_("failed to remove: %s"), strerror(errno));
> +	}
> +	closedir(dir);
> +	if (!show_only)
> +		rmdir(git_path("worktrees"));
> +	strbuf_release(&reason);
> +	strbuf_release(&path);
> +}
> +
>  /*
>   * Write errors (particularly out of space) can result in
>   * failed temporary packs (and more rarely indexes and other
> @@ -138,10 +223,12 @@ int cmd_prune(int argc, const char **argv, cons=
t char *prefix)
>  {
>  	struct rev_info revs;
>  	struct progress *progress =3D NULL;
> +	int do_prune_worktrees =3D 0;
>  	const struct option options[] =3D {
>  		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
>  		OPT__VERBOSE(&verbose, N_("report pruned objects")),
>  		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
> +		OPT_BOOL(0, "worktrees", &do_prune_worktrees, N_("prune .git/workt=
rees")),
>  		OPT_EXPIRY_DATE(0, "expire", &expire,
>  				N_("expire objects older than <time>")),
>  		OPT_END()
> @@ -154,6 +241,14 @@ int cmd_prune(int argc, const char **argv, const=
 char *prefix)
>  	init_revisions(&revs, prefix);
> =20
>  	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0)=
;
> +
> +	if (do_prune_worktrees) {
> +		if (argc)
> +			die(_("--worktrees does not take extra arguments"));
> +		prune_worktrees();
> +		return 0;
> +	}
> +
>  	while (argc--) {
>  		unsigned char sha1[20];
>  		const char *name =3D *argv++;
> diff --git a/setup.c b/setup.c
> index b99bdd3..fb61860 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -390,6 +390,17 @@ static int check_repository_format_gently(const =
char *gitdir, int *nongit_ok)
>  	return ret;
>  }
> =20
> +static void update_linked_gitdir(const char *gitfile, const char *gi=
tdir)
> +{
> +	struct strbuf path =3D STRBUF_INIT;
> +	struct stat st;
> +
> +	strbuf_addf(&path, "%s/gitfile", gitdir);
> +	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
> +		write_file(path.buf, 0, "%s\n", gitfile);
> +	strbuf_release(&path);
> +}
> +
>  /*
>   * Try to read the location of the git directory from the .git file,
>   * return path to git directory if found.
> @@ -438,6 +449,8 @@ const char *read_gitfile(const char *path)
> =20
>  	if (!is_git_directory(dir))
>  		die("Not a git repository: %s", dir);
> +
> +	update_linked_gitdir(path, dir);
>  	path =3D real_path(dir);
> =20
>  	free(buf);
> diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked=
-checkouts.sh
> new file mode 100755
> index 0000000..3622800
> --- /dev/null
> +++ b/t/t2026-prune-linked-checkouts.sh
> @@ -0,0 +1,84 @@
> +#!/bin/sh
> +
> +test_description=3D'prune $GIT_DIR/worktrees'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'prune --worktrees on normal repo' '
> +	git prune --worktrees &&
> +	test_must_fail git prune --worktrees abc
> +'
> +
> +test_expect_success 'prune files inside $GIT_DIR/worktrees' '
> +	mkdir .git/worktrees &&
> +	: >.git/worktrees/abc &&
> +	git prune --worktrees --verbose >actual &&
> +	cat >expect <<EOF &&
> +Removing worktrees/abc: not a valid directory
> +EOF
> +	test_i18ncmp expect actual &&
> +	! test -f .git/worktrees/abc &&
> +	! test -d .git/worktrees
> +'
> +
> +test_expect_success 'prune directories without gitdir' '
> +	mkdir -p .git/worktrees/def/abc &&
> +	: >.git/worktrees/def/def &&
> +	cat >expect <<EOF &&
> +Removing worktrees/def: gitdir file does not exist
> +EOF
> +	git prune --worktrees --verbose >actual &&
> +	test_i18ncmp expect actual &&
> +	! test -d .git/worktrees/def &&
> +	! test -d .git/worktrees
> +'
> +
> +test_expect_success POSIXPERM 'prune directories with unreadable git=
dir' '
> +	mkdir -p .git/worktrees/def/abc &&
> +	: >.git/worktrees/def/def &&
> +	: >.git/worktrees/def/gitdir &&
> +	chmod u-r .git/worktrees/def/gitdir &&
> +	git prune --worktrees --verbose >actual &&
> +	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" =
actual &&
> +	! test -d .git/worktrees/def &&
> +	! test -d .git/worktrees
> +'
> +
> +test_expect_success 'prune directories with invalid gitdir' '
> +	mkdir -p .git/worktrees/def/abc &&
> +	: >.git/worktrees/def/def &&
> +	: >.git/worktrees/def/gitdir &&
> +	git prune --worktrees --verbose >actual &&
> +	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual =
&&
> +	! test -d .git/worktrees/def &&
> +	! test -d .git/worktrees
> +'
> +
> +test_expect_success 'prune directories with gitdir pointing to nowhe=
re' '
> +	mkdir -p .git/worktrees/def/abc &&
> +	: >.git/worktrees/def/def &&
> +	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
> +	git prune --worktrees --verbose >actual &&
> +	test_i18ngrep "Removing worktrees/def: gitdir file points to non-ex=
istent location" actual &&
> +	! test -d .git/worktrees/def &&
> +	! test -d .git/worktrees
> +'
> +
> +test_expect_success 'not prune locked checkout' '
> +	test_when_finished rm -r .git/worktrees
> +	mkdir -p .git/worktrees/ghi &&
> +	: >.git/worktrees/ghi/locked &&
> +	git prune --worktrees &&
> +	test -d .git/worktrees/ghi
> +'
> +
> +test_expect_success 'not prune recent checkouts' '
> +	test_when_finished rm -r .git/worktrees
> +	mkdir zz &&
> +	mkdir -p .git/worktrees/jlm &&
> +	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
> +	git prune --worktrees --verbose --expire=3D2.days.ago &&
> +	test -d .git/worktrees/jlm
> +'
> +
> +test_done
>=20
