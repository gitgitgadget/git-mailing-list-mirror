From: mhagger@alum.mit.edu
Subject: [PATCH 07/28] sort_ref_dir(): do not sort if already sorted
Date: Fri, 28 Oct 2011 14:28:20 +0200
Message-ID: <1319804921-17545-8-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYP-0003RI-6m
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab1J1M2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:28:52 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55683 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Hi; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184374>

From: Michael Haggerty <mhagger@alum.mit.edu>

Keep track of how many entries in a ref_dir are already sorted.  In
sort_ref_dir(), only call qsort() if the dir contains unsorted
entries.

We could store a binary "sorted" value instead of an integer, but
storing the number of sorted entries leaves the way open for a couple
of possible future optimizations:

* In sort_ref_dir(), sort *only* the unsorted entries, then merge them
  with the sorted entries.  This should be faster if most of the
  entries are already sorted.

* Teach search_ref_dir() to do a binary search of any sorted entries,
  and if unsuccessful do a linear search of any unsorted entries.
  This would avoid the need to sort the list every time that
  search_ref_dir() is called, and (given some intelligence about how
  often to sort) could significantly improve the speed in certain
  hypothetical usage patterns.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6b4d5d5..8733a08 100644
--- a/refs.c
+++ b/refs.c
@@ -145,6 +145,10 @@ struct ref_value {
 
 struct ref_dir {
 	int nr, alloc;
+
+	/* How many of the entries in this directory are sorted? */
+	int sorted;
+
 	struct ref_entry **entries;
 };
 
@@ -245,7 +249,7 @@ static void clear_ref_dir(struct ref_dir *dir)
 	for (i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
 	free(dir->entries);
-	dir->nr = dir->alloc = 0;
+	dir->sorted = dir->nr = dir->alloc = 0;
 	dir->entries = NULL;
 }
 
@@ -294,8 +298,9 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 
 	/*
 	 * We need dir to be sorted so that binary search works.
-	 * FIXME: Sorting the array each time is terribly inefficient,
-	 * and has to be changed.
+	 * Calling sort_ref_dir() here is not quite as terribly
+	 * inefficient as it looks, because directories that are
+	 * already sorted are not re-sorted.
 	 */
 	sort_ref_dir(dir);
 
@@ -400,13 +405,27 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 	return 1;
 }
 
+/*
+ * Sort the entries in dir and its subdirectories (if they are not
+ * already sorted).
+ */
 static void sort_ref_dir(struct ref_dir *dir)
 {
 	int i, j;
 	struct ref_entry *last = NULL;
 
-	if (!dir->nr)
+	if (dir->sorted == dir->nr) {
+		/*
+		 * This directory is already sorted and de-duped, but
+		 * we still have to sort subdirectories.
+		 */
+		for (i = 0; i < dir->nr; i++) {
+			struct ref_entry *entry = dir->entries[i];
+			if (entry->flag & REF_DIR)
+				sort_ref_dir(&entry->u.subdir);
+		}
 		return;
+	}
 
 	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
@@ -423,7 +442,7 @@ static void sort_ref_dir(struct ref_dir *dir)
 			last = dir->entries[i++] = entry;
 		}
 	}
-	dir->nr = i;
+	dir->sorted = dir->nr = i;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
-- 
1.7.7
