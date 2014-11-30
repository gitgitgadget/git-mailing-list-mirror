From: Max Kirillov <max@max630.net>
Subject: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Mon,  1 Dec 2014 01:27:56 +0200
Message-ID: <1417390076-2953-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 00:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvDug-0001fs-88
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 00:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaK3X2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 18:28:18 -0500
Received: from p3plsmtpa09-08.prod.phx3.secureserver.net ([173.201.193.237]:53560
	"EHLO p3plsmtpa09-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752030AbaK3X2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2014 18:28:16 -0500
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa09-08.prod.phx3.secureserver.net with 
	id MzU61p0075B68XE01zUBc3; Sun, 30 Nov 2014 16:28:13 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260456>

builtin/checkout.c: use absolute path instead of given argument for
 picking worktree name, it happens to be needed because for submodule
 checkout the new worktree is always "."
environment.c: add GIT_COMMON_DIR to local_repo_env
git-submodule.sh: implement automatic cloning of main repository
 and checkout to new worktree at "submodule update --init"
path.c, setup.c, submodule.c: fix "diff --submodule" when
 submodule is a linked worktree
t/t7410-submodule-checkout-to.sh: tests for all the above

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi.

Thanks for including my 2 patches.

But, while hacking the submodule init I became more convinced that the
modules directory should be common and submodules in checkout should be
a checkouts of the submodule. Because this is looks like concept of
submodules, that they are unique for the lifetime of repository, even if
they do not exist in all revisions. And if anybody want to use fully
independent checkout they can be always checked out manually. Actually,
after a submodule is initialized and have a proper gitlink, it can be
updated and inquired regardless of where it points to.

So that one I think is not needed. I have instead some changes to
git-submodule, but have not prepared them yet as an exportable history.

I am submitting here squashed changes which I have so far, to give an
idea where it goes. I'll try to prepare a proper patch series as soon as
I can.

They contain change $gmane/258173, which I think is important,
especially because it is required not only for initialization but for
regular work also, and changes for initialization of submodules.

They are rebased on top of you patches excluding the 34/34 patch.

 builtin/checkout.c               |  25 ++---
 cache.h                          |   1 +
 environment.c                    |   1 +
 git-submodule.sh                 |  94 ++++++++++++++----
 path.c                           |  24 ++++-
 setup.c                          |  17 +++-
 submodule.c                      |  28 ++----
 t/t7410-submodule-checkout-to.sh | 201 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 332 insertions(+), 59 deletions(-)
 create mode 100755 t/t7410-submodule-checkout-to.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 953b763..78154ae 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -858,27 +858,29 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *path = opts->new_worktree, *name;
+	struct strbuf sb_path = STRBUF_INIT;
+	const char *name;
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
 
 	if (!new->commit)
 		die(_("no branch specified"));
-	if (file_exists(path) && !is_empty_dir(path))
-		die(_("'%s' already exists"), path);
+	strbuf_add_absolute_path(&sb_path, opts->new_worktree);
+	if (file_exists(sb_path.buf) && !is_empty_dir(sb_path.buf))
+		die(_("'%s' already exists"), sb_path.buf);
 
-	len = strlen(path);
-	while (len && is_dir_sep(path[len - 1]))
+	len = sb_path.len;
+	while (len && is_dir_sep(sb_path.buf[len - 1]))
 		len--;
 
-	for (name = path + len - 1; name > path; name--)
+	for (name = sb_path.buf + len - 1; name > sb_path.buf; name--)
 		if (is_dir_sep(*name)) {
 			name++;
 			break;
 		}
 	strbuf_addstr(&sb_repo,
-		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+		      git_path("worktrees/%.*s", (int)(sb_path.buf + len - name), name));
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -906,11 +908,11 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	write_file(sb.buf, 1, "initializing\n");
 
-	strbuf_addf(&sb_git, "%s/.git", path);
+	strbuf_addf(&sb_git, "%s/.git", sb_path.buf);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
-	junk_work_tree = xstrdup(path);
+	junk_work_tree = xstrdup(sb_path.buf);
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
@@ -931,11 +933,11 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	write_file(sb.buf, 1, "../..\n");
 
 	if (!opts->quiet)
-		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+		fprintf_ln(stderr, _("Enter %s (identifier %s)"), sb_path.buf, name);
 
 	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
 	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, sb_path.buf, 1);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
 	cp.argv = opts->saved_argv;
