From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/25] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Mon,  7 Apr 2014 01:33:53 +0200
Message-ID: <1396827247-28465-12-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbQ-000602-VO
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbaDFXfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64144 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754636AbaDFXfD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:03 -0400
X-AuditID: 12074413-f79076d000002d17-ef-5341e4a7ddb0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 91.08.11543.7A4E1435; Sun,  6 Apr 2014 19:35:03 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWw011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:01 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLv8iWOwweN7nBZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PQ8dtsBQ85Kk4ePczUwPidrYuRk0NCwESid80z
	RghbTOLCvfVAcS4OIYHLjBKTJv5gBkkICRxnkljRlwJiswnoSizqaWYCsUUE1CQmth1iAWlg
	FrjBKPFu32EWkISwQLTE9oPzwJpZBFQlNi5vBdvGK+AqcX3iNahtchInj01mBbE5geLrJs9l
	gVjmAjTnHtsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUJCT3gH
	466TcocYBTgYlXh4Vx5yDBZiTSwrrsw9xCjJwaQkyvvgMVCILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCO+BG0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE71+QoYJF
	qempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaK/bE5C9xQWJuUBRiNZT
	jIpS4rzsIAkBkERGaR7cWFhCecUoDvSlMK8iSBUPMBnBdb8CGswENLghzA5kcEkiQkqqgTH1
	ttOVk39N73zV+L5K61TC/fquh/eKeTIZfyxc1Xed1T504XQnGbHV2bcPbfmybsaWB/pdtg8L
	ponl35kZEcMQLHD9acpDx2TZBZHyP++ackvoJt2YombXJOwl4ZPo7lqjc/ZwiNEt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245806>

It's bad manners.  Especially since, if unlink_or_warn() failed, the
memory wasn't restored to its original contents.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 67fe8b7..64ea2f0 100644
--- a/refs.c
+++ b/refs.c
@@ -2485,12 +2485,14 @@ static int repack_without_ref(const char *refname)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = '.';
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(lock->lk->filename,
+						strlen(lock->lk->filename) - 5);
+		int err = unlink_or_warn(loose_filename);
+		free(loose_filename);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
1.9.1
