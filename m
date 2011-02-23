From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Wed, 23 Feb 2011 21:34:21 +0100
Message-ID: <4D656F4D.6080401@web.de>
References: <4D656F25.5090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 23 21:35:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsLQI-000750-CX
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 21:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab1BWUet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 15:34:49 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50877 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214Ab1BWUes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 15:34:48 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id B9B7718934F48;
	Wed, 23 Feb 2011 21:34:22 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsLPi-0005TS-00; Wed, 23 Feb 2011 21:34:22 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D656F25.5090007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18hx+lK9jMYaJoTCf+ImTxtaIKCTAV6HhAyIzVq
	lnKdmnqsJ7Bu+c+uKhzdnyu28XBp6BMWi17t27gzMyFLX7L2ba
	GByrxJUHk741OPbdQagA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167722>

To be able to access all commits of populated submodules referenced by the
superproject it is sufficient to only then let "git fetch" recurse into a
submodule when the new commits fetched in the superproject record new
commits for it. Having these commits present is extremely useful when
using the "--submodule" option to "git diff" (which is what "git gui" and
"gitk" do since 1.6.6), as all submodule commits needed for creating a
descriptive output can be accessed. Also merging submodule commits (added
in 1.7.3) depends on the submodule commits in question being present to
work. Last but not least this enables disconnected operation when using
submodules, as all commits necessary for a successful "git submodule
update -N" will have been fetched automatically. So we choose this mode as
the default for fetch and pull.

Before a new or changed ref from upstream is updated in update_local_ref()
"git rev-list <new-sha1> --not --branches --remotes" is used to determine
all newly fetched commits. These are then walked and diffed against their
parent(s) to see if a submodule has been changed. If that is the case, its
path is stored to be fetched after the superproject fetch is completed.

Using the "--recurse-submodules" or the "--no-recurse-submodules" option
disables the examination of the fetched refs because the result will be
ignored anyway.

There is currently no infrastructure for storing deleted and new
submodules in the .git directory of the superproject. Thats why fetch and
pull for now only fetch submodules that are already checked out and are
not renamed.

In t7403 the "--no-recurse-submodules" argument had to be added to "git
pull" to avoid failure because of the moved upstream submodule repo.

Thanks-To: Jonathan Nieder <jrnieder@gmail.com>
Thanks-To: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/fetch-options.txt |    8 +++
 builtin/fetch.c                 |   25 ++++++---
 submodule.c                     |   98 +++++++++++++++++++++++++++++++++--
 submodule.h                     |    9 +++
 t/t5526-fetch-submodules.sh     |  109 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 6 files changed, 235 insertions(+), 16 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f37276e..1d770d9 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -73,6 +73,14 @@ ifndef::git-pull[]
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
 	internally when recursing over submodules.
+
+--submodule-default=[yes|on-demand]::
+	This option is used internally to set the submodule recursion default
+	to either a boolean configuration value representing "true" (for
+	unconditonal recursion) or to "on-demand" (when only those submodules
+	should be fetched of which new commits have been fetched in its
+	superproject).
+	Using the "--[no-]recurse-submodules" option ignores this setting.
 endif::git-pull[]

 -u::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7efecfe..feb9392 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,12 +28,6 @@ enum {
 	TAGS_SET = 2
 };

-enum {
-	RECURSE_SUBMODULES_OFF = 0,
-	RECURSE_SUBMODULES_DEFAULT = 1,
-	RECURSE_SUBMODULES_ON = 2
-};
-
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
 static int progress, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT;
@@ -42,6 +36,7 @@ static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
 static const char *submodule_prefix = "";
+static const char *submodule_default;

 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
@@ -73,6 +68,8 @@ static struct option builtin_fetch_options[] = {
 		   "deepen history of shallow clone"),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "dir",
 		   "prepend this to submodule path output", PARSE_OPT_HIDDEN },
+	{ OPTION_STRING, 0, "submodule-default", &submodule_default, NULL,
+		   "default mode for recursion", PARSE_OPT_HIDDEN },
 	OPT_END()
 };

@@ -284,6 +281,9 @@ static int update_local_ref(struct ref *ref,
 		else {
 			msg = "storing head";
 			what = "[new branch]";
+			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+			    (recurse_submodules != RECURSE_SUBMODULES_ON))
+				check_for_new_submodule_commits(ref->new_sha1);
 		}

 		r = s_update_ref(msg, ref, 0);
