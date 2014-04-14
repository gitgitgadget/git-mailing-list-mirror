From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/25] remove_lock_file(): call rollback_lock_file()
Date: Mon, 14 Apr 2014 15:54:44 +0200
Message-ID: <1397483695-10888-15-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNg-0002Rh-Hg
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbaDNN4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:56:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49187 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755205AbaDNNza (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:30 -0400
X-AuditID: 12074411-f79ab6d000002f0e-19-534be8d2349e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.A6.12046.2D8EB435; Mon, 14 Apr 2014 09:55:30 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09E010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:28 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHvphXewwcnLfBZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGes2LuEveAaa8XERa+YGxiPsnQx
	cnJICJhIrDrzihHCFpO4cG89G4gtJHCZUWLfGVkI+ySTxL8NQiA2m4CuxKKeZiYQW0RATWJi
	2yGgOVwczALtTBKHdvSCJYQF3CVW/vsPZrMIqEpsObkUbAGvgKvEnOef2SCWyUmcPDaZtYuR
	g4MTKL7wQxbELheJu1+msE5g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81
	pXQTIyQQBXcwzjgpd4hRgINRiYe3Y453sBBrYllxZe4hRkkOJiVR3owbQCG+pPyUyozE4oz4
	otKc1OJDjBIczEoivK5bgXK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4O
	JQleY2DECQkWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD4iK+GBgZICkeoL1Jz0H2
	Fhck5gJFIVpPMSpKifOWgCQEQBIZpXlwY2Hp5RWjONCXwrwSINt5gKkJrvsV0GAmoMEs7WCD
	SxIRUlINjHk/Ig0fFDMfWLil7deOtte3/6j+imCqOWSe8Ss05cnf1qgMngO+fsrxQdOUb5p9
	XuSeuMP77PdZ/K/uNE9jvjzpTP6+S1Iv971q/M5rWbP3fL+0bEtcS+rnrxXmG5Z8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246241>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index ba791d5..477bf4b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -63,12 +63,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
1.9.1
