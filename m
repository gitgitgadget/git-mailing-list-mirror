From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/25] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Mon, 14 Apr 2014 15:54:35 +0200
Message-ID: <1397483695-10888-6-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhOH-0003Jl-8F
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbaDNN53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:57:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57165 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086AbaDNNzO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:14 -0400
X-AuditID: 12074412-f79d46d000002e58-af-534be8c1a399
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id AA.CF.11864.1C8EB435; Mon, 14 Apr 2014 09:55:14 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt095010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:12 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHvohXewQZOWRdeVbiaLht4rzBYr
	f9ZY3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA4fH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IH
	Xh6fN8l53P2/k8nj9rNtLAEcUdw2SYklZcGZ6Xn6dgncGa8nfGIseMhR8XHdLJYGxj9sXYyc
	HBICJhKfTh5nh7DFJC7cWw8WFxK4zCjRfT+1i5ELyD7JJPH1xDlWkASbgK7Eop5mJhBbREBN
	YmLbIRaQImaBdiaJQzt6wRLCAlESHafusYDYLAKqEhsO3gabyivgIvGlYy0LxDY5iZPHJgMN
	5eDgFHCVWPghC2Kxi8TdL1NYJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mi
	l5pSuokREohCOxjXn5Q7xCjAwajEw9sxxztYiDWxrLgy9xCjJAeTkihvxg2gEF9SfkplRmJx
	RnxRaU5q8SFGCQ5mJRFe161AOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZ
	Dg4lCd5vz4EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGREV8MjA2QFA/Q3iSQ
	dt7igsRcoChE6ylGRSlx3hKQhABIIqM0D24sLL28YhQH+lKYVwKYbIR4gKkJrvsV0GAmoMEs
	7WCDSxIRUlINjHOWf9p22IlVM+vY74r4/eGdQqV/qqoXra03ErrSnx1e5eNvzr0qpHn2/Y1G
	X6t8S5a0nckRT1RQFrPrXBZhJbBjZdXzdzy+kRxXM3cmMayvP7Ziz52MZbI7nny8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246247>

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
