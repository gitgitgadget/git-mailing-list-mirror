From: mhagger@alum.mit.edu
Subject: [PATCH v2 38/51] find_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:45 +0100
Message-ID: <1323668338-1764-39-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydT-0000k3-LH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab1LLFks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34910 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab1LLFkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:46 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ap015577;
	Mon, 12 Dec 2011 06:40:36 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186850>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 6b7d374..df7416f 100644
--- a/refs.c
+++ b/refs.c
@@ -321,10 +321,12 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
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
@@ -835,7 +837,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	struct ref_entry *ref;
 	struct ref_entry *direntry = get_packed_refs(refs);
 
-	ref = find_ref(&direntry->u.subdir, refname);
+	ref = find_ref(direntry, refname);
 	if (ref == NULL)
 		return -1;
 
@@ -907,7 +909,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 static int get_packed_ref(const char *refname, unsigned char *sha1)
 {
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(&packed->u.subdir, refname);
+	struct ref_entry *entry = find_ref(packed, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
@@ -1078,7 +1080,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if ((flag & REF_ISPACKED)) {
 		struct ref_entry *direntry = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(&direntry->u.subdir, refname);
+		struct ref_entry *r = find_ref(direntry, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
 			hashcpy(sha1, r->u.value.peeled);
@@ -1608,7 +1610,7 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
-	if (find_ref(&packed->u.subdir, refname) == NULL)
+	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-- 
1.7.8
