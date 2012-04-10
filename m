From: mhagger@alum.mit.edu
Subject: [PATCH 03/15] do_for_each_ref_in_array(): new function
Date: Tue, 10 Apr 2012 07:30:15 +0200
Message-ID: <1334035827-20331-4-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfe-0002Gn-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab2DJFbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:02 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59204 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab2DJFax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdu000870;
	Tue, 10 Apr 2012 07:30:41 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195063>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract function do_for_each_ref_in_array() from do_for_each_ref().
The new function will be a useful building block for storing refs
hierarchically.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 20d5300..263bd81 100644
--- a/refs.c
+++ b/refs.c
@@ -269,6 +269,25 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 }
 
 /*
+ * Call fn for each reference in array that has index in the range
+ * offset <= index < array->nr.  This function does not sort the
+ * array; sorting should be done by the caller.
+ */
+static int do_for_each_ref_in_array(struct ref_array *array, int offset,
+				    const char *base,
+				    each_ref_fn fn, int trim, int flags, void *cb_data)
+{
+	int i;
+	assert(array->sorted == array->nr);
+	for (i = offset; i < array->nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, array->refs[i]);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
+/*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If oldrefname
  * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
@@ -878,16 +897,10 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			return retval;
 	}
 
-	if (l < loose->nr) {
-		p = l;
-		packed = loose;
-	}
-
-	for (; p < packed->nr; p++) {
-		retval = do_one_ref(base, fn, trim, flags, cb_data, packed->refs[p]);
-		if (retval)
-			return retval;
-	}
+	if (l < loose->nr)
+		return do_for_each_ref_in_array(loose, l, base, fn, trim, flags, cb_data);
+	if (p < packed->nr)
+		return do_for_each_ref_in_array(packed, p, base, fn, trim, flags, cb_data);
 
 	return 0;
 }
-- 
1.7.10
