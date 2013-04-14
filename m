From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/33] peel_ref(): fix return value for non-peelable, not-current reference
Date: Sun, 14 Apr 2013 14:54:28 +0200
Message-ID: <1365944088-10588-14-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMU7-0005OY-94
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab3DNM4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:35 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53347 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751925Ab3DNMzg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:36 -0400
X-AuditID: 12074413-b7f226d000000902-e4-516aa748c0fd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BE.D6.02306.847AA615; Sun, 14 Apr 2013 08:55:36 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkA007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:35 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqOuxPCvQ4M9GEYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5o+TyLpWCSQMWWXr8Gxsc8XYycHBICJhKLb35khLDFJC7cW8/WxcjFISRwmVFixr75
	jBDOWSaJ/d82soJUsQnoSizqaWbqYuTgEBHIlti9Vh4kzCzgILH5cyPYIGGBaImfX94xg9gs
	AqoS03+/YAEp5xVwlfjzIQ1il4LE8e3bwMo5gcLTnx9jB7GFBFwkZm2ezTqBkXcBI8MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJBwEt7BuOuk3CFGAQ5GJR7eF4xZgUKs
	iWXFlbmHGCU5mJREeRWXAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Dq2AuV4UxIrq1KL8mFS
	0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8r5cCNQoWpaanVqRl5pQgpJk4OEEEF8gG
	HqANb0EKeYsLEnOLM9Mhik4xKkqJ834ESQiAJDJK8+AGwCL/FaM40D/CvE9BqniASQOu+xXQ
	YCagwT5700EGlyQipKQaGPlnNqV2Or/5xrYm4Wrkk0V9Wg+P+z7XZrdcWdiyTexuts2TuFn3
	xbjCag3Wxmxy9l90sJwpfu7/9zmcPkxHp+4wroze0DHpqwin1B1rCQ+DlqqSSzda5bjEm+Z9
	mrf/+LFTfyon3leLtwsxkgzePTvsx4PJn28JPcvlnMQibPnnS+yHFUFsHEosxRmJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221122>

The old version was inconsistent: when a reference was
REF_KNOWS_PEELED but with a null peeled value, it returned non-zero
for the current reference but zero for other references.  Change the
behavior for non-current references to match that of current_ref,
which is what callers expect.  Document the behavior.

Current callers did not trigger the previously-buggy behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++++-
 refs.h | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 84c2497..a0d8e32 100644
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
