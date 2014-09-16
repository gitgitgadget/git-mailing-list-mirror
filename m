From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 11/35] delete_ref_loose(): don't muck around in the lock_file's filename
Date: Tue, 16 Sep 2014 21:33:32 +0200
Message-ID: <1410896036-12750-12-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTydi-0003e3-NI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbaIPTmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:10 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60014 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755043AbaIPTmI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:08 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Sep 2014 15:42:07 EDT
X-AuditID: 1207440d-f797f6d000000a4a-41-541890c72dea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CC.81.02634.7C098145; Tue, 16 Sep 2014 15:34:31 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcF001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:30 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqHt8gkSIwcoVFhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdcaLpHXPBP86KnzduMTcw/mbvYuTkkBAwkZj2vI8N
	whaTuHBvPZDNxSEkcJlR4tPGe1DOCSaJ82sns4BUsQnoSizqaWYCSYgItDFK7Lq4mRXEYRbo
	ZpR4f+I0E0iVsEC0xNMfzWA7WARUJXq2LmQGsXkFXCX23/zMArFPTmLD7v+MXYwcHJxA8a/7
	CkBMIQEXiYN3/SYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJ4
	vDsY/6+TOcQowMGoxMPr8Ug8RIg1say4MvcQoyQHk5Io779uiRAhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIrw/fIFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXj5g
	hAkJFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9H/tB9hYXJOYC
	RSFaTzHqcqzr/NbPJMSSl5+XKiXOawNSJABSlFGaB7cClmZeMYoDfSzM+w6kigeYouAmvQJa
	wgS05GyPGMiSkkSElFQDY+PHU4e+iq1bVvStZ1VD4S++wrcalZd15gXNmCV3xun54/mZUdvb
	jTsU9aaV7blw27xfJmu+z42w4nnz1TP3r9P/o+GatWXLxf6FDlcFVY7d59fQmn9T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257170>

It's bad manners. Especially since there could be a signal during the
call to unlink_or_warn(), in which case the signal handler will see
the wrong filename and delete the reference file, leaving the lockfile
behind.

So make our own copy to work with.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 53cd4fb..11c76ec 100644
--- a/refs.c
+++ b/refs.c
@@ -2551,12 +2551,15 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 static int delete_ref_loose(struct ref_lock *lock, int flag)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		int err, i = strlen(lock->lk->filename) - LOCK_SUFFIX_LEN;
-
-		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
-		lock->lk->filename[i] = LOCK_SUFFIX[0];
+		/*
+		 * loose.  The loose file name is the same as the
+		 * lockfile name, minus ".lock":
+		 */
+		char *loose_filename = xmemdupz(
+				lock->lk->filename,
+				strlen(lock->lk->filename) - LOCK_SUFFIX_LEN);
+		int err = unlink_or_warn(loose_filename);
+		free(loose_filename);
 		if (err && errno != ENOENT)
 			return 1;
 	}
-- 
2.1.0
