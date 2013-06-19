From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/12] refs: manage lifetime of packed refs cache via reference counting
Date: Wed, 19 Jun 2013 09:51:26 +0200
Message-ID: <1371628293-28824-6-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBb-0002ed-7a
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab3FSHv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:51:59 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57201 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422Ab3FSHv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:56 -0400
X-AuditID: 12074411-b7f296d000001209-f8-51c1631b6763
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 47.5B.04617.B1361C15; Wed, 19 Jun 2013 03:51:55 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWX002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:54 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCudfDDQ4OQCc4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZxxffp294ItIxbkFkQ2MHwW6GDk5JARMJPa/3McIYYtJXLi3ng3E
	FhK4zChxoU2wi5ELyL7NJLH56kUWkASbgK7Eop5mJhBbREBNYmLbIRaQImaB3YwSy0+fYgdJ
	CAtES/zb8ABsEouAqsSv1ctYuxg5OHgFXCTerVWGWKYgMeXhe2aQMKeAq8TZZZ4Qe10k5p2a
	zDqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJAQE9zBOOOk3CFG
	AQ5GJR7eG6sPBAqxJpYVV+YeYpTkYFIS5WVPOhgoxJeUn1KZkVicEV9UmpNafIhRgoNZSYRX
	zwEox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4A0DGSpYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPior4YmBcgKR4gPYeSQTZW1yQmAsUhWg9xajLMfns
	lveMQix5+XmpUuK8kSA7BECKMkrz4FbAEsorRnGgj4V57UCqeIDJCG7SK6AlTEBLhL7vA1lS
	koiQkmpgbBD+e+VFQOH9s3Hnp3poNh7ZsHv630MiHPe32D9p7y4ofP1LtXzvl6WCy8vEj9z7
	6jsvh8fzCsu3Jy/rb3w+U261Y2OQxoS3RYFbPdifm7+29+PkKMvPVd+hzrV1qaq1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228359>

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
index ad73251..e2e441d 100644
--- a/refs.c
+++ b/refs.c
@@ -810,6 +810,14 @@ struct packed_ref_cache {
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
@@ -833,14 +841,38 @@ static struct ref_cache {
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
 
@@ -1021,6 +1053,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 		FILE *f;
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
+		acquire_packed_ref_cache(refs->packed);
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
-- 
1.8.3.1