@@ -950,6 +952,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 	unlink_or_warn(sb.buf);
+	strbuf_release(&sb_path);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
diff --git a/cache.h b/cache.h
index 3f60a11..e8f465a 100644
--- a/cache.h
+++ b/cache.h
@@ -437,6 +437,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
diff --git a/environment.c b/environment.c
index 8351007..85ce3c4 100644
--- a/environment.c
+++ b/environment.c
@@ -94,6 +94,7 @@ const char * const local_repo_env[] = {
 	CONFIG_DATA_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
+	GIT_COMMON_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
 	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
 	GRAFT_ENVIRONMENT,
diff --git a/git-submodule.sh b/git-submodule.sh
index 9245abf..1b1dbf9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -254,6 +254,7 @@ module_name()
 #
 module_clone()
 {
+	local sm_path
 	sm_path=$1
 	name=$2
 	url=$3
@@ -269,9 +270,8 @@ module_clone()
 	gitdir_base=
 	base_name=$(dirname "$name")
 
-	gitdir=$(git rev-parse --git-dir)
-	gitdir_base="$gitdir/modules/$base_name"
-	gitdir="$gitdir/modules/$name"
+	gitdir_base=$(git rev-parse --git-path "modules/$base_name")
+	gitdir=$(git rev-parse --git-path "modules/$name")
 
 	if test -d "$gitdir"
 	then
@@ -458,12 +458,13 @@ Use -f if you really want to add it." >&2
 		fi
 
 	else
-		if test -d ".git/modules/$sm_name"
+		module_gitdir=$(git rev-parse --git-path "modules/$sm_name")
+		if test -d "$module_gitdir"
 		then
 			if test -z "$force"
 			then
 				echo >&2 "$(eval_gettext "A git directory for '\$sm_name' is found locally with remote(s):")"
-				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
+				GIT_DIR="$module_gitdir" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
 				echo >&2 "$(eval_gettext "If you want to reuse this local git directory instead of cloning again from")"
 				echo >&2 "  $realrepo"
 				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
@@ -472,16 +473,44 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
-		(
-			clear_local_git_env
-			cd "$sm_path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
-			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
+		checkout_to_common_gitdir=
+		common_dir=$(git rev-parse --git-common-dir)
+		private_dir=$(git rev-parse --git-dir)
+		if test "$common_dir" != "$private_dir"
+		then
+			checkout_to_common_gitdir="$module_gitdir"
+			tmp_worktree=$(mktemp -d)
+			ls -a "$tmp_worktree"
+			test -n "$tmp_worktree" || die "mktemp failed"
+			module_clone "$tmp_worktree" "$sm_name" "$realrepo" "$reference" "$depth" &&
+			(
+				clear_local_git_env
+				cd "$tmp_worktree" &&
+				git update-ref --no-deref HEAD HEAD'^0' &&
+				git config --unset core.worktree
+			) || exit
+			rm -rf "$tmp_worktree"
+			rm -f "$checkout_to_common_gitdir/index"
+			(
+				clear_local_git_env
+				# ash fails to wordsplit ${branch:+-b "$branch"...}
+				case "$branch" in
+				'') git --git-dir="$checkout_to_common_gitdir" checkout -f -q --to "$sm_path" origin/HEAD ;;
+				?*) git --git-dir="$checkout_to_common_gitdir" checkout -f -q -B "$branch" --to "$sm_path" "origin/$branch" ;;
+				esac
+			) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
+		else
+			module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
+			(
+				clear_local_git_env
+				cd "$sm_path" &&
+				# ash fails to wordsplit ${branch:+-b "$branch"...}
+				case "$branch" in
+				'') git checkout -f -q ;;
+				?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
+				esac
+			) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
+		fi
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
@@ -832,9 +861,27 @@ Maybe you want to use 'update --init'?")"
 			continue
 		fi
 
+		checkout_to_common_gitdir=
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			common_dir=$(git rev-parse --git-common-dir)
+			private_dir=$(git rev-parse --git-dir)
+			if test "$common_dir" != "$private_dir"
+			then
+				checkout_to_common_gitdir=$(git rev-parse --git-path "modules/$name")
+				if ! test -d "$checkout_to_common_gitdir"
+				then
+					tmp_worktree=$(mktemp -d)
+					ls -a "$tmp_worktree"
+					test -n "$tmp_worktree" || die "mktemp failed"
+					module_clone "$tmp_worktree" "$name" "$url" "$reference" "$depth" || exit
+					git --git-dir="$checkout_to_common_gitdir" config --unset core.worktree
+					rm -rf "$tmp_worktree"
+					rm -f "$checkout_to_common_gitdir/index"
+				fi
+			else
+				module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			fi
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
@@ -886,24 +933,29 @@ Maybe you want to use 'update --init'?")"
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
-				command="git checkout $subforce -q"
+				if test -n "$checkout_to_common_gitdir"
+				then
+					submodule_command() { git --git-dir="$checkout_to_common_gitdir" checkout --to . $subforce -q "$@"; }
+				else
+					submodule_command() { git checkout $subforce -q "$@"; }
+				fi
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
 				;;
 			rebase)
