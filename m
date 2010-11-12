From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 12 Nov 2010 13:54:52 +0100
Message-ID: <4CDD391C.2000905@web.de>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 14:20:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGtYQ-0002Vz-Jv
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 14:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551Ab0KLNUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 08:20:31 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:36429 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757539Ab0KLNUa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 08:20:30 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id AAB4F17192061;
	Fri, 12 Nov 2010 13:54:53 +0100 (CET)
Received: from [93.246.52.137] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGt9Z-0005SS-00; Fri, 12 Nov 2010 13:54:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101111000538.GB14189@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19aaSR5aK3QOl7rUYNZDf2+cd0HEGVmHgazt1TY
	GgUNs12iHtJ7q6B2odqg0grXNRDVrt5r5THMXuJTbimKi348xO
	+ROU+iefk96sE9TCGaYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161341>

Until now you had to call "git submodule update" (without -N|--no-fetch
option) or something like "git submodule foreach git fetch" to fetch
new commits in populated submodules from their remote.

This could lead to "(commits not present)" messages in the output of
"git diff --submodule" (which is used by "git gui" and "gitk") after
fetching or pulling new commits in the superproject and is an obstacle for
implementing recursive checkout of submodules. Also "git submodule
update" cannot fetch changes when disconnected, so it was very easy to
forget to fetch the submodule changes before disconnecting only to
discover later that they are needed.

This patch adds the "--recurse-submodules" option to recursively fetch
each populated submodule from the url configured in the .git/config of the
submodule at the end of each "git fetch" or during "git pull" in the
superproject. The submodule paths are taken from the index.

The hidden option "--submodule-prefix" is added to "git fetch" to be able
to print out the full paths of nested submodules.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 11.11.2010 01:05, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> * Should the "--submodule-prefix" option - which is only used internally
>>   now - be a hidden option to "git fetch"?
> 
> Yes.  (Any option that is useless outside scripts should be, imho.)

Ok, here is the updated version of patch 1/3 making "--submodule-prefix" a
hidden option which is not documented in Documentation/fetch-options.txt .


 Documentation/fetch-options.txt |    3 +
 builtin/fetch.c                 |   53 ++++++++++++++-----
 git-pull.sh                     |    7 ++-
 submodule.c                     |   66 +++++++++++++++++++++++-
 submodule.h                     |    3 +
 t/t5526-fetch-submodules.sh     |  109 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 224 insertions(+), 17 deletions(-)
 create mode 100755 t/t5526-fetch-submodules.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 5ce1e72..85b7f84 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -66,6 +66,9 @@ ifndef::git-pull[]
 	linkgit:git-config[1].
 endif::git-pull[]

+--recurse-submodules::
+	Use this option to fetch new commits of all populated submodules too.
+
 -u::
 --update-head-ok::
 	By default 'git fetch' refuses to update the head which
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d35f000..db3fba3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "sigchain.h"
 #include "transport.h"
+#include "submodule.h"

 static const char * const builtin_fetch_usage[] = {
 	"git fetch [<options>] [<repository> [<refspec>...]]",
@@ -28,12 +29,13 @@ enum {
 };

 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
-static int progress;
+static int progress, recurse_submodules;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static const char *submodule_prefix = "";

 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
@@ -53,6 +55,8 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
+	OPT_BOOLEAN(0, "recurse-submodules", &recurse_submodules,
+		    "control recursive fetching of submodules"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -61,6 +65,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
+	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "DIR",
+		   "prepend this to submodule path output", PARSE_OPT_HIDDEN },
 	OPT_END()
 };

@@ -784,28 +790,36 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 	return 1;
 }

-static int fetch_multiple(struct string_list *list)
+static void add_options_to_argv(int *argc, const char **argv)
 {
-	int i, result = 0;
-	const char *argv[11] = { "fetch", "--append" };
-	int argc = 2;
-
 	if (dry_run)
-		argv[argc++] = "--dry-run";
+		argv[(*argc)++] = "--dry-run";
 	if (prune)
-		argv[argc++] = "--prune";
+		argv[(*argc)++] = "--prune";
 	if (update_head_ok)
-		argv[argc++] = "--update-head-ok";
+		argv[(*argc)++] = "--update-head-ok";
 	if (force)
-		argv[argc++] = "--force";
+		argv[(*argc)++] = "--force";
 	if (keep)
-		argv[argc++] = "--keep";
+		argv[(*argc)++] = "--keep";
+	if (recurse_submodules)
+		argv[(*argc)++] = "--recurse-submodules";
 	if (verbosity >= 2)
-		argv[argc++] = "-v";
+		argv[(*argc)++] = "-v";
 	if (verbosity >= 1)
-		argv[argc++] = "-v";
+		argv[(*argc)++] = "-v";
 	else if (verbosity < 0)
-		argv[argc++] = "-q";
+		argv[(*argc)++] = "-q";
+
+}
+
+static int fetch_multiple(struct string_list *list)
+{
+	int i, result = 0;
+	const char *argv[12] = { "fetch", "--append" };
+	int argc = 2;
+
+	add_options_to_argv(&argc, argv);

 	if (!append && !dry_run) {
 		int errcode = truncate_fetch_head();
@@ -926,6 +940,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}

+	if (!result && recurse_submodules) {
+		const char *options[10];
+		int num_options = 0;
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		add_options_to_argv(&num_options, options);
+		result = fetch_populated_submodules(num_options, options,
+						    submodule_prefix,
+						    verbosity < 0);
+	}
+
 	/* All names were strdup()ed or strndup()ed */
 	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
diff --git a/git-pull.sh b/git-pull.sh
index 8eb74d4..5804c62 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge

 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress=
+log_arg= verbosity= progress= recurse_submodules=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
@@ -105,6 +105,9 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	--recurse-submodules)
+		recurse_submodules=--recurse-submodules
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
@@ -220,7 +223,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0

 curr_head=$(git rev-parse -q --verify HEAD)
