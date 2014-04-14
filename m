From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/25] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Mon, 14 Apr 2014 15:54:40 +0200
Message-ID: <1397483695-10888-11-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNk-0002dO-VT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbaDNN5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:57:05 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49187 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754802AbaDNNzY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:24 -0400
X-AuditID: 12074411-f79ab6d000002f0e-0f-534be8cb65e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 29.A6.12046.BC8EB435; Mon, 14 Apr 2014 09:55:23 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09A010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:21 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHv6hXewwcGbHBZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGc8WmtW0MRZ0df6hLWBcTp7FyMn
	h4SAicSLX7/ZIGwxiQv31gPZXBxCApcZJea+OsoK4Zxkkvh7bQ0LSBWbgK7Eop5mJhBbREBN
	YmLbIRaQImaBdiaJQzt6wRLCAtESn79fYQSxWQRUJeZsngEW5xVwlVi2cyUTxDo5iZPHJgNt
	4ODgBIov/JAFEhYScJG4+2UK6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL
	9FJTSjcxQkJRcAfjjJNyhxgFOBiVeHg75ngHC7EmlhVX5h5ilORgUhLlzbgBFOJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTC67oVKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuA1BsackGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2pv0
	HGRvcUFiLlAUovUUo6KUOG8JSEIAJJFRmgc3FpZgXjGKA30pzCsBsp0HmJzgul8BDWYCGszS
	Dja4JBEhJdXAaGS352jujcJN0W1WjlMCXH1Fio/Uz+np7LKd+3rz7LmOfkryYireeWyGH3dJ
	nmn+PbdKSd//RnjE7Uuyns+eHPjQkhx2u2QRzyJp+60hC+tfmC67J3753XwxL43b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246242>

It's bad manners.  Especially since, if unlink_or_warn() failed, the
memory wasn't restored to its original contents.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 2805b31..20c483b 100644
--- a/refs.c
+++ b/refs.c
@@ -2486,12 +2486,15 @@ static int repack_without_ref(const char *refname)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = LOCK_SUFFIX[0];
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(
+				lock->lk->filename,
+				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
+		int err = unlink_or_warn(loose_filename);
+		free(loose_filename);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
1.9.1
