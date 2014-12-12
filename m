From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/24] Extract function should_expire_reflog_ent()
Date: Fri, 12 Dec 2014 09:56:47 +0100
Message-ID: <1418374623-5566-9-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3S-0005QU-Id
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934696AbaLLI6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:18 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49444 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964856AbaLLI5X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:23 -0500
X-AuditID: 12074411-f79fa6d000006b8a-52-548aadf3c9c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 06.DC.27530.3FDAA845; Fri, 12 Dec 2014 03:57:23 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nI023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:22 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqPt5bVeIwZWvwhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujB0rNQv2SVVM/nCDqYHxi0gXIyeHhICJxM07r9kgbDGJC/fWA9lcHEIClxkl
	Fk3awg7hHGOSuD9pKxNIFZuArsSinmYwW0RATWJi2yEWEJtZ4ASjxOyGEBBbWMBV4tPXucwg
	NouAqsTfxivsIDavgLPE377NrF2MHEDb5CS2rvMGCXMKuEhcbHkCNkYIqGTrik7WCYy8CxgZ
	VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBJbgDsYZJ+UOMQpwMCrx8L5I
	7QoRYk0sK67MPcQoycGkJMr7fTJQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv3yigHG9KYmVV
	alE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgjduDVCjYFFqempFWmZOCUKaiYMT
	ZDiXlEhxal5KalFiaUlGPCgu4ouBkQGS4gHaGwzSzltckJgLFIVoPcWoKCXO2wqSEABJZJTm
	wY2FpYtXjOJAXwrzngGp4gGmGrjuV0CDmYAGL9/SATK4JBEhJdXAKH7Gr0goXulq/ET2vAyO
	kx+vTL8ZJ/WmL+hSnMRJO7dJv7Sv1Elt+iRW3nQ78vbanQ3+p1waF/AWC7vHHtk777ff5jv3
	RZ4dr7eOqr+i9cQyW72odouZ8VcnU5aaxsXKRY7fTB2dw8pSPG+vdxDUk3r/Kj1N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261342>

Extract from expire_reflog_ent() a function that is solely responsible
for deciding whether a reflog entry should be expired. By separating
this "business logic" from the mechanics of actually expiring entries,
we are working towards the goal of encapsulating reflog expiry within
the refs API, with policy decided by a callback function passed to it
by its caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 70 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ba5b3d3..06ce8b1 100644
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
