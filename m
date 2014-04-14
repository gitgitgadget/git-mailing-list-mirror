From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/25] rollback_lock_file(): set fd to -1
Date: Mon, 14 Apr 2014 15:54:34 +0200
Message-ID: <1397483695-10888-5-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhM9-0000Ae-8I
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbaDNNzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55513 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358AbaDNNzN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:13 -0400
X-AuditID: 1207440f-f79326d000003c9f-45-534be8c01b8c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.65.15519.0C8EB435; Mon, 14 Apr 2014 09:55:12 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt094010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:10 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHvghXewwfcPXBZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGc8nPacpeA4a8XXxfuZGhh3sHQx
	cnBICJhI7Jrg3sXICWSKSVy4t56ti5GLQ0jgMqPEtQn7mCGck0wSXbv62UGq2AR0JRb1NDOB
	2CICahIT2w6xgBQxC7QzSRza0QuWEBawkfg9ew4jiM0ioCpxYm4DM4jNK+AiMeXcOzaIdXIS
	J49NZgW5glPAVWLhhyyQsBBQyd0vU1gnMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRr
	opebWaKXmlK6iRESivw7GLvWyxxiFOBgVOLh7ZjjHSzEmlhWXJl7iFGSg0lJlDfjBlCILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCK/rVqAcb0piZVVqUT5MSpqDRUmcV32Jup+QQHpiSWp2ampB
	ahFMVoaDQ0mC1xgYc0KCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoMiILwbGBkiK
	B2hv0nOQvcUFiblAUYjWU4yKUuK8JSAJAZBERmke3FhYgnnFKA70pTCvBMh2HmBygut+BTSY
	CWgwSzvY4JJEhJRUA2Pfl7Yl8SwH6x7tkYpbNjN0nft+zfNLGIv0DF9M2pt1rcIr11l/ulUo
	wzFZpWLO6ov9n5bUZT/qV3P2b5MRE/jOUGm0lJerZ1aw5q/3kS23+mWPM0t+m5h4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246224>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1.  This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 7701267..1122542 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -275,7 +275,7 @@ void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
 		if (lk->fd >= 0)
-			close(lk->fd);
+			close_lock_file(lk);
 		unlink_or_warn(lk->filename);
 		lk->filename[0] = 0;
 	}
-- 
1.9.1
