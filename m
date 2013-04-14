From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/33] refs: extract a function write_packed_entry()
Date: Sun, 14 Apr 2013 14:54:37 +0200
Message-ID: <1365944088-10588-23-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTQ-0004Wx-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab3DNMzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:55 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54967 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab3DNMzv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:51 -0400
X-AuditID: 1207440f-b7f0e6d000000957-69-516aa756cec9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.7A.02391.657AA615; Sun, 14 Apr 2013 08:55:50 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkJ007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:49 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqBu2PCvQ4OFRE4uuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Yuzq64KVgRfubDuYGxoV8XYwcHBICJhLL9kl3MXICmWISF+6tZwOxhQQuM0r8OMnY
	xcgFZJ9lknjyazULSIJNQFdiUU8zE0iviEC2xO618iBhZgEHic2fGxlBbGEBF4lDvy+wg9gs
	AqoSN/oOgLXyCrhKLFvxnwlil4LE8e3bwOo5geLTnx9jh9jrIjFr82zWCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEBBP/Dsau9TKHGAU4GJV4eB1YsgKFWBPL
	iitzDzFKcjApifIuXAoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLr2AqU401JrKxKLcqHSUlz
	sCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8L4GGSpYlJqeWpGWmVOCkGbi4AQRXCAbeIA2
	vAUp5C0uSMwtzkyHKDrFqCglzvsRJCEAksgozYMbAIv7V4ziQP8I8z4FqeIBpgy47ldAg5mA
	BvvsTQcZXJKIkJJqYGwMvZA2JeXsxVNMlg55j+SOmi7wOBB3Nbvs8Pud1zxWT2AUkq1VvN69
	P3n2poDOnXNTehnfGcecW3rw6QTFvtdXVh2Ifpe/99IBCb7MjFP1Ey/YHMvZuHXHdzb7Zws0
	jzSlHJ9nms8XdSbWOevOGS8/9Sus3DozT7M7qOTtjpxQZ1D2QLuw66cSS3FGoqEW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221108>

Extract the I/O code from the "business logic" in repack_ref_fn().
Later there will be another caller for this function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 140360f..9e3eff2 100644
--- a/refs.c
+++ b/refs.c
@@ -1956,29 +1956,43 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
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
 
-	/* Silently skip broken refs: */
-	if (!ref_resolves_to_object(entry, 0))
-		return 0;
 	len = snprintf(line, sizeof(line), "%s %s\n",
-		       sha1_to_hex(entry->u.value.sha1), entry->name);
+		       sha1_to_hex(sha1), refname);
 	/* this should not happen but just being defensive */
 	if (len > sizeof(line))
-		die("too long a refname '%s'", entry->name);
-	write_or_die(*fd, line, len);
-	if (!peel_entry(entry)) {
-		/* This reference could be peeled; write the peeled value: */
+		die("too long a refname '%s'", refname);
+	write_or_die(fd, line, len);
+
+	if (peeled) {
 		if (snprintf(line, sizeof(line), "^%s\n",
-			     sha1_to_hex(entry->u.value.peeled)) !=
-		    PEELED_LINE_LENGTH)
+			     sha1_to_hex(peeled)) != PEELED_LINE_LENGTH)
 			die("internal error");
-		write_or_die(*fd, line, PEELED_LINE_LENGTH);
+		write_or_die(fd, line, PEELED_LINE_LENGTH);
 	}
+}
+
+static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
+{
+	int *fd = cb_data;
+	enum peel_status peel_status;
+
+	/* Silently skip broken refs: */
+	if (!ref_resolves_to_object(entry, 0))
+		return 0;
+	peel_status = peel_entry(entry);
+	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
+			   peel_status == PEEL_PEELED ?
+			   entry->u.value.peeled : NULL);
 
 	return 0;
 }
-- 
1.8.2.1
