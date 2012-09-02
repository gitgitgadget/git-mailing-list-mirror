From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 8/9] Provide free_directory() for reclaiming dir_struct memory
Date: Sun,  2 Sep 2012 01:12:10 +0100
Message-ID: <1346544731-938-9-git-send-email-git@adamspiers.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7xvO-0001oR-LP
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 02:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab2IBATu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 20:19:50 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:55522 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab2IBAS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 20:18:57 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 1E9F52E5EE;
	Sun,  2 Sep 2012 01:12:22 +0100 (BST)
X-Mailer: git-send-email 1.7.12.155.ge5750d5.dirty
In-Reply-To: <1346544731-938-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204662>

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/technical/api-directory-listing.txt |  2 ++
 dir.c                                             | 23 +++++++++++++++++++++--
 dir.h                                             |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 944fc39..e339c18 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -79,4 +79,6 @@ marked. If you to exclude files, make sure you have loaded index first.
 
 * Use `dir.entries[]`.
 
+* Call `free_directory()` when none of the contained elements are no longer in use.
+
 (JC)
diff --git a/dir.c b/dir.c
index ac8c838..80f9b22 100644
--- a/dir.c
+++ b/dir.c
@@ -454,6 +454,12 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
 
+static void free_exclude_stack(struct exclude_stack *stk)
+{
+	free(stk->filebuf);
+	free(stk);
+}
+
 /*
  * Loads the per-directory exclude list for the substring of base
  * which has a char length of baselen.
@@ -479,8 +485,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			struct exclude *exclude = el->excludes[--el->nr];
 			free(exclude);
 		}
-		free(stk->filebuf);
-		free(stk);
+		free_exclude_stack(stk);
 	}
 
 	/* Read from the parent directories and push them down. */
@@ -1467,3 +1472,17 @@ void free_pathspec(struct pathspec *pathspec)
 	free(pathspec->items);
 	pathspec->items = NULL;
 }
+
+void free_directory(struct dir_struct *dir)
+{
+	int st;
+	for (st = EXC_CMDL; st <= EXC_FILE; st++)
+		free_excludes(&dir->exclude_list[st]);
+
+	struct exclude_stack *prev, *stk = dir->exclude_stack;
+	while (stk) {
+		prev = stk->prev;
+		free_exclude_stack(stk);
+		stk = prev;
+	}
+}
diff --git a/dir.h b/dir.h
index 81efee4..f7cea9c 100644
--- a/dir.h
+++ b/dir.h
@@ -128,6 +128,7 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, const char *src, int srcpos);
 extern void free_excludes(struct exclude_list *el);
+extern void free_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
 
 extern int is_inside_dir(const char *dir);
-- 
1.7.12.155.ge5750d5.dirty
