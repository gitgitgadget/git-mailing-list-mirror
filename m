From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 07/16] git-clean: add support for -i/--interactive
Date: Tue, 25 Jun 2013 23:53:48 +0800
Message-ID: <49edd78c870c769fb088a9a29640f10a15503605.1372175283.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVa3-00045v-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab3FYPyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:54:44 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61686 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab3FYPyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:54:39 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so987792pdj.8
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=IhuG6qRuaKrqlV8on5K45lnvbGdZLVkygRtEohanOqU=;
        b=xN6Q+0g5iooCnNbst8RVisKkpCGlB5f2LKOHD/pbfMDJZdgPmqAyjjSuZRLkBHU5Ta
         ryZ9jMvAYmH9tGQRHatCtJMOivc8Udezw9jJghtJtariMNNbOFDwpClM0PI8NmQA91GX
         9I5hlywSOLTiS3ICiw4Gq3nXqabJSQeyZjL6eNP25nk4KraIt9lanSE8OibXXs0SAVr2
         ToJdOfMidqygctDL8144Z9QFNqXpeTjV0Lpoe1Whs3K0QTlhn7YfOjsBUmrVGQWVLo8l
         DpIwPG7u5xyfwz11hyPlmnGc1SW2vahHXg4MF+qX7IlWJvbxG4RzTbvKtjV3p2LROqfs
         9ksg==
X-Received: by 10.68.110.227 with SMTP id id3mr8593870pbb.106.1372175679187;
        Tue, 25 Jun 2013 08:54:39 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.54.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:54:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228970>

Show what would be done and the user must confirm before actually
cleaning.

    Would remove ...
    Would remove ...
    Would remove ...

    Remove [y/n]?

Press "y" to start cleaning, and press "n" if you want to abort.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 77ec1..698fb 100644
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
1.8.3.1.756.g2e9b71f
