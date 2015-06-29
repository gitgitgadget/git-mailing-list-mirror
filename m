From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH] --count feature for git shortlog
Date: Sun, 28 Jun 2015 18:22:01 -0700
Message-ID: <1435540922-12208-2-git-send-email-lawrencesiebert@gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Cc: Johannes.Schindelin@gmx.de, apelisse@gmail.com, jrnieder@gmail.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 03:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9NmG-0008TO-To
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 03:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbbF2BWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 21:22:23 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35971 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbbF2BWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 21:22:20 -0400
Received: by ykdr198 with SMTP id r198so102482265ykd.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h8iM8CAwDpNIBmqo3lszjCWX4vFwCv9gRtzB7RTJz0c=;
        b=N8Rb6Gz9ledRVmlras9QkKdAFqGvOGprGfFhtVb7RPH+v4Cgusdxr0oK6ddufO3mzC
         KAki7t5k6OpY6zFjb8Pzo2nvcN5n2tFwMiFkZ8gIHpG844VTyUt/HOqP52Vc3MbdFhcG
         FwzQvQ7x7T+GOQr6Q3d6LaPhpuMsYiVzLWL8T68cngTRwEmYS/yyHna9C4tMm7KZY2uw
         kYlYKNy43vITPXFVi5obpoaE2pJMzdSazGHNbefbX99jiSCla9QwhlOeckz2RQ3mFa4R
         n28gwXYeLDqqBktuEYz5N1858E0G1QnSv/rQY+gKYALCAEitWilKwXJQYn8Nv8RCkeCu
         94lQ==
X-Received: by 10.13.218.71 with SMTP id c68mr15984091ywe.126.1435540938847;
        Sun, 28 Jun 2015 18:22:18 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id c3sm35528470ywd.39.2015.06.28.18.22.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 18:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272929>

--summary is per author --count counts all

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 builtin/shortlog.c | 14 +++++++++-----
 shortlog.h         |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c0bab6a..4b79dc8 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -226,8 +226,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 
 	static const struct option options[] = {
+		 OPT_BOOL('N', "count", &log.show_count,
+			N_("display the total number of commits for all authors")),
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
-			 N_("sort output according to the number of commits per author")),
+			 N_("Sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
 			 N_("Suppress commit descriptions, only provides commit count")),
 		OPT_BOOL('e', "email", &log.email,
@@ -290,8 +292,8 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 void shortlog_output(struct shortlog *log)
 {
 	int i, j;
+  unsigned int count = 0;
 	struct strbuf sb = STRBUF_INIT;
-
 	if (log->sort_by_number)
 		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
 			compare_by_number);
@@ -300,7 +302,9 @@ void shortlog_output(struct shortlog *log)
 
 		if (log->summary) {
 			printf("%6d\t%s\n", onelines->nr, log->list.items[i].string);
-		} else {
+		} else if (log->show_count) {
+        count += onelines->nr;
+    } else {
 			printf("%s (%d):\n", log->list.items[i].string, onelines->nr);
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].string;
@@ -315,13 +319,13 @@ void shortlog_output(struct shortlog *log)
 			}
 			putchar('\n');
 		}
-
 		onelines->strdup_strings = 1;
 		string_list_clear(onelines, 0);
 		free(onelines);
 		log->list.items[i].util = NULL;
 	}
-
+  if (log->show_count) 
+    printf("%d\n", count);
 	strbuf_release(&sb);
 	log->list.strdup_strings = 1;
 	string_list_clear(&log->list, 1);
diff --git a/shortlog.h b/shortlog.h
index de4f86f..57797b7 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -8,6 +8,7 @@ struct shortlog {
 	int summary;
 	int wrap_lines;
 	int sort_by_number;
+	int show_count;
 	int wrap;
 	int in1;
 	int in2;
-- 
1.9.1
