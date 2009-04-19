From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] rev-list: refactor printing bisect vars
Date: Sun, 19 Apr 2009 11:55:43 +0200
Message-ID: <20090419115543.ed8220e4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTnb-0002MA-1n
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbZDSJ5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbZDSJ5A
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:57:00 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:41637 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659AbZDSJ47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:56:59 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 7E1D9E080C1;
	Sun, 19 Apr 2009 11:56:52 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 366E9E08173;
	Sun, 19 Apr 2009 11:56:50 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116888>

This simplifies the code, and while at it we create the
"print_commit_list" function that will be reused later.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.h           |    4 +++
 builtin-rev-list.c |   61 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/bisect.h b/bisect.h
index cb37ddf..89aa6cb 100644
--- a/bisect.h
+++ b/bisect.h
@@ -9,6 +9,10 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
 					  int show_all);
 
+extern void print_commit_list(struct commit_list *list,
+			      const char *format_cur,
+			      const char *format_last);
+
 /* bisect_show_flags flags in struct rev_list_info */
 #define BISECT_SHOW_ALL		(1<<0)
 #define BISECT_SHOW_TRIED	(1<<1)
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4c5f5ee..d6ec787 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -225,20 +225,37 @@ int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
+void print_commit_list(struct commit_list *list,
+		       const char *format_cur,
+		       const char *format_last)
+{
+	for (;list; list = list->next) {
+		const char *format = list->next ? format_cur : format_last;
+		printf(format, sha1_to_hex(list->item->object.sha1));
+	}
+}
+
 static void show_tried_revs(struct commit_list *tried, int stringed)
 {
 	printf("bisect_tried='");
-	for (;tried; tried = tried->next) {
-		char *format = tried->next ? "%s|" : "%s";
-		printf(format, sha1_to_hex(tried->item->object.sha1));
-	}
+	print_commit_list(tried, "%s|", "%s");
 	printf(stringed ? "' &&\n" : "'\n");
 }
 
+static void print_var_str(const char *var, const char *val, int stringed)
+{
+	printf("%s='%s'%s\n", var, val, stringed ? " &&" : "");
+}
+
+static void print_var_int(const char *var, int val, int stringed)
+{
+	printf("%s=%d%s\n", var, val, stringed ? " &&" : "");
+}
+
 int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
-	int cnt, flags = info->bisect_show_flags;
-	char hex[41] = "", *format;
+	int cnt, stringed, flags = info->bisect_show_flags;
+	char hex[41] = "";
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
 
@@ -268,29 +285,17 @@ int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 		printf("------\n");
 	}
 
+	stringed = flags & BISECT_SHOW_STRINGED;
+
 	if (flags & BISECT_SHOW_TRIED)
-		show_tried_revs(tried, flags & BISECT_SHOW_STRINGED);
-	format = (flags & BISECT_SHOW_STRINGED) ?
-		"bisect_rev=%s &&\n"
-		"bisect_nr=%d &&\n"
-		"bisect_good=%d &&\n"
-		"bisect_bad=%d &&\n"
-		"bisect_all=%d &&\n"
-		"bisect_steps=%d\n"
-		:
-		"bisect_rev=%s\n"
-		"bisect_nr=%d\n"
-		"bisect_good=%d\n"
-		"bisect_bad=%d\n"
-		"bisect_all=%d\n"
-		"bisect_steps=%d\n";
-	printf(format,
-	       hex,
-	       cnt - 1,
-	       all - reaches - 1,
-	       reaches - 1,
-	       all,
-	       estimate_bisect_steps(all));
+		show_tried_revs(tried, stringed);
+
+	print_var_str("bisect_rev", hex, stringed);
+	print_var_int("bisect_nr", cnt - 1, stringed);
+	print_var_int("bisect_good", all - reaches - 1, stringed);
+	print_var_int("bisect_bad", reaches - 1, stringed);
+	print_var_int("bisect_all", all, stringed);
+	print_var_int("bisect_steps", estimate_bisect_steps(all), 0);
 
 	return 0;
 }
-- 
1.6.2.2.537.g3b83b