diff --git a/submodule.c b/submodule.c
index 91a4758..4d9b774 100644
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
@@ -229,6 +229,70 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

+int fetch_populated_submodules(int num_options, const char **options,
+			       const char *prefix, int quiet)
+{
+	int i, result = 0, argc = 0;
+	struct child_process cp;
+	const char **argv;
+	struct string_list_item *name_for_path;
+	const char *work_tree = get_git_work_tree();
+	if (!work_tree)
+		return 0;
+
+	if (!the_index.initialized)
+		if (read_cache() < 0)
+			die("index file corrupt");
+
+	argv = xcalloc(num_options + 5, sizeof(const char *));
+	argv[argc++] = "fetch";
+	for (i = 0; i < num_options; i++)
+		argv[argc++] = options[i];
+	argv[argc++] = "--submodule-prefix";
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+
+	for (i = 0; i < active_nr; i++) {
+		struct strbuf submodule_path = STRBUF_INIT;
+		struct strbuf submodule_git_dir = STRBUF_INIT;
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		struct cache_entry *ce = active_cache[i];
+		const char *git_dir, *name;
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		name = ce->name;
+		name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
+		if (name_for_path)
+			name = name_for_path->util;
+
+		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
+		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
+		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
+		git_dir = read_gitfile_gently(submodule_git_dir.buf);
+		if (!git_dir)
+			git_dir = submodule_git_dir.buf;
+		if (is_directory(git_dir)) {
+			if (!quiet)
+				printf("Fetching submodule %s%s\n", prefix, ce->name);
+			cp.dir = submodule_path.buf;
+			argv[argc] = submodule_prefix.buf;
+			if (run_command(&cp))
+				result = 1;
+		}
+		strbuf_release(&submodule_path);
+		strbuf_release(&submodule_git_dir);
+		strbuf_release(&submodule_prefix);
+	}
+	free(argv);
+	return result;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
diff --git a/submodule.h b/submodule.h
index 386f410..b39d7a1 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,7 @@ struct diff_options;

 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
+int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config();
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
@@ -12,6 +13,8 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
+int fetch_populated_submodules(int num_options, const char **options,
+			       const char *prefix, int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
new file mode 100755
index 0000000..107317a
--- /dev/null
+++ b/t/t5526-fetch-submodules.sh
@@ -0,0 +1,109 @@
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
+		echo "From $pwd/submodule" > ../expect.err &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+	)
+	(
+		cd deepsubmodule &&
+		head1=$(git rev-parse --short HEAD) &&
+		echo new >> deepsubfile &&
+		test_tick &&
+		git add deepsubfile &&
+		git commit -m new deepsubfile &&
+		head2=$(git rev-parse --short HEAD) &&
+		echo "From $pwd/deepsubmodule" >> ../expect.err &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err
+	)
+}
+
+test_expect_success setup '
+	mkdir deepsubmodule &&
+	(
+		cd deepsubmodule &&
+		git init &&
+		echo deepsubcontent > deepsubfile &&
+		git add deepsubfile &&
+		git commit -m new deepsubfile
+	) &&
+	mkdir submodule &&
+	(
+		cd submodule &&
+		git init &&
+		echo subcontent > subfile &&
+		git add subfile &&
+		git submodule add "$pwd/deepsubmodule" deepsubmodule &&
+		git commit -a -m new
+	) &&
+	git submodule add "$pwd/submodule" submodule &&
+	git commit -am initial &&
+	git clone . downstream &&
+	(
+		cd downstream &&
+		git submodule update --init --recursive
+	) &&
+	echo "Fetching submodule submodule" > expect.out &&
+	echo "Fetching submodule submodule/deepsubmodule" >> expect.out
+'
+
+test_expect_success "fetch --recurse-submodules recurses into submodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "fetch alone only fetches superproject" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "--quiet propagates to submodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules --quiet >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "--dry-run propagates to submodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_done
-- 
1.7.3.2.335.g2e3006
