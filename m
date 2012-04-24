From: mhagger@alum.mit.edu
Subject: [PATCH 16/30] add_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:22 +0200
Message-ID: <1335307536-26914-17-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofh-00005X-CG
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758478Ab2DXW5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:03 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60965 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758439Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id BFE16248162;
	Wed, 25 Apr 2012 00:46:13 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196266>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 694d802..6077cfb 100644
--- a/refs.c
+++ b/refs.c
@@ -345,13 +345,15 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
 }
 
 /*
- * Add a ref_entry to the ref_dir (unsorted), recursing into
- * subdirectories as necessary.  dir must represent the top-level
- * directory.  Return 0 on success.
+ * Add ref to the direntry (unsorted), recursing into subdirectories
+ * as necessary.  direntry must represent the top-level directory.
+ * Return 0 on success.
  */
-static int add_ref(struct ref_dir *dir, struct ref_entry *ref)
+static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 {
-	dir = find_containing_dir(dir, ref->name, 1);
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = find_containing_dir(&direntry->u.subdir, ref->name, 1);
 	if (!dir)
 		return -1;
 	add_entry_to_dir(dir, ref);
@@ -731,7 +733,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(&direntry->u.subdir, last);
+			add_ref(direntry, last);
 			continue;
 		}
 		if (last &&
@@ -765,7 +767,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
-	add_ref(&get_packed_refs(get_ref_cache(NULL))->u.subdir,
+	add_ref(get_packed_refs(get_ref_cache(NULL)),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
-- 
1.7.10
