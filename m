From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/9] submodule: implement `module_clone` as a builtin helper
Date: Thu, 27 Aug 2015 18:14:49 -0700
Message-ID: <1440724495-708-4-git-send-email-sbeller@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8Gh-00012l-JM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbbH1BPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34995 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbH1BPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:03 -0400
Received: by pacdd16 with SMTP id dd16so43387523pac.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVU9Clnh4Wd6sYXUd0ZdVd34AGZWQGJG+DRkFyDbxy8=;
        b=HfIBgXdlo7+ZSudJxsrsdaafe5HuMPCreqYARHJUKTFo7t1G+zADHUexXqP2tMVK38
         IEdgD+C5xHplZq1WeWBkrVdW7c/lU3bhMvZVdsk48FPauqk4nyhYW8c2XKwUSf8VhlRm
         5Zpxtw4QKZHtxrZjTCh5ZUh2CK01V56bV4oMc3gx1QFgp5bA4hrulx13if1g5wDdhcsn
         Wokz5e8vJQrG0Jzf77mWUKpDbyWQt43apLbxq7kIzOrmfYRC2Opbu+3tzEz2j2gon1f1
         WugjK9cakPXxZC9nzRrXSHMtH8XymItZqNQdiAIo5ROhV/osF+DJGHtAkxb1MtlIS6rg
         kp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVU9Clnh4Wd6sYXUd0ZdVd34AGZWQGJG+DRkFyDbxy8=;
        b=Ue/Z/i843bRVYA8fmIAPQ0fxgdTBHiTJvLVXqVG7wk7SD+4CdvS1o42YBOjuFaXzE0
         AjjMJBTI7fEz+vo0w0axVoixmGjxjR8r5Fmb32ZKSlGPCCKJ3ruiPTxUOX3OAFpfRYmT
         ty5GIlWNTEU2Ge7sURJNDacnzUIYOsGPH1jjayudUiLQ4m6wOTZs5cKBhDLtrsBRKpro
         ciL5QfRxF43qTb4G4ReUtltJZzT0EpRxpXIYG8vSJaD4Wy9zMajKvcFngc3JRovkp4ll
         f4spYlJ5Q3h6eemKarhUGsg8KZ84NMSW+nd+/Oi9780b0zj7YKxc+1u1MUX1vhE2V3yd
         Q5Zw==
X-Gm-Message-State: ALoCoQn3p+/Bb9EgyAWu848BIog9uPANGeRb9TOqw1wxK6jVt3Ok14QZ2G4OeoEABgxJpLG518fh
X-Received: by 10.68.168.161 with SMTP id zx1mr11083573pbb.35.1440724503195;
        Thu, 27 Aug 2015 18:15:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id lo10sm3757599pab.16.2015.08.27.18.15.02
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:15:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
In-Reply-To: <1440724495-708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276692>

`module_clone` is part of the update command,
which I want to convert to C next.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 148 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  80 +-----------------------
 2 files changed, 150 insertions(+), 78 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c8f7e0c..d29499c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -8,6 +8,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
+#include "run-command.h"
 
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
@@ -124,6 +125,147 @@ static int module_name(int argc, const char **argv, const char *prefix)
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
+	if (depth && strcmp(depth, "")) {
+		argv_array_push(&cp.args, "--depth");
+		argv_array_push(&cp.args, depth);
+	}
+	if (reference && strcmp(reference, "")) {
+		argv_array_push(&cp.args, "--reference");
+		argv_array_push(&cp.args, reference);
+	}
+	if (gitdir) {
+		argv_array_push(&cp.args, "--separate-git-dir");
+		argv_array_push(&cp.args, gitdir);
+	}
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
+	const char *sm_gitdir, *p;
+	struct strbuf rel_path = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	struct option module_update_options[] = {
+		OPT_STRING(0, "prefix", &alternative_path,
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
+		OPT_END()
+	};
+
+	static const char * const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update [--prefix=<path>] [--quiet] [--remote] [-N|--no-fetch]"
+		   "[-f|--force] [--rebase|--merge] [--reference <repository>]"
+		   "[--depth <depth>] [--recursive] [--] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_update_options,
+			     git_submodule_helper_usage, 0);
+
+	if (getenv("GIT_QUIET"))
+		quiet = 1;
+
+	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
+	sm_gitdir = strbuf_detach(&sb, NULL);
+
+	if (!file_exists(sm_gitdir)) {
+		safe_create_leading_directories_const(sm_gitdir);
+		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
+			die(N_("Clone of '%s' into submodule path '%s' failed"),
+			    url, path);
+	} else {
+		safe_create_leading_directories_const(path);
+		unlink(sm_gitdir);
+	}
+
+	/* Write a .git file in the submodule to redirect to the superproject. */
+	if (alternative_path && !strcmp(alternative_path, "")) {
+		p = relative_path(path, alternative_path, &sb);
+		strbuf_reset(&sb);
+	} else
+		p = path;
+
+	if (safe_create_leading_directories_const(p) < 0)
+		die("Could not create directory '%s'", p);
+
+	strbuf_addf(&sb, "%s/.git", p);
+
+	if (safe_create_leading_directories_const(sb.buf) < 0)
+		die(_("could not create leading directories of '%s'"), sb.buf);
+	submodule_dot_git = fopen(sb.buf, "w");
+	if (!submodule_dot_git)
+		die ("Cannot open file '%s': %s", sb.buf, strerror(errno));
+
+	fprintf(submodule_dot_git, "gitdir: %s\n",
+		relative_path(sm_gitdir, path, &rel_path));
+	if (fclose(submodule_dot_git))
+		die("Could not close file %s", sb.buf);
+	strbuf_reset(&sb);
+
+	/* Redirect the worktree of the submodule in the superprojects config */
+	if (!is_absolute_path(sm_gitdir)) {
+		char *s = (char*)sm_gitdir;
+		if (strbuf_getcwd(&sb))
+			die_errno("unable to get current working directory");
+		strbuf_addf(&sb, "/%s", sm_gitdir);
+		sm_gitdir = strbuf_detach(&sb, NULL);
+		free(s);
+	}
+
+	if (strbuf_getcwd(&sb))
+		die_errno("unable to get current working directory");
+	strbuf_addf(&sb, "/%s", path);
+
+	p = git_pathdup_submodule(path, "config");
+	if (!p)
+		die("Could not get submodule directory for '%s'", path);
+	git_config_set_in_file(p, "core.worktree",
+			       relative_path(sb.buf, sm_gitdir, &rel_path));
+	strbuf_release(&sb);
+	free((char*)sm_gitdir);
+	return 0;
+}
+
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	if (argc < 2)
@@ -135,6 +277,10 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_name"))
 		return module_name(argc - 2, argv + 2, prefix);
 
+	if (!strcmp(argv[1], "module_clone"))
+		return module_clone(argc - 1, argv + 1, prefix);
+
 usage:
-	usage("git submodule--helper [module_list | module_name]\n");
+	usage("git submodule--helper [module_list | module_name | "
+	      "module_clone]\n");
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index e6ff38d..fb5155e 100755
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
+		git submodule--helper module_clone --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -774,7 +700,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
+			git submodule--helper module_clone --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.5.0.264.g5e52b0d
