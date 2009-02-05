From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v4 1/4] Add log.mailmap as configurational option for mailmap location
Date: Thu,  5 Feb 2009 09:06:38 +0100
Message-ID: <565c86bdbc8d6303d7d468fa196fb54ff7bd2352.1233819451.git.marius@trolltech.com>
References: <cover.1233819451.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:10:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzJG-0002UM-7X
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZBEIIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbZBEIIR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:08:17 -0500
Received: from hoat.troll.no ([62.70.27.150]:58559 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754514AbZBEIIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:08:09 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 7E7E120F7D;
	Thu,  5 Feb 2009 09:08:01 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 6EB2720F77;
	Thu,  5 Feb 2009 09:08:01 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.354.g200fb
In-Reply-To: <cover.1233819451.git.marius@trolltech.com>
In-Reply-To: <cover.1233819451.git.marius@trolltech.com>
References: <cover.1233819451.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108528>

This allows us to augment the repo mailmap file, and to use
mailmap files elsewhere than the repository root. Meaning
that the entries in log.mailmap will override the entries
in "./.mailmap", should they match the same.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/config.txt       |    8 +++
 Documentation/git-shortlog.txt |    3 +-
 builtin-blame.c                |    2 +-
 builtin-shortlog.c             |    3 +-
 cache.h                        |    1 +
 config.c                       |   10 ++++
 mailmap.c                      |   12 ++++-
 mailmap.h                      |    2 +-
 pretty.c                       |    2 +-
 t/t4203-mailmap.sh             |  109 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 145 insertions(+), 7 deletions(-)
 create mode 100755 t/t4203-mailmap.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e2b8775..1334d36 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1012,6 +1012,14 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.mailmap::
+	The location of an augmenting mailmap file. The default
+	mailmap, located in the root of the repository, is loaded
+	first, then the mailmap file pointed to by this variable.
+	The location of the mailmap file may be in a repository
+	subdirectory, or somewhere outside of the repository itself.
+	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
+
 man.viewer::
 	Specify the programs that may be used to display help in the
 	'man' format. See linkgit:git-help[1].
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 498bd28..66b6045 100644
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
index aae14ef..19edcf3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2394,7 +2394,7 @@ parse_done:
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
-	read_mailmap(&mailmap, ".mailmap", NULL);
+	read_mailmap(&mailmap, NULL);
 
 	if (!incremental)
 		setup_pager();
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 5f9f3f0..314b6bc 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -219,7 +219,7 @@ void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
 
-	read_mailmap(&log->mailmap, ".mailmap", &log->common_repo_prefix);
+	read_mailmap(&log->mailmap, &log->common_repo_prefix);
 
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
index 88fc6f3..5aaee91 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,10 +2,11 @@
 #include "string-list.h"
 #include "mailmap.h"
 
-int read_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
+const char *git_log_mailmap;
+static int read_single_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
 {
 	char buffer[1024];
-	FILE *f = fopen(filename, "r");
+	FILE *f = (filename == NULL ? NULL : fopen(filename, "r"));
 
 	if (f == NULL)
 		return 1;
@@ -60,6 +61,13 @@ int read_mailmap(struct string_list *map, const char *filename, char **repo_abbr
 	return 0;
 }
 
+int read_mailmap(struct string_list *map, char **repo_abbrev)
+{
+	/* each failure returns 1, so >1 means both calls failed */
+	return read_single_mailmap(map, ".mailmap", repo_abbrev) +
+	       read_single_mailmap(map, git_log_mailmap, repo_abbrev) > 1;
+}
+
 int map_email(struct string_list *map, const char *email, char *name, int maxlen)
 {
 	char *p;
diff --git a/mailmap.h b/mailmap.h
index 6e48f83..ba2ee76 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,7 +1,7 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
-int read_mailmap(struct string_list *map, const char *filename, char **repo_abbrev);
+int read_mailmap(struct string_list *map, char **repo_abbrev);
 int map_email(struct string_list *mailmap, const char *email, char *name, int maxlen);
 
 #endif
diff --git a/pretty.c b/pretty.c
index cc460b5..9e03d6a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -312,7 +312,7 @@ static int mailmap_name(struct strbuf *sb, const char *email)
 
 	if (!mail_map) {
 		mail_map = xcalloc(1, sizeof(*mail_map));
-		read_mailmap(mail_map, ".mailmap", NULL);
+		read_mailmap(mail_map, NULL);
 	}
 
 	if (!mail_map->nr)
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
new file mode 100755
index 0000000..2eded8e
--- /dev/null
+++ b/t/t4203-mailmap.sh
@@ -0,0 +1,109 @@
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
+	git commit -m initial &&
+	echo two >>one &&
+	git add one &&
+	git commit --author "nick1 <bugs@company.xx>" -m second
+'
+
+cat >expect <<\EOF
+A U Thor (1):
+      initial
+
+nick1 (1):
+      second
+
+EOF
+
+test_expect_success 'No mailmap' '
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+Repo Guy (1):
+      initial
+
+nick1 (1):
+      second
+
+EOF
+
+test_expect_success 'default .mailmap' '
+	echo "Repo Guy <author@example.com>" > .mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+# Using a mailmap file in a subdirectory of the repo here, but
+# could just as well have been a file outside of the repository
+cat >expect <<\EOF
+Internal Guy (1):
+      second
+
+Repo Guy (1):
+      initial
+
+EOF
+test_expect_success 'log.mailmap set' '
+	mkdir internal_mailmap &&
+	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
+	git config log.mailmap internal_mailmap/.mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+External Guy (1):
+      initial
+
+Internal Guy (1):
+      second
+
+EOF
+test_expect_success 'log.mailmap override' '
+	echo "External Guy <author@example.com>" >> internal_mailmap/.mailmap &&
+	git config log.mailmap internal_mailmap/.mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+Repo Guy (1):
+      initial
+
+nick1 (1):
+      second
+
+EOF
+
+test_expect_success 'log.mailmap file non-existant' '
+	rm internal_mailmap/.mailmap &&
+	rmdir internal_mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+A U Thor (1):
+      initial
+
+nick1 (1):
+      second
+
+EOF
+test_expect_success 'No mailmap files, but configured' '
+	rm .mailmap &&
+	git shortlog >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.6.1.2.323.g37255
