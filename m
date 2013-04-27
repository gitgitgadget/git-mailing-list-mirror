From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] Add support for -i/--interactive to git-clean
Date: Sun, 28 Apr 2013 00:13:26 +0800
Message-ID: <2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
References: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 27 18:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW7lO-0003c5-19
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 18:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab3D0QN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 12:13:58 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60276 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab3D0QNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 12:13:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so2995435pab.1
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UCdSHwd/ntrtn5N/2va8DE+Cc6iqz6YyINMg3gjADTg=;
        b=pC6C39CYY6xMeeRwDAOIxPsZl23f9fIwzdyodMPdSYw8EQnj+B10vfJ2AcVnb9bOLK
         52cOTLEEcbNThmaXGESML/xv8FWYVeqD9Oyq0wWiBqmkkP++v9OI/CUjbaWevkbFizQE
         AQQiNUucdHvyuvGUWQH3OgMRFhinzuEpNu7Uoxdt9mLa5rGJpVEBB66vXUr59D8HyC6+
         8YoKEy6duXzUWcAnEWC4xPoRVMJO08UBLoRMiXrB9iBEakviY7XEQ0+OfnXvxymDFPbx
         qIAotXYFog6bxco0fSuYxnnSHd0Qv0PFTfpX8eCKKodtzz6jWBhFJ+GboVk+IPMg1G3K
         lvkw==
X-Received: by 10.68.26.6 with SMTP id h6mr35014132pbg.149.1367079230716;
        Sat, 27 Apr 2013 09:13:50 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.2])
        by mx.google.com with ESMTPSA id aa8sm17758085pad.14.2013.04.27.09.13.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 09:13:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.921.g1826d07
In-Reply-To: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222658>

Show what would be done and a confirmation dialog before actually
cleaning. In the confirmation dialog, the user can input a space
separated prefix list, and each clean candidate that matches with
one of prefix, will be excluded from cleaning. When the user feels
it's OK, press ENTER to start cleaning. If the user wants to cancel
the whole cleaning, simply input ctrl-c in the confirmation dialog.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Suggested-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-clean.txt |  14 +++++-
 builtin/clean.c             | 101 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3a..60a30 100644
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
@@ -34,7 +34,17 @@ OPTIONS
 -f::
 --force::
 	If the Git configuration variable clean.requireForce is not set
-	to false, 'git clean' will refuse to run unless given -f or -n.
+	to false, 'git clean' will refuse to run unless given -f, -n or
+	-i.
+
+-i::
+--interactive::
+  Show what would be done and a confirmation dialog before actually
+  cleaning. In the confirmation dialog, the user can input a space
+  separated prefix list, and each clean candidate that matches with
+  one of prefix, will be excluded from cleaning. When the user feels
+  it's OK, press ENTER to start cleaning. If the user wants to cancel
+  the whole cleaning, simply input ctrl-c in the confirmation dialog.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..eee04 100644
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
 
@@ -154,12 +155,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
@@ -186,12 +190,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
 
@@ -257,26 +261,92 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
+	if (interactive && dels.nr > 0 && !dry_run && isatty(0) && isatty(1)) {
+		struct strbuf confirm = STRBUF_INIT;
+
+		while (1) {
+			struct strbuf **prefix_list, **prefix_list_head;
+
+			/* dels list may become empty when we run string_list_remove_empty_items latter */
+			if (!dels.nr)
+				break;
+
+			for_each_string_list_item(item, &dels) {
+				qname = quote_path_relative(item->string, -1, &buf, prefix);
+				printf(_(msg_would_remove), qname);
+			}
+
+			printf(_("Remove (press enter to confirm or input items you want to keep)? "));
+			strbuf_getline(&confirm, stdin, '\n');
+			strbuf_trim(&confirm);
+
+			if (!confirm.len)
+				break;
+
+			printf("\n");
+
+			prefix_list_head = strbuf_split_buf(confirm.buf, confirm.len, ' ', 0);
+			for (prefix_list = prefix_list_head; *prefix_list; *prefix_list++)
+			{
+				int prefix_matched = 0;
+
+				strbuf_trim(*prefix_list);
+				if (!(*prefix_list)->len)
+					continue;
+
+				for_each_string_list_item(item, &dels) {
+					if (!strncasecmp(item->string, (*prefix_list)->buf, (*prefix_list)->len)) {
+						*item->string = '\0';
+						prefix_matched++;
+					}
+				}
+				if (!prefix_matched) {
+					warning(_("Cannot find items start with the given prefix: %s"), (*prefix_list)->buf);
+					printf("\n");
+				} else {
+					string_list_remove_empty_items(&dels, 0);
+				}
+			}
+
+			strbuf_reset(&confirm);
+			strbuf_list_free(prefix_list_head);
+		}
+		strbuf_release(&confirm);
+	}
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
@@ -285,5 +355,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&directory);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&dels, 0);
 	return (errors != 0);
 }
-- 
1.8.2.1.921.g1826d07
