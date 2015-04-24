From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] commit_ref_update(): new function, extracted from write_ref_sha1()
Date: Fri, 24 Apr 2015 13:35:46 +0200
Message-ID: <1429875349-29736-3-git-send-email-mhagger@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylbu0-0004FB-BP
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbbDXLgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56412 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933551AbbDXLgB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:01 -0400
X-AuditID: 12074412-f79e46d0000036b4-2e-553a2aa02d26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 82.DF.14004.0AA2A355; Fri, 24 Apr 2015 07:36:00 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8Y008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:35:59 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqLtAyyrU4OcxA4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ0zYeI6p4Dt3xYtJOg2MJzi7GDk5JARMJP5fv8IOYYtJXLi3ng3EFhK4zCjxsNmli5EL
	yD7JJPHi6jZWkASbgK7Eop5mpi5GDg4RAS+JtpnFIGFmgRSJjufdjCBhYYFwiW03zUDCLAKq
	Ehf+/mABCfMKuEicPBMPsUlO4vzxn8wgNqeAq0T/8o8sEFtdJNZs+sA+gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQQBLawbj+pNwhRgEORiUe3hlzLEOFWBPL
	iitzDzFKcjApifJ2SlmFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhTRQCyvGmJFZWpRblw6Sk
	OViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfByawI1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxIMiIr4YGBMgKR6gvTYg7bzFBYm5QFGI1lOMilLivD4gCQGQREZpHtxYWHp4
	xSgO9KUwbxpIFQ8wtcB1vwIazAQ0eOZSC5DBJYkIKakGRtPXK6T9xb5zGlksvN38t6Sj67iK
	5xKdD16fVq78G7ar++AJgTfS/UpevPLBLQuZvNJcjik71xuufFBcPiVWtpfhvZuXhPjf3x8F
	Fkx98Kg/ccnVtck5T4rsujP2JeW/i1e5WLPjxpSHnxMLb90+xXzzJ+ty09fRmUJp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267732>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 72dae21..9b68aec 100644
--- a/refs.c
+++ b/refs.c
@@ -3052,16 +3052,9 @@ static int write_ref_to_lockfile(struct ref_lock *lock, const unsigned char *sha
 	return 0;
 }
 
-/*
- * Write sha1 into the ref specified by the lock. Make sure that errno
- * is sane on error.
- */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int commit_ref_update(struct ref_lock *lock,
+			     const unsigned char *sha1, const char *logmsg)
 {
-	if (write_ref_to_lockfile(lock, sha1))
-		return -1;
-
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
@@ -3100,6 +3093,21 @@ static int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
+/*
+ * Write sha1 as the new value of the reference specified by the
+ * (open) lock. On error, roll back the lockfile and set errno
+ * appropriately.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	if (write_ref_to_lockfile(lock, sha1) ||
+	    commit_ref_update(lock, sha1, logmsg))
+		return -1;
+
+	return 0;
+}
+
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-- 
2.1.4
