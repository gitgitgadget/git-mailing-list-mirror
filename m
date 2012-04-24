From: mhagger@alum.mit.edu
Subject: [PATCH 29/30] create_dir_entry(): allow the flag value to be passed as an argument
Date: Wed, 25 Apr 2012 00:45:35 +0200
Message-ID: <1335307536-26914-30-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMogG-0000SK-FX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499Ab2DXW5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:51 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60970 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758453Ab2DXW46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:58 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 2B8D1248182;
	Wed, 25 Apr 2012 00:46:28 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196279>

From: Michael Haggerty <mhagger@alum.mit.edu>

In a moment we will support multiple flag values for directory entries.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4eca965..869c9a7 100644
--- a/refs.c
+++ b/refs.c
@@ -231,18 +231,18 @@ static void clear_ref_dir(struct ref_dir *dir)
 }
 
 /*
- * Create a struct ref_entry object for the specified dirname.
+ * Create a struct ref_entry object for the specified dirname and flag.
  * dirname is the name of the directory with a trailing slash (e.g.,
  * "refs/heads/") or "" for the top-level directory.
  */
 static struct ref_entry *create_dir_entry(struct ref_cache *ref_cache,
-					  const char *dirname)
+					  const char *dirname, int flag)
 {
 	struct ref_entry *direntry;
 	int len = strlen(dirname);
 	direntry = xcalloc(1, sizeof(struct ref_entry) + len + 1);
 	memcpy(direntry->name, dirname, len + 1);
-	direntry->flag = REF_DIR;
+	direntry->flag = flag;
 	direntry->u.subdir.ref_cache = ref_cache;
 	return direntry;
 }
@@ -304,7 +304,7 @@ static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 		if (!mkdir)
 			return NULL;
 		entry = create_dir_entry(direntry->u.subdir.ref_cache,
-					 subdirname);
+					 subdirname, REF_DIR);
 		add_entry(direntry, entry);
 	}
 	assert(entry->flag & REF_DIR);
@@ -768,7 +768,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 		const char *packed_refs_file;
 		FILE *f;
 
-		refs->packed = create_dir_entry(refs, "");
+		refs->packed = create_dir_entry(refs, "", REF_DIR);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
 		else
@@ -860,7 +860,7 @@ static void read_loose_refs(struct ref_entry *direntry)
 static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
-		refs->loose = create_dir_entry(refs, "");
+		refs->loose = create_dir_entry(refs, "", REF_DIR);
 		read_loose_refs(search_for_subdir(refs->loose, "refs/", 1));
 	}
 	return refs->loose;
-- 
1.7.10
