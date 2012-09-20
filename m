From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 02/14] Improve documentation and comments regarding directory traversal API
Date: Thu, 20 Sep 2012 20:46:11 +0100
Message-ID: <1348170383-15751-3-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmif-0000yz-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab2ITTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:47:17 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46173 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab2ITTq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:27 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 1FB562E5E1;
	Thu, 20 Sep 2012 20:46:26 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206086>

>From the perspective of a newcomer to the codebase, the directory
traversal API has a few potentially confusing properties.  These
comments clarify a few key aspects and will hopefully make it easier
to understand for other newcomers in the future.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
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
index 4868339..98d1995 100644
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
@@ -451,6 +453,10 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
 
+/*
+ * Loads the per-directory exclude list for the substring of base
+ * which has a char length of baselen.
+ */
 static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 {
 	struct exclude_list *el;
@@ -461,7 +467,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
 		return; /* too long a path -- ignore */
 
-	/* Pop the ones that are not the prefix of the path being checked. */
+	/* Pop the directories that are not the prefix of the path being checked. */
 	el = &dir->exclude_list[EXC_DIRS];
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
diff --git a/dir.h b/dir.h
index 893465a..a226fbc 100644
--- a/dir.h
+++ b/dir.h
@@ -1,6 +1,8 @@
 #ifndef DIR_H
 #define DIR_H
 
+/* See Documentation/technical/api-directory-listing.txt */
+
 #include "strbuf.h"
 
 struct dir_entry {
@@ -12,6 +14,12 @@ struct dir_entry {
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
 
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
1.7.12.147.g6d168f4
