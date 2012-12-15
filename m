From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 6/7] log: Add --use-mailmap option
Date: Sat, 15 Dec 2012 19:05:53 +0100
Message-ID: <1355594754-27589-7-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw8O-0001RZ-8N
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab2LOSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:29 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63788 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2LOSGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:09 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888863wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rmlLq4XzUad95xSb85LKr9BpEN3Uawpgn70RGUiGZdM=;
        b=aCeihZ/d2ZLlQt/NMRUk3H0YOduv1uCiaxNLhLjhj5duxB3chFWAfQYWhTcI6J89V6
         2eFovs1gjnv3xYFasDXIKqbCAgz4fnQLQVakqSdi9Be+USVsIUOY2CzmF+oKn43GF1Hk
         ofs/FfEOAUfZpBq/IuVdRjpa5XU8NuDUZByCKKkl6FFbabjIoAamsUwwkIrWpuyCQ6PQ
         L6l40zXCl1MSqsQjOVfe2N0nBCQiGY2s3k8QZCEoDUe4hkXOOgg6dtRlrm6rbbjlZPJY
         LdrZUu4orsrxyAOUqd9Z/vcLemR2LE9MjhRG1b1ss2itxieElj4wvhDnRBQgXOPnBBZP
         r7qw==
Received: by 10.180.81.232 with SMTP id d8mr8301733wiy.14.1355594768394;
        Sat, 15 Dec 2012 10:06:08 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:07 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211550>

Add the --use-mailmap option to log commands. It allows
to display names from mailmap file when displaying logs,
whatever the format used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/git-log.txt |    5 +++++
 builtin/log.c             |    9 ++++++++-
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
1.7.9.5
