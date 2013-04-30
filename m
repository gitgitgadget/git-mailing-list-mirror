From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] Add support for -i/--interactive to git-clean
Date: Wed,  1 May 2013 03:25:11 +0800
Message-ID: <3ecc9ca1b1363b5bd27ae53cbf5899ce6d44cd48.1367349734.git.worldhello.net@gmail.com>
References: <CANYiYbHKWv6R2vtwG=bTNhj8q0iC4EBt8usC3posBCtYBTXOvA@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:25:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGBE-00070A-T3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830Ab3D3TZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:25:26 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35217 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724Ab3D3TZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:25:24 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so518157pad.25
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=P8ON0uyeDIR3rcR0R678uxP4usGM/I4uyPuN3m2ARxQ=;
        b=X6BW5ZQ36dHbgP4MEDzfBo2r2sYh+UFSMAo0cTDHqq0uqoAZAXjfAn3U4oUcKWCHVG
         WvFTjivrYjzhG8viSLjhwA05vC+z31zct04GYWrPzf5TcHzJ2OyG/kjYyDCe2Qnfm2dv
         vqEmzAlCINxE3Ec2pimFZqSxDYMQJpuKQwzkQXd5mCnL6K4PQtNpk7FKEwPuJJ6e0Gez
         2OaMs8WIda+APFYq1b/c5FFRQhdCQoqH3xPd/OXoXDLlJOmtizXTEjt+H9BPNVWcjFAW
         LlvJ58Y9bMBWb2teKyZCCpwqum2PckujdwdAM+4qPvoPvd2/lAUY5uTYb/yD1mZWp5LS
         AgVw==
X-Received: by 10.66.146.232 with SMTP id tf8mr492420pab.32.1367349924232;
        Tue, 30 Apr 2013 12:25:24 -0700 (PDT)
Received: from localhost.localdomain ([114.246.126.106])
        by mx.google.com with ESMTPSA id dg5sm29572258pbc.29.2013.04.30.12.25.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 12:25:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.306.gee4c747
In-Reply-To: <CANYiYbHKWv6R2vtwG=bTNhj8q0iC4EBt8usC3posBCtYBTXOvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222993>

Show what would be done and the user must confirm before actually
cleaning. In the confirmation dialog, the user has three choices:

 * Yes: Start to do cleaning.
 * No:  Nothing will be deleted.
 * Edit (default): Enter edit mode.

When the user chooses the edit mode, the user can input space-
separated patterns (the same syntax as gitignore), and each clean
candidate that matches with one of the patterns will be excluded
from cleaning. When the user feels it's OK, presses ENTER to start
cleaning.

When in the edit mode, if the user wants to cancel the whole
cleaning, simply inputs ctrl-c to abort the cleaning.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-clean.txt |  16 ++++-
 builtin/clean.c             | 141 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 140 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3a..6bc99 100644
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
@@ -34,7 +34,19 @@ OPTIONS
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
+	OK, presses ENTER to start cleaning. If the user wants to cancel
+	the whole cleaning in the edit mode, simply inputs ctrl-c to abort.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..b26c0 100644
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
 
@@ -142,6 +143,96 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+void interactive_clean(struct string_list *dels, const char *prefix)
+{
+	struct dir_struct dir;
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **ignore_list;
+	struct string_list_item *item;
+	struct exclude_list *el;
+	const char *qname;
+	int edit_mode = 0, i;
+
+	while (1) {
+		int matches = 0;
+
+		/* dels list may become empty when we run string_list_remove_empty_items later */
+		if (!dels->nr)
+			break;
+
+		for_each_string_list_item(item, dels) {
+			qname = quote_path_relative(item->string, -1, &buf, prefix);
+			printf(_(msg_would_remove), qname);
+		}
+
+		if (message.len) {
+			printf("\n%s\n", message.buf);
+			strbuf_reset(&message);
+		}
+
+		if (!edit_mode) {
+			printf(_("Remove (yes/no/Edit) ? "));
+			strbuf_getline(&confirm, stdin, '\n');
+			strbuf_trim(&confirm);
+			if (confirm.len) {
+				if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
+					break;
+				} else if (!strncasecmp(confirm.buf, "no", confirm.len)) {
+					string_list_clear(dels, 0);
+					break;
+				}
+			}
+			edit_mode = 1;
+		}
+
+		printf(_("Input ignore patterns to keep items, or press ENTER to confirm: "));
+		strbuf_getline(&confirm, stdin, '\n');
+		strbuf_trim(&confirm);
+		printf("\n");
+
+		if (!confirm.len)
+			break;
+
+		memset(&dir, 0, sizeof(dir));
+		el = add_exclude_list(&dir, EXC_CMDL, "manual exclude");
+		ignore_list = strbuf_split_buf(confirm.buf, confirm.len, ' ', 0);
+
+		for (i = 0; ignore_list[i]; i++)
+		{
+
+			strbuf_trim(*ignore_list);
+			if (!(*ignore_list)->len)
+				continue;
+
+			add_exclude(ignore_list[i]->buf, "", 0, el, -(i+1));
+		}
+
+		for_each_string_list_item(item, dels) {
+			int dtype = DT_UNKNOWN;
+			if (is_excluded(&dir, item->string, &dtype)) {
+				*item->string = '\0';
+				matches++;
+			}
+		}
+
+		if (!matches) {
+			strbuf_addf(&message, _("WARNING: Cannot find items prefixed by: %s"), confirm.buf);
+			strbuf_addch(&message, '\n');
+		} else {
+			string_list_remove_empty_items(dels, 0);
+		}
+
+		strbuf_reset(&confirm);
+		strbuf_list_free(ignore_list);
+		clear_directory(&dir);
+	}
+
+	strbuf_release(&confirm);
+	strbuf_release(&message);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -154,12 +245,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
@@ -186,12 +280,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
 
@@ -257,26 +351,42 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
@@ -285,5 +395,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&dels, 0);
 	return (errors != 0);
 }
-- 
1.8.3.rc0.306.gee4c747
