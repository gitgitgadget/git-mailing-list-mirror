From: mhagger@alum.mit.edu
Subject: [PATCH v4 2/7] invalidate_ref_cache(): take the submodule as parameter
Date: Mon, 17 Oct 2011 04:38:06 +0200
Message-ID: <1318819091-7066-3-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6W-00026B-QO
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab1JQCiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45405 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab1JQCio (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:44 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3U013403;
	Mon, 17 Oct 2011 04:38:29 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183759>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of invalidating the ref cache on an all-or-nothing basis,
invalidate the cache for a specific submodule.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 02b1ef0..68b73aa 100644
--- a/refs.c
+++ b/refs.c
@@ -202,13 +202,9 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 	return refs;
 }
 
-static void invalidate_ref_cache(void)
+static void invalidate_ref_cache(const char *submodule)
 {
-	struct ref_cache *refs = ref_cache;
-	while (refs) {
-		clear_ref_cache(refs);
-		refs = refs->next;
-	}
+	clear_ref_cache(get_ref_cache(submodule));
 }
 
 static void read_packed_refs(FILE *f, struct ref_array *array)
@@ -1228,7 +1224,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_ref_cache();
+	invalidate_ref_cache(NULL);
 	unlock_ref(lock);
 	return ret;
 }
@@ -1527,7 +1523,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_ref_cache();
+	invalidate_ref_cache(NULL);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
