From: mhagger@alum.mit.edu
Subject: [PATCH v2 08/51] is_dup_ref(): extract function from sort_ref_array()
Date: Mon, 12 Dec 2011 06:38:15 +0100
Message-ID: <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycZ-0000Sq-NB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1LLFjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:53 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34590 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1LLFjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:45 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aL015577;
	Mon, 12 Dec 2011 06:39:28 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186831>

From: Michael Haggerty <mhagger@alum.mit.edu>

Giving the function a name makes the code easier to understand.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 2252c66..ea058c1 100644
--- a/refs.c
+++ b/refs.c
@@ -84,9 +84,28 @@ static int ref_entry_cmp(const void *a, const void *b)
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
-	int i = 0, j = 1;
+	int i, j;
 
 	/* Nothing to sort unless there are at least two entries */
 	if (array->nr < 2)
@@ -95,19 +114,13 @@ static void sort_ref_array(struct ref_array *array)
 	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
 
 	/* Remove any duplicates from the ref_array */
-	for (; j < array->nr; j++) {
-		struct ref_entry *a = array->refs[i];
-		struct ref_entry *b = array->refs[j];
-		if (!strcmp(a->name, b->name)) {
-			if (hashcmp(a->sha1, b->sha1))
-				die("Duplicated ref, and SHA1s don't match: %s",
-				    a->name);
-			warning("Duplicated ref: %s", a->name);
-			free(b);
+	i = 0;
+	for (j = 1; j < array->nr; j++) {
+		if (is_dup_ref(array->refs[i], array->refs[j])) {
+			free(array->refs[j]);
 			continue;
 		}
-		i++;
-		array->refs[i] = array->refs[j];
+		array->refs[++i] = array->refs[j];
 	}
 	array->nr = i + 1;
 }
-- 
1.7.8
