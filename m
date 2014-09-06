From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 18/32] commit_lock_file(): if close fails, roll back
Date: Sat,  6 Sep 2014 09:50:32 +0200
Message-ID: <1409989846-22401-19-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuG-0005AA-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbaIFH7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:30 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48062 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301AbaIFH7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:25 -0400
X-AuditID: 1207440d-f797f6d000000a4a-46-540abd37ce60
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A6.62.02634.73DBA045; Sat,  6 Sep 2014 03:52:23 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHH006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:22 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqGu+lyvE4NIkA4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujFPLHjEWdLBX/Nvxg72B8RJrFyMnh4SAiUTv2/3sELaYxIV769m6
	GLk4hAQuM0p8mdrDAuEcY5J4cGMeWBWbgK7Eop5mJpCEiEAbo8Sui5vBRjELpEh0PO9mBLGF
	Bdwlpsz4wAZiswioSqx6dAjM5hVwlTh98hwbxDo5iQ27/4PVcwLFpzd1gtlCAi4S7Sf7mSYw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJqvDsY/6+TOcQowMGo
	xMNb4MAVIsSaWFZcmXuIUZKDSUmUN285UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8dkoBxv
	SmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL3xm6gRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtJd1D8je4oLEXKAoROspRmOOlqa3vUwc
	6zq/9TMJseTl56VKifMygZQKgJRmlObBLYIlmVeM4kB/C/PeB7mHB5ig4Oa9AlrFBLTKPJ0T
	ZFVJIkJKqoHR/RnfNPEeiZ/yssyCDw6ukjr9Scp9HdMBdrUNWtm8z6ZdYXrmc+qosVF65ryt
	WmWvThRqVIbLHD3jWe4pOO/71uyIrZPFe7aIv7olW2/xqvsY393G7/dSK5cdVary 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256572>

If closing an open lockfile fails, then we cannot be sure of the
contents of the lockfile, so there is nothing sensible to do but
delete it.  This change also leaves the lock_file object in a defined
state in this error path (namely, unlocked).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 716b674..213783a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -310,8 +310,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (!lk->filename[0])
 		die("BUG: attempt to commit unlocked object");
 
-	if (lk->fd >= 0 && close_lock_file(lk))
+	if (lk->fd >= 0 && close_lock_file(lk)) {
+		int save_errno = errno;
+		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
+	}
 
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-- 
2.1.0
