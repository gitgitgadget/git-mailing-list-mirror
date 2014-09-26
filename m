From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 07/39] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Fri, 26 Sep 2014 12:08:07 +0200
Message-ID: <1411726119-31598-8-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSUA-000526-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbaIZKKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:10:41 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61723 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754372AbaIZKJD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:03 -0400
X-AuditID: 12074414-f79446d000001f1d-bd-54253b3e5778
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 88.0F.07965.E3B35245; Fri, 26 Sep 2014 06:09:02 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLq013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:01 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1LWzVg0xaLiibtF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd0br+WMsBbvYK3bvWcfWwPiDtYuR
	k0NCwERi/9TLjBC2mMSFe+vZuhi5OIQELjNK7Dl+iR3C2cQkcX/OR7AqNgFdiUU9zUwgtoiA
	msTEtkMsIEXMAouZJCYc2sQGkhAWiJJY/amJHcRmEVCVuL1nGlicV8BF4tiyA0wQ6+QkNuz+
	DzaUU8BVonH7NTBbCKimZf1klgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW
	6KWmlG5ihISjyA7GIyflDjEKcDAq8fDeWKcSIsSaWFZcmXuIUZKDSUmU94uFaogQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd47RkA53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUw
	WRkODiUJ3ouWQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiILwbGB0iKB2jv
	FJB23uKCxFygKETrKUZjjpamt71MHOs6v/UzCbHk5eelSonzHgEpFQApzSjNg1sES0SvGMWB
	/hbmvQFSxQNMYnDzXgGtYgJapXREGWRVSSJCSqqBkavY8o71YaZjW/nnfxYtKb7WUv9qzWrd
	ZNtDkydsm51us1q2W8dtXZnYusCHEu+Vnd88yA5aHComVPqNPe4G8/Ty2IYii2T1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257526>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state (namely, unlocked).  Previously, the lockfile was
retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lockfile.c b/lockfile.c
index 3df1e83..d74de8d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -153,6 +153,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
 			      lk->filename);
+			rollback_lock_file(lk);
 			errno = save_errno;
 			return -1;
 		}
-- 
2.1.0
