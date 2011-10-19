From: mhagger@alum.mit.edu
Subject: [PATCH 12/12] is_refname_available(): reimplement using do_for_each_ref_in_array()
Date: Wed, 19 Oct 2011 23:44:52 +0200
Message-ID: <1319060692-27216-13-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGe1W-000231-JH
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab1JSVt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:49:59 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33222 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab1JSVt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:49:59 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-Om; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183981>

From: Michael Haggerty <mhagger@alum.mit.edu>

This implementation will survive upcoming changes to the ref_array
data structure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   44 ++++++++++++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 4bc6041..c41d995 100644
--- a/refs.c
+++ b/refs.c
@@ -1102,6 +1102,25 @@ static int names_conflict(const char *refname1, const char *refname2)
 		|| (*refname1 == '/' && *refname2 == '\0');
 }
 
+struct name_conflict_cb {
+       const char *refname;
+       const char *oldrefname;
+       const char *conflicting_refname;
+};
+
+static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
+			    int flags, void *cb_data)
+{
+       struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+       if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+	       return 0;
+       if (names_conflict(data->refname, existingrefname)) {
+	       data->conflicting_refname = existingrefname;
+	       return 1;
+       }
+       return 0;
+}
+
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If oldrefname
@@ -1112,18 +1131,19 @@ static int names_conflict(const char *refname1, const char *refname2)
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_array *array)
 {
-	int i;
-	for (i = 0; i < array->nr; i++ ) {
-		struct ref_entry *entry = array->refs[i];
-		if (oldrefname && !strcmp(oldrefname, entry->name))
-			continue;
-		if (names_conflict(refname, entry->name)) {
-			error("'%s' exists; cannot create '%s'",
-			      entry->name, refname);
-			return 0;
-		}
-	}
-	return 1;
+       struct name_conflict_cb data;
+       data.refname = refname;
+       data.oldrefname = oldrefname;
+       data.conflicting_refname = NULL;
+
+       if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
+				    0, DO_FOR_EACH_INCLUDE_BROKEN,
+				    &data)) {
+	       error("'%s' exists; cannot create '%s'",
+		     data.conflicting_refname, refname);
+	       return 0;
+       }
+       return 1;
 }
 
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
-- 
1.7.7
