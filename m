From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 07/15] git-clean: add support for -i/--interactive
Date: Sat, 18 May 2013 11:18:59 +0800
Message-ID: <29b78fa98bc895ab0e480ca2716cb5fdbf42e8c8.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhl-0005De-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448Ab3ERDUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:20:42 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47922 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519Ab3ERDTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:19:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id 6so3899211pdd.17
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=EXsBChD3WhtDG0v4HTdsmFG7D8kuzCT81RVyZiVJa8M=;
        b=1AYQgLE+XBsf55E3bKFA6KxzQhIdyo1+m4AVlWmkFyugFIYqbVrLotWgWgFNcSSadN
         4vrncqIMl1jmBl/EAo+Sda7clhLZwIoJiIkXfqwsJ7N2ZIFyEpOBo6YQyppPOqVu+wHF
         ksY4SiDo5ewctKj6abZJ6ZdSTepTrLaJLCOAsI1agsHiooSetK79RbNKys15F3J/QY21
         2Imq/CPoXK2piTXUZ0vmLiVs/NUEN7a8PsX7p+T8ZzfjMQb3rDQbp7S9bKW0XYZaiAnb
         oEsRgdwPVePHnJ2uov85oeHfwt3ndJxdGA1+3iYPlONy2KCG2PPuDA/KbF2qSYmttPXf
         YINA==
X-Received: by 10.68.254.225 with SMTP id al1mr52091481pbd.69.1368847187289;
        Fri, 17 May 2013 20:19:47 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.19.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:19:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224766>

Show what would be done and the user must confirm before actually
cleaning.

    Would remove ...
    Would remove ...
    Would remove ...

    Remove [y/n]?

Press "y" to start cleaning, and press "n" if you want to abort.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt | 10 ++++++--
 builtin/clean.c             | 57 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3a..186e34 100644
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
@@ -34,7 +34,13 @@ OPTIONS
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
+	cleaning.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index 23e1f..f28d6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,10 +15,11 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
@@ -143,6 +144,50 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	return ret;
 }
 
+static void interactive_main_loop(void)
+{
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	const char *qname;
+
+	while (del_list.nr) {
+		putchar('\n');
+		for_each_string_list_item(item, &del_list) {
+			qname = quote_path_relative(item->string, NULL, &buf);
+			printf(_(msg_would_remove), qname);
+		}
+		putchar('\n');
+
+		printf(_("Remove [y/n]? "));
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
@@ -162,6 +207,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
+		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
@@ -188,12 +234,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!dry_run && !force) {
+	if (!interactive && !dry_run && !force) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
+			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 	}
 
@@ -267,7 +313,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* TODO: do interactive git-clean here, which will modify del_list */
+	if (interactive && del_list.nr > 0)
+		interactive_main_loop();
 
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
-- 
1.8.3.rc2.26.g7472058
