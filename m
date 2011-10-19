From: mhagger@alum.mit.edu
Subject: [PATCH 07/12] do_for_each_ref_in_array(): new function
Date: Wed, 19 Oct 2011 23:44:47 +0200
Message-ID: <1319060692-27216-8-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:46:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdxY-0000P2-R2
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778Ab1JSVpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:45:53 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33134 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1JSVpO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:45:14 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-JH; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183978>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract function do_for_each_ref_in_array() from do_for_each_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 7aef76c..4e60edb 100644
--- a/refs.c
+++ b/refs.c
@@ -696,21 +696,31 @@ fallback:
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
@@ -730,14 +740,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
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
1.7.7
