From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/25] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Mon,  7 Apr 2014 01:33:47 +0200
Message-ID: <1396827247-28465-6-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbN-000602-LY
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbaDFXfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:38 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61995 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754589AbaDFXew (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:52 -0400
X-AuditID: 12074412-f79d46d000002e58-93-5341e49be4f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 44.8D.11864.B94E1435; Sun,  6 Apr 2014 19:34:51 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWq011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:49 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDv7iWOwwe7tyhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+P1hE+MBQ85Kj6um8XSwPiHrYuRk0NCwETi69KL
	jBC2mMSFe+uB4lwcQgKXGSXOPz3NAuEcZ5K4f+YRWBWbgK7Eop5mJhBbREBNYmLbIbAiZoEb
	jBLv9h1mAUkIC0RJfD25GcxmEVCVWPqiEWwdr4CLxKuPt6FWy0mcPDaZFcTmFHCVWDd5Lli9
	EFDNu3332CYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERJ8QjsY
	15+UO8QowMGoxMO74pBjsBBrYllxZe4hRkkOJiVRXst7QCG+pPyUyozE4oz4otKc1OJDjBIc
	zEoivAduAOV4UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4+x4DNQoW
	paanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL0RIO28xQWJuUBRiNZT
	jIpS4rwzHwElBEASGaV5cGNhKeUVozjQl8K8BiDtPMB0BNf9CmgwE9DghjA7kMEliQgpqQZG
	21/ibr9b7z/dfn9BpfmmyuBOafnPle90OOV6S84nsx3Q3nur3THY+QzrmznTLwZYOmZVNDkf
	yTWN7DWXrvwoFsBc82nzvrvHzrUeUmzxmOeikpWdtkM+jOt/3WOvx4td3sl7fu5c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245808>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state (namely, unlocked).  Previously, the lockfile was
retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1122542..b101f77 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -148,9 +148,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			lock_file_list = lk;
 			lk->on_list = 1;
 		}
-		if (adjust_shared_perm(lk->filename))
-			return error("cannot fix permission bits on %s",
-				     lk->filename);
+		if (adjust_shared_perm(lk->filename)) {
+			error("cannot fix permission bits on %s", lk->filename);
+			rollback_lock_file(lk);
+			return -1;
+		}
 	}
 	else
 		lk->filename[0] = 0;
-- 
1.9.1
