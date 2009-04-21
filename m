From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] rev-list: remove stringed output flag from
	"show_bisect_vars"
Date: Tue, 21 Apr 2009 07:54:10 +0200
Message-ID: <20090421055411.4006.28030.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 07:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8yq-0003GN-GO
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbZDUFzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 01:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbZDUFzj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:55:39 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:58274 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbZDUFzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 01:55:39 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 17ABDE080B5;
	Tue, 21 Apr 2009 07:55:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id D8C00E0809B;
	Tue, 21 Apr 2009 07:55:29 +0200 (CEST)
X-git-sha1: 6e841a8dd53f48b853b0145cae369ab76c7f2d2a 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117092>

Because it was used only by "git bisect--helper --next-vars" but
the "--next-vars" option has been removed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.h           |    1 -
 builtin-rev-list.c |   32 +++++++++++++++-----------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/bisect.h b/bisect.h
index 908e362..0b5d122 100644
--- a/bisect.h
+++ b/bisect.h
@@ -16,7 +16,6 @@ extern void print_commit_list(struct commit_list *list,
 /* bisect_show_flags flags in struct rev_list_info */
 #define BISECT_SHOW_ALL		(1<<0)
 #define BISECT_SHOW_TRIED	(1<<1)
-#define BISECT_SHOW_STRINGED	(1<<2)
 
 struct rev_list_info {
 	struct rev_info *revs;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 35f88ca..31ea5f4 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -235,26 +235,26 @@ void print_commit_list(struct commit_list *list,
 	}
 }
 
-static void show_tried_revs(struct commit_list *tried, int stringed)
+static void show_tried_revs(struct commit_list *tried)
 {
 	printf("bisect_tried='");
 	print_commit_list(tried, "%s|", "%s");
-	printf(stringed ? "' &&\n" : "'\n");
+	printf("'\n");
 }
 
-static void print_var_str(const char *var, const char *val, int stringed)
+static void print_var_str(const char *var, const char *val)
 {
-	printf("%s='%s'%s\n", var, val, stringed ? " &&" : "");
+	printf("%s='%s'\n", var, val);
 }
 
-static void print_var_int(const char *var, int val, int stringed)
+static void print_var_int(const char *var, int val)
 {
-	printf("%s=%d%s\n", var, val, stringed ? " &&" : "");
+	printf("%s=%d\n", var, val);
 }
 
 int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
-	int cnt, stringed, flags = info->bisect_show_flags;
+	int cnt, flags = info->bisect_show_flags;
 	char hex[41] = "";
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
@@ -285,17 +285,15 @@ int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 		printf("------\n");
 	}
 
-	stringed = flags & BISECT_SHOW_STRINGED;
-
 	if (flags & BISECT_SHOW_TRIED)
-		show_tried_revs(tried, stringed);
-
-	print_var_str("bisect_rev", hex, stringed);
-	print_var_int("bisect_nr", cnt - 1, stringed);
-	print_var_int("bisect_good", all - reaches - 1, stringed);
-	print_var_int("bisect_bad", reaches - 1, stringed);
-	print_var_int("bisect_all", all, stringed);
-	print_var_int("bisect_steps", estimate_bisect_steps(all), 0);
+		show_tried_revs(tried);
+
+	print_var_str("bisect_rev", hex);
+	print_var_int("bisect_nr", cnt - 1);
+	print_var_int("bisect_good", all - reaches - 1);
+	print_var_int("bisect_bad", reaches - 1);
+	print_var_int("bisect_all", all);
+	print_var_int("bisect_steps", estimate_bisect_steps(all));
 
 	return 0;
 }
-- 
1.6.2.2.537.g3b83b
