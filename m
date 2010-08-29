From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] Submodules: Add the new "fetch" config option
Date: Sun, 29 Aug 2010 17:51:12 +0200
Message-ID: <4C7A81F0.4090209@web.de>
References: <4C7A819B.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 17:51:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpkAB-000319-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0H2PvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:51:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33120 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0H2PvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:51:14 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 192FB166D952B;
	Sun, 29 Aug 2010 17:51:13 +0200 (CEST)
Received: from [93.246.33.247] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OpkA4-0007OY-00; Sun, 29 Aug 2010 17:51:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7A819B.3000403@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19TFtITMmyp9Fq0nIGmEXcn8VgHSBURMHIT+LUY
	F7FF31Eej4iPwQo/Q18MA0HL9YksuWX6KT+EQ/YiWYWEXmrx1w
	N/2hgrHayVVuZ2zuhY1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154696>

The new boolean "fetch" config option controls the default behavior for
"git fetch" and "git pull". It specifies if these commands should recurse
into submodules and fetch new commits there too and can be set separately
for each submodule.

The .gitmodules file is parsed for "submodule.<name>.fetch" entries before
looking for them in .git/config. Thus settings found in .git/config will
override those from .gitmodules, thereby allowing the local developer to
ignore settings given by the remote side while also letting upstream set
defaults for those users who don't have special needs.

This configuration can be overridden by the command line option
"--[no-]recursive" of "git fetch" and "git pull".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt        |    6 +++++
 Documentation/fetch-options.txt |    3 +-
 Documentation/gitmodules.txt    |    8 +++++++
 builtin/fetch.c                 |   14 +++++++++---
 submodule.c                     |   19 +++++++++++++++++-
 submodule.h                     |    2 +-
 t/t5526-fetch-submodules.sh     |   40 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0510ac7..048465f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1769,6 +1769,12 @@ submodule.<name>.update::
 	URL and other values found in the `.gitmodules` file.  See
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.

+submodule.<name>.fetch::
+	A boolean to enable/disable recursive fetching of this submodule. It can
+	be overriden by using the --[no-]recursive command line option to "git
+	fetch" and "git pull".	This setting overrides any setting made in
+	.gitmodules for this submodule.
+
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 1d875be..aff4daf 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -67,7 +67,8 @@ endif::git-pull[]
 --[no-]recursive::
 	By default new commits of all populated submodules will be fetched
 	too. This option can be used to disable/enable recursive fetching of
-	submodules.
+	submodules regardless of the 'fetch' configuration setting (see
+	linkgit:git-config[1] or linkgit:gitmodules[5]).

 -u::
 --update-head-ok::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index bcffd95..febfef4 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -44,6 +44,14 @@ submodule.<name>.update::
 	This config option is overridden if 'git submodule update' is given
 	the '--merge' or '--rebase' options.

+submodule.<name>.fetch::
+	A boolean to enable/disable recursive fetching of this submodule.
+	If this option is also present in the submodules entry in .git/config of
+	the superproject, the setting there will override the one found in
+	.gitmodules.
+	Both settings can be overriden on the command line by using the
+	"--[no-]recursive" option to "git fetch" and "git pull"..
+
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
diff --git a/builtin/fetch.c b/builtin/fetch.c
index da5fc9a..17759b5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,7 +28,13 @@ enum {
 	TAGS_SET = 2
 };

-static int all, append, dry_run, force, keep, multiple, prune, recursive = -1, update_head_ok, verbosity;
+enum {
+	RECURSIVE_UNSET = 0,
+	RECURSIVE_DEFAULT = 1,
+	RECURSIVE_SET = 2
+};
+
+static int all, append, dry_run, force, keep, multiple, prune, recursive = RECURSIVE_DEFAULT, update_head_ok, verbosity;
 static int progress;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
@@ -54,8 +60,8 @@ static struct option builtin_fetch_options[] = {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
-	OPT_BOOLEAN(0, "recursive", &recursive,
-		    "control recursive fetching of submodules"),
+	OPT_SET_INT(0, "recursive", &recursive,
+		    "control recursive fetching of submodules", RECURSIVE_SET),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
@@ -927,7 +933,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!result && recursive) {
 		gitmodules_config();
 		git_config(submodule_config, NULL);
-		result = fetch_populated_submodules();
+		result = fetch_populated_submodules(recursive == RECURSIVE_SET);
 	}

 	/* All names were strdup()ed or strndup()ed */
diff --git a/submodule.c b/submodule.c
index e4f2419..8c98fad 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,6 +10,7 @@
 #include "string-list.h"

 struct string_list config_name_for_path;
+struct string_list config_fetch_for_name;
 struct string_list config_ignore_for_name;

 static int add_submodule_odb(const char *path)
@@ -100,6 +101,14 @@ int parse_submodule_config_option(const char *var, const char *value)
 			config = string_list_append(&config_name_for_path, xstrdup(value));
 		config->util = strbuf_detach(&submodname, NULL);
 		strbuf_release(&submodname);
+	} else if ((len > 5) && !strcmp(var + len - 6, ".fetch")) {
+		strbuf_add(&submodname, var, len - 6);
+		config = unsorted_string_list_lookup(&config_fetch_for_name, submodname.buf);
+		if (!config)
+			config = string_list_append(&config_fetch_for_name,
+						    strbuf_detach(&submodname, NULL));
+		config->util = (void *)git_config_bool(var, value);
+		strbuf_release(&submodname);
 	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
@@ -229,7 +238,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

-int fetch_populated_submodules()
+int fetch_populated_submodules(int forced)
 {
 	int result = 0;
 	struct child_process cp;
@@ -253,6 +262,14 @@ int fetch_populated_submodules()
 		struct strbuf submodule_path = STRBUF_INIT;
 		struct strbuf submodule_git_dir = STRBUF_INIT;
 		const char *git_dir;
+
+		if (!forced) {
+			struct string_list_item *fetch_option;
+			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name_for_path->util);
+			if (fetch_option && !fetch_option->util)
+				continue;
+		}
+
 		strbuf_addf(&submodule_path, "%s/%s", work_tree, name_for_path->string);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		git_dir = read_gitfile_gently(submodule_git_dir.buf);
diff --git a/submodule.h b/submodule.h
index 380878c..9e6257e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,7 +13,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
-int fetch_populated_submodules();
+int fetch_populated_submodules(int forced);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index da5d5fd..489ef1a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -52,6 +52,46 @@ test_expect_success "fetch recurses into submodules" '
 '

 test_expect_success "fetch --no-recursive only fetches superproject" '
+	(
+		cd downstream &&
+		git fetch --no-recursive >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "using fetch=false in .gitmodules only fetches superproject" '
+	(
+		cd downstream &&
+		git config -f .gitmodules submodule.submodule.fetch false &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "--recursive overrides .gitmodules config" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recursive >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "using fetch=true in .git/config overrides setting in .gitmodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git config submodule.submodule.fetch true &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "--no-recursive overrides fetch setting from .git/config" '
 	add_upstream_commit &&
 	(
 		cd downstream &&
-- 
1.7.2.2.527.gdf3084
