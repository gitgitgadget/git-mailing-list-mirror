From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 04/32] rollback_lock_file(): exit early if lock is not active
Date: Sat,  6 Sep 2014 09:50:18 +0200
Message-ID: <1409989846-22401-5-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuF-0005AA-IY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbaIFH7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59874 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbaIFH7T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:19 -0400
X-AuditID: 1207440f-f79156d000006a5c-2a-540abd23113d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F8.1B.27228.32DBA045; Sat,  6 Sep 2014 03:52:03 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH3006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:02 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqKu8lyvE4MceeYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujMZXPxgLjrBWrPm2mb2BcRdLFyMnh4SAicTeL63sELaYxIV769m6
	GLk4hAQuM0osvv6GEcI5xiSx/cceVpAqNgFdiUU9zUwgCRGBNkaJXRc3gyWYBVIkOp53M4LY
	wgIBEnOWPgUbyyKgKvH91k82EJtXwEXi2J1WZoh1chIbdv8Hq+cUcJWY3tQJZgsB1bSf7Gea
	wMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIqPHvYOxaL3OIUYCD
	UYmHt8CBK0SINbGsuDL3EKMkB5OSKG/ecqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6OyUA5
	3pTEyqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IE743dQI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2jvWZB23uKCxFygKETrKUZjjpamt71M
	HOs6v/UzCbHk5eelSonzMu0BKhUAKc0ozYNbBEsyrxjFgf4W5r0PMpAHmKDg5r0CWsUEtMo8
	nRNkVUkiQkqqgZFBhvNi2PaFMaZpnS79q1s+xnGVNsdPZLl8limn98mW/XoSuS7Xr6tIreHJ
	PZ3x+VQp34XHvsnvv82M0DSuum2/aE5MnuDtyozsLs2bhrP6eCewZ3cf52uV+MAd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256570>

Eliminate a layer of nesting.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a548e08..49179d8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -272,10 +272,11 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
-		if (lk->fd >= 0)
-			close(lk->fd);
-		unlink_or_warn(lk->filename);
-		lk->filename[0] = 0;
-	}
+	if (!lk->filename[0])
+		return;
+
+	if (lk->fd >= 0)
+		close(lk->fd);
+	unlink_or_warn(lk->filename);
+	lk->filename[0] = 0;
 }
-- 
2.1.0
