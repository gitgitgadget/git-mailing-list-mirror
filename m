From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] verify_lock(): on errors, let the caller unlock the lock
Date: Sat, 23 May 2015 01:34:54 +0200
Message-ID: <1432337697-29161-3-git-send-email-mhagger@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTA-0003G5-Pa
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331AbbEVXfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:08 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64450 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757022AbbEVXfH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:07 -0400
X-AuditID: 12074413-f79386d000000d23-c9-555fbd2a150b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.60.03363.A2DBF555; Fri, 22 May 2015 19:35:06 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Pt007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:05 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKu1Nz7UYMIdZYuuK91MFg29V5gt
	bq+Yz2yxeXM7iwOLx9/3H5g8Fmwq9bh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MK7saWQs+
	cFS0bnrG1sD4k62LkZNDQsBEYuGmSSwQtpjEhXvrgeJcHEIClxklVq8+D1YkJHCCSWLCnlAQ
	m01AV2JRTzMTiC0ioCYxse0QWDOzQK7Ehn2nwOLCAr4S19b+ZgWxWQRUJZZMnQE2h1fAReJx
	1zeoxXIS54//ZAaxOQVcJW4v7WOC2OUi0bv9G8sERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3TN9XIzS/RSU0o3MUKCR3gH466TcocYBTgYlXh4Ow7HhQqxJpYVV+YeYpTkYFIS5V21
	Ij5UiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv2c1AOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0
	xJLU7NTUgtQimKwMB4eSBC/nHqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBk
	xBcDYwMkxQO01wiknbe4IDEXKArReopRUUqc9/1uoIQASCKjNA9uLCwlvGIUB/pSmNcUpJ0H
	mE7gul8BDWYCGrxqQizI4JJEhJRUAyN73fsNjdlvS22K41rfvzEpmDI1qs5llwf3Ir/DcZcU
	Y7jOWW1Rvs4XXv6ibN7i6eKX5fabdqb9Uf5ozbJmA8+jjZLn1/os3dS1K3m3nO031rCyKNUL
	FlP13nDaVy44mKL5KPxqzP+4/fOf8R6NeRt/m0dijcv+FIeF95PW1ujfrTc8dnX9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269769>

The caller already knows how to do it, so always do it in the same
place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4432bc9..100a767 100644
--- a/refs.c
+++ b/refs.c
@@ -2209,14 +2209,12 @@ static int verify_lock(struct ref_lock *lock,
 			  lock->old_sha1, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
-		unlock_ref(lock);
 		errno = save_errno;
 		return -1;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
-		unlock_ref(lock);
 		errno = EBUSY;
 		return -1;
 	}
@@ -2450,8 +2448,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	if (old_sha1 && verify_lock(lock, old_sha1, mustexist))
-		return NULL;
+	if (old_sha1 && verify_lock(lock, old_sha1, mustexist)) {
+		last_errno = errno;
+		goto error_return;
+	}
 	return lock;
 
  error_return:
-- 
2.1.4
