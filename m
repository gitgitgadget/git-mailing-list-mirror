From: mhagger@alum.mit.edu
Subject: [PATCH v2 51/51] repack_without_ref(): call clear_packed_ref_cache()
Date: Mon, 12 Dec 2011 06:38:58 +0100
Message-ID: <1323668338-1764-52-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeE-00015m-5N
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1LLFlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35049 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1LLFlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:08 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8b4015577;
	Mon, 12 Dec 2011 06:40:59 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186869>

From: Michael Haggerty <mhagger@alum.mit.edu>

Call clear_packed_ref_cache() from repack_without_ref().  This is a
more logical place to call it than from delete_ref().  Also,
repack_without_ref() is smart enough to know that it doesn't have to
invalidate the cache if the reference was not found among the packed
refs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 92523fd..3541a73 100644
--- a/refs.c
+++ b/refs.c
@@ -1736,7 +1736,9 @@ static struct lock_file packlock;
 static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
-	struct ref_entry *packed = get_packed_refs(get_ref_cache(NULL));
+	struct ref_cache *refs = get_ref_cache(NULL);
+	struct ref_entry *packed = get_packed_refs(refs);
+
 	if (find_ref(packed, refname) == NULL)
 		return 0;
 	data.refname = refname;
@@ -1746,6 +1748,7 @@ static int repack_without_ref(const char *refname)
 		return error("cannot delete '%s' from packed refs", refname);
 	}
 	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	clear_packed_ref_cache(refs);
 	return commit_lock_file(&packlock);
 }
 
@@ -1774,6 +1777,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 		if (!(delopt & REF_NODEREF))
 			lock->lk->filename[i] = '.';
+		clear_loose_ref_cache(get_ref_cache(NULL));
 	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -1782,7 +1786,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_ref_cache(NULL);
 	unlock_ref(lock);
 	return ret;
 }
-- 
1.7.8
