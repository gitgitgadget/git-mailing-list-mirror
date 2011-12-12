From: mhagger@alum.mit.edu
Subject: [PATCH v2 30/51] sort_ref_dir(): do not sort if already sorted
Date: Mon, 12 Dec 2011 06:38:37 +0100
Message-ID: <1323668338-1764-31-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeH-00015m-2m
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab1LLFln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34812 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1LLFk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:28 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ah015577;
	Mon, 12 Dec 2011 06:40:18 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186874>

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
index ccd2806..ce141ea 100644
--- a/refs.c
+++ b/refs.c
@@ -108,6 +108,10 @@ struct ref_value {
 
 struct ref_dir {
 	int nr, alloc;
+
+	/* How many of the entries in this directory are sorted? */
+	int sorted;
+
 	struct ref_entry **entries;
 };
 
@@ -210,7 +214,7 @@ static void clear_ref_dir(struct ref_dir *dir)
 	for (i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
 	free(dir->entries);
-	dir->nr = dir->alloc = 0;
+	dir->sorted = dir->nr = dir->alloc = 0;
 	dir->entries = NULL;
 }
 
@@ -252,8 +256,9 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 
 	/*
 	 * We need dir to be sorted so that binary search works.
-	 * FIXME: Sorting the array each time is terribly inefficient,
-	 * and has to be changed.
+	 * Calling sort_ref_dir() here is not quite as terribly
+	 * inefficient as it looks, because directories that are
+	 * already sorted are not re-sorted.
 	 */
 	sort_ref_dir(dir);
 
@@ -358,13 +363,27 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
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
 
@@ -381,7 +400,7 @@ static void sort_ref_dir(struct ref_dir *dir)
 			last = dir->entries[i++] = entry;
 		}
 	}
-	dir->nr = i;
+	dir->sorted = dir->nr = i;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
-- 
1.7.8
