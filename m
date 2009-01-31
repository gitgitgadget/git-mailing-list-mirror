From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 1/4] Add log.mailmap as configurational option for mailmap location
Date: Sat, 31 Jan 2009 22:47:58 +0100
Message-ID: <ce94ea88e3182e97997c23f71e184e0db64fa708.1233438174.git.marius@trolltech.com>
References: <cover.1233438174.git.marius@trolltech.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 22:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNjb-0000lO-Pp
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbZAaVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbZAaVtP
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:49:15 -0500
Received: from hoat.troll.no ([62.70.27.150]:44188 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbZAaVtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:49:13 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 077CE20FE1;
	Sat, 31 Jan 2009 22:49:07 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id F0BCC20FC7;
	Sat, 31 Jan 2009 22:49:06 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g34f62
In-Reply-To: <cover.1233438174.git.marius@trolltech.com>
In-Reply-To: <cover.1233438174.git.marius@trolltech.com>
References: <cover.1233438174.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107945>

This allows us to override a repo mailmap file, or to use
mailmap files elsewhere than the repository root.

Should the log.mailmap file not be found, it falls back to ".mailmap".

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt       |    9 +++++++
 Documentation/git-shortlog.txt |    3 +-
 builtin-blame.c                |    2 +-
 builtin-shortlog.c             |    3 +-
 cache.h                        |    1 +
 config.c                       |   10 +++++++
 mailmap.c                      |    9 ++++++-
 t/t4203-mailmap.sh             |   53 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100755 t/t4203-mailmap.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e2b8775..02c7b4c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1012,6 +1012,15 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.mailmap::
+	Overrides the default location of the mailmap file. The default
+	mailmap location is .mailmap in the root of the repository.
+	The new location of the mailmap file may be in a repository
+	subdirectory, or somewhere outside of the repository itself.
+	If git can't find the file, it will try to load the default
+	mailmap location instead.
+	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
+
 man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 8f7c0e2..cacbeea 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -48,7 +48,8 @@ OPTIONS
 FILES
 -----
 
-If a file `.mailmap` exists at the toplevel of the repository,
+If a file `.mailmap` exists at the toplevel of the repository, or at the
+location pointed to by the log.mailmap configuration option,
 it is used to map an author email address to a canonical real name. This
 can be used to coalesce together commits by the same person where their
 name was spelled differently (whether with the same email address or
diff --git a/builtin-blame.c b/builtin-blame.c
index aae14ef..4b63775 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2394,7 +2394,7 @@ parse_done:
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
-	read_mailmap(&mailmap, ".mailmap", NULL);
+	read_mailmap(&mailmap, NULL, NULL);
 
 	if (!incremental)
 		setup_pager();
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 5f9f3f0..04832a8 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -219,7 +219,7 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
+	read_mailmap(&log->mailmap, NULL, &log->common_repo_prefix);
 
 	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
@@ -248,6 +248,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 
 	prefix = setup_git_directory_gently(&nongit);
+	git_config(git_default_config, NULL);
 	shortlog_init(&log);
 	init_revisions(&rev, prefix);
 	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
diff --git a/cache.h b/cache.h
index 45e713e..3eef7ea 100644
--- a/cache.h
+++ b/cache.h
@@ -867,6 +867,7 @@ extern int user_ident_explicitly_given;
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
+extern const char *git_log_mailmap;
 
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
diff --git a/config.c b/config.c
index 790405a..9ebcbbe 100644
--- a/config.c
+++ b/config.c
@@ -565,6 +565,13 @@ static int git_default_branch_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_log_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "log.mailmap"))
+		return git_config_string(&git_log_mailmap, var, value);
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value, void *dummy)
 {
 	if (!prefixcmp(var, "core."))
@@ -579,6 +586,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (!prefixcmp(var, "branch."))
 		return git_default_branch_config(var, value);
 
+	if (!prefixcmp(var, "log."))
+		return git_default_log_config(var, value);
+
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
 		pager_use_color = git_config_bool(var,value);
 		return 0;
diff --git a/mailmap.c b/mailmap.c
index 88fc6f3..32eab6c 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,11 +2,18 @@
 #include "string-list.h"
 #include "mailmap.h"
 
+const char *git_log_mailmap;
 int read_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
 {
 	char buffer[1024];
-	FILE *f = fopen(filename, "r");
+	FILE *f = NULL;
 
+	if (filename)
+		f = fopen(filename, "r");
+	if (f == NULL && git_log_mailmap)
+		f = fopen(git_log_mailmap, "r");
+	if (f == NULL)
+		f = fopen(".mailmap", "r");
 	if (f == NULL)
 		return 1;
 	while (fgets(buffer, sizeof(buffer), f) != NULL) {
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
new file mode 100755
index 0000000..57fd88e
--- /dev/null
+++ b/t/t4203-mailmap.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description='.mailmap configurations'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo one >one &&
+	git add one &&
+	test_tick &&
+	git commit -m initial
+'
+
+test_expect_success 'No mailmap' '
+	git shortlog >actual &&
+	echo "A U Thor (1):" >expect; echo "      initial" >>expect; echo >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default .mailmap' '
+	echo "Repo Guy <author@example.com>" > .mailmap &&
+	git shortlog >actual &&
+	echo "Repo Guy (1):" >expect; echo "      initial" >>expect; echo >>expect &&
+	test_cmp expect actual
+'
+
+# Using a mailmap file in a subdirectory of the repo here, but
+# could just as well have been a file outside of the repository
+test_expect_success 'log.mailmap set' '
+	mkdir internal_mailmap &&
+	echo "Internal Guy <author@example.com>" > internal_mailmap/.mailmap &&
+	git config log.mailmap internal_mailmap/.mailmap &&
+	git shortlog >actual &&
+	echo "Internal Guy (1):" >expect; echo "      initial" >>expect; echo >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log.mailmap file non-existant' '
+	rm internal_mailmap/.mailmap &&
+	rmdir internal_mailmap &&
+	git shortlog >actual &&
+	echo "Repo Guy (1):" >expect; echo "      initial" >>expect; echo >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'No mailmap files, but configured' '
+	rm .mailmap &&
+	git shortlog >actual &&
+	echo "A U Thor (1):" >expect; echo "      initial" >>expect; echo >>expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.1.2.257.g34f62
