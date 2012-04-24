From: mhagger@alum.mit.edu
Subject: [PATCH 20/30] search_for_subdir(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:26 +0200
Message-ID: <1335307536-26914-21-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofR-0008NB-1c
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab2DXW47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:56:59 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60961 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758396Ab2DXW44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:56 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 0079B248166;
	Wed, 25 Apr 2012 00:46:18 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196263>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index bc4a69b..4bea486 100644
--- a/refs.c
+++ b/refs.c
@@ -277,21 +277,22 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 }
 
 /*
- * Search for a directory entry directly within dir (without
- * recursing).  Sort dir if necessary.  subdirname must be a directory
- * name (i.e., end in '/').  If mkdir is set, then create the
- * directory if it is missing; otherwise, return NULL if the desired
- * directory cannot be found.
+ * Search for a directory entry directly within direntry (without
+ * recursing).  Sort direntry if necessary.  subdirname must be a
+ * directory name (i.e., end in '/').  If mkdir is set, then create
+ * the directory if it is missing; otherwise, return NULL if the
+ * desired directory cannot be found.
  */
-static struct ref_entry *search_for_subdir(struct ref_dir *dir,
+static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 					   const char *subdirname, int mkdir)
 {
-	struct ref_entry *entry = search_ref_dir(dir, subdirname);
+	struct ref_entry *entry = search_ref_dir(&direntry->u.subdir,
+						 subdirname);
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
 		entry = create_dir_entry(subdirname);
-		add_entry_to_dir(dir, entry);
+		add_entry_to_dir(&direntry->u.subdir, entry);
 	}
 	assert(entry->flag & REF_DIR);
 	return entry;
@@ -314,7 +315,7 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
 		char tmp = slash[1];
 		slash[1] = '\0';
-		direntry = search_for_subdir(&direntry->u.subdir, refname_copy, mkdir);
+		direntry = search_for_subdir(direntry, refname_copy, mkdir);
 		slash[1] = tmp;
 		if (!direntry)
 			break;
@@ -812,7 +813,7 @@ static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
 			get_ref_dir(refs,
-				    search_for_subdir(&direntry->u.subdir,
+				    search_for_subdir(direntry,
 						      refname.buf, 1));
 		} else {
 			if (*refs->name) {
@@ -840,8 +841,7 @@ static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
 		get_ref_dir(refs,
-			    search_for_subdir(&refs->loose->u.subdir,
-					      "refs/", 1));
+			    search_for_subdir(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
 }
-- 
1.7.10
