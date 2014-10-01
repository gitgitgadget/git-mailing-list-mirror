From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 06/38] rollback_lock_file(): set fd to -1
Date: Wed,  1 Oct 2014 12:28:10 +0200
Message-ID: <1412159322-2622-7-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBP-0003Gf-54
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbaJAK3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:08 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42024 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387AbaJAK3C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:02 -0400
X-AuditID: 12074413-f79ed6d000002501-eb-542bd76cee31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 92.AD.09473.C67DB245; Wed,  1 Oct 2014 06:29:00 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk65026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:58 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1M25rh1isPWMlEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bm/j19nLPjHVtF07BBTA+NN1i5G
	Tg4JAROJmRsaGSFsMYkL99azdTFycQgJXGaU2LhxJiuEc5xJom/FPLAONgFdiUU9zUwgtoiA
	msTEtkMsIEXMAouZJCYc2sQGkhAWsJE4u/IxWBGLgKpEc9MBIJuDg1fAWeLhYlOIbXISG3b/
	B9vMKeAisfxyMwuILQRUsuPOV6YJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+Vm
	luilppRuYoQEo/AOxl0n5Q4xCnAwKvHwKiRohwixJpYVV+YeYpTkYFIS5V10CSjEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhDf7AFCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgm
	K8PBoSTBy3ANqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO11
	BmnnLS5IzAWKQrSeYjTmaGl628vEsa7zWz+TEEtefl6qlDhv6FWgUgGQ0ozSPLhFsDT0ilEc
	6G9hXmmQgTzAFAY37xXQKiagVclrwFaVJCKkpBoYg38V36jaLfK49sxGuSOvm9vtUhjdhX5N
	6AiafkHA0Ik/w0z2nsxZ6f/ZLHmGOUztK4LfLjxwxvNzvFF6dsAtroPFvq/DBWR5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257731>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1. This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused. It also makes it unnecessary to check whether
the file has already been closed, because close_lock_file() takes care
of that.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e55149a..3df1e83 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -279,8 +279,7 @@ void rollback_lock_file(struct lock_file *lk)
 	if (!lk->filename[0])
 		return;
 
-	if (lk->fd >= 0)
-		close(lk->fd);
+	close_lock_file(lk);
 	unlink_or_warn(lk->filename);
 	lk->filename[0] = 0;
 }
-- 
2.1.0
