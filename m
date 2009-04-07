From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] rev-list: add "int bisect_show_flags" in "struct
	rev_list_info"
Date: Tue, 7 Apr 2009 05:08:42 +0200
Message-ID: <20090407040854.4338.21694.chriscool@tuxfamily.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>
	<20090407040854.4338.94304.chriscool@tuxfamily.org>
	<20090407040854.4338.40055.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr2fm-0002PG-OC
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 06:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbZDGEKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 00:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbZDGEKa
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 00:10:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36973 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757876AbZDGEKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 00:10:23 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CFA6181806D;
	Tue,  7 Apr 2009 06:10:14 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8ECAC818083;
	Tue,  7 Apr 2009 06:10:11 +0200 (CEST)
X-git-sha1: 4420aa7af20afbf25f78073c875e59b3aafdf592 
X-Mailer: git-mail-commits v0.2
In-Reply-To: <20090407040854.4338.40055.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115904>

This is a cleanup patch to make it easier to use the
"show_bisect_vars" function and take advantage of the rev_list_info
struct.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c           |    4 ++--
 bisect.h           |    6 +++---
 builtin-rev-list.c |   11 ++++-------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4d2a150..58f7e6f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -540,6 +540,7 @@ int bisect_next_vars(const char *prefix)
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
+	info.bisect_show_flags = BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED;
 
 	bisect_rev_setup(&revs, prefix);
 
@@ -551,6 +552,5 @@ int bisect_next_vars(const char *prefix)
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
 				      !!skipped_sha1_nr);
 
-	return show_bisect_vars(&info, reaches, all,
-				BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED);
+	return show_bisect_vars(&info, reaches, all);
 }
diff --git a/bisect.h b/bisect.h
index b1c334d..fdba913 100644
--- a/bisect.h
+++ b/bisect.h
@@ -9,20 +9,20 @@ extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
 					  int show_all);
 
-/* show_bisect_vars flags */
+/* bisect_show_flags flags in struct rev_list_info */
 #define BISECT_SHOW_ALL		(1<<0)
 #define BISECT_SHOW_TRIED	(1<<1)
 #define BISECT_SHOW_STRINGED	(1<<2)
 
 struct rev_list_info {
 	struct rev_info *revs;
+	int bisect_show_flags;
 	int show_timestamp;
 	int hdr_termination;
 	const char *header_prefix;
 };
 
-extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all,
-			    int flags);
+extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
 
 extern int bisect_next_vars(const char *prefix);
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 244b73e..193993c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -233,10 +233,9 @@ static void show_tried_revs(struct commit_list *tried, int stringed)
 	printf(stringed ? "' &&\n" : "'\n");
 }
 
-int show_bisect_vars(struct rev_list_info *info, int reaches, int all,
-		     int flags)
+int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
-	int cnt;
+	int cnt, flags = info->bisect_show_flags;
 	char hex[41] = "", *format;
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
@@ -303,7 +302,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
-	int bisect_show_all = 0;
 	int quiet = 0;
 
 	git_config(git_default_config, NULL);
@@ -334,7 +332,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--bisect-all")) {
 			bisect_list = 1;
 			bisect_find_all = 1;
-			bisect_show_all = 1;
+			info.bisect_show_flags = BISECT_SHOW_ALL;
 			revs.show_decorations = 1;
 			continue;
 		}
@@ -387,8 +385,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 					      bisect_find_all);
 
 		if (bisect_show_vars)
-			return show_bisect_vars(&info, reaches, all,
-						bisect_show_all ? BISECT_SHOW_ALL : 0);
+			return show_bisect_vars(&info, reaches, all);
 	}
 
 	traverse_commit_list(&revs,
-- 
1.6.2.2.537.g3b83b