-				command="git rebase"
+				submodule_command() { git rebase "$@"; }
 				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			merge)
-				command="git merge"
+				submodule_command() { git merge "$@"; }
 				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
 				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
 				must_die_on_failure=yes
 				;;
 			!*)
-				command="${update_module#!}"
+				submodule_command() { ${update_module#!} "$@"; }
 				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
 				must_die_on_failure=yes
@@ -912,7 +964,7 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
 			esac
 
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+			if (clear_local_git_env; cd "$sm_path" && submodule_command "$sha1")
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
diff --git a/path.c b/path.c
index 35d498e..fadc1ea 100644
--- a/path.c
+++ b/path.c
@@ -98,7 +98,7 @@ static const char *common_list[] = {
 	NULL
 };
 
-static void update_common_dir(struct strbuf *buf, int git_dir_len)
+static void update_common_dir(struct strbuf *buf, int git_dir_len, const char* common_dir)
 {
 	char *base = buf->buf + git_dir_len;
 	const char **p;
@@ -115,12 +115,17 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
 			path++;
 			is_dir = 1;
 		}
+
+		if (!common_dir) {
+			common_dir = get_git_common_dir();
+		}
+
 		if (is_dir && dir_prefix(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
+			replace_dir(buf, git_dir_len, common_dir);
 			return;
 		}
 		if (!is_dir && !strcmp(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
+			replace_dir(buf, git_dir_len, common_dir);
 			return;
 		}
 	}
@@ -160,7 +165,7 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
 	else if (git_common_dir_env)
-		update_common_dir(buf, git_dir_len);
+		update_common_dir(buf, git_dir_len, NULL);
 }
 
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
@@ -256,6 +261,8 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	struct strbuf *buf = get_pathname();
 	const char *git_dir;
+	struct strbuf git_submodule_common_dir = STRBUF_INIT;
+	struct strbuf git_submodule_dir = STRBUF_INIT;
 	va_list args;
 
 	strbuf_addstr(buf, path);
@@ -269,11 +276,20 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
 		strbuf_addstr(buf, git_dir);
 	}
 	strbuf_addch(buf, '/');
+	strbuf_addstr(&git_submodule_dir, buf->buf);
 
 	va_start(args, fmt);
 	strbuf_vaddf(buf, fmt, args);
 	va_end(args);
+
+	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf)) {
+		update_common_dir(buf, git_submodule_dir.len, git_submodule_common_dir.buf);
+	}
+
 	strbuf_cleanup_path(buf);
+
+	strbuf_release(&git_submodule_dir);
+	strbuf_release(&git_submodule_common_dir);
 	return buf->buf;
 }
 
