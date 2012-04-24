From: mhagger@alum.mit.edu
Subject: [PATCH 22/30] add_entry(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:28 +0200
Message-ID: <1335307536-26914-23-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofv-0000Gj-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab2DXW5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:18 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60970 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758466Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 40F54248168;
	Wed, 25 Apr 2012 00:46:20 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196272>

From: Michael Haggerty <mhagger@alum.mit.edu>

And rename function add_entry_to_dir() -> add_entry().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 07856fb..a794d3a 100644
--- a/refs.c
+++ b/refs.c
@@ -200,12 +200,14 @@ static void free_ref_entry(struct ref_entry *entry)
 }
 
 /*
- * Add a ref_entry to the end of dir (unsorted).  Entry is always
- * stored directly in dir; no recursion into subdirectories is
- * done.
+ * Add entry to the end of direntry, unsorted.  entry is always stored
+ * directly in direntry; no recursion into subdirectories is done.
  */
-static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
+static void add_entry(struct ref_entry *direntry, struct ref_entry *entry)
 {
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
 	dir->entries[dir->nr++] = entry;
 }
@@ -295,7 +297,7 @@ static struct ref_entry *search_for_subdir(struct ref_entry *direntry,
 		if (!mkdir)
 			return NULL;
 		entry = create_dir_entry(subdirname);
-		add_entry_to_dir(&direntry->u.subdir, entry);
+		add_entry(direntry, entry);
 	}
 	assert(entry->flag & REF_DIR);
 	return entry;
@@ -356,7 +358,7 @@ static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 	direntry = find_containing_direntry(direntry, ref->name, 1);
 	if (!direntry)
 		return -1;
-	add_entry_to_dir(&direntry->u.subdir, ref);
+	add_entry(direntry, ref);
 	return 0;
 }
 
@@ -830,8 +832,8 @@ static void get_ref_dir(struct ref_cache *refs, struct ref_entry *direntry)
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_entry_to_dir(&direntry->u.subdir,
-					 create_ref_entry(refname.buf, sha1, flag, 1));
+			add_entry(direntry,
+				  create_ref_entry(refname.buf, sha1, flag, 1));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
-- 
1.7.10
