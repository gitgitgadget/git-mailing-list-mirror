From: mhagger@alum.mit.edu
Subject: [PATCH v2 18/51] do_for_each_ref_in_array(): new function
Date: Mon, 12 Dec 2011 06:38:25 +0100
Message-ID: <1323668338-1764-19-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyce-0000Sq-BN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab1LLFkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34691 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab1LLFkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aV015577;
	Mon, 12 Dec 2011 06:39:53 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186843>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract function do_for_each_ref_in_array() from do_for_each_ref().
The new function will be a useful building block for storing refs
hierarchically.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index fb6fe84..bc14437 100644
--- a/refs.c
+++ b/refs.c
@@ -701,21 +701,31 @@ fallback:
 	return -1;
 }
 
+static int do_for_each_ref_in_array(struct ref_array *array, int offset,
+				    const char *base,
+				    each_ref_fn fn, int trim, int flags, void *cb_data)
+{
+	int i;
+	for (i = offset; i < array->nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-	int retval = 0, i, p = 0, l = 0;
+	int retval = 0, p = 0, l = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_array *packed = get_packed_refs(refs);
 	struct ref_array *loose = get_loose_refs(refs);
 
-	struct ref_array *extra = &extra_refs;
-
-	for (i = 0; i < extra->nr; i++) {
-		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
-		if (retval)
-			goto end_each;
-	}
+	retval = do_for_each_ref_in_array(&extra_refs, 0,
+					  base, fn, trim, flags, cb_data);
+	if (retval)
+		goto end_each;
 
 	while (p < packed->nr && l < loose->nr) {
 		struct ref_entry *entry;
@@ -735,14 +745,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	}
 
 	if (l < loose->nr) {
-		p = l;
-		packed = loose;
-	}
-
-	for (; p < packed->nr; p++) {
-		retval = do_one_ref(base, fn, trim, flags, cb_data, packed->refs[p]);
-		if (retval)
-			goto end_each;
+		retval = do_for_each_ref_in_array(loose, l,
+						  base, fn, trim, flags, cb_data);
+	} else {
+		retval = do_for_each_ref_in_array(packed, p,
+						  base, fn, trim, flags, cb_data);
 	}
 
 end_each:
-- 
1.7.8
