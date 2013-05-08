From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 01/10] Add support for -i/--interactive to git-clean
Date: Wed,  8 May 2013 19:38:46 +0800
Message-ID: <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2iR-00014J-GS
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab3EHLjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:14 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40099 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3EHLjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:11 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so1274064pab.32
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=f4Vr2eWSo+aLl9uQbzLBlZuDD1we2JlSqZY2Asbvx+M=;
        b=TiA3PymVUXTl5bRWVhi8yTASSwciBHaUTFpawbA3t4Ph7+HDKw4f2wNSNuUjmO6Saf
         tL7WyRknMjqcoJymUKRg871HFwyqb7ZccYMsBNN18SvwnNqA1b75KoRzLXVLlKRdXIqr
         VYbrg1KUITnGMZKKyIv+EQlgjRPeIvBpOpQOkhkSqF0R++w+/zFU07XYEjV/KSLC/Yyn
         Rop+yV4sP4nR/03rNFrcEi/sG7B4zroSfNTMt8sT+5IaJRafCfmvbUBIWYEBu5RpnRgm
         6ogbeGja9bT4q7qWJcRShZfN26wURUijBD0i28Al4wA4UHSnKanNIiSl1xoQ5zSwU/98
         V1aw==
X-Received: by 10.66.20.7 with SMTP id j7mr7631409pae.142.1368013151268;
        Wed, 08 May 2013 04:39:11 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223660>

Show what would be done and the user must confirm before actually
cleaning. In the confirmation dialog, the user has three choices:

 * y/yes:  Start to do cleaning.
 * n/no:   Nothing will be deleted.
 * e/edit: Exclude items from deletion using ignore patterns.

When the user chooses the edit mode, the user can input space-
separated patterns (the same syntax as gitignore), and each clean
candidate that matches with one of the patterns will be excluded
from cleaning. When the user feels it's OK, presses ENTER and back
to the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Spelling-checked-by: Eric Sunshine <sunshine@sunshineco.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-clean.txt |  15 +++-
 builtin/clean.c             | 198 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 192 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3a..f5572 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -34,7 +34,18 @@ OPTIONS
 -f::
 --force::
 	If the Git configuration variable clean.requireForce is not set
