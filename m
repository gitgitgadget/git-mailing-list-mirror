From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/18] rename_ref(): integrate lock_ref_sha1_basic() errors into ours
Date: Mon, 11 May 2015 17:25:17 +0200
Message-ID: <1431357920-25090-16-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:33:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrphy-0006Bo-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbbEKPd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:33:26 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62884 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbEKPdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:33:25 -0400
X-AuditID: 12074411-f79fa6d000006b8a-f1-5550ca042164
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A4.5A.27530.40AC0555; Mon, 11 May 2015 11:25:56 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnR002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:54 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqMtyKiDUoHmJnEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLxZk3jYwObB5/339g8liwqdTjWe8eRo+Ll5Q9Fj/w8vi8SS6ALYrb
	JimxpCw4Mz1P3y6BO+Pi3/3sBV1cFV8/cjUwTuPoYuTkkBAwkTgxbTUrhC0mceHeerYuRi4O
	IYHLjBIbP85gh3COM0k8nvyfDaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwC5GiXtLp7KAJIQF
	IiQ2bZjGDGKzCKhKPNo9HayZV8BVYu6xY2wQ6+Qkzh//CVbDCRRfevUyWK+QgItE0+N7LBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAkywR2MM07KHWIU4GBU
	4uE1uOAfKsSaWFZcmXuIUZKDSUmU99fegFAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzKa4By
	vCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3sYTQI2CRanpqRVpmTkl
	CGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiILwZGB0iKB2iv0UmQvcUFiblAUYjWU4yKUuK8C0Hm
	CoAkMkrz4MbCUscrRnGgL4V514NU8QDTDlz3K6DBTECDHePABpckIqSkGhittwaEHuz8e1RL
	Se3Q8oo/ckpt3tLnFNm2fElT0KxlvLc53u7RNwtrNqt35Wd3Ceeuvus5z4d7F4/Vap3ngYZ8
	C0V/sAmWlZ/mjpDuunV93knpw5XT7rvH7BaYv7SgK/iLSNGNPxLZb0+LzU6fJr1T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268795>

Now that lock_ref_sha1_basic() gives us back its error messages via a
strbuf, incorporate its error message into our error message rather
than emitting two separate error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index ce993bd..87c1ad1 100644
--- a/refs.c
+++ b/refs.c
@@ -2907,9 +2907,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
-		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
 	hashcpy(lock->old_sha1, orig_sha1);
@@ -2923,9 +2922,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
  rollback:
 	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
-		error("%s", err.buf);
+		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
-		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
 	}
 
-- 
2.1.4
