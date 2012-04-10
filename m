From: mhagger@alum.mit.edu
Subject: [PATCH 04/15] do_for_each_ref_in_arrays(): new function
Date: Tue, 10 Apr 2012 07:30:16 +0200
Message-ID: <1334035827-20331-5-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfd-0002Gn-GO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2DJFa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:30:56 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59196 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab2DJFav (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:51 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdv000870;
	Tue, 10 Apr 2012 07:30:43 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195061>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract function do_for_each_ref_in_arrays() from do_for_each_ref().
The new function will be a useful building block for storing refs
hierarchically.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   82 +++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index 263bd81..f9a1b57 100644
--- a/refs.c
+++ b/refs.c
@@ -288,6 +288,52 @@ static int do_for_each_ref_in_array(struct ref_array *array, int offset,
 }
 
 /*
+ * Call fn for each reference in the union of array1 and array2, in
+ * order by refname.  If an entry appears in both array1 and array2,
+ * then only process the version that is in array2.  The input arrays
+ * must already be sorted.
+ */
+static int do_for_each_ref_in_arrays(struct ref_array *array1,
+				     struct ref_array *array2,
+				     const char *base, each_ref_fn fn, int trim,
+				     int flags, void *cb_data)
+{
+	int retval;
+	int i1 = 0, i2 = 0;
+
+	assert(array1->sorted == array1->nr);
+	assert(array2->sorted == array2->nr);
+	while (i1 < array1->nr && i2 < array2->nr) {
+		struct ref_entry *e1 = array1->refs[i1];
+		struct ref_entry *e2 = array2->refs[i2];
+		int cmp = strcmp(e1->name, e2->name);
+		if (cmp < 0) {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
+			i1++;
+		} else {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
+			i2++;
+			if (cmp == 0) {
+				/*
+				 * There was a ref in array1 with the
+				 * same name; ignore it.
+				 */
+				i1++;
+			}
+		}
+		if (retval)
+			return retval;
+	}
+	if (i1 < array1->nr)
+		return do_for_each_ref_in_array(array1, i1,
+						base, fn, trim, flags, cb_data);
+	if (i2 < array2->nr)
+		return do_for_each_ref_in_array(array2, i2,
+						base, fn, trim, flags, cb_data);
+	return 0;
+}
+
+/*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If oldrefname
  * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
@@ -873,36 +919,14 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-	int retval = 0, p = 0, l = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_array *packed = get_packed_refs(refs);
-	struct ref_array *loose = get_loose_refs(refs);
-
-	sort_ref_array(packed);
-	sort_ref_array(loose);
-	while (p < packed->nr && l < loose->nr) {
-		struct ref_entry *entry;
-		int cmp = strcmp(packed->refs[p]->name, loose->refs[l]->name);
-		if (!cmp) {
-			p++;
-			continue;
-		}
-		if (cmp > 0) {
-			entry = loose->refs[l++];
-		} else {
-			entry = packed->refs[p++];
-		}
-		retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
-		if (retval)
-			return retval;
-	}
-
-	if (l < loose->nr)
-		return do_for_each_ref_in_array(loose, l, base, fn, trim, flags, cb_data);
-	if (p < packed->nr)
-		return do_for_each_ref_in_array(packed, p, base, fn, trim, flags, cb_data);
-
-	return 0;
+	struct ref_array *packed_refs = get_packed_refs(refs);
+	struct ref_array *loose_refs = get_loose_refs(refs);
+	sort_ref_array(packed_refs);
+	sort_ref_array(loose_refs);
+	return do_for_each_ref_in_arrays(packed_refs,
+					 loose_refs,
+					 base, fn, trim, flags, cb_data);
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
-- 
1.7.10
