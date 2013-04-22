From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/33] refs: extract a function write_packed_entry()
Date: Mon, 22 Apr 2013 21:52:30 +0200
Message-ID: <1366660361-21831-23-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMod-0005VC-0P
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab3DVTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:07 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:54693 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755150Ab3DVTx7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:59 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-7d-51759557a60a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 54.DA.02380.75595715; Mon, 22 Apr 2013 15:53:59 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOZ008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:58 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqBs+tTTQ4MFZVouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y/W0Ge8FP4YqtO36zNDD+
	4e9i5OSQEDCR2Nr7kwnCFpO4cG89WxcjF4eQwGVGiX0r25kgnAtMErMvrGUHqWIT0JVY1NMM
	1iEioCYxse0QC4jNLOAgsflzIyOILSzgLrF42kKgSRwcLAKqErsXuoGEeQVcJTac/MUMsUxB
	4vj2bWDlnEDx0x0nwMYICbhIrDg4lWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrG
	ermZJXqpKaWbGCGhwreDsX29zCFGAQ5GJR5eAffSQCHWxLLiytxDjJIcTEqivBxTgEJ8Sfkp
	lRmJxRnxRaU5qcWHGCU4mJVEeEXzgXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQneb5OBGgWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGSJDtvMUFibnFmekQRacYFaXE
	ed0mASUEQBIZpXlwA2BR/YpRHOgfYd5LIHt4gAkBrvsV0GAmoMGZCSUgg0sSEVJSDYzyM07P
	1IqZNe33h+stfuwf7ucp3Yy/614eMT2Vl7Ne7ZZaSEWLuefqK0IhsTWr7oVt4g6+e/j21EcB
	Dk0nDqWfOdnXe9xFrmpW4Cy95uWPzj3UOvpSQuQi+3X9vq/xzMxT97uv37SkwWc9/wS2lVXX
	Du9jP++1uaR37mO5ZfbCfPsnvF9jlnNUiaU4I9FQi7moOBEAXiqhd8UCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222065>

Extract the I/O code from the "business logic" in repack_ref_fn().
Later there will be another caller for this function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index ff4c5f1..42298db 100644
--- a/refs.c
+++ b/refs.c
@@ -1958,12 +1958,36 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 	return lock_ref_sha1_basic(refname, old_sha1, flags, NULL);
 }
 
-static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
+/*
+ * Write an entry to the packed-refs file for the specified refname.
+ * If peeled is non-NULL, write it as the entry's peeled value.
+ */
+static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
+			       unsigned char *peeled)
 {
-	int *fd = cb_data;
 	char line[PATH_MAX + 100];
 	int len;
 
+	len = snprintf(line, sizeof(line), "%s %s\n",
+		       sha1_to_hex(sha1), refname);
+	/* this should not happen but just being defensive */
+	if (len > sizeof(line))
+		die("too long a refname '%s'", refname);
+	write_or_die(fd, line, len);
+
+	if (peeled) {
+		if (snprintf(line, sizeof(line), "^%s\n",
+			     sha1_to_hex(peeled)) != PEELED_LINE_LENGTH)
+			die("internal error");
+		write_or_die(fd, line, PEELED_LINE_LENGTH);
+	}
+}
+
+static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
+{
+	int *fd = cb_data;
+	enum peel_status peel_status;
+
 	if (entry->flag & REF_ISBROKEN) {
 		/* This shouldn't happen to packed refs. */
 		error("%s is broken!", entry->name);
@@ -1999,20 +2023,10 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 		return 0;
 	}
 
-	len = snprintf(line, sizeof(line), "%s %s\n",
-		       sha1_to_hex(entry->u.value.sha1), entry->name);
-	/* this should not happen but just being defensive */
-	if (len > sizeof(line))
-		die("too long a refname '%s'", entry->name);
-	write_or_die(*fd, line, len);
-	if (!peel_entry(entry)) {
-		/* This reference could be peeled; write the peeled value: */
-		if (snprintf(line, sizeof(line), "^%s\n",
-			     sha1_to_hex(entry->u.value.peeled)) !=
-		    PEELED_LINE_LENGTH)
-			die("internal error");
-		write_or_die(*fd, line, PEELED_LINE_LENGTH);
-	}
+	peel_status = peel_entry(entry);
+	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
+			   peel_status == PEEL_PEELED ?
+			   entry->u.value.peeled : NULL);
 
 	return 0;
 }
-- 
1.8.2.1
