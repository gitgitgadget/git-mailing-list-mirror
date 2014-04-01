From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/22] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Tue,  1 Apr 2014 17:58:13 +0200
Message-ID: <1396367910-7299-6-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV17J-0008AR-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbaDAQAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 12:00:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54271 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbaDAP6o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:44 -0400
X-AuditID: 12074412-f79d46d000002e58-e4-533ae2337142
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.3C.11864.332EA335; Tue,  1 Apr 2014 11:58:43 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb9027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:42 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGv8yCrYYHeDhkXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7ov3eMseAZR8XeD1fYGhgb2LsYOTkkBEwkmt5sYIKwxSQu3FvPBmILCVxmlHh/17mL
	kQvIPsYk0blgCjNIgk1AV2JRTzNYg4iAmsTEtkMsIDazQIrEq7+7wGxhgXCJZcePsILYLAKq
	EheW/gOzeQWcJTadvMQKsUxOYsrvBWBHcAq4SFx6sIcVYrGzxOk3i5knMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESUkI7GNeflDvEKMDBqMTDe+C8VbAQa2JZ
	cWXuIUZJDiYlUd4fd4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhn3QTK8aYkVlalFuXDpKQ5
	WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8Mo/BGoULEpNT61Iy8wpQUgzcXCCDOeSEilO
	zUtJLUosLcmIB0VGfDEwNkBSPEB7FUHaeYsLEnOBohCtpxgVpcR5WR4AJQRAEhmleXBjYYni
	FaM40JfCvLog7TzAJAPX/QpoMBPQYO51YINLEhFSUg2Mclmzeqvu8oWJfXtXLcqwX+KViqg1
	5++X1/bMP7732b+2GV/2cabNaQp4d/tCmU7RIqWJjpcqhFdPDPWUNeQ/aL7qRYe6X97j8Gqp
	WXwpKz6x8eyrm/Pz5Zn5vtktFxr0btZKchpW7Nq4Y57RoimLDkvOtZl8d7qNQOrn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245614>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state that (namely, unlocked).  Previously, the lockfile
was retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index c1af65b..1928e5e 100644
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
1.9.0
