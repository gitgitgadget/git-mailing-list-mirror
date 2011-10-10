From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] invalidate_cached_refs(): take the submodule as parameter
Date: Mon, 10 Oct 2011 07:46:13 +0200
Message-ID: <1318225574-18785-2-git-send-email-mhagger@alum.mit.edu>
References: <7v39f2rko5.fsf@alter.siamese.dyndns.org>
 <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 07:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD8hC-00064v-NK
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 07:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1JJFq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 01:46:27 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:56642 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab1JJFq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 01:46:27 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RD8bW-0003hC-Od; Mon, 10 Oct 2011 07:40:46 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183224>

Instead of invalidating the refs cache on an all-or-nothing basis,
allow the cache for individual submodules to be invalidated.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2cb93e2..49b73c4 100644
--- a/refs.c
+++ b/refs.c
@@ -223,13 +223,9 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 	return refs;
 }
 
-static void invalidate_cached_refs(void)
+static void invalidate_cached_refs(const char *submodule)
 {
-	struct cached_refs *refs = cached_refs;
-	while (refs) {
-		clear_cached_refs(refs);
-		refs = refs->next;
-	}
+	clear_cached_refs(get_cached_refs(submodule));
 }
 
 static struct ref_list *read_packed_refs(FILE *f)
@@ -1212,7 +1208,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_cached_refs();
+	invalidate_cached_refs(NULL);
 	unlock_ref(lock);
 	return ret;
 }
@@ -1511,7 +1507,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_cached_refs();
+	invalidate_cached_refs(NULL);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
