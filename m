From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/12] refs: manage lifetime of packed refs cache via reference counting
Date: Thu, 20 Jun 2013 10:37:47 +0200
Message-ID: <1371717474-28942-6-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaSd-0008MN-NA
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935303Ab3FTInO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:43:14 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44060 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935185Ab3FTIiP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:15 -0400
X-AuditID: 12074414-b7f626d0000001f1-3f-51c2bf77674b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A3.D8.00497.77FB2C15; Thu, 20 Jun 2013 04:38:15 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sD001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:14 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqFu+/1CgwdZWOYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ1zaUF0wSbTi3sQDTA2MHYJdjJwcEgImEtN/fGKDsMUkLtxbD2Rz
	cQgJXGaUWL5lNiuEc45J4nPTbkaQKjYBXYlFPc1MILaIgJrExLZDLCBFzAK7gTpOn2IHSQgL
	REts2D8PrIFFQFViefs3sAZeAReJO/c+s0CsU5CY8vA9M4jNKeAq8ebwHFYQWwioZuuuHawT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJNJEdjEdOyh1iFOBg
	VOLh1bh8MFCINbGsuDL3EKMkB5OSKO/cfYcChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwps4B
	yvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfA+BBkqWJSanlqRlplT
	gpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2LgNp5y0uSMwFikK0nmLU5Zh8dst7
	RiGWvPy8VClx3scgRQIgRRmleXArYGnlFaM40MfCvBdAqniAKQlu0iugJUxAS/asBltSkoiQ
	kmpgnHrYn1v++QKHWwov1z5d2HFh39nqg2w/KqdXyOomWxeHtL9jPfQoUUA39/qHG3sP1fsV
	Oc+fvVPt7NHDps3X58xg+sTzfgbzl7q2253ie88IJzN/U9klsOuBirOl7lQxLdPG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228461>

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
index b345799..80c172f 100644
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
@@ -836,14 +844,38 @@ static struct ref_cache {
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
 
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
 
@@ -1024,6 +1056,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 		FILE *f;
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
+		acquire_packed_ref_cache(refs->packed);
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
 		if (*refs->name)
 			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
-- 
1.8.3.1
