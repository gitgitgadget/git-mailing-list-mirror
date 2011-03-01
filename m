From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/7] fetch/pull: Add the 'on-demand' value to the --recurse-submodules
 option
Date: Wed, 02 Mar 2011 00:01:46 +0100
Message-ID: <4D6D7ADA.6090302@web.de>
References: <4D6D7A50.5090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYZm-0001CI-6M
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 00:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab1CAXBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 18:01:49 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:44228 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600Ab1CAXBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 18:01:48 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 32A8E18A51E8D;
	Wed,  2 Mar 2011 00:01:47 +0100 (CET)
Received: from [93.240.102.247] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PuYZe-0001Mf-00; Wed, 02 Mar 2011 00:01:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D6D7A50.5090802@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18AD7YBGYHYdtSQImNVSjDl41DbRBfsz41FEZD5
	PXZ86kEMi3a/GRVXUCiRmlToD6Zh71XHV0CB8bskyGzMVzQMxI
	U+M/vtbCBnF7cGRqAQvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168275>

Until now the --recurse-submodules option could only be used to either
fetch all populated submodules recursively or to disable recursion
completely. As fetch and pull now by default just fetch those submodules
for which new commits have been fetched in the superproject, a command
line option to enforce that behavior is needed to be able to override
configuration settings.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/fetch-options.txt |   16 +++++++--
 Documentation/git-pull.txt      |    2 +-
 builtin/fetch.c                 |   22 ++++++++++--
 git-pull.sh                     |    3 ++
 submodule.c                     |    8 +++-
 submodule.h                     |    2 +-
 t/t5526-fetch-submodules.sh     |   71 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index ae22f75..f28c0b1 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -65,9 +65,19 @@ ifndef::git-pull[]
 	specified with the remote.<name>.tagopt setting. See
 	linkgit:git-config[1].

---[no-]recurse-submodules::
-	This option controls if new commits of all populated submodules should
-	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
+--recurse-submodules[=yes|on-demand|no]::
+	This option controls if and under what conditions new commits of all
+	populated submodules should be fetched too. It can be used as a
+	boolean option to completely disable recursion when set to 'no' or to
+	unconditionally recurse into all populated submodules when set to
+	'yes', which is the default when this option is used without any
+	value. If 'on-demand' is used, it will only recurse into those
+	submodules where new commits have been fetched in the superproject
+	(also see linkgit:git-config[1] and linkgit:gitmodules[5]).
+
+--no-recurse-submodules::
+	Disable recursive fetching of submodules (this has the same effect as
+	using the '--recurse-submodules=no' option).

 --submodule-prefix=<path>::
 	Prepend <path> to paths printed in informative messages
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index b33e6be..c45efb3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -84,7 +84,7 @@ must be given before the options meant for 'git fetch'.
 --verbose::
 	Pass --verbose to git-fetch and git-merge.

---[no-]recurse-submodules::
+--[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of all populated submodules should
 	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
 	That might be necessary to get the data needed for merging submodule
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55d6b1a..7d24e47 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -38,6 +38,20 @@ static struct transport *transport;
 static const char *submodule_prefix = "";
 static const char *submodule_default;

+static int option_parse_recurse_submodules(const struct option *opt,
+				   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+	} else {
+		if (arg)
+			recurse_submodules = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
+		else
+			recurse_submodules = RECURSE_SUBMODULES_ON;
+	}
+	return 0;
+}
+
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "all", &all,
@@ -55,9 +69,9 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune remote-tracking branches no longer on remote"),
-	OPT_SET_INT(0, "recurse-submodules", &recurse_submodules,
+	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, "on-demand",
 		    "control recursive fetching of submodules",
-		    RECURSE_SUBMODULES_ON),
+		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -816,6 +830,8 @@ static void add_options_to_argv(int *argc, const char **argv)
 		argv[(*argc)++] = "--keep";
 	if (recurse_submodules == RECURSE_SUBMODULES_ON)
 		argv[(*argc)++] = "--recurse-submodules";
+	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		argv[(*argc)++] = "--recurse-submodules=on-demand";
 	if (verbosity >= 2)
 		argv[(*argc)++] = "-v";
 	if (verbosity >= 1)
@@ -964,7 +980,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		add_options_to_argv(&num_options, options);
 		result = fetch_populated_submodules(num_options, options,
 						    submodule_prefix,
-						    recurse_submodules == RECURSE_SUBMODULES_ON,
+						    recurse_submodules,
 						    verbosity < 0);
 	}

diff --git a/git-pull.sh b/git-pull.sh
index 86517e9..7a97d8e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -108,6 +108,9 @@ do
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
 		;;
+	--recurse-submodules=*)
+		recurse_submodules="$1"
+		;;
 	--no-recurse-submodules)
 		recurse_submodules=--no-recurse-submodules
 		;;
diff --git a/submodule.c b/submodule.c
index 8f991ce..86a99af 100644
--- a/submodule.c
+++ b/submodule.c
@@ -330,7 +330,7 @@ void check_for_new_submodule_commits(unsigned char new_sha1[20])
 }

 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int ignore_config,
+			       const char *prefix, int command_line_option,
 			       int quiet)
 {
 	int i, result = 0, argc = 0, default_argc;
@@ -376,7 +376,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 			name = name_for_path->util;

 		default_argv = "yes";
-		if (!ignore_config) {
+		if (command_line_option == RECURSE_SUBMODULES_DEFAULT) {
 			struct string_list_item *fetch_recurse_submodules_option;
 			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
 			if (fetch_recurse_submodules_option) {
@@ -391,6 +391,10 @@ int fetch_populated_submodules(int num_options, const char **options,
 					default_argv = "on-demand";
 				}
 			}
+		} else if (command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
+			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+				continue;
+			default_argv = "on-demand";
 		}

 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
diff --git a/submodule.h b/submodule.h
index 3434a8e..5350b0d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -24,7 +24,7 @@ void show_submodule_summary(FILE *f, const char *path,
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int ignore_config,
+			       const char *prefix, int command_line_option,
 			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6d92f7a..4cd723c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -301,4 +301,75 @@ test_expect_success "Recursion picks up all submodules when necessary" '
 	test_cmp expect.out actual.out
 '

+test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no new commits are fetched in the superproject (and ignores config)" '
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
+	(
+		cd downstream &&
+		git config fetch.recurseSubmodules true &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
+		git config --unset fetch.recurseSubmodules
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	tail -2 expect.err > expect.err.deepsub &&
+	echo "From $pwd/." > expect.err &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err
+	cat expect.err.sub >> expect.err &&
+	cat expect.err.deepsub >> expect.err &&
+	(
+		cd downstream &&
+		git config fetch.recurseSubmodules false &&
+		(
+			cd submodule &&
+			git config -f .gitmodules submodule.deepsubmodule.fetchRecursive false
+		) &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
+		git config --unset fetch.recurseSubmodules
+		(
+			cd submodule &&
+			git config --unset -f .gitmodules submodule.deepsubmodule.fetchRecursive
+		)
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
+	add_upstream_commit &&
+	head1=$(git rev-parse --short HEAD) &&
+	echo a >> file &&
+	git add file &&
+	git commit -m "new file" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.file &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.file &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	test_cmp expect.err.file actual.err
+'
+
 test_done
-- 
1.7.4.1.291.g6060
