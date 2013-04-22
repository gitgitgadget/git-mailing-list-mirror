From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/33] peel_ref(): fix return value for non-peelable, not-current reference
Date: Mon, 22 Apr 2013 21:52:21 +0200
Message-ID: <1366660361-21831-14-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoR-0005Bt-KX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3DVTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:50 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53461 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab3DVTxr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:47 -0400
X-AuditID: 1207440f-b7f0e6d000000957-9f-5175954aaf6e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 99.0D.02391.A4595715; Mon, 22 Apr 2013 15:53:46 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOQ008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:45 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOs1tTTQ4Nt3FYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7YfXIvW8FXgYq5814yNzBu
	4e1i5OSQEDCRaH05iwXCFpO4cG89WxcjF4eQwGVGiaYNW1ghnAtMEl/fbgCrYhPQlVjU08wE
	YosIqElMbDsEFmcWcJDY/LmREcQWFoiTmNL7hhXEZhFQlZjReJ4ZxOYVcJVYfukvG8Q2BYnj
	27eB1XMCxU93nACbIyTgIrHi4FSWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujl
	ZpbopaaUbmKEBAv/Dsau9TKHGAU4GJV4eDM8SwOFWBPLiitzDzFKcjApifJyTAEK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuEVzQfK8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeDNAhgoWpaanVqRl5pQgpJk4OEEEF8gGHqANkSCFvMUFibnFmekQRacYFaXEed0m
	ASUEQBIZpXlwA2Bx/YpRHOgfYV4PkHYeYEqA634FNJgJaHBmQgnI4JJEhJRUA6OOwaV96YcM
	Dh/JKph5QMo0Z014W8bh63u1X87pjI58bvpqmWRNmLEtz0/WZclX2l/leMaeZ0yd7ilQVv+5
	vP5ChazyzU0tQiaKkqGMvJYsF6oqLzz8XHFPQqnmhAV72Kr9aTzT++99KNbRPPVy+cxtU9ve
	mN+y/rWbVbdihqmhTbBjjxPXbCWW4oxEQy3mouJEADhir9zGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222059>

The old version was inconsistent: when a reference was
REF_KNOWS_PEELED but with a null peeled value, it returned non-zero
for the current reference but zero for other references.  Change the
behavior for non-current references to match that of current_ref,
which is what callers expect.  Document the behavior.

Current callers only call peel_ref() from within a for_each_ref-style
iteration and only for the current ref; therefore, the buggy code path
was never reached.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++++-
 refs.h | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d26e847..2f73189 100644
--- a/refs.c
+++ b/refs.c
@@ -120,7 +120,8 @@ struct ref_value {
 	/*
 	 * If REF_KNOWS_PEELED, then this field holds the peeled value
 	 * of this reference, or null if the reference is known not to
-	 * be peelable.
+	 * be peelable.  See the documentation for peel_ref() for an
+	 * exact definition of "peelable".
 	 */
 	unsigned char peeled[20];
 };
@@ -1339,6 +1340,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		struct ref_entry *r = get_packed_ref(refname);
 
 		if (r && (r->flag & REF_KNOWS_PEELED)) {
+			if (is_null_sha1(r->u.value.peeled))
+			    return -1;
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
 		}
diff --git a/refs.h b/refs.h
index 17bc1c1..ac0ff92 100644
--- a/refs.h
+++ b/refs.h
@@ -74,6 +74,14 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
 
 extern int ref_exists(const char *);
 
+/*
+ * If refname is a non-symbolic reference that refers to a tag object,
+ * and the tag can be (recursively) dereferenced to a non-tag object,
+ * store the SHA1 of the referred-to object to sha1 and return 0.  If
+ * any of these conditions are not met, return a non-zero value.
+ * Symbolic references are considered unpeelable, even if they
+ * ultimately resolve to a peelable tag.
+ */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-- 
1.8.2.1
