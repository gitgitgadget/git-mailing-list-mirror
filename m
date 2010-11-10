From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Thu, 11 Nov 2010 00:55:02 +0100
Message-ID: <4CDB30D6.5040302@web.de>
References: <4CDB3063.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 00:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGKY7-0002ll-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 00:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561Ab0KJX5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 18:57:50 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:46968 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0KJX5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 18:57:49 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id CAAE518166A0A;
	Thu, 11 Nov 2010 00:55:02 +0100 (CET)
Received: from [93.246.41.165] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGKVK-00005r-00; Thu, 11 Nov 2010 00:55:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CDB3063.5010801@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/pktg+Pl3qQ6uNI7yRKBCJu7FNhQ5RN0UeQupY
	4FrmB3NpQcZCDsP87+f+LAeLq7/nMssjyQ3XIcJM598BDv59Bh
	6lHLY1WehxXTYlcaqwSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161196>

This new boolean option can be used to override the default for "git
fetch" and "git pull", which is to not recurse into populated submodules
and fetch all new commits there too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt        |    5 +++++
 Documentation/fetch-options.txt |    5 +++--
 builtin/fetch.c                 |   21 ++++++++++++++++-----
 git-pull.sh                     |    3 +++
 submodule.c                     |   18 +++++++++++++++++-
 submodule.h                     |    4 +++-
 t/t5526-fetch-submodules.sh     |   36 ++++++++++++++++++++++++++++++++++++
 7 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 538ebb5..453c1eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -879,6 +879,11 @@ diff.wordRegex::
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.

+fetch.recurseSubmodules::
+	A boolean value which changes the behavior for fetch and pull, the
+	default is to not recursively fetch populated sumodules unless
+	configured otherwise.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index bd36466..6aea5f6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -66,8 +66,9 @@ ifndef::git-pull[]
 	linkgit:git-config[1].
 endif::git-pull[]

---recurse-submodules::
-	Use this option to fetch new commits of all populated submodules too.
+--[no-]recurse-submodules::
+	This option controls if new commits of all populated submodules should
+	be fetched too (see linkgit:git-config[1]).

 ifndef::git-pull[]
 --submodule-prefix::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 658bb4c..eb2296d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,8 +28,14 @@ enum {
 	TAGS_SET = 2
 };

+enum {
+	RECURSE_SUBMODULES_OFF = 0,
+	RECURSE_SUBMODULES_DEFAULT = 1,
+	RECURSE_SUBMODULES_ON = 2
+};
+
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
-static int progress, recurse_submodules;
+static int progress, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -55,8 +61,9 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
-	OPT_BOOLEAN(0, "recurse-submodules", &recurse_submodules,
-		    "control recursive fetching of submodules"),
+	OPT_SET_INT(0, "recurse-submodules", &recurse_submodules,
+		    "control recursive fetching of submodules",
+		    RECURSE_SUBMODULES_ON),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -802,7 +809,7 @@ static void add_options_to_argv(int *argc, const char **argv)
 		argv[(*argc)++] = "--force";
 	if (keep)
 		argv[(*argc)++] = "--keep";
-	if (recurse_submodules)
+	if (recurse_submodules == RECURSE_SUBMODULES_ON)
 		argv[(*argc)++] = "--recurse-submodules";
 	if (verbosity >= 2)
 		argv[(*argc)++] = "-v";
@@ -940,14 +947,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}

-	if (!result && recurse_submodules) {
+	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		const char *options[10];
 		int num_options = 0;
+		/* Set recursion as default when we already are recursing */
+		if (submodule_prefix[0])
+			set_config_fetch_recurse_submodules(1);
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 		add_options_to_argv(&num_options, options);
 		result = fetch_populated_submodules(num_options, options,
 						    submodule_prefix,
+						    recurse_submodules == RECURSE_SUBMODULES_ON,
 						    verbosity < 0);
 	}

diff --git a/git-pull.sh b/git-pull.sh
index 5804c62..a5ab195 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -108,6 +108,9 @@ do
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
 		;;
+	--no-recurse-submodules)
+		recurse_submodules=--no-recurse-submodules
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
diff --git a/submodule.c b/submodule.c
index 4d9b774..01d75f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -11,6 +11,7 @@

 struct string_list config_name_for_path;
 struct string_list config_ignore_for_name;
+static int config_fetch_recurse_submodules;

 static int add_submodule_odb(const char *path)
 {
@@ -67,6 +68,10 @@ int submodule_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
+	else if (!strcmp(var, "fetch.recursesubmodules")) {
+		config_fetch_recurse_submodules = git_config_bool(var, value);
+		return 0;
+	}
 	return 0;
 }

@@ -229,8 +234,14 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

+void set_config_fetch_recurse_submodules(int value)
+{
+	config_fetch_recurse_submodules = value;
+}
+
 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int quiet)
+			       const char *prefix, int ignore_config,
+			       int quiet)
 {
 	int i, result = 0, argc = 0;
 	struct child_process cp;
@@ -271,6 +282,11 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (name_for_path)
 			name = name_for_path->util;

+		if (!ignore_config) {
+			if (!config_fetch_recurse_submodules)
+				continue;
+		}
+
 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
diff --git a/submodule.h b/submodule.h
index b39d7a1..4729023 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,8 +13,10 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
+void set_config_fetch_recurse_submodules(int value);
 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int quiet);
+			       const char *prefix, int ignore_config,
+			       int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 107317a..69ed3e2 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -106,4 +106,40 @@ test_expect_success "--dry-run propagates to submodules" '
 	test_cmp expect.err actual.err
 '

+test_expect_success "recurseSubmodules=true propagates into submodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git config fetch.recurseSubmodules true
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "--recurse-submodules overrides config in submodule" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git config fetch.recurseSubmodules false
+		) &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "--no-recurse-submodules overrides config setting" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git config fetch.recurseSubmodules true
+		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
 test_done
-- 
1.7.3.2.337.g9376c
