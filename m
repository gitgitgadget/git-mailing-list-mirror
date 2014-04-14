From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 21/25] commit_lock_file(): use a strbuf to manage temporary space
Date: Mon, 14 Apr 2014 15:54:51 +0200
Message-ID: <1397483695-10888-22-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMk-00015x-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbaDNNzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:53 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59726 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754857AbaDNNzn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:43 -0400
X-AuditID: 12074413-f79076d000002d17-a0-534be8def3a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 38.40.11543.ED8EB435; Mon, 14 Apr 2014 09:55:42 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09L010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:41 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqHvvhXewwY/JJhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGcc//mWvWAGZ8WbXUvZGxgPsXcx
	cnJICJhIzD67iA3CFpO4cG89kM3FISRwmVHi/uO1rCAJIYGTTBKXTkWD2GwCuhKLepqZQGwR
	ATWJiW2HWEAamAXamSQO7egFSwgLhEj8u76VBcRmEVCVeHxjDiOIzSvgKnHkbRcLxDY5iZPH
	JgMt4ODgBIov/JAFsctF4u6XKawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vN
	LNFLTSndxAgJReEdjLtOyh1iFOBgVOLh7ZjjHSzEmlhWXJl7iFGSg0lJlDfjBlCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCK/rVqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFM
	VoaDQ0mCt+Y5UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDLii4GxAZLiAdqb
	BNLOW1yQmAsUhWg9xagoJc5bApIQAElklObBjYUlmFeM4kBfCvOmgVTxAJMTXPcroMFMQINZ
	2sEGlyQipKQaGFfdne3qOGnWqRNneDv2nXLbnO61yUf10qr086f3XKw2NmVzaJ7AqyJsZXZh
	RpqLY8sj3gcN09bzPRb/K8Vu9mnSbuclj5dcWRPE6j8p0OTOlDDOnTPjzrc//Wmb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246233>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index fce53f1..0aa2998 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -305,7 +305,8 @@ int close_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
@@ -313,11 +314,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
 
-	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-
-	if (rename(lk->filename, result_file))
+	strbuf_add(&result_file, lk->filename,
+		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename, result_file.buf);
+	strbuf_reset(&result_file);
+	if (err)
 		return -1;
 	lk->active = 0;
 	lk->filename[0] = 0;
-- 
1.9.1
