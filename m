From: mhagger@alum.mit.edu
Subject: [PATCH 28/28] repack_without_ref(): call clear_packed_ref_cache()
Date: Fri, 28 Oct 2011 14:28:41 +0200
Message-ID: <1319804921-17545-29-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlZy-0004Ez-8b
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672Ab1J1Maa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:30:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55777 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552Ab1J1Ma3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:30:29 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Va; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184384>

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
index 6a19d19..bbf9e3e 100644
--- a/refs.c
+++ b/refs.c
@@ -1784,7 +1784,9 @@ static struct lock_file packlock;
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
@@ -1794,6 +1796,7 @@ static int repack_without_ref(const char *refname)
 		return error("cannot delete '%s' from packed refs", refname);
 	}
 	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	clear_packed_ref_cache(refs);
 	return commit_lock_file(&packlock);
 }
 
@@ -1822,6 +1825,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 		if (!(delopt & REF_NODEREF))
 			lock->lk->filename[i] = '.';
+		clear_loose_ref_cache(get_ref_cache(NULL));
 	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
@@ -1830,7 +1834,6 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_ref_cache(NULL);
 	unlock_ref(lock);
 	return ret;
 }
-- 
1.7.7
