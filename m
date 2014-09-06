From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 05/32] rollback_lock_file(): set fd to -1
Date: Sat,  6 Sep 2014 09:50:19 +0200
Message-ID: <1409989846-22401-6-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnH-0000CU-M0
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbaIFHwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:15 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44680 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbaIFHwF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:05 -0400
X-AuditID: 12074414-f79446d000001f1d-07-540abd247025
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 04.9A.07965.42DBA045; Sat,  6 Sep 2014 03:52:05 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFH4006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:03 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqKu6lyvEYFuSRdeVbiaLht4rzBZP
	5t5ltri9Yj6zxY+WHmaLzo6vjA5sHn/ff2DyePiqi93jWe8eRo+Ll5Q9Pm+S87j9bBtLAFsU
	t01SYklZcGZ6nr5dAnfGtKlNrAWbWCuunpjA3MC4iqWLkZNDQsBEYsGuI1C2mMSFe+vZuhi5
	OIQELjNKPPmznhnCOcYksX7BDmaQKjYBXYlFPc1MIAkRgTZGiV0XN7OCJJgFUiQ6nnczgtjC
	AjYSl96cA7NZBFQlvn/YzgRi8wq4SKy99YcVYp2cxIbd/8FqOAVcJaY3dYLZQkA17Sf7mSYw
	8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERJoIjsYj5yUO8QowMGo
	xMNb4MAVIsSaWFZcmXuIUZKDSUmUN285UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8dkoBxv
	SmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILUIpisDAeHkgRv326gRsGi1PTUirTMnBKE
	NBMHJ8hwLimR4tS8lNSixNKSjHhQdMQXA+MDJMUDtPcsSDtvcUFiLlAUovUUozFHS9PbXiaO
	dZ3f+pmEWPLy81KlxHnv7AIqFQApzSjNg1sESzGvGMWB/hbmvQ8ykAeYnuDmvQJaxQS0yjyd
	E2RVSSJCSqqBsXzHEwvxopBqEa6m0z9FlZ13ZVrqOcoUZTrFpCWUz17/PEhr6sL9vgm6R5uZ
	Vtzf++PdZ5+/13cyhaVEtsp6rq9JbG/YlHtjxqX8tjM3J7Czvlnx0EwnM++0U4O6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256552>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1.  This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 49179d8..b1c4ba0 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -276,7 +276,7 @@ void rollback_lock_file(struct lock_file *lk)
 		return;
 
 	if (lk->fd >= 0)
-		close(lk->fd);
+		close_lock_file(lk);
 	unlink_or_warn(lk->filename);
 	lk->filename[0] = 0;
 }
-- 
2.1.0
