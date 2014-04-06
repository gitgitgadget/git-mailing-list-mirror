From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/25] commit_lock_file(): make committing an unlocked lockfile a NOP
Date: Mon,  7 Apr 2014 01:33:59 +0200
Message-ID: <1396827247-28465-18-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc4-00074B-1m
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbaDFXgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44485 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754650AbaDFXfP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:15 -0400
X-AuditID: 12074414-f79d96d000002d2b-d4-5341e4b20dc0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B7.8A.11563.2B4E1435; Sun,  6 Apr 2014 19:35:14 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX4011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:13 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvpiWOwwfTp+hZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO6PzzCqWgq8CFfN/vGVrYLzO28XIySEhYCLRsOMc
	G4QtJnHh3nogm4tDSOAyo8TLjmdMEM5xJomjjX/BqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQvc
	YJR4t+8wC0hCWCBCYt2ndkYQm0VAVWLmx4VgzbwCrhJfZ/5kglgnJ3Hy2GRWEJsTKL5u8lyw
	XiEBF6A599gmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESfCI7
	GI+clDvEKMDBqMTDu+KQY7AQa2JZcWXuIUZJDiYlUV7Le0AhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIrwHbgDleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeI8+BmoU
	LEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VHfDEwPkBSPEB7L4K08xYXJOYCRSFa
	TzEqSonzznwElBAASWSU5sGNhaWUV4ziQF8K8y4DaecBpiO47ldAg5mABjeE2YEMLklESEk1
	MKaIz/giUu8x9b9AvWyRuDTLFH33LYnb5Q4Ky7rcNu3dPLWayUM9Z8GljVcO/VyZqt79iWHy
	Seabd7IS85MDWY5+zk/5vvD1ycDNRhtfGgraitxwPGCRqRa8ulfyj+XF9GnfIhnm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245823>

It was previously a bug to call commit_lock_file() with a lock_file
object that was not active (an illegal access would happen within the
function).  It was presumably never done, but this would be an easy
programming error to overlook.  So guard the file-renaming code with
an if statement to change committing an unlocked file into a NOP.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Alternatively, we could make it a fatal error (e.g., an assert() or
if...die()) to call commit_lock_file() on an unlocked file, or omit a
warning in this case.  But since it is so hard to test code related to
locking failures, I have the feeling that such an error is most likely
to occur in some error-handling path, maybe when some other lockfile
acquisition has failed, and it would be better to let the code
continue its attempted cleanup instead of dying.  But it would be easy
to persuade me to change my opinion.

 Documentation/technical/api-lockfile.txt | 4 +++-
 lockfile.c                               | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index b53e300..bfb2676 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -68,7 +68,9 @@ commit_lock_file::
 	with an earlier call to `hold_lock_file_for_update()`,
 	close the file descriptor and rename the lockfile to its
 	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	value on failure to close(2) or rename(2).  It is a NOP to
+	call `commit_lock_file()` for a `lock_file` object that is not
+	currently locked.
 
 rollback_lock_file::
 
diff --git a/lockfile.c b/lockfile.c
index 47762c6..24aaa53 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -301,6 +301,9 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 
+	if (!lk->filename[0])
+		return 0;
+
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-- 
1.9.1
