From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/23] Extract function should_expire_reflog_ent()
Date: Fri,  5 Dec 2014 00:08:20 +0100
Message-ID: <1417734515-11812-9-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWy-0003Mo-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbaLDXJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:47 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60069 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753262AbaLDXIx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:53 -0500
X-AuditID: 1207440e-f79d26d000001b6e-8f-5480e985e3ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EB.67.07022.589E0845; Thu,  4 Dec 2014 18:08:53 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de5027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:52 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqNv6siHEYN5DcYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xv0JHewFB6Qqfv++z9TA+E2ki5GTQ0LAROLqssPsELaYxIV769m6GLk4hAQu
	M0rM33AWLCEkcIxJonV+FIjNJqArsainmQnEFhFQk5i5ajZYA7PACUaJX5O7GUESwgJOElP/
	d4A1swioSmw7s5AZxOYVcJFoOfqTtYuRA2ibnMTWdd4gYU4BV4mpM1sZIXa5SDzbtJB9AiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghocW3g7F9vcwhRgEORiUe
	3oLd9SFCrIllxZW5hxglOZiURHnPPm0IEeJLyk+pzEgszogvKs1JLT7EKMHBrCTCa3wEKMeb
	klhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuAtfQHUKFiUmp5akZaZU4KQ
	ZuLgBBnOJSVSnJqXklqUWFqSEQ+KjPhiYGyApHiA9paBtPMWFyTmAkUhWk8xKkqJ81qDJARA
	EhmleXBjYQnjFaM40JfCENt5gMkGrvsV0GAmoMFnG2pBBpckIqSkGhhdH+c4P1DqffyZtyNl
	gnNUnmby455lLNO3q+d0F6Rc1pi5KOHRp6J/F9d02d7KYZzLNfNgNd/i7YEMLyYrT54nY84Q
	Pu+orPWq+mtCN67m/FWUuGP749+F2Kq0vdxBDmIiISm7/9asOBog+Ej2/nnrkq3H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260829>

Extracted from expire_reflog_ent() a function that is solely
responsible for deciding whether a reflog entry should be expired. By
separating this "business logic" from the mechanics of actually
expiring entries, we are working towards the goal of encapsulating
reflog expiry within the refs API, with policy decided by a callback
function passed to it by its caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 70 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index d344d45..7bc6e0f 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -288,51 +288,65 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 	return !(commit->object.flags & REACHABLE);
 }
 
-static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
+/*
+ * Return true iff the specified reflog entry should be expired.
+ */
+static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+				    const char *email, unsigned long timestamp, int tz,
+				    const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
 	struct commit *old, *new;
 
 	if (timestamp < cb->cmd->expire_total)
-		goto prune;
-
-	if (cb->cmd->rewrite)
-		osha1 = cb->last_kept_sha1;
+		return 1;
 
 	old = new = NULL;
 	if (cb->cmd->stalefix &&
 	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
-		goto prune;
+		return 1;
 
 	if (timestamp < cb->cmd->expire_unreachable) {
 		if (cb->unreachable_expire_kind == UE_ALWAYS)
-			goto prune;
+			return 1;
 		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
-			goto prune;
+			return 1;
 	}
 
 	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
-		goto prune;
-
-	if (cb->newlog) {
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
-		fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1),
-			email, timestamp, sign, zone,
-			message);
-		hashcpy(cb->last_kept_sha1, nsha1);
-	}
-	if (cb->cmd->verbose)
-		printf("keep %s", message);
+		return 1;
+
 	return 0;
- prune:
-	if (!cb->newlog)
-		printf("would prune %s", message);
-	else if (cb->cmd->verbose)
-		printf("prune %s", message);
+}
+
+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+
+	if (cb->cmd->rewrite)
+		osha1 = cb->last_kept_sha1;
+
+	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
+				     message, cb_data)) {
+		if (!cb->newlog)
+			printf("would prune %s", message);
+		else if (cb->cmd->verbose)
+			printf("prune %s", message);
+	} else {
+		if (cb->newlog) {
+			char sign = (tz < 0) ? '-' : '+';
+			int zone = (tz < 0) ? (-tz) : tz;
+			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+				sha1_to_hex(osha1), sha1_to_hex(nsha1),
+				email, timestamp, sign, zone,
+				message);
+			hashcpy(cb->last_kept_sha1, nsha1);
+		}
+		if (cb->cmd->verbose)
+			printf("keep %s", message);
+	}
 	return 0;
 }
 
-- 
2.1.3
