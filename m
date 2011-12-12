From: mhagger@alum.mit.edu
Subject: [PATCH v2 19/51] do_for_each_ref_in_arrays(): new function
Date: Mon, 12 Dec 2011 06:38:26 +0100
Message-ID: <1323668338-1764-20-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeH-00015m-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab1LLFlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34723 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1LLFkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:12 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aW015577;
	Mon, 12 Dec 2011 06:39:55 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186872>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract function do_for_each_ref_in_arrays() from do_for_each_ref().
The new function will be a useful building block for storing refs
hierarchically.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   71 +++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index bc14437..601665b 100644
--- a/refs.c
+++ b/refs.c
@@ -714,45 +714,58 @@ static int do_for_each_ref_in_array(struct ref_array *array, int offset,
 	return 0;
 }
 
-static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
-			   int trim, int flags, void *cb_data)
+static int do_for_each_ref_in_arrays(struct ref_array *array1,
+				     struct ref_array *array2,
+				     const char *base, each_ref_fn fn, int trim,
+				     int flags, void *cb_data)
 {
-	int retval = 0, p = 0, l = 0;
-	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_array *packed = get_packed_refs(refs);
-	struct ref_array *loose = get_loose_refs(refs);
+	int retval;
+	int i1 = 0, i2 = 0;
 
-	retval = do_for_each_ref_in_array(&extra_refs, 0,
-					  base, fn, trim, flags, cb_data);
-	if (retval)
-		goto end_each;
-
-	while (p < packed->nr && l < loose->nr) {
-		struct ref_entry *entry;
-		int cmp = strcmp(packed->refs[p]->name, loose->refs[l]->name);
-		if (!cmp) {
-			p++;
+	while (1) {
+		struct ref_entry *e1, *e2;
+		int cmp;
+		if (i1 == array1->nr) {
+			return do_for_each_ref_in_array(array2, i2,
+							base, fn, trim, flags, cb_data);
+		}
+		if (i2 == array2->nr) {
+			return do_for_each_ref_in_array(array1, i1,
+							base, fn, trim, flags, cb_data);
+		}
+		e1 = array1->refs[i1];
+		e2 = array2->refs[i2];
+		cmp = strcmp(e1->name, e2->name);
+		if (cmp == 0) {
+			/* Two refs with the same name; ignore the one from array1. */
+			i1++;
 			continue;
 		}
-		if (cmp > 0) {
-			entry = loose->refs[l++];
+		if (cmp < 0) {
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e1);
+			i1++;
 		} else {
-			entry = packed->refs[p++];
+			retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
+			i2++;
 		}
-		retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
 		if (retval)
-			goto end_each;
+			return retval;
 	}
+}
 
-	if (l < loose->nr) {
-		retval = do_for_each_ref_in_array(loose, l,
-						  base, fn, trim, flags, cb_data);
-	} else {
-		retval = do_for_each_ref_in_array(packed, p,
-						  base, fn, trim, flags, cb_data);
-	}
+static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
+			   int trim, int flags, void *cb_data)
+{
+	int retval = 0;
+	struct ref_cache *refs = get_ref_cache(submodule);
+
+	retval = do_for_each_ref_in_array(&extra_refs, 0,
+					  base, fn, trim, flags, cb_data);
+	if (!retval)
+		retval = do_for_each_ref_in_arrays(get_packed_refs(refs),
+						   get_loose_refs(refs),
+						   base, fn, trim, flags, cb_data);
 
-end_each:
 	current_ref = NULL;
 	return retval;
 }
-- 
1.7.8
