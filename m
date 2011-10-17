From: mhagger@alum.mit.edu
Subject: [PATCH v2 09/14] is_dup_ref(): extract function from sort_ref_array()
Date: Mon, 17 Oct 2011 09:39:18 +0200
Message-ID: <1318837163-27112-10-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnk-0007mH-OY
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1JQHjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:45 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33597 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1JQHjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:42 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhd-0000eM-OR; Mon, 17 Oct 2011 09:33:41 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183776>

From: Michael Haggerty <mhagger@alum.mit.edu>

Giving it a name makes the code easier to understand.  And the new
function will be convenient later when it has to be called from
multiple places.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ea0f598..7417f9a 100644
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
@@ -98,11 +117,7 @@ static void sort_ref_array(struct ref_array *array)
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
