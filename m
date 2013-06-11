From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/12] refs: manage lifetime of packed refs cache via reference counting
Date: Tue, 11 Jun 2013 23:48:25 +0200
Message-ID: <1370987312-6761-6-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRV-00043f-L6
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab3FKVtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52120 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756527Ab3FKVtA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:00 -0400
X-AuditID: 1207440c-b7f016d000005997-1a-51b79b4b5492
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.D6.22935.B4B97B15; Tue, 11 Jun 2013 17:48:59 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbit015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:48:58 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqOs9e3ugwc25FhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj9uM1bAXHRCo+9L1ka2A8KtDFyMkhIWAiMXnqWVYIW0ziwr31bF2MXBxCApcZJaa8
	n8YC4Vxgklgy8z07SBWbgK7Eop5mJhBbREBNYmLbIbAiZoF2Rol3zfuYQRLCAhESPVP3go1l
	EVCV6OnezAhi8wo4S+xasJIJYp2cxPs7u1hAbE4BF4mNmzeD9QoB1XzvaWKcwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZIWPHsYPy2TuYQowAHoxIP7wGz7YFC
	rIllxZW5hxglOZiURHnZpgGF+JLyUyozEosz4otKc1KLDzFKcDArifDq5gLleFMSK6tSi/Jh
	UtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvHdnAjUKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg6IjvhgYHyApHqC9fLNA9hYXJOYCRSFaTzHqcmw+P/kdoxBLXn5eqpQ4
	7yOQHQIgRRmleXArYEnkFaM40MfCvBdBqniACQhu0iugJUxAS4oywJaUJCKkpBoY01drbJtZ
	/nv5wmf6/95/y7vRftEwq+X69lkLs/PYy+bUnql++HPxAYsnrIKv5iTxr22RndLMUPxuaTZz
	4hdF810nE+5yGy9vqjuiu6ss6A6TWPBL5sdH+39xKpV9Zdxqs4xL8NHJ7YfCOsp+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227529>

In struct packed_ref_cache, keep a count of the number of users of the
data structure.  Only free the packed ref cache when the reference
count goes to zero rather than when the packed ref cache is cleared.
This mechanism will be used to prevent the cache data structure from
being freed while it is being iterated over.

So far, only the reference in struct ref_cache::packed is counted;
other users will be adjusted in separate commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 114bd5b..b0d77a7 100644
--- a/refs.c
+++ b/refs.c
@@ -806,6 +806,14 @@ struct packed_ref_cache {
 	struct ref_entry *root;
 
 	/*
+	 * Count of references to the data structure in this instance,
+	 * including the pointer from ref_cache::packed if any.  The
+	 * data will not be freed as long as the reference count is
+	 * nonzero.
+	 */
+	unsigned int referrers;
+
+	/*
 	 * Iff the packed-refs file associated with this instance is
 	 * currently locked for writing, this points at the associated
 	 * lock (which is owned by somebody else).
@@ -832,14 +840,38 @@ static struct ref_cache {
 	char name[1];
 } ref_cache, *submodule_ref_caches;
 
+/*
+ * Increment the reference count of *packed_refs.
+ */
+static void acquire_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	packed_refs->referrers++;
+}
+
+/*
+ * Decrease the reference count of *packed_refs.  If it goes to zero,
+ * free *packed_refs and return true; otherwise return false.
+ */
+static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
+{
+	if (!--packed_refs->referrers) {
+		free_ref_entry(packed_refs->root);
+		free(packed_refs);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->packed) {
-		if (refs->packed->lock)
+		struct packed_ref_cache *packed_refs = refs->packed;
+
+		if (packed_refs->lock)
 			die("internal error: packed-ref cache cleared while locked");
-		free_ref_entry(refs->packed->root);
-		free(refs->packed);
 		refs->packed = NULL;
+		release_packed_ref_cache(packed_refs);
 	}
 }
 
@@ -1020,6 +1052,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 		FILE *f;
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
+		acquire_packed_ref_cache(refs->packed);
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
 		refs->packed->fd = -1;
 		if (*refs->name)
-- 
1.8.3