@@ -299,6 +299,9 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("fast-forward", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : ' ',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
@@ -310,6 +313,9 @@ static int update_local_ref(struct ref *ref,
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
 		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref("forced-update", ref, 1);
 		sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
 			TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
@@ -949,9 +955,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		const char *options[10];
 		int num_options = 0;
-		/* Set recursion as default when we already are recursing */
-		if (submodule_prefix[0])
-			set_config_fetch_recurse_submodules(1);
+		if (submodule_default) {
+			int arg = parse_fetch_recurse_submodules_arg(submodule_default);
+			set_config_fetch_recurse_submodules(arg);
+		}
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 		add_options_to_argv(&num_options, options);
diff --git a/submodule.c b/submodule.c
index 6f1c107..c8c3a99 100644
--- a/submodule.c
+++ b/submodule.c
@@ -12,7 +12,8 @@
 struct string_list config_name_for_path;
 struct string_list config_fetch_recurse_submodules_for_name;
 struct string_list config_ignore_for_name;
-static int config_fetch_recurse_submodules;
+static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+struct string_list changed_submodule_paths;

 static int add_submodule_odb(const char *path)
 {
@@ -152,6 +153,20 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 		die("bad --ignore-submodules argument: %s", arg);
 }

+int parse_fetch_recurse_submodules_arg(const char *arg)
+{
+	switch (git_config_maybe_bool("", arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "on-demand"))
+			return RECURSE_SUBMODULES_ON_DEMAND;
+		die("bad --recurse-submodules argument: %s", arg);
+	}
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
@@ -248,11 +263,73 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }

+static void submodule_collect_changed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!S_ISGITLINK(p->two->mode))
+			continue;
+
+		if (S_ISGITLINK(p->one->mode)) {
+			/* NEEDSWORK: We should honor the name configured in
+			 * the .gitmodules file of the commit we are examining
+			 * here to be able to correctly follow submodules
+			 * being moved around. */
+			struct string_list_item *path;
+			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
+			if (!path)
+				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
+		} else {
+			/* Submodule is new or was moved here */
+			/* NEEDSWORK: When the .git directories of submodules
+			 * live inside the superprojects .git directory some
+			 * day we should fetch new submodules directly into
+			 * that location too when config or options request
+			 * that so they can be checked out from there. */
+			continue;
+		}
+	}
+}
+
+void check_for_new_submodule_commits(unsigned char new_sha1[20])
+{
+	struct rev_info rev;
+	struct commit *commit;
+	int argc = 5;
+	const char *argv[] = {NULL, NULL, "--not", "--branches", "--remotes", NULL};
+
+	init_revisions(&rev, NULL);
+	argv[1] = xstrdup(sha1_to_hex(new_sha1));
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev))) {
+		struct commit_list *parent = commit->parents;
+		while (parent) {
+			struct diff_options diff_opts;
+			diff_setup(&diff_opts);
+			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
+			diff_opts.format_callback = submodule_collect_changed_cb;
+			if (diff_setup_done(&diff_opts) < 0)
+				die("diff_setup_done failed");
+			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
+			diffcore_std(&diff_opts);
+			diff_flush(&diff_opts);
+			parent = parent->next;
+		}
+	}
+	free((char *)argv[1]);
+}
+
 int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int ignore_config,
 			       int quiet)
 {
-	int i, result = 0, argc = 0;
+	int i, result = 0, argc = 0, default_argc;
 	struct child_process cp;
 	const char **argv;
 	struct string_list_item *name_for_path;
@@ -264,11 +341,13 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (read_cache() < 0)
 			die("index file corrupt");

-	/* 4: "fetch" (options) "--submodule-prefix" prefix NULL */
-	argv = xcalloc(num_options + 4, sizeof(const char *));
+	/* 6: "fetch" (options) --submodule-default default "--submodule-prefix" prefix NULL */
+	argv = xcalloc(num_options + 6, sizeof(const char *));
 	argv[argc++] = "fetch";
 	for (i = 0; i < num_options; i++)
 		argv[argc++] = options[i];
+	argv[argc++] = "--submodule-default";
+	default_argc = argc++;
 	argv[argc++] = "--submodule-prefix";

 	memset(&cp, 0, sizeof(cp));
@@ -282,7 +361,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		struct cache_entry *ce = active_cache[i];
-		const char *git_dir, *name;
+		const char *git_dir, *name, *default_argv;

 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
@@ -292,6 +371,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (name_for_path)
 			name = name_for_path->util;

+		default_argv = "yes";
 		if (!ignore_config) {
 			struct string_list_item *fetch_recurse_submodules_option;
 			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
@@ -299,8 +379,13 @@ int fetch_populated_submodules(int num_options, const char **options,
 				if (!fetch_recurse_submodules_option->util)
 					continue;
 			} else {
-				if (!config_fetch_recurse_submodules)
+				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF)
 					continue;
+				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
+					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+						continue;
+					default_argv = "on-demand";
+				}
 			}
 		}

