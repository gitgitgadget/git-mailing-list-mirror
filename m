From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 13/19] dir.c: provide clear_directory() for reclaiming dir_struct memory
Date: Thu, 27 Dec 2012 02:32:32 +0000
Message-ID: <1356575558-2674-14-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hj-0006Tl-Up
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab2L0Cc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:56 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53770 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab2L0Ccv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:51 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 680992E5E6
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:50 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212176>

By the end of a directory traversal, a dir_struct instance will
typically contains pointers to various data structures on the heap.
clear_directory() provides a convenient way to reclaim that memory.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/technical/api-directory-listing.txt |  2 ++
 dir.c                                             | 30 +++++++++++++++++++++++
 dir.h                                             |  1 +
 3 files changed, 33 insertions(+)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index fa9c8ae..fbceb62 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -81,4 +81,6 @@ marked. If you to exclude files, make sure you have loaded index first.
 
 * Use `dir.entries[]`.
 
+* Call `free_directory()` when none of the contained elements are no longer in use.
+
 (JC)
diff --git a/dir.c b/dir.c
index aefe2bb..0d1b7e9 100644
--- a/dir.c
+++ b/dir.c
@@ -1555,3 +1555,33 @@ void free_pathspec(struct pathspec *pathspec)
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
+
+/*
+ * Frees memory within dir which was allocated for exclude lists and
+ * the exclude_stack.  Does not free dir itself.
+ */
+void clear_directory(struct dir_struct *dir)
+{
+	int i, j;
+	struct exclude_list_group *group;
+	struct exclude_list *el;
+	struct exclude_stack *stk;
+
+	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
+		group = &dir->exclude_list_groups[i];
+		for (j = 0; j < group->nr; j++) {
+			el = &group->ary[j];
+			if (i == EXC_DIRS)
+				free((char *)el->src);
+			clear_exclude_list(el);
+		}
+		free(group->ary);
+	}
+
+	stk = dir->exclude_stack;
+	while (stk) {
+		struct exclude_stack *prev = stk->prev;
+		free(stk);
+		stk = prev;
+	}
+}
diff --git a/dir.h b/dir.h
index f91770a..286de4e 100644
--- a/dir.h
+++ b/dir.h
@@ -169,6 +169,7 @@ extern void parse_exclude_pattern(const char **string, int *patternlen, int *fla
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
+extern void clear_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
-- 
1.7.11.2.249.g31c7954
