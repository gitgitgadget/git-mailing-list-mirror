From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/3] submodule: Reimplement `module_clone` shell function in C
Date: Wed,  2 Sep 2015 14:42:26 -0700
Message-ID: <1441230146-26921-4-git-send-email-sbeller@google.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Sep 02 23:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFnr-0001Tq-09
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbbIBVmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 17:42:44 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33192 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbbIBVmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 17:42:43 -0400
Received: by pacex6 with SMTP id ex6so18560184pac.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bYDkpQOWolQemeQHz2DBwOYZYgFD04SQbxeoYL+LrYE=;
        b=N2Ft1HfRFipKD5KWYD9n4lK++Byn3EaMKZ7nYE3cOtd/AiW1jLFsBqLsxWNxdJRMfm
         9Hff5zUi2M3MhqgsT/MqJ077tfn6TFo4H/y4rBcWuMErRqPwaPvrJvJ1hFojBZEImv7A
         VfgLqtKJJPsZDK7TQL8is612ILAUZ+CM7X5tiEO8ziXYiaGDskNDH/LNNgXbpBJJtjpe
         xhrrDrql3Uwb2MgaFLmX6DC5ZMmXgRzHzYpgfU+xMvClhzexicdVQDM9XX41yCy0qnzC
         l6wznlHpGXnfGcF26zM3j1yGjAhetOtsuA4m0dO7ll6KFhHbXvyNd+jzmZtuY/2s16GE
         OKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bYDkpQOWolQemeQHz2DBwOYZYgFD04SQbxeoYL+LrYE=;
        b=SWIXD3mSNCPTj+cEFUS6skpjkJ0ekKfNdhEal0xflErJtA8Oy1TgK8HovCrTP2hx1K
         W2hycYEzNB2t66Ye9QgCkihBlx8eUU9z1NhnSjSOrU4hi4TAxVLN9wmH+2PJ+3pWytva
         f6WzgrUxVO0pwSMj1wC0EKyLzDODvOgWWsFseFHuOmcZVT3BZo2Wp+tuxMkTTA0aUS2t
         zKqMB0LUjOB6KAH/KYgFAnZDctUsn615ZGIWkDzQDs7WOAVg4nZKe5Yt3YxSm2zUmXd3
         dK1whJZSRF6a0YsYJuEp4jTlT8wudFVh8a4HPsuQI099csH09fE2doXJ8xpEM66ZtVMj
         6FTw==
X-Gm-Message-State: ALoCoQm2dev9adoywXFXryDrOVcVo3sy78hB7FpzmvoOKZR7rUYqWHCh6AGJLIAIfhDx3uoaLDOY
X-Received: by 10.69.12.33 with SMTP id en1mr60186286pbd.97.1441230162566;
        Wed, 02 Sep 2015 14:42:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8100:e957:594c:edb9])
        by smtp.gmail.com with ESMTPSA id y7sm10787959pdm.51.2015.09.02.14.42.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 14:42:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441230146-26921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277130>

This reimplements the helper function `module_clone` in shell
in C as `clone`. This functionality is needed for converting
`git submodule update` later on, which we want to add threading
to.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 136 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  80 +-------------------------
 2 files changed, 139 insertions(+), 77 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f989319..4e30d8e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -8,6 +8,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
