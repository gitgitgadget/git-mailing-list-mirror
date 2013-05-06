From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 1/7] Add support for -i/--interactive to git-clean
Date: Tue,  7 May 2013 03:18:50 +0800
Message-ID: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
References: <cover.1367867498.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwY-0001yF-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3EFTTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:20 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:50604 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3EFTTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:19 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so1945105dak.21
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=yVDXTpSuYbLfPHk8/+CUtxYe6G/mtv6xVUdBl6KxK4M=;
        b=WQty2ed3+r0JiAIxArcYjhmzMzICbtpkkt+UOHL+OYrnMR01WDo9vpcRzfCKrUJkt/
         wvBsPFU9PwJIM1JwpH7MrUFO4ueHxEx5SQYOgoz0KKiEB+eoYZJQVUjksxNBb6IBY4hW
         CpuFYdD9AzYfD+PoYZi7cG8iGtkCqQ7LCaxWx4KGvoLkUVQGM8xAMZcrc9osX2RjSVmK
         tF2uZQL+YnB+yrOlBtm5qzSQ0iHpOWyqeItmcBJjZNmAcyYBNnrg9JmDouL4CUSsQRwV
         nuCFH8Zm8PYJKjIchQsOwAVSDBzv5SXemFV4BQS92jwnbyEBznsiuQg0J71CwjawesPC
         Z2xw==
X-Received: by 10.66.197.228 with SMTP id ix4mr27981200pac.91.1367867959135;
        Mon, 06 May 2013 12:19:19 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com> <cover.1367867498.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223491>

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
 builtin/clean.c             | 195 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 191 insertions(+), 19 deletions(-)

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
index 04e39..29fbf 100644
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
 
+void edit_by_patterns_cmd()
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
+void interactive_main_loop()
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
 
@@ -257,26 +401,42 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
-					errors++;
-				if (gone && !quiet) {
-					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
-				}
+				string_list_append(&del_list, ent->name);
 			}
-			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			string_list_append(&del_list, ent->name);
+		}
+	}
+
+	if (interactive && del_list.nr > 0 && !dry_run && isatty(0) && isatty(1))
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
@@ -285,5 +445,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&del_list, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc1.338.gb35aa5d
