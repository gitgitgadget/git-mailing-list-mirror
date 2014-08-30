From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] merge-tree: remove unused df_conflict arguments
Date: Sat, 30 Aug 2014 23:40:34 +0200
Message-ID: <540244D2.6070403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNqOK-0004aR-5h
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbaH3Vk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 17:40:56 -0400
Received: from mout.web.de ([212.227.15.4]:53707 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbaH3Vk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 17:40:56 -0400
Received: from [192.168.178.27] ([79.253.135.121]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M3gLx-1YEz6g0Y53-00rLNN; Sat, 30 Aug 2014 23:40:51
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:pvaNWRb4UgMr/fZM0b2fkkXAupUD3/nxVFRly1WnU0YFLyfOFyS
 7LBtet1KDi6gS9mE3yhiMQskU2xhBP6/gAaQmGNjoToKQwvuMiuetv0T084QsbJmD6dMvBI
 MZnqV+jeKOw1dJFMXSAe/pSTWPmI6rJRO4M5kfMGwGj9cwphlft5WHKnwLzbZCJ9p2AHVg/
 UkSAYx9dFRB/senDygpPg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256271>

merge_trees_recursive() stores a pointer to its parameter df_conflict in
its struct traverse_info, but it is never actually used.  Stop doing
that, remove the parameter and inline the function into merge_trees(),
as the latter is now only passing on its parameters.

Remove the parameter df_conflict from unresolved_directory() as well,
now that there is no way to pass it to merge_trees_recursive() through
that function anymore.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/merge-tree.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 61cbde4..f9ab485 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -25,7 +25,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees_recursive(struct tree_desc t[3], const char *base, int df_conflict);
+static void merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -195,8 +195,8 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 	add_merge_entry(final);
 }
 
-static void unresolved_directory(const struct traverse_info *info, struct name_entry n[3],
-				 int df_conflict)
+static void unresolved_directory(const struct traverse_info *info,
+				 struct name_entry n[3])
 {
 	char *newbase;
 	struct name_entry *p;
@@ -218,7 +218,7 @@ static void unresolved_directory(const struct traverse_info *info, struct name_e
 	buf2 = fill_tree_descriptor(t+2, ENTRY_SHA1(n + 2));
 #undef ENTRY_SHA1
 
-	merge_trees_recursive(t, newbase, df_conflict);
+	merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -259,7 +259,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
 			dirmask |= (1 << i);
 	}
 
-	unresolved_directory(info, n, dirmask && (dirmask != mask));
+	unresolved_directory(info, n);
 
 	if (dirmask == mask)
 		return;
@@ -335,21 +335,15 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees_recursive(struct tree_desc t[3], const char *base, int df_conflict)
+static void merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
 	setup_traverse_info(&info, base);
-	info.data = &df_conflict;
 	info.fn = threeway_callback;
 	traverse_trees(3, t, &info);
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
-{
-	merge_trees_recursive(t, base, 0);
-}
-
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 {
 	unsigned char sha1[20];
-- 
2.1.0
