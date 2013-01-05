From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 07/10] log: add --use-mailmap option
Date: Sat,  5 Jan 2013 22:26:43 +0100
Message-ID: <1357421206-5014-8-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:35:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbP5-0007nb-2u
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab3AEVfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:35:21 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:63136 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab3AEVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:35:20 -0500
Received: by mail-we0-f180.google.com with SMTP id t57so8481568wey.39
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0cBNkzm8vodYXgTb3nmwXZMC6z3S5uNn+GKSIc1EZGU=;
        b=xMvFrJDs+4N5am2hmBfp/D0qTlfzZFm/fDZdcA1BtGhEJB4LD9Fq4YYM1uZvS9jXzs
         PyKztw+kjtzUM0DGNmC/VkmVuC0EjM8rGibMgcPwLvwSnkyvc4sYXMzgH9I+ljFVM8o+
         7KEMZT1R7ar2XX4v6fQPGkJhYoYwd33n5faMh+7hrySlq32+1aylNdHhmFg7sI5ZdyVs
         4N7HPxjJf50NBkPbFxpviSVlm03DnXjwlznSBWe7ndaIZtFoYhymBsTqoxLfKCMquTU1
         ml9nMB1rZ0/KtUe1fSf9MB8TJoT8sOzVpNUCxYyd7u9ksKWQ8Oket/ZvI4TkzM9gD21p
         IrpQ==
X-Received: by 10.180.72.232 with SMTP id g8mr3255211wiv.0.1357421240573;
        Sat, 05 Jan 2013 13:27:20 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:19 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212729>

Add the --use-mailmap option to log commands. It allows
to display names from mailmap file when displaying logs,
whatever the format used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/git-log.txt | 5 +++++
 builtin/log.c             | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 585dac4..a99be97 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -47,6 +47,11 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
+--use-mailmap::
+	Use mailmap file to map author and committer names and email
+	to canonical real names and email addresses. See
+	linkgit:git-shortlog[1].
+
 --full-diff::
 	Without this flag, "git log -p <path>..." shows commits that
 	touch the specified paths, and diffs about the same specified
diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..d2bd8ce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -22,6 +22,7 @@
 #include "branch.h"
 #include "streaming.h"
 #include "version.h"
+#include "mailmap.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -94,11 +95,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0;
+	int quiet = 0, source = 0, mailmap = 0;
 
 	const struct option builtin_log_options[] = {
 		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
 		OPT_BOOLEAN(0, "source", &source, N_("show source")),
+		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
@@ -136,6 +138,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
+	if (mailmap) {
+		rev->mailmap = xcalloc(1, sizeof(struct string_list));
+		read_mailmap(rev->mailmap, NULL);
+	}
+
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
-- 
1.7.12.4.3.g2036a08.dirty