diff --git a/setup.c b/setup.c
index fb61860..ffda622 100644
--- a/setup.c
+++ b/setup.c
@@ -226,14 +226,21 @@ void verify_non_filename(const char *prefix, const char *arg)
 
 int get_common_dir(struct strbuf *sb, const char *gitdir)
 {
+	const char *git_env_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_env_common_dir) {
+		strbuf_addstr(sb, git_env_common_dir);
+		return 1;
+	} else {
+		return get_common_dir_noenv(sb, gitdir);
+	}
+}
+
+int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
+{
 	struct strbuf data = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	const char *git_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
 	int ret = 0;
-	if (git_common_dir) {
-		strbuf_addstr(sb, git_common_dir);
-		return 1;
-	}
+
 	strbuf_addf(&path, "%s/commondir", gitdir);
 	if (file_exists(path.buf)) {
 		if (strbuf_read_file(&data, path.buf, 0) <= 0)
diff --git a/submodule.c b/submodule.c
index 34094f5..4aad3d4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -122,43 +122,35 @@ void stage_updated_gitmodules(void)
 
 static int add_submodule_odb(const char *path)
 {
-	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
+	const char* objects_directory;
 	int ret = 0;
-	const char *git_dir;
 
-	strbuf_addf(&objects_directory, "%s/.git", path);
-	git_dir = read_gitfile(objects_directory.buf);
-	if (git_dir) {
-		strbuf_reset(&objects_directory);
-		strbuf_addstr(&objects_directory, git_dir);
-	}
-	strbuf_addstr(&objects_directory, "/objects/");
-	if (!is_directory(objects_directory.buf)) {
+	objects_directory = git_path_submodule(path, "objects/");
+	if (!is_directory(objects_directory)) {
 		ret = -1;
 		goto done;
 	}
+
 	/* avoid adding it twice */
 	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
-		if (alt_odb->name - alt_odb->base == objects_directory.len &&
-				!strncmp(alt_odb->base, objects_directory.buf,
-					objects_directory.len))
+		if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
+				!strcmp(alt_odb->base, objects_directory))
 			goto done;
 
-	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
+	alt_odb = xmalloc(strlen(objects_directory) + 42 + sizeof(*alt_odb));
 	alt_odb->next = alt_odb_list;
-	strcpy(alt_odb->base, objects_directory.buf);
-	alt_odb->name = alt_odb->base + objects_directory.len;
+	strcpy(alt_odb->base, objects_directory);
+	alt_odb->name = alt_odb->base + strlen(objects_directory);
 	alt_odb->name[2] = '/';
 	alt_odb->name[40] = '\0';
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
 
 	/* add possible alternates from the submodule */
-	read_info_alternates(objects_directory.buf, 0);
+	read_info_alternates(objects_directory, 0);
 	prepare_alt_odb();
 done:
-	strbuf_release(&objects_directory);
 	return ret;
 }
 
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
new file mode 100755
index 0000000..cbbcecb
--- /dev/null
+++ b/t/t7410-submodule-checkout-to.sh
@@ -0,0 +1,201 @@
+#!/bin/sh
+
+test_description='Combination of submodules and multiple workdirs'
+
+. ./test-lib.sh
+
+base_path=$(pwd -P)
+
+test_expect_success 'setup: make origin' \
+    'mkdir -p origin/sub && ( cd origin/sub && git init &&
+	echo file1 >file1 &&
+	git add file1 &&
+	git commit -m file1 ) &&
+    mkdir -p origin/main && ( cd origin/main && git init &&
+	git submodule add ../sub &&
+	git commit -m "add sub" ) &&
+    ( cd origin/sub &&
+	echo file1updated >file1 &&
+	git add file1 &&
+	git commit -m "file1 updated" ) &&
+    ( cd origin/main/sub && git pull ) &&
+    ( cd origin/main &&
+	git add sub &&
+	git commit -m "sub updated" )'
+
+test_expect_success 'setup: clone' \
+    'mkdir clone && ( cd clone &&
+	git clone --recursive "$base_path/origin/main")'
+
+rev1_hash_main=$(git --git-dir=origin/main/.git show --pretty=format:%h -q "HEAD~1")
+rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1")
+
+test_expect_success 'checkout main' \
+    'mkdir default_checkout &&
+    (cd clone/main &&
+	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+
+# TODO: this must never work without --recursive
+test_expect_failure 'can see submodule diffs just after checkout' \
+    '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'checkout main and initialize independed clones' \
+    'mkdir fully_cloned_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+    (cd fully_cloned_submodule/main && git submodule update)'
+
+# TODO: thus must require update --init
+test_expect_success 'can see submodule diffs after independed cloning' \
+    '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+# TODO: this is not needed to do now regularly, rather being a special case
+# 1. manual checkout should point to somewhere else at all
+# 2. no need to make that gitlink
+test_expect_success 'checkout sub manually' \
+    'mkdir linked_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/linked_submodule/main" "$rev1_hash_main") &&
+    (cd clone/main/sub &&
+	git checkout --to "$base_path/linked_submodule/main/sub" "$rev1_hash_sub") &&
+    mkdir clone/main/.git/worktrees/main/modules &&
+	echo "gitdir: ../../modules/sub/worktrees/sub" > clone/main/.git/worktrees/main/modules/sub'
+
+test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
+    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'clone non-recursively and update to linked superpproject' \
+    'mkdir clone_norec && ( cd clone_norec &&
+	git clone "$base_path/origin/main" &&
+	cd main &&
+	git checkout --to "$base_path/worktree_with_submodule/main" "$rev1_hash_main") &&
+    (cd worktree_with_submodule/main &&
+	git submodule update --init)'
+
+test_expect_success 'can see submodule diffs in worktree with independently updated submodule' \
+    '(cd worktree_with_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'init submodule in main repository back' \
+    '( cd clone_norec/main && git submodule update --init)'
+
+test_expect_success 'can see submodule diffs in main repository which initalized after linked' \
+    '(cd clone_norec/main && git diff --submodule master"^!" | grep "file1 updated")'
+
+test_expect_success 'linked worktree is uptodate after chanages in main' \
+    '(cd clone_norec/main && git checkout --detach master~1 && git submodule update) &&
+    (cd worktree_with_submodule/main &&
+	git status --porcelain >../../actual &&
+	: >../../expected &&
+	test_cmp ../../expected ../../actual)'
+
+test_expect_success 'init another repository to test adding' \
+    'mkdir -p add_area/repo &&
+    (cd add_area/repo &&
+	git init &&
+	git commit --allow-empty -m main_commit &&
+	git branch b2 &&
+	git checkout --to ../worktree b2)'
+
+test_expect_success 'add sub&history' \
+    '(cd add_area/worktree &&
+	git submodule add ../../origin/sub sub &&
+	(cd sub && git checkout --detach "$rev1_hash_sub") &&
+	git add sub &&
+	git commit -m sub_added &&
+	(cd sub && git checkout --detach origin/master) &&
+	git add sub &&
+	git commit -m sub_changed)'
+
+test_expect_success 'inquire history after adding' \
+    '(cd add_area/worktree &&
+	git diff --submodule b2"^!" | grep "file1 updated")'
+
+test_expect_success 'init submodule in main' \
+    '(cd add_area/repo &&
+	git reset --hard b2~1 &&
+	git submodule update --init)'
+
+test_expect_success 'linked worktree is uptodate after changes in original after adding' \
+    '(cd add_area/worktree &&
+	git status --porcelain >../../actual &&
+	: >../../expected &&
+	test_cmp ../../expected ../../actual)'
+
+deinit_start()
+{
+    rm -rf deinit_area && \
+    mkdir deinit_area && \
+    ( cd deinit_area && \
+	git clone "$base_path/origin/main" && \
+	cd main && \
+	git checkout --to ../worktree --detach HEAD )
+}
+
+deinit_init()
+{
+    (cd "deinit_area/$1" && git submodule update --init)
+}
+
+deinit_deinit()
+{
+    (cd "deinit_area/$1" && git submodule deinit sub)
+}
+
+deinit_not_checked_out()
+{
+    (cd "deinit_area/$1" && git diff --submodule master"^!" >actual && grep -q "not checked out" actual)
+}
+
+deinit_checked_out()
+{
+    (cd "deinit_area/$1" && git diff --submodule master"^!" >actual && grep -q "file1 updated" actual)
+}
+
+# TODO:
+# 1. check that directories are cleaned and index is removed for main (?)
+# 2. .git/config should be removed only after last owrktree is. Is it visible at all?
+test_expect_success 'deinit main only - create' \
+    'deinit_start && deinit_init main && deinit_deinit main'
+
+test_expect_success 'deinit main only - not checked out' \
+    'deinit_not_checked_out main'
+
+test_expect_success 'deinit worktree only - create' \
+    'deinit_init && deinit_init worktree && deinit_deinit worktree'
+
+test_expect_success 'deinit worktree only - not checked out' \
+    'deinit_not_checked_out worktree'
+
+test_expect_success 'deinit from both, worktree then main - create' \
+    'deinit_init && deinit_init main && deinit_init worktree && deinit_deinit worktree'
+
+test_expect_success 'deinit from both, worktree then main - update' \
+    '(cd deinit_area/main && git submodule update) &&
+    (cd deinit_area/worktree && git submodule update)'
+
+test_expect_success 'deinit from both, worktree then main - check#1' \
+    'deinit_not_checked_out worktree && deinit_checked_out main'
+
+test_expect_success 'deinit from both, worktree then main - deinit main' \
+    'deinit_deinit main'
+
+test_expect_success 'deinit from both, worktree then main - check#2' \
+    'deinit_not_checked_out worktree && deinit_not_checked_out main'
+
+test_expect_success 'deinit from both, main then worktree - create' \
+    'deinit_init && deinit_init main && deinit_init worktree && deinit_deinit main'
+
+test_expect_success 'deinit from both, worktree then main - update' \
+    '(cd deinit_area/main && git submodule update) &&
+    (cd deinit_area/worktree && git submodule update)'
+
+test_expect_success 'deinit from both, main then worktree - check#1' \
+    'deinit_not_checked_out main && deinit_checked_out worktree'
+
+test_expect_success 'deinit from both, main then worktree - deinit worktree' \
+    'deinit_deinit worktree'
+
+test_expect_success 'deinit from both, main then worktree - check#2' \
+    'deinit_not_checked_out worktree && deinit_not_checked_out main'
+
+test_done
-- 
2.1.1.391.g7a54a76
