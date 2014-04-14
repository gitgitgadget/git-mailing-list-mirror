From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/25] hold_lock_file_for_append(): release lock on errors
Date: Mon, 14 Apr 2014 15:54:36 +0200
Message-ID: <1397483695-10888-7-git-send-email-mhagger@alum.mit.edu>
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
	id 1WZhM9-0000Ae-QC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbaDNNzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42532 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754809AbaDNNzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:16 -0400
X-AuditID: 1207440d-f79d86d0000043db-2f-534be8c3245c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F4.69.17371.3C8EB435; Mon, 14 Apr 2014 09:55:15 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt096010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:14 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHv4hXewwdfpJhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGds2nmWtaCLveLO/9MsDYzHWLsY
	OTkkBEwk9m58xQxhi0lcuLeerYuRi0NI4DKjxIK/XxkhnJNMEht+zWMHqWIT0JVY1NPMBGKL
	CKhJTGw7xAJSxCzQziRxaEcvWEJYwFdicvsOsAYWAVWJ31Ofg63jFXCR+LlrBxPEOjmJk8cm
	A8U5ODgFXCUWfsgCCQsBldz9MoV1AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5
	mSV6qSmlmxghwci7g/H/OplDjAIcjEo8vB1zvIOFWBPLiitzDzFKcjApifJm3AAK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuF13QqU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2C
	ycpwcChJ8G59DtQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2
	JoG08xYXJOYCRSFaTzEqSonzloAkBEASGaV5cGNhKeYVozjQl8K8i0CqeIDpCa77FdBgJqDB
	LO1gg0sSEVJSDYxd4toONz73ZriWvbfbYFX88cJ2hWhN9vLQyQFhIapWN7oitV5WBDNnn8vO
	e92gtrH/CMsavs7H1Rr9GzPb5x/g/7Z++Tr+FYeMcrprjq6qNteQnfDnx+R97p2R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246226>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index b101f77..e78a35f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -212,13 +212,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 		if (errno != ENOENT) {
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
-			close(fd);
+			rollback_lock_file(lk);
 			return error("cannot open '%s' for copying", path);
 		}
 	} else if (copy_fd(orig_fd, fd)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
-		close(fd);
+		rollback_lock_file(lk);
 		return -1;
 	}
 	return fd;
-- 
1.9.1
