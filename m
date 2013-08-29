From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 5/7] refs: add function to repack without multiple refs
Date: Thu, 29 Aug 2013 10:11:53 -0400
Message-ID: <85ef4bbb02b7648560d016a5b7ec62df9d394bdb.1377784597.git.brad.king@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 16:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF37J-0000xR-AP
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3H2OWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 10:22:16 -0400
Received: from tripoint.kitware.com ([66.194.253.20]:48738 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213Ab3H2OWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 10:22:15 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 791749FB8C; Thu, 29 Aug 2013 10:11:55 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1377784597.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233259>

Generalize repack_without_ref as repack_without_refs to support a list
of refs and implement the former in terms of the latter.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 refs.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 5908648..5a6c14e 100644
--- a/refs.c
+++ b/refs.c
@@ -2414,25 +2414,35 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
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
+	/* Look for a packed ref: */
+	for (i = 0; i < n; ++i)
+		if (get_packed_ref(refnames[i]))
+			break;
 
-	if (!get_packed_ref(refname))
-		return 0; /* refname does not exist in packed refs */
+	/* Avoid locking if we have nothing to do: */
+	if(i == n)
+		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refname);
+		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
 	packed = get_packed_refs(&ref_cache);
 
-	/* Remove refname from the cache: */
-	if (remove_entry(packed, refname) == -1) {
+	/* Remove refnames from the cache: */
+	for (i = 0; i < n; ++i)
+		if (remove_entry(packed, refnames[i]) != -1)
+			removed = 1;
+	if (!removed) {
 		/*
-		 * The packed entry disappeared while we were
+		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
 		rollback_packed_refs();
@@ -2450,6 +2460,11 @@ static int repack_without_ref(const char *refname)
 	return commit_packed_refs();
 }
 
+static int repack_without_ref(const char *refname)
+{
+	return repack_without_refs(&refname, 1);
+}
+
 static int delete_ref_loose(struct ref_lock *lock, int type)
 {
 	int err, i, ret = 0;
-- 
1.7.10.4
