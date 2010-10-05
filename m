From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/3] Submodules: Add the new "fetch" config option for fetch
 and pull
Date: Tue, 05 Oct 2010 22:44:35 +0200
Message-ID: <4CAB8E33.1030208@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ENQ-0007Ij-5m
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab0JEUoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:44:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38217 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab0JEUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:44:37 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0F3F1174FF6A1;
	Tue,  5 Oct 2010 22:44:36 +0200 (CEST)
Received: from [93.246.38.65] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P3ENH-0001jV-00; Tue, 05 Oct 2010 22:44:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CAB8DDF.8080004@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18fsjGaJmEScMRtAOWJaj0mNebRRvgT4mzCH5ve
	2+SEW0crZg/pDP9mSEcpfzXU7ClfoK336j+d3VLwxJ4hRjwIhd
	WXOflOjLXM0096VYuLoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158241>

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
 Documentation/config.txt        |    6 ++++
 Documentation/fetch-options.txt |    3 +-
 Documentation/gitmodules.txt    |    8 ++++++
 builtin/fetch.c                 |   13 +++++++--
 submodule.c                     |   20 +++++++++++++-
 submodule.h                     |    2 +-
 t/t5526-fetch-submodules.sh     |   54 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 69d91fa..bc9b768 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1791,6 +1791,12 @@ submodule.<name>.update::
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
index 4eb8c90..f238e3c 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -67,7 +67,8 @@ endif::git-pull[]
 --[no-]recursive::
 	By default new commits of all populated submodules will be fetched
 	too. This option can be used to disable/enable recursive fetching of
-	submodules.
+	submodules regardless of the 'fetch' configuration setting (see
+	linkgit:git-config[1] or linkgit:gitmodules[5]).

 ifndef::git-pull[]
 --submodule-prefix::
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
index d41f8cc..d20d022 100644
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
@@ -55,8 +61,8 @@ static struct option builtin_fetch_options[] = {
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
@@ -946,6 +952,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		add_options_to_argv(&num_options, options);
 		result = fetch_populated_submodules(num_options, options,
 						    submodule_prefix,
+						    recursive == RECURSIVE_SET,
 						    verbosity < 0);
 	}

diff --git a/submodule.c b/submodule.c
index 4d9b774..e4437b4 100644
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
+		config->util = git_config_bool(var, value) ? (void *)1 : NULL;
+		strbuf_release(&submodname);
 	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
@@ -230,7 +239,7 @@ void show_submodule_summary(FILE *f, const char *path,
 }

 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int quiet)
+			       const char *prefix, int forced, int quiet)
 {
 	int i, result = 0, argc = 0;
 	struct child_process cp;
@@ -248,6 +257,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 	argv[argc++] = "fetch";
 	for (i = 0; i < num_options; i++)
 		argv[argc++] = options[i];
+	if (forced)
+		argv[argc++] = "--recursive";
 	argv[argc++] = "--submodule-prefix";

 	memset(&cp, 0, sizeof(cp));
@@ -271,6 +282,13 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (name_for_path)
 			name = name_for_path->util;

+		if (!forced) {
+			struct string_list_item *fetch_option;
+			fetch_option = unsorted_string_list_lookup(&config_fetch_for_name, name);
+			if (fetch_option && !fetch_option->util)
+				continue;
+		}
+
 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
 		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", prefix, ce->name);
diff --git a/submodule.h b/submodule.h
index b39d7a1..08b422a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -14,7 +14,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 int fetch_populated_submodules(int num_options, const char **options,
-			       const char *prefix, int quiet);
+			       const char *prefix, int forced, int quiet);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index e0230a2..f4e3157 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -72,6 +72,46 @@ test_expect_success "fetch recurses into submodules" '
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
@@ -106,4 +146,18 @@ test_expect_success "--dry-run propagates to submodules" '
 	test_cmp expect.err actual.err
 '

+test_expect_success "--recursive propagates to submodules" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		(
+			cd submodule &&
+			git config -f .gitmodules submodule.deepsubmodule.fetch false
+		) &&
+		git fetch --recursive >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_done
-- 
1.7.3.1.108.gb6303