-	to false, 'git clean' will refuse to run unless given -f or -n.
+	to false, 'git clean' will refuse to run unless given -f, -n or
+	-i.
+
+-i::
+--interactive::
+	Show what would be done and the user must confirm before actually
+	cleaning. In the confirmation dialog, the user can choose to abort
+	the cleaning, or enter into an edit mode. In the edit mode, the
+	user can input space-separated patterns (the same syntax as
+	gitignore), and each clean candidate that matches with one of the
+	patterns will be excluded from cleaning. When the user feels it's
+	OK, presses ENTER and back to the confirmation dialog.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..49aab 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,9 +15,12 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static int interactive;
+static struct string_list del_list = STRING_LIST_INIT_DUP;
+static const char **the_prefix;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
@@ -142,6 +145,139 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+static void edit_by_patterns_cmd()
+{
+	struct dir_struct dir;
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **ignore_list;
+	struct string_list_item *item;
+	struct exclude_list *el;
+	const char *qname;
+	int changed = -1, i;
+
+	while (1) {
+		/* dels list may become empty when we run string_list_remove_empty_items later */
+		if (!del_list.nr) {
+			printf_ln(_("No more files to clean, exiting."));
+			break;
+		}
+
+		if (changed) {
+			putchar('\n');
+
+			/* Display dels in "Would remove ..." format */
+			for_each_string_list_item(item, &del_list) {
+				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+				printf(_(msg_would_remove), qname);
+			}
+			putchar('\n');
+		}
+
+		printf(_("Input ignore patterns>> "));
+		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+			strbuf_trim(&confirm);
+		} else {
+			putchar('\n');
+			break;
+		}
+
+		/* Quit edit mode */
+		if (!confirm.len)
+			break;
+
+		memset(&dir, 0, sizeof(dir));
+		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		ignore_list = strbuf_split_max(&confirm, ' ', 0);
+
+		for (i = 0; ignore_list[i]; i++) {
+			strbuf_trim(ignore_list[i]);
+			if (!ignore_list[i]->len)
+				continue;
+
+			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
+		}
+
+		changed = 0;
+		for_each_string_list_item(item, &del_list) {
+			int dtype = DT_UNKNOWN;
+			const char *qname;
+
+			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+
+			if (is_excluded(&dir, qname, &dtype)) {
+				*item->string = '\0';
+				changed++;
+			}
+		}
+
+		if (changed) {
+			string_list_remove_empty_items(&del_list, 0);
+		} else {
+			printf_ln(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+		}
+
+		strbuf_list_free(ignore_list);
+		clear_directory(&dir);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&confirm);
+}
+
+static void interactive_main_loop()
+{
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	const char *qname;
+
+	/* dels list may become empty after return back from edit mode */
+	while (del_list.nr) {
+		printf_ln(Q_("Would remove the following item:",
+			     "Would remove the following items:",
+			     del_list.nr));
+		putchar('\n');
+
+		/* Display dels in "Would remove ..." format */
+		for_each_string_list_item(item, &del_list) {
+			qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
+			printf(_(msg_would_remove), qname);
+		}
+		putchar('\n');
+
+		/* Confirmation dialog */
+		printf(_("Remove ([y]es/[n]o/[e]dit) ? "));
+		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+			strbuf_trim(&confirm);
+		} else {
+			/* Ctrl-D is the same as "quit" */
+			string_list_clear(&del_list, 0);
+			putchar('\n');
+			printf_ln("Bye.");
+			break;
+		}
+
+		if (confirm.len) {
+			if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
+				break;
+			} else if (!strncasecmp(confirm.buf, "no", confirm.len) ||
+				   !strncasecmp(confirm.buf, "quit", confirm.len)) {
+				string_list_clear(&del_list, 0);
+				printf_ln("Bye.");
+				break;
+			} else if (!strncasecmp(confirm.buf, "edit", confirm.len)) {
+				edit_by_patterns_cmd();
+			} else {
+				continue;
+			}
+		}
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&confirm);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -154,12 +290,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
+	struct string_list_item *item;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
+		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
@@ -176,7 +314,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	else
 		config_set = 1;
 
-	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
+	the_prefix = &prefix;
+
+	argc = parse_options(argc, argv, *the_prefix, options, builtin_clean_usage,
 			     0);
 
 	memset(&dir, 0, sizeof(dir));
@@ -186,12 +326,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!dry_run && !force) {
+	if (interactive) {
+		if (!isatty(0) || !isatty(1))
+			die(_("interactive clean can not run without a valid tty; "
+				  "refusing to clean"));
+	} else if (!dry_run && !force) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
+			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 	}
 
@@ -210,7 +354,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
 
-	pathspec = get_pathspec(prefix, argv);
+	pathspec = get_pathspec(*the_prefix, argv);
 
 	fill_directory(&dir, pathspec);
 
@@ -257,26 +401,41 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
-			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
-					errors++;
-				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
-				}
-			}
-			strbuf_reset(&directory);
+			if (remove_directories || (matches == MATCHED_EXACTLY))
+				string_list_append(&del_list, ent->name);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			string_list_append(&del_list, ent->name);
+		}
+	}
+
+	if (interactive && !dry_run && del_list.nr > 0)
+		interactive_main_loop();
+
+	for_each_string_list_item(item, &del_list) {
+		struct stat st;
+
+		if (lstat(item->string, &st))
+			continue;
+
+		if (S_ISDIR(st.st_mode)) {
+			strbuf_addstr(&directory, item->string);
+			if (remove_dirs(&directory, *the_prefix, rm_flags, dry_run, quiet, &gone))
+				errors++;
+			if (gone && !quiet) {
+				qname = quote_path_relative(directory.buf, directory.len, &buf, *the_prefix);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+			}
+			strbuf_reset(&directory);
+		} else {
+			res = dry_run ? 0 : unlink(item->string);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, *the_prefix);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
@@ -285,5 +444,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&del_list, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc1.341.g1c24ab7
