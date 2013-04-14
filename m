From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/33] get_packed_ref(): return a ref_entry
Date: Sun, 14 Apr 2013 14:54:22 +0200
Message-ID: <1365944088-10588-8-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMU1-0005J6-Cx
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab3DNMze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:34 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52901 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845Ab3DNMz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:27 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-73-516aa73e238f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 06.D8.02380.E37AA615; Sun, 14 Apr 2013 08:55:26 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk4007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:25 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqGu3PCvQYHa/pUXXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGe0HVrPXtDCXzG7YRtrA+Mn7i5GTg4JAROJSVsXskDYYhIX7q1n62Lk4hASuMwocfnu
	QiYI5yyTxOo7EFVsAroSi3qagRIcHCIC2RK718qDhJkFHCQ2f25kBLGFBawlFl3bxA5iswio
	Sry6eosNxOYVcJG4tXMNI8QyBYnj27eB2ZwCrhLTnx8DqxcCqpm1eTbrBEbeBYwMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCQopvB2P7eplDjAIcjEo8vC8YswKFWBPL
	iitzDzFKcjApifKeXAYU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLr2AqU401JrKxKLcqHSUlz
	sCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8E4DGSpYlJqeWpGWmVOCkGbi4AQRXCAbeIA2
	zAMp5C0uSMwtzkyHKDrFqCglzpsCkhAASWSU5sENgEX/K0ZxoH+EIfbwABMHXPcroMFMQIN9
	9qaDDC5JREhJNTAuF9mgnf7+z82slaYtZx9pS30ujoh6cTb/lk/KSd4/Sc4vyl2u8XBfS779
	QrH5nUjXtA1q9Rta/4tsv6j3iuU4S3DLfBe9S/fZFuzONDZ6XOG5JWiHX+EXk7A/v27uSd01
	6ecxH5uHMfKng0/1tK8WEHsu+jtk2+H9vbP/fct6s9ZhvsYmVQ9eJZbijERDLeai 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221120>

Instead of copying the reference's SHA1 into a caller-supplied
variable, just return the ref_entry itself (or NULL if there is no
such entry).  This change will allow the function to be used from
elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 9f508dd..de5dc7d 100644
--- a/refs.c
+++ b/refs.c
@@ -1100,18 +1100,12 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 }
 
 /*
- * Try to read ref from the packed references.  On success, set sha1
- * and return 0; otherwise, return -1.
+ * Return the ref_entry for the given refname from the packed
+ * references.  If it does not exist, return NULL.
  */
-static int get_packed_ref(const char *refname, unsigned char *sha1)
+static struct ref_entry *get_packed_ref(const char *refname)
 {
-	struct ref_dir *packed = get_packed_refs(get_ref_cache(NULL));
-	struct ref_entry *entry = find_ref(packed, refname);
-	if (entry) {
-		hashcpy(sha1, entry->u.value.sha1);
-		return 0;
-	}
-	return -1;
+	return find_ref(get_packed_refs(get_ref_cache(NULL)), refname);
 }
 
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
@@ -1139,13 +1133,17 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		git_snpath(path, sizeof(path), "%s", refname);
 
 		if (lstat(path, &st) < 0) {
+			struct ref_entry *entry;
+
 			if (errno != ENOENT)
 				return NULL;
 			/*
 			 * The loose reference file does not exist;
 			 * check for a packed reference.
 			 */
-			if (!get_packed_ref(refname, sha1)) {
+			entry = get_packed_ref(refname);
+			if (entry) {
+				hashcpy(sha1, entry->u.value.sha1);
 				if (flag)
 					*flag |= REF_ISPACKED;
 				return refname;
-- 
1.8.2.1
