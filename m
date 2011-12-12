From: mhagger@alum.mit.edu
Subject: [PATCH v2 23/51] is_refname_available(): reimplement using do_for_each_ref_in_array()
Date: Mon, 12 Dec 2011 06:38:30 +0100
Message-ID: <1323668338-1764-24-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycf-0000Sq-Gf
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1LLFkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34728 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1LLFkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:12 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aa015577;
	Mon, 12 Dec 2011 06:40:02 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186839>

From: Michael Haggerty <mhagger@alum.mit.edu>

This implementation will survive upcoming changes to the ref_array
data structure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 12a70c1..064a70f 100644
--- a/refs.c
+++ b/refs.c
@@ -1100,6 +1100,25 @@ static int names_conflict(const char *refname1, const char *refname2)
 		|| (*refname1 == '/' && *refname2 == '\0');
 }
 
+struct name_conflict_cb {
+	const char *refname;
+	const char *oldrefname;
+	const char *conflicting_refname;
+};
+
+static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
+			    int flags, void *cb_data)
+{
+	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+		return 0;
+	if (names_conflict(data->refname, existingrefname)) {
+		data->conflicting_refname = existingrefname;
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference.  If oldrefname
@@ -1110,16 +1129,17 @@ static int names_conflict(const char *refname1, const char *refname2)
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
+	struct name_conflict_cb data;
+	data.refname = refname;
+	data.oldrefname = oldrefname;
+	data.conflicting_refname = NULL;
+
+	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
+				     0, DO_FOR_EACH_INCLUDE_BROKEN,
+				     &data)) {
+		error("'%s' exists; cannot create '%s'",
+		      data.conflicting_refname, refname);
+		return 0;
 	}
 	return 1;
 }
-- 
1.7.8
