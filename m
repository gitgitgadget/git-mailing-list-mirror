From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 1/3] Add support for -i/--interactive to git-clean
Date: Thu,  2 May 2013 21:15:02 +0800
Message-ID: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
References: <vpq38u6n397.fsf@grenoble-inp.fr>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtM5-0007Sm-7L
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758569Ab3EBNPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:15:19 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:64088 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab3EBNPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:15:17 -0400
Received: by mail-pb0-f47.google.com with SMTP id uo1so340964pbc.6
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=rIM3SGSTfP9QPlkCUaT2WiQaiA5UPLs2Svs7X1why5k=;
        b=WPzZ4SscJPJs7obnl0NK6dscaywZBEy+yuNBwveVniPJbP6laJ/9sfxf6uKngQPHsm
         fdxtBQEqi79SO4zkT/cjTLVz/RvATTE5uCQ0c1nvn+fx5TPaXRVI9AomRFsvvFZwELfV
         B8/rcMNaRRxFwZ86rhvQLgy5RG+Hoz9M9UH7oKm59liHOu5QeVboxdu9SYec/YezqF3c
         JhwIKT6b/aa8Oslt3Fo94f7KOawuTw49BN6x3jDVSeD2JeIQnfi0X1ofj1yMvQu09SgX
         Uv3rzl3z/rWajGGQD7OnD/1dp3jsjvp9Hqp/Mrh/c/4mExWhpTDUBgKWyg2Uh0qeYMAp
         ViGw==
X-Received: by 10.66.121.169 with SMTP id ll9mr6925028pab.126.1367500516805;
        Thu, 02 May 2013 06:15:16 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id ux10sm8293841pab.1.2013.05.02.06.15.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:15:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.364.gbb5463f
In-Reply-To: <vpq38u6n397.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223194>

Show what would be done and the user must confirm before actually
cleaning. In the confirmation dialog, the user has three choices:

 * Yes: Start to do cleaning.
 * No:  Nothing will be deleted.
 * Edit (default for the first time): Enter edit mode.

When the user chooses the edit mode, the user can input space-
separated patterns (the same syntax as gitignore), and each clean
candidate that matches with one of the patterns will be excluded
from cleaning. When the user feels it's OK, presses ENTER and back
to the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Spelling-check-by: Eric Sunshine <sunshine@sunshineco.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-clean.txt |  15 +++-
 builtin/clean.c             | 183 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 181 insertions(+), 17 deletions(-)

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
index 04e39..407744e5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,9 +15,10 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static int interactive;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
@@ -142,6 +143,138 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+void interactive_clean_edit(struct string_list *dels, const char *prefix)
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
+		if (!dels->nr) {
+			printf_ln(_("No more files to clean, exiting."));
+			break;
+		}
+
+		if (changed) {
+			printf(_(
+				 "NOTE: Will remove the following items. You can input space-seperated\n"
+				 "NOTE: patterns (just like .gitignore) to exclude items from deletion,\n"
+				 "NOTE: or press ENTER to continue."
+				));
+			putchar('\n');
+			putchar('\n');
+
+			/* Display dels in "Would remove ..." format */
+			for_each_string_list_item(item, dels) {
+				qname = quote_path_relative(item->string, -1, &buf, prefix);
+				printf(_(msg_would_remove), qname);
+			}
+			putchar('\n');
+		}
+
+		printf(_("Input ignore patterns> "));
+		strbuf_getline(&confirm, stdin, '\n');
+		strbuf_trim(&confirm);
+		putchar('\n');
+
+		/* Quit edit mode */
+		if (!confirm.len)
+			break;
+
+		memset(&dir, 0, sizeof(dir));
+		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		ignore_list = strbuf_split_buf(confirm.buf, confirm.len, ' ', 0);
+
+		for (i = 0; ignore_list[i]; i++) {
+			strbuf_trim(*ignore_list);
+			if (!(*ignore_list)->len)
+				continue;
+
+			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
+		}
+
+		changed = 0;
+		for_each_string_list_item(item, dels) {
+			int dtype = DT_UNKNOWN;
+			const char *qname;
+
+			qname = quote_path_relative(item->string, -1, &buf, prefix);
+
+			if (is_excluded(&dir, qname, &dtype)) {
+				*item->string = '\0';
+				changed++;
+			}
+		}
+
+		if (changed) {
+			string_list_remove_empty_items(dels, 0);
+		} else {
+			printf(_("WARNING: Cannot find items matched by: %s"), confirm.buf);
+			putchar('\n');
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
+void interactive_clean(struct string_list *dels, const char *prefix)
+{
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	const char *qname;
+	int count = 0;
+
+	/* dels list may become empty after return back from edit mode */
+	while (dels->nr) {
+		/* Display dels in "Would remove ..." format */
+		for_each_string_list_item(item, dels) {
+			qname = quote_path_relative(item->string, -1, &buf, prefix);
+			printf(_(msg_would_remove), qname);
+		}
+		putchar('\n');
+
+		/* Confirmation dialog */
+		printf(count > 0 ? _("Remove (Yes/no/edit) ? ") : _("Remove (yes/no/Edit) ? "));
+		strbuf_getline(&confirm, stdin, '\n');
+		strbuf_trim(&confirm);
+		putchar('\n');
+
+		if (confirm.len) {
+			if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
+				break;
+			} else if (!strncasecmp(confirm.buf, "no", confirm.len)) {
+				string_list_clear(dels, 0);
+				break;
+			} else if (!strncasecmp(confirm.buf, "edit", confirm.len)) {
+				interactive_clean_edit(dels, prefix);
+			} else {
+				continue;
+			}
+		} else if (count > 0) {
+			/* If back from edit_mode, confirmation dialog defaults to "yes" */
+			break;
+		} else {
+			/* For the first time, confirmation dialog defaults to "edit" */
+			interactive_clean_edit(dels, prefix);
+		}
+		count++;
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&confirm);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -154,12 +287,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct exclude_list *el;
+	struct string_list dels = STRING_LIST_INIT_DUP;
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
@@ -186,12 +322,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!dry_run && !force) {
+	if (!dry_run && !force && !interactive) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
+			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 	}
 
@@ -257,26 +393,42 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
+				string_list_append(&dels, ent->name);
 			}
-			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
-			res = dry_run ? 0 : unlink(ent->name);
+			string_list_append(&dels, ent->name);
+		}
+	}
+
+	if (interactive && dels.nr > 0 && !dry_run && isatty(0) && isatty(1))
+		interactive_clean(&dels, prefix);
+
+	for_each_string_list_item(item, &dels) {
+		struct stat st;
+
+		if (lstat(item->string, &st))
+			continue;
+
+		if (S_ISDIR(st.st_mode)) {
+			strbuf_addstr(&directory, item->string);
+			if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
+				errors++;
+			if (gone && !quiet) {
+				qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
+				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+			}
+			strbuf_reset(&directory);
+		} else {
+			res = dry_run ? 0 : unlink(item->string);
 			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, prefix);
 				warning(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
+				qname = quote_path_relative(item->string, -1, &buf, prefix);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
@@ -285,5 +437,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&dels, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc0.364.gbb5463f
