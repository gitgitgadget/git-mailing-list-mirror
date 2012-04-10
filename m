From: mhagger@alum.mit.edu
Subject: [PATCH 13/15] sort_ref_dir(): simplify logic
Date: Tue, 10 Apr 2012 07:30:25 +0200
Message-ID: <1334035827-20331-14-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTg2-0002SQ-D6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab2DJFbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59272 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab2DJFb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe6000870;
	Tue, 10 Apr 2012 07:31:03 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195071>

From: Michael Haggerty <mhagger@alum.mit.edu>

Use the more usual indexing idiom for clarity.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 4e0cfb2..a3b8428 100644
--- a/refs.c
+++ b/refs.c
@@ -227,11 +227,13 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 }
 
 /*
- * Sort the entries in dir (if they are not already sorted).
+ * Sort the entries in dir (if they are not already sorted)
+ * and remove any duplicate entries.
  */
 static void sort_ref_dir(struct ref_dir *dir)
 {
 	int i, j;
+	struct ref_entry *last = NULL;
 
 	/*
 	 * This check also prevents passing a zero-length array to qsort(),
@@ -242,16 +244,16 @@ static void sort_ref_dir(struct ref_dir *dir)
 
 	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
-	/* Remove any duplicates from the ref_dir */
-	i = 0;
-	for (j = 1; j < dir->nr; j++) {
-		if (is_dup_ref(dir->entries[i], dir->entries[j])) {
-			free_ref_entry(dir->entries[j]);
-			continue;
+	/* Remove any duplicates: */
+	for (i = 0, j = 0; j < dir->nr; j++) {
+		struct ref_entry *entry = dir->entries[j];
+		if (last && is_dup_ref(last, entry)) {
+			free_ref_entry(entry);
+		} else {
+			last = dir->entries[i++] = entry;
 		}
-		dir->entries[++i] = dir->entries[j];
 	}
-	dir->sorted = dir->nr = i + 1;
+	dir->sorted = dir->nr = i;
 }
 
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
-- 
1.7.10
