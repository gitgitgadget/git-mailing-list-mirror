From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/2] fetch/pull: Recursively fetch populated submodules
Date: Sun, 29 Aug 2010 17:50:32 +0200
Message-ID: <4C7A81C8.9070402@web.de>
References: <4C7A819B.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 17:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opk9Y-0002dl-JI
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab0H2Pug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:50:36 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60940 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0H2Pue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:50:34 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id B4CD2166D94F7;
	Sun, 29 Aug 2010 17:50:33 +0200 (CEST)
Received: from [93.246.33.247] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Opk9R-0006MY-00; Sun, 29 Aug 2010 17:50:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7A819B.3000403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+xNHVLuOjrcCcUAAPU7aWBihzOqF8Y7S3+gm7T
	gWC4HD1BhCr4ZtaQ6zGxuq59WjBsCbmvs+Xa2qlvYk7u64xdrM
	BazwCWpNgLWZscuxLiUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154695>

Until now you had to call "git submodule update" (without the using the
-N|--no-fetch option) or something like "git submodule foreach git fetch"
to fetch new commits in populated submodules from their remote.

This could lead to "(commits not present)" messages in the output of "git
diff --submodule" (and in "git gui" and "gitk") after fetching/pulling new
commits in the superproject and is an obstacle for implementing recursive
checkout of submodules.

This patch recursively fetches each populated submodule from the url
configured in the .git/config of the submodule at the end of each "git
fetch" or during "git pull" in the superproject. This new behavior can be
disabled by using the new --no-recursive option.

t7403 had to be changed to use the --no-recursive option for pull.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/fetch-options.txt |    5 +++
 builtin/fetch.c                 |   11 ++++++-
 git-pull.sh                     |   10 +++++-
 submodule.c                     |   43 +++++++++++++++++++++++++-
 submodule.h                     |    2 +
 t/t5526-fetch-submodules.sh     |   64 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 7 files changed, 132 insertions(+), 5 deletions(-)
 create mode 100755 t/t5526-fetch-submodules.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 470ac31..1d875be 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,6 +64,11 @@ endif::git-pull[]
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].

+--[no-]recursive::
+	By default new commits of all populated submodules will be fetched
+	too. This option can be used to disable/enable recursive fetching of
+	submodules.
+
 -u::
 --update-head-ok::
 	By default 'git fetch' refuses to update the head which
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fab3fce..da5fc9a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "sigchain.h"
 #include "transport.h"
+#include "submodule.h"

 static const char * const builtin_fetch_usage[] = {
 	"git fetch [<options>] [<repository> [<refspec>...]]",
@@ -27,7 +28,7 @@ enum {
 	TAGS_SET = 2
 };

-static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
+static int all, append, dry_run, force, keep, multiple, prune, recursive = -1, update_head_ok, verbosity;
 static int progress;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
@@ -53,6 +54,8 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
+	OPT_BOOLEAN(0, "recursive", &recursive,
+		    "control recursive fetching of submodules"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -921,6 +924,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}

+	if (!result && recursive) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		result = fetch_populated_submodules();
+	}
+
 	/* All names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..4bc8a60 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge

 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress=
+log_arg= verbosity= progress= recursive=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
@@ -105,6 +105,12 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	--recursive)
+		recursive=--recursive
+		;;
+	--no-recursive)
+		recursive=--no-recursive
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
@@ -220,7 +226,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run $recursive --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0

 curr_head=$(git rev-parse -q --verify HEAD)
diff --git a/submodule.c b/submodule.c
index 91a4758..e4f2419 100644
--- a/submodule.c
+++ b/submodule.c
@@ -63,7 +63,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 	}
 }

-static int submodule_config(const char *var, const char *value, void *cb)
+int submodule_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
@@ -229,6 +229,47 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

+int fetch_populated_submodules()
+{
+	int result = 0;
+	struct child_process cp;
+	const char *argv[] = {
+		"fetch",
+		NULL,
+	};
+	struct string_list_item *name_for_path;
+	const char *work_tree = get_git_work_tree();
+	if (!work_tree)
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.out = -1;
+
+	for_each_string_list_item(name_for_path, &config_name_for_path) {
+		struct strbuf submodule_path = STRBUF_INIT;
+		struct strbuf submodule_git_dir = STRBUF_INIT;
+		const char *git_dir;
+		strbuf_addf(&submodule_path, "%s/%s", work_tree, name_for_path->string);
+		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
+		git_dir = read_gitfile_gently(submodule_git_dir.buf);
+		if (!git_dir)
+			git_dir = submodule_git_dir.buf;
+		if (is_directory(git_dir)) {
+			printf("Fetching submodule %s\n", name_for_path->string);
+			cp.dir = submodule_path.buf;
+			if (run_command(&cp))
+				result = 1;
+		}
+		strbuf_release(&submodule_path);
+		strbuf_release(&submodule_git_dir);
+	}
+	return result;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
diff --git a/submodule.h b/submodule.h
index 386f410..380878c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;

 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
+int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config();
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
@@ -12,6 +13,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
+int fetch_populated_submodules();
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
new file mode 100755
index 0000000..da5d5fd
--- /dev/null
+++ b/t/t5526-fetch-submodules.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# Copyright (c) 2010, Jens Lehmann
+
+test_description='Recursive "git fetch" for submodules'
+
+. ./test-lib.sh
+
+pwd=$(pwd)
+
+add_upstream_commit() {
+	(
+		cd submodule &&
+		head1=$(git rev-parse --short HEAD) &&
+		echo new >> subfile &&
+		test_tick &&
+		git add subfile &&
+		git commit -m new subfile &&
+		head2=$(git rev-parse --short HEAD) &&
+		echo "From $pwd/submodule" > ../expect.err
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+	)
+}
+
+test_expect_success setup '
+	mkdir submodule &&
+	(
+		cd submodule &&
+		git init &&
+		echo subcontent > subfile &&
+		git add subfile &&
+		git commit -m new subfile
+	) &&
+	git submodule add "$pwd/submodule" submodule &&
+	git commit -am initial &&
+	git clone . downstream &&
+	(
+		cd downstream &&
+		git submodule init &&
+		git submodule update
+	) &&
+	echo "Fetching submodule submodule" > expect.out
+'
+
+test_expect_success "fetch recurses into submodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "fetch --no-recursive only fetches superproject" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --no-recursive >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_done
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 02522f9..6f3e966 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -50,7 +50,7 @@ test_expect_success 'change submodule url' '

 test_expect_success '"git submodule sync" should update submodule URLs' '
 	(cd super-clone &&
-	 git pull &&
+	 git pull --no-recursive &&
 	 git submodule sync
 	) &&
 	test -d "$(git config -f super-clone/submodule/.git/config \
-- 
1.7.2.2.527.gdf3084
