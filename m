From: mhagger@alum.mit.edu
Subject: [PATCH v2 45/51] sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:52 +0100
Message-ID: <1323668338-1764-46-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydX-0000k3-1r
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab1LLFlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35002 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab1LLFk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:59 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aw015577;
	Mon, 12 Dec 2011 06:40:50 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186860>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f6d9fe7..4a3546b 100644
--- a/refs.c
+++ b/refs.c
@@ -243,7 +243,7 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
-static void sort_ref_dir(struct ref_dir *dir);
+static void sort_ref_dir(struct ref_entry *direntry);
 
 /*
  * Return the entry with the given refname from the ref_dir
@@ -271,7 +271,7 @@ static struct ref_entry *search_ref_dir(struct ref_entry *direntry, const char *
 	 * references one after the other to a single subdirectory
 	 * doesn't require *any* intermediate sorting.
 	 */
-	sort_ref_dir(dir);
+	sort_ref_dir(direntry);
 
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
@@ -382,11 +382,13 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
  * Sort the entries in dir (if they are not already sorted).  Sort
  * only dir itself, not its subdirectories.
  */
-static void sort_ref_dir(struct ref_dir *dir)
+static void sort_ref_dir(struct ref_entry *direntry)
 {
 	int i, j;
 	struct ref_entry *last = NULL;
-
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	if (dir->sorted == dir->nr)
 		return; /* This directory is already sorted and de-duped */
 
@@ -437,7 +439,7 @@ static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
 	dir = &direntry->u.subdir;
-	sort_ref_dir(dir);
+	sort_ref_dir(direntry);
 	for (i = offset; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
@@ -466,8 +468,8 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
 	assert(direntry2->flag & REF_DIR);
 	dir1 = &direntry1->u.subdir;
 	dir2 = &direntry2->u.subdir;
-	sort_ref_dir(dir1);
-	sort_ref_dir(dir2);
+	sort_ref_dir(direntry1);
+	sort_ref_dir(direntry2);
 	while (1) {
 		struct ref_entry *e1, *e2, *entry;
 		int cmp;
-- 
1.7.8
