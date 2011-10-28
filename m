From: mhagger@alum.mit.edu
Subject: [PATCH 22/28] sort_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:35 +0200
Message-ID: <1319804921-17545-23-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbi-0005AX-1P
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218Ab1J1McN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:32:13 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55968 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638Ab1J1McM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:32:12 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-QY; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184400>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index c3ee93d..98c8569 100644
--- a/refs.c
+++ b/refs.c
@@ -285,7 +285,7 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
-static void sort_ref_dir(struct ref_dir *dir);
+static void sort_ref_dir(struct ref_entry *direntry);
 
 /*
  * Return the entry with the given refname from the ref_dir
@@ -313,7 +313,7 @@ static struct ref_entry *search_ref_dir(struct ref_entry *direntry, const char *
 	 * references one after the other to a single subdirectory
 	 * doesn't require *any* intermediate sorting.
 	 */
-	sort_ref_dir(dir);
+	sort_ref_dir(direntry);
 
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
@@ -424,11 +424,13 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
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
 
@@ -479,7 +481,7 @@ static int do_for_each_ref_in_dir(struct ref_entry *direntry, int offset,
 	struct ref_dir *dir;
 	assert(direntry->flag & REF_DIR);
 	dir = &direntry->u.subdir;
-	sort_ref_dir(dir);
+	sort_ref_dir(direntry);
 	for (i = offset; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
@@ -508,8 +510,8 @@ static int do_for_each_ref_in_dirs(struct ref_entry *direntry1,
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
1.7.7
