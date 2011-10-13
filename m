From: mhagger@alum.mit.edu
Subject: [PATCH 10/14] is_dup_ref(): extract function from sort_ref_list()
Date: Thu, 13 Oct 2011 09:58:31 +0200
Message-ID: <1318492715-5931-11-git-send-email-mhagger@alum.mit.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:59:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGCp-0002CO-3c
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab1JMH7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:59:50 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:34455 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab1JMH7t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:59:49 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1REG6O-0002Mo-T7; Thu, 13 Oct 2011 09:53:16 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183459>

From: Michael Haggerty <mhagger@alum.mit.edu>

Giving it a name makes the code easier to understand.  And the new
function will be convenient later when it has to be called from
multiple places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index cb5bb18..715a41a 100644
--- a/refs.c
+++ b/refs.c
@@ -84,6 +84,25 @@ static int ref_entry_cmp(const void *a, const void *b)
 	return strcmp(one->name, two->name);
 }
 
+/*
+ * Emit a warning and return true iff ref1 and ref2 have the same name
+ * and the same sha1.  Die if they have the same name but different
+ * sha1s.
+ */
+static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2)
+{
+	if (!strcmp(ref1->name, ref2->name)) {
+		/* Duplicate name; make sure that the SHA1s match: */
+		if (hashcmp(ref1->sha1, ref2->sha1))
+			die("Duplicated ref, and SHA1s don't match: %s",
+			    ref1->name);
+		warning("Duplicated ref: %s", ref1->name);
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
 static void sort_ref_array(struct ref_array *array)
 {
 	int i = 0, j = 1;
@@ -94,15 +113,11 @@ static void sort_ref_array(struct ref_array *array)
 
 	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
 
-	/* Remove any duplicates from the ref_array */
+	/* Remove any duplicates from the ref_list */
 	for (; j < array->nr; j++) {
 		struct ref_entry *a = array->refs[i];
 		struct ref_entry *b = array->refs[j];
-		if (!strcmp(a->name, b->name)) {
-			if (hashcmp(a->sha1, b->sha1))
-				die("Duplicated ref, and SHA1s don't match: %s",
-				    a->name);
-			warning("Duplicated ref: %s", a->name);
+		if (is_dup_ref(a, b)) {
 			free(b);
 			continue;
 		}
-- 
1.7.7.rc2
