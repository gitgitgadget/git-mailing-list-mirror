From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 03/11] dir.c: provide clear_directory() for reclaiming dir_struct memory
Date: Sun,  6 Jan 2013 16:58:05 +0000
Message-ID: <1357491493-11619-4-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYY-0007mE-WE
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab3AFQ6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:20 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45595 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab3AFQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:17 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id BA3702E660
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:16 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212817>

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
index d3f462b..46f362e 100644
--- a/dir.c
+++ b/dir.c
@@ -1557,3 +1557,33 @@ void free_pathspec(struct pathspec *pathspec)
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
+		group = &dir->exclude_list_group[i];
+		for (j = 0; j < group->nr; j++) {
+			el = &group->el[j];
+			if (i == EXC_DIRS)
+				free((char *)el->src);
+			clear_exclude_list(el);
+		}
+		free(group->el);
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
index 64c410e..dd42a3a 100644
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
1.7.11.7.33.gb8feba5
