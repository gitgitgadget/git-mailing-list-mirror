From: mhagger@alum.mit.edu
Subject: [PATCH 21/30] search_ref_dir(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:27 +0200
Message-ID: <1335307536-26914-22-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogb-0000i7-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab2DXW56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:58 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60969 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758451Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 2981B248167;
	Wed, 25 Apr 2012 00:46:19 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196281>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 4bea486..07856fb 100644
--- a/refs.c
+++ b/refs.c
@@ -248,15 +248,19 @@ static int ref_entry_cmp(const void *a, const void *b)
 static void sort_ref_dir(struct ref_dir *dir);
 
 /*
- * Return the entry with the given refname from the ref_dir
- * (non-recursively), sorting dir if necessary.  Return NULL if no
- * such entry is found.
+ * Return the entry with the given refname from direntry
+ * (non-recursively), sorting direntry if necessary.  Return NULL if
+ * no such entry is found.
  */
-static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
+static struct ref_entry *search_ref_dir(struct ref_entry *direntry,
+					const char *refname)
 {
 	struct ref_entry *e, **r;
 	int len;
+	struct ref_dir *dir;
 
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	if (refname == NULL || !dir->nr)
 		return NULL;
 
@@ -286,8 +290,7 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 					   const char *subdirname, int mkdir)
 {
-	struct ref_entry *entry = search_ref_dir(&direntry->u.subdir,
-						 subdirname);
+	struct ref_entry *entry = search_ref_dir(direntry, subdirname);
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
@@ -338,7 +341,7 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
 	direntry = find_containing_direntry(direntry, refname, 0);
 	if (!direntry)
 		return NULL;
-	entry = search_ref_dir(&direntry->u.subdir, refname);
+	entry = search_ref_dir(direntry, refname);
 	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
 }
 
-- 
1.7.10
