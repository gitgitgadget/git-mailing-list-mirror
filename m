From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 07/35] hold_lock_file_for_append(): release lock on errors
Date: Tue, 16 Sep 2014 21:33:28 +0200
Message-ID: <1410896036-12750-8-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWG-0000B4-5Y
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbaIPTe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:27 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52822 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111AbaIPTe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:26 -0400
X-AuditID: 12074413-f79ed6d000002501-99-541890c190cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 03.BC.09473.1C098145; Tue, 16 Sep 2014 15:34:25 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcB001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:24 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqHtwgkSIwbEbhhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8CdcWvZPJaCLvaKCwt72RsYj7F2MXJwSAiYSPzezN7F
	yAlkiklcuLeerYuRi0NI4DKjxMmj85hBEkICJ5gktsx3ALHZBHQlFvU0M4EUiQi0MUrsuriZ
	FcRhFuhmlHh/4jQTSJWwgK/Eob49bCA2i4CqxNaT88BW8Aq4SHRO7GODWCcnsWH3f0aQKzgF
	XCW+7isAMYWASg7e9ZvAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukm
	RkjQCe9g3HVS7hCjAAejEg+vxyPxECHWxLLiytxDjJIcTEqivP+6JUKE+JLyUyozEosz4otK
	c1KLDzFKcDArifD+8AXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	ePmA0SUkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qL+GJgZICkeID2aoO08xYX
	JOYCRSFaTzEac7Q0ve1l4ljX+a2fSYglLz8vVUqc16YfqFQApDSjNA9uESzdvGIUB/pbGGIg
	DzBVwc17BbSKCWjV2R4xkFUliQgpqQZGfs9Iv6OLjNRnhj1RsjlasLp30oL0tzmGPTPXn+j7
	tWeRjrKGdpvjggoH723zIpVsd9woX3FQd1tcZjzv+0cLbl2rvCuh89+j02Pnhk/q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257147>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d4f165d..983c3ec 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -219,13 +219,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
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
2.1.0
