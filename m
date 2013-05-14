From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 2/9] git-clean: add support for -i/--interactive
Date: Tue, 14 May 2013 16:45:16 +0800
Message-ID: <9c5ea46607a9e50e0ddb1e74eec9fb36bb04facc.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 14 10:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcAsD-00030F-WD
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 10:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab3ENIp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 04:45:58 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57584 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab3ENIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 04:45:55 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so240818pdi.15
        for <git@vger.kernel.org>; Tue, 14 May 2013 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=ivufC+UY7fpLLpck6GtQEQ1IsYeJ6MJA2t1CW9hu/+k=;
        b=YUn6vEiK59qGsXElJxfOzIkD5Argc8JnnTCLh9F7UnG4+nruI58E6nJ4dP3nTo7PG0
         pFDR4Jd6OtEvjI7dalBXIUDGgRueNdJBut/poaXr/XyeeoSjepQ0iQAfEAopzbC0hSFU
         0VjhGtYEi7uGzvaGqEBe0NktMfMxx3JVAoZVApHxBs4vMO1zjl480OrqqTvsKxoih1D9
         CqegXEmEYg7gEvvdG3EHZfLhtMKO0K5Uw5HBN45bP4hhNdT0RYdBRNHktF/IWoWBC4jg
         rKvyrIoFfaHbEiU+SKuCrhEHmD+KyKMtFIHb9T9Yfr/5YHAs5ihIjMM4NQG/dtTM7J0U
         rb+g==
X-Received: by 10.68.245.6 with SMTP id xk6mr33100355pbc.41.1368521154476;
        Tue, 14 May 2013 01:45:54 -0700 (PDT)
Received: from localhost.localdomain ([114.248.141.128])
        by mx.google.com with ESMTPSA id wt5sm17356069pbc.38.2013.05.14.01.45.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 01:45:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.401.gfc9adf8
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368518327.git.worldhello.net@gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224286>

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
 builtin/clean.c             | 61 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 7 deletions(-)

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
index ccd4..127463 100644
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
 
@@ -185,6 +186,50 @@ static const char *path_relative(const char *in, const char *prefix)
 	return buf;
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
+			qname = quote_path_relative(item->string, -1, &buf, NULL);
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
@@ -204,6 +249,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
+		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
@@ -230,12 +276,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
 
@@ -309,7 +359,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* TODO: do interactive git-clean here, which will modify del_list */
+	if (interactive && del_list.nr > 0)
+		interactive_main_loop();
 
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
-- 
1.8.3.rc1.404.gb9fcf3e