+#include "run-command.h"
 
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
@@ -119,6 +120,140 @@ static int module_name(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+static int clone_submodule(const char *path, const char *gitdir, const char *url,
+			   const char *depth, const char *reference, int quiet)
+{
+	struct child_process cp;
+	child_process_init(&cp);
+
+	argv_array_push(&cp.args, "clone");
+	argv_array_push(&cp.args, "--no-checkout");
+	if (quiet)
+		argv_array_push(&cp.args, "--quiet");
+	if (depth && *depth)
+		argv_array_pushl(&cp.args, "--depth", depth, NULL);
+	if (reference && *reference)
+		argv_array_pushl(&cp.args, "--reference", reference, NULL);
+	if (gitdir && *gitdir)
+		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+
+	argv_array_push(&cp.args, url);
+	argv_array_push(&cp.args, path);
+
+	cp.git_cmd = 1;
+	cp.env = local_repo_env;
+
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.no_stderr = 1;
+
+	return run_command(&cp);
+}
+
+static int module_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *path = NULL, *name = NULL, *url = NULL;
+	const char *reference = NULL, *depth = NULL;
+	int quiet = 0;
+	FILE *submodule_dot_git;
+	char *sm_gitdir, *cwd, *p;
+	struct strbuf rel_path = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	struct option module_clone_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "path", &path,
+			   N_("path"),
+			   N_("where the new submodule will be cloned to")),
+		OPT_STRING(0, "name", &name,
+			   N_("string"),
+			   N_("name of the new submodule")),
+		OPT_STRING(0, "url", &url,
+			   N_("string"),
+			   N_("url where to clone the submodule from")),
+		OPT_STRING(0, "reference", &reference,
+			   N_("string"),
+			   N_("reference repository")),
+		OPT_STRING(0, "depth", &depth,
+			   N_("string"),
+			   N_("depth for shallow clones")),
+		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
+		   "[--reference <repository>] [--name <name>] [--url <url>]"
+		   "[--depth <depth>] [--] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_clone_options,
+			     git_submodule_helper_usage, 0);
+
+	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	sm_gitdir = strbuf_detach(&sb, NULL);
+
+	if (!file_exists(sm_gitdir)) {
+		if (safe_create_leading_directories_const(sm_gitdir) < 0)
+			die(_("could not create directory '%s'"), sm_gitdir);
+		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
+			die(_("clone of '%s' into submodule path '%s' failed"),
+			    url, path);
+	} else {
+		if (safe_create_leading_directories_const(path) < 0)
+			die(_("could not create directory '%s'"), path);
+		strbuf_addf(&sb, "%s/index", sm_gitdir);
+		if (unlink(sb.buf) < 0)
+			die_errno(_("failed to delete '%s'"), sm_gitdir);
+		strbuf_reset(&sb);
+	}
+
+	/* Write a .git file in the submodule to redirect to the superproject. */
+	if (safe_create_leading_directories_const(path) < 0)
+		die(_("could not create directory '%s'"), path);
+
+	if (path && *path)
+		strbuf_addf(&sb, "%s/.git", path);
+	else
+		strbuf_addf(&sb, ".git");
+
+	if (safe_create_leading_directories_const(sb.buf) < 0)
+		die(_("could not create leading directories of '%s'"), sb.buf);
+	submodule_dot_git = fopen(sb.buf, "w");
+	if (!submodule_dot_git)
+		die_errno(_("cannot open file '%s'"), sb.buf);
+
+	fprintf(submodule_dot_git, "gitdir: %s\n",
+		relative_path(sm_gitdir, path, &rel_path));
+	if (fclose(submodule_dot_git))
+		die(_("could not close file %s"), sb.buf);
+	strbuf_reset(&sb);
+	strbuf_reset(&rel_path);
+
+	cwd = xgetcwd();
+	/* Redirect the worktree of the submodule in the superproject's config */
+	if (!is_absolute_path(sm_gitdir)) {
+		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
+		free(sm_gitdir);
+		sm_gitdir = strbuf_detach(&sb, NULL);
+	}
+
+	strbuf_addf(&sb, "%s/%s", cwd, path);
+	p = git_pathdup_submodule(path, "config");
+	if (!p)
+		die(_("could not get submodule directory for '%s'"), path);
+	git_config_set_in_file(p, "core.worktree",
+			       relative_path(sb.buf, sm_gitdir, &rel_path));
+	strbuf_release(&sb);
+	strbuf_release(&rel_path);
+	free(sm_gitdir);
+	free(cwd);
+	free(p);
+	return 0;
+}
 
 struct cmd_struct {
 	const char *cmd;
@@ -128,6 +263,7 @@ struct cmd_struct {
 static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
+	{"clone", module_clone},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 2be8da2..7cfdc2c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -178,80 +178,6 @@ get_submodule_config () {
 	printf '%s' "${value:-$default}"
 }
 
-#
-# Clone a submodule
-#
-# $1 = submodule path
-# $2 = submodule name
-# $3 = URL to clone
-# $4 = reference repository to reuse (empty for independent)
-# $5 = depth argument for shallow clones (empty for deep)
-#
-# Prior to calling, cmd_update checks that a possibly existing
-# path is not a git repository.
-# Likewise, cmd_add checks that path does not exist at all,
-# since it is the location of a new submodule.
-#
-module_clone()
-{
-	sm_path=$1
-	name=$2
-	url=$3
-	reference="$4"
-	depth="$5"
-	quiet=
-	if test -n "$GIT_QUIET"
-	then
-		quiet=-q
-	fi
-
-	gitdir=
-	gitdir_base=
-	base_name=$(dirname "$name")
-
-	gitdir=$(git rev-parse --git-dir)
-	gitdir_base="$gitdir/modules/$base_name"
-	gitdir="$gitdir/modules/$name"
-
-	if test -d "$gitdir"
-	then
-		mkdir -p "$sm_path"
-		rm -f "$gitdir/index"
-	else
-		mkdir -p "$gitdir_base"
-		(
-			clear_local_git_env
-			git clone $quiet ${depth:+"$depth"} -n ${reference:+"$reference"} \
-				--separate-git-dir "$gitdir" "$url" "$sm_path"
-		) ||
-		die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_path' failed")"
-	fi
-
-	# We already are at the root of the work tree but cd_to_toplevel will
-	# resolve any symlinks that might be present in $PWD
-	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
-	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
-	# Remove all common leading directories after a sanity check
-	if test "${a#$b}" != "$a" || test "${b#$a}" != "$b"; then
-		die "$(eval_gettext "Gitdir '\$a' is part of the submodule path '\$b' or vice versa")"
-	fi
-	while test "${a%%/*}" = "${b%%/*}"
-	do
-		a=${a#*/}
-		b=${b#*/}
-	done
-	# Now chop off the trailing '/'s that were added in the beginning
-	a=${a%/}
-	b=${b%/}
-
-	# Turn each leading "*/" component into "../"
-	rel=$(printf '%s\n' "$b" | sed -e 's|[^/][^/]*|..|g')
-	printf '%s\n' "gitdir: $rel/$a" >"$sm_path/.git"
-
-	rel=$(printf '%s\n' "$a" | sed -e 's|[^/][^/]*|..|g')
-	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
@@ -301,7 +227,7 @@ cmd_add()
 			shift
 			;;
 		--depth=*)
-			depth=$1
+			depth="$1"
 			;;
 		--)
 			shift
@@ -412,7 +338,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -774,7 +700,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.5.0.256.g89f8063.dirty
