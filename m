From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 02/19] Improve documentation and comments regarding directory traversal API
Date: Thu, 27 Dec 2012 02:32:21 +0000
Message-ID: <1356575558-2674-3-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3HK-0006HI-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab2L0Cco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:44 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53762 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2L0Ccl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:41 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 787EA2E5E6
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:40 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212170>

>From the perspective of a newcomer to the codebase, the directory
traversal API has a few potentially confusing properties.  These
comments clarify a few key aspects and will hopefully make it easier
to understand for other newcomers in the future.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
For some reason this patch was dropped from the v2 series when it was
applied to the 'pu' branch.

 Documentation/technical/api-directory-listing.txt |  9 +++++---
 dir.c                                             |  8 ++++++-
 dir.h                                             | 26 +++++++++++++++++++++--
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 0356d25..944fc39 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -9,8 +9,11 @@ Data structure
 --------------
 
 `struct dir_struct` structure is used to pass directory traversal
-options to the library and to record the paths discovered.  The notable
-options are:
+options to the library and to record the paths discovered.  A single
+`struct dir_struct` is used regardless of whether or not the traversal
+recursively descends into subdirectories.
+
+The notable options are:
 
 `exclude_per_dir`::
 
@@ -39,7 +42,7 @@ options are:
 	If set, recurse into a directory that looks like a git
 	directory.  Otherwise it is shown as a directory.
 
-The result of the enumeration is left in these fields::
+The result of the enumeration is left in these fields:
 
 `entries[]`::
 
diff --git a/dir.c b/dir.c
index ee8e711..89e27a6 100644
--- a/dir.c
+++ b/dir.c
@@ -2,6 +2,8 @@
  * This handles recursive filename detection with exclude
  * files, index knowledge etc..
  *
+ * See Documentation/technical/api-directory-listing.txt
+ *
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
@@ -476,6 +478,10 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
 
+/*
+ * Loads the per-directory exclude list for the substring of base
+ * which has a char length of baselen.
+ */
 static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 {
 	struct exclude_list *el;
@@ -486,7 +492,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
 		return; /* too long a path -- ignore */
 
-	/* Pop the ones that are not the prefix of the path being checked. */
+	/* Pop the directories that are not the prefix of the path being checked. */
 	el = &dir->exclude_list[EXC_DIRS];
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
diff --git a/dir.h b/dir.h
index f5c89e3..e0869bc 100644
--- a/dir.h
+++ b/dir.h
@@ -1,6 +1,8 @@
 #ifndef DIR_H
 #define DIR_H
 
+/* See Documentation/technical/api-directory-listing.txt */
+
 #include "strbuf.h"
 
 struct dir_entry {
@@ -13,6 +15,12 @@ struct dir_entry {
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
 
+/*
+ * Each .gitignore file will be parsed into patterns which are then
+ * appended to the relevant exclude_list (either EXC_DIRS or
+ * EXC_FILE).  exclude_lists are also used to represent the list of
+ * --exclude values passed via CLI args (EXC_CMDL).
+ */
 struct exclude_list {
 	int nr;
 	int alloc;
@@ -26,9 +34,15 @@ struct exclude_list {
 	} **excludes;
 };
 
+/*
+ * The contents of the per-directory exclude files are lazily read on
+ * demand and then cached in memory, one per exclude_stack struct, in
+ * order to avoid opening and parsing each one every time that
+ * directory is traversed.
+ */
 struct exclude_stack {
-	struct exclude_stack *prev;
-	char *filebuf;
+	struct exclude_stack *prev; /* the struct exclude_stack for the parent directory */
+	char *filebuf; /* remember pointer to per-directory exclude file contents so we can free() */
 	int baselen;
 	int exclude_ix;
 };
@@ -59,6 +73,14 @@ struct dir_struct {
 #define EXC_DIRS 1
 #define EXC_FILE 2
 
+	/*
+	 * Temporary variables which are used during loading of the
+	 * per-directory exclude lists.
+	 *
+	 * exclude_stack points to the top of the exclude_stack, and
+	 * basebuf contains the full path to the current
+	 * (sub)directory in the traversal.
+	 */
 	struct exclude_stack *exclude_stack;
 	char basebuf[PATH_MAX];
 };
-- 
1.7.11.2.249.g31c7954
