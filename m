From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 20/39] commit_lock_file(): rollback lock file on failure to rename
Date: Fri, 26 Sep 2014 12:08:20 +0200
Message-ID: <1411726119-31598-21-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSa0-0002f8-5u
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbaIZKQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:42 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56884 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756026AbaIZKQl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:41 -0400
X-AuditID: 1207440f-f79156d000006a5c-88-54253b531504
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 24.ED.27228.35B35245; Fri, 26 Sep 2014 06:09:23 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM5013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:21 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1A22Vg0xaGuTsOi60s1k0dB7hdni
	ydy7zBZvby5htLi9Yj6zxY+WHmaLfxNqLDo7vjI6cHj8ff+ByWPnrLvsHgs2lXo8fNXF7vGs
	dw+jx8VLyh6fN8l53H62jSWAI4rbJimxpCw4Mz1P3y6BO+Njz3TGgrNsFTd/fGNpYFzG2sXI
	ySEhYCLRsv05lC0mceHeejYQW0jgMqPE1WNpXYxcQPYmJokrG0+zgyTYBHQlFvU0M4HYIgJq
	EhPbDrGAFDELLGaSmHBoE1i3sECoxNc3E5lBbBYBVYnrDasZuxg5OHgFXCXe7cuDWCYnsWH3
	f0YQmxMo3Lj9GiPEYheJlvWTWSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZ
	opeaUrqJERKK/DsYu9bLHGIU4GBU4uG9sU4lRIg1say4MvcQoyQHk5Io7xcL1RAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIrx3jIByvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUw
	WRkODiUJXisroEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7SX
	C6Sdt7ggMRcoCtF6itGYo6XpbS8Tx7rOb/1MQix5+XmpUuK8RyyBSgVASjNK8+AWwZLQK0Zx
	oL+FeUVABvIAExjcvFdAq5iAVikdUQZZVZKIkJJqYJy+jf9B8FydLQF7NNw2zle6bity65wg
	pxyH99sdvAaTstwU/k2aYS0SfOB27OZ/Ug85p7cG/eDk/pCjk78o6d0zp5nmb7bN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257532>

If rename() fails, call rollback_lock_file() to delete the lock file
(in case it is still present) and reset the filename field to the
empty string so that the lockfile object is left in a valid state.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 1d18c67..728ce49 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -318,8 +318,13 @@ int commit_lock_file(struct lock_file *lk)
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
 
-	if (rename(lk->filename, result_file))
+	if (rename(lk->filename, result_file)) {
+		int save_errno = errno;
+		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
+	}
+
 	lk->filename[0] = 0;
 	return 0;
 }
-- 
2.1.0
