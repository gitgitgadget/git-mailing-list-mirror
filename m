From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule: implement `module_clone` as a builtin helper
Date: Wed, 26 Aug 2015 17:52:42 -0700
Message-ID: <1440636766-12738-2-git-send-email-sbeller@google.com>
References: <1440636766-12738-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 02:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUlRC-0000PV-Tm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 02:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbbH0Awz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 20:52:55 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35965 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbH0Awy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 20:52:54 -0400
Received: by pacgr6 with SMTP id gr6so5085867pac.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Hie9JZBp35mmZYFeug0bHPcrTLTYfUtm6hGty3r+pI=;
        b=S3bPlugq+t0S5gOzZB1tCwlVCRHu5JzrtuLxc6BaDV398f0Va5ut2AazUMWWR80fW6
         PzJavgaiNjpyN+sIdQhI93KbQBDjQ3r1uMiD2GdtEUKUnga5BVXOIoSvi0g7RZ8jKtWJ
         WtBmHElprLTNCxG1L8asoKQ7Gj4cUzfeUScG6tUNWJjUy2ZOk1uv+5CCyLlrckElu6zp
         HM1hrSO7pmr/JBjD3cs1VcyNSewN+RVUbSJejYpz5s9iIQ/MiUDNACwHQoSLl3WZAf6z
         xdkD04eGGf3wstjahryvBeq/rfL+NZ3nkuhPFAVVUIJbspm6o/BU4P14ywMpE6cFwcM1
         zGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Hie9JZBp35mmZYFeug0bHPcrTLTYfUtm6hGty3r+pI=;
        b=eJhOWseuN6s0uloDpdVMSx1lTpEYGaRg5oS5Eez6cnzHD3jdMdWfYZ0kSY7fSPDgUo
         6KIJ7GziVjtqfkfr8GLhcxyWFiq1A8jKnsDNZjiKJStsjDa+SGyEV81cWUQPBgpgaThW
         ScecMWWl5uXCVFva0Pq+sl0dWRW4Ae/b01Vq7N5w3ViqTQkb62iDj8hO41L9K8kAwiJr
         VqBfMBxG+OSQ/4zSYdcxvCup818QrJ2bFuM57tNvDjsRTKZluCi8nwLCq9KxfSWw1Hlc
         VvngZ/wotR6REu1ACYic12LdmfTjgmB9G30EQMF+2mPGXWds1UipkPYRdWAOG+lh7z6f
         RBeg==
X-Gm-Message-State: ALoCoQnY+NYCzVSbqwaKbQbvwhtyTm1dKJERK0GcUWqTxtcVjuS9QgjJ1DkpUdVgg9umERPzDc95
X-Received: by 10.68.241.103 with SMTP id wh7mr2321615pbc.88.1440636773424;
        Wed, 26 Aug 2015 17:52:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:806a:7c76:ca55:3bf1])
        by smtp.gmail.com with ESMTPSA id uv5sm295711pbc.12.2015.08.26.17.52.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Aug 2015 17:52:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g784836d
In-Reply-To: <1440636766-12738-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276652>

`module_clone` is part of the update command, which I want to convert
to C next.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 160 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            |  80 +---------------------
 2 files changed, 162 insertions(+), 78 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4b32a3c..f11fb9c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -8,6 +8,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "string-list.h"
+#include "run-command.h"
 
 static const struct cache_entry **ce_entries;
 static int ce_alloc, ce_used;
@@ -124,6 +125,160 @@ static int module_name(int argc, const char **argv, const char *prefix)
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
+/*
+ * Clone a submodule
+ *
+ * $1 = submodule path
+ * $2 = submodule name
+ * $3 = URL to clone
+ * $4 = reference repository to reuse (empty for independent)
+ * $5 = depth argument for shallow clones (empty for deep)
+ *
+ * Prior to calling, cmd_update checks that a possibly existing
+ * path is not a git repository.
+ * Likewise, cmd_add checks that path does not exist at all,
+ * since it is the location of a new submodule.
+ */
+static int module_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *path = NULL, *name = NULL, *url = NULL, *reference = NULL, *depth = NULL;
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
@@ -135,6 +290,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "module_name"))
 		return module_name(argc - 2, argv + 2, prefix);
 
+	if (!strcmp(argv[1], "module_clone"))
+		return module_clone(argc - 1, argv + 1, prefix);
+
 usage:
-	usage("git submodule--helper [module_list module_name]\n");
+	usage("git submodule--helper [module_list module_name module_clone]\n");
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
2.5.0.264.g784836d