@@ -314,6 +399,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 			if (!quiet)
 				printf("Fetching submodule %s%s\n", prefix, ce->name);
 			cp.dir = submodule_path.buf;
+			argv[default_argc] = default_argv;
 			argv[argc] = submodule_prefix.buf;
 			if (run_command(&cp))
 				result = 1;
diff --git a/submodule.h b/submodule.h
index 4729023..aca023a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,17 +3,26 @@

 struct diff_options;

+enum {
+	RECURSE_SUBMODULES_ON_DEMAND = -1,
+	RECURSE_SUBMODULES_OFF = 0,
+	RECURSE_SUBMODULES_DEFAULT = 1,
+	RECURSE_SUBMODULES_ON = 2
+};
+
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config();
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
+int parse_fetch_recurse_submodules_arg(const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
+void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(int num_options, const char **options,
 			       const char *prefix, int ignore_config,
 			       int quiet);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a5f4585..6d92f7a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -192,4 +192,113 @@ test_expect_success "--no-recurse-submodules overrides config setting" '
 	! test -s actual.err
 '

+test_expect_success "Recursion doesn't happen when no new commits are fetched in the superproject" '
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git config --unset fetch.recurseSubmodules
+		) &&
+		git config --unset fetch.recurseSubmodules
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "Recursion stops when no new submodule commits are fetched" '
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "Fetching submodule submodule" > expect.out.sub &&
+	echo "From $pwd/." > expect.err.sub &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub
+	head -2 expect.err >> expect.err.sub &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.err.sub actual.err &&
+	test_cmp expect.out.sub actual.out
+'
+
+test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
+	add_upstream_commit &&
+	head1=$(git rev-parse --short HEAD) &&
+	echo a > file &&
+	git add file &&
+	git commit -m "new file" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.file &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	test_cmp expect.err.file actual.err
+'
+
+test_expect_success "Recursion picks up config in submodule" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules &&
+		(
+			cd submodule &&
+			git config fetch.recurseSubmodules true
+		)
+	) &&
+	add_upstream_commit &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.sub &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.sub &&
+	cat expect.err >> expect.err.sub &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err &&
+		(
+			cd submodule &&
+			git config --unset fetch.recurseSubmodules
+		)
+	) &&
+	test_cmp expect.err.sub actual.err &&
+	test_cmp expect.out actual.out
+'
+
+test_expect_success "Recursion picks up all submodules when necessary" '
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		head1=$(git rev-parse --short HEAD^) &&
+		git add deepsubmodule &&
+		git commit -m "new deepsubmodule"
+		head2=$(git rev-parse --short HEAD) &&
+		echo "From $pwd/submodule" > ../expect.err.sub &&
+		echo "   $head1..$head2  master     -> origin/master" >> ../expect.err.sub
+	) &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.2 &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2 &&
+	cat expect.err.sub >> expect.err.2 &&
+	tail -2 expect.err >> expect.err.2 &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.err.2 actual.err &&
+	test_cmp expect.out actual.out
+'
+
 test_done
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index e5b1953..d600583 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -52,7 +52,7 @@ test_expect_success 'change submodule url' '

 test_expect_success '"git submodule sync" should update submodule URLs' '
 	(cd super-clone &&
-	 git pull &&
+	 git pull --no-recurse-submodules &&
 	 git submodule sync
 	) &&
 	test -d "$(git config -f super-clone/submodule/.git/config \
-- 
1.7.4.1.190.g13e20
