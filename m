From: mhagger@alum.mit.edu
Subject: [PATCH 15/28] find_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:28 +0200
Message-ID: <1319804921-17545-16-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbO-0004ys-S1
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab1J1Mb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:58 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55920 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab1J1Mb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:56 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-M0; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184397>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 6bda033..e7d4482 100644
--- a/refs.c
+++ b/refs.c
@@ -363,10 +363,12 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
  * subdirectories as necessary.  If the name is not found or it
  * corresponds to a directory entry, return NULL.
  */
-static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refname)
 {
 	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname, 0);
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = find_containing_dir(&direntry->u.subdir, refname, 0);
 	if (!dir)
 		return NULL;
 	entry = search_ref_dir(dir, refname);
@@ -881,7 +883,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	struct ref_entry *ref;
 	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(&direntry->u.subdir, refname);
+	ref = find_ref(direntry, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -953,7 +955,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(&packed->u.subdir, refname);
+	struct ref_entry *entry = find_ref(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -1113,7 +1115,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
+		struct ref_entry *r = find_ref(direntry, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1650,7 +1652,7 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	if (find_ref(&packed->u.subdir, refname) == NULL)
+	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-- 
1.7.7
