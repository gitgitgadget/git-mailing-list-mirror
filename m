From: Brad King <brad.king@kitware.com>
Subject: [PATCH v4 5/8] refs: add function to repack without multiple refs
Date: Wed,  4 Sep 2013 11:22:42 -0400
Message-ID: <4d330225743473df43ef6145632e731aa1ba95f3.1378307529.git.brad.king@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com>
Cc: gitster@pobox.com, mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 04 17:25:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHEx5-0008E7-8W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 17:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935098Ab3IDPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 11:24:45 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:60256 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935084Ab3IDPYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 11:24:39 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 842A89FB95; Wed,  4 Sep 2013 11:22:45 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <cover.1378307529.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233845>

Generalize repack_without_ref as repack_without_refs to support a list
of refs and implement the former in terms of the latter.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index ab9d22e..92d801c 100644
--- a/refs.c
+++ b/refs.c
@@ -2414,42 +2414,57 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_ref(const char *refname)
+static int repack_without_refs(const char **refnames, int n)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
+	int i, removed = 0;
+
+	/* Look for a packed ref */
+	for (i = 0; i < n; i++)
+		if (get_packed_ref(refnames[i]))
+			break;
 
-	if (!get_packed_ref(refname))
-		return 0; /* refname does not exist in packed refs */
+	/* Avoid locking if we have nothing to do */
+	if (i == n)
+		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refname);
+		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
 	packed = get_packed_refs(&ref_cache);
 
-	/* Remove refname from the cache: */
-	if (remove_entry(packed, refname) == -1) {
+	/* Remove refnames from the cache */
+	for (i = 0; i < n; i++)
+		if (remove_entry(packed, refnames[i]) != -1)
+			removed = 1;
+	if (!removed) {
 		/*
-		 * The packed entry disappeared while we were
+		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
 		rollback_packed_refs();
 		return 0;
 	}
 
-	/* Remove any other accumulated cruft: */
+	/* Remove any other accumulated cruft */
 	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		if (remove_entry(packed, ref_to_delete->string) == -1)
 			die("internal error");
 	}
 
-	/* Write what remains: */
+	/* Write what remains */
 	return commit_packed_refs();
 }
 
+static int repack_without_ref(const char *refname)
+{
+	return repack_without_refs(&refname, 1);
+}
+
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-- 
1.8.4.rc3
