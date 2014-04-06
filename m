From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/25] hold_lock_file_for_append(): release lock on errors
Date: Mon,  7 Apr 2014 01:33:48 +0200
Message-ID: <1396827247-28465-7-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbO-000602-6p
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaDFXfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:39 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54068 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754596AbaDFXey (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:54 -0400
X-AuditID: 12074411-f79ab6d000002f0e-ae-5341e49dd2bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 35.2F.12046.D94E1435; Sun,  6 Apr 2014 19:34:53 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWr011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:51 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDv3iWOwwaS9MhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2PTzrOsBV3sFXf+n2ZpYDzG2sXIySEhYCLRd+kF
	E4QtJnHh3nq2LkYuDiGBy4wSm+YtZYFwjjNJbDr6nx2kik1AV2JRTzNYh4iAmsTEtkNgRcwC
	Nxgl3u07zAKSEBbwlTj2fBlYA4uAqsSDxsvMIDavgItE5/NbUOvkJE4emwx2BqeAq8S6yXPB
	eoWAat7tu8c2gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQ4BPc
	wTjjpNwhRgEORiUe3hWHHIOFWBPLiitzDzFKcjApifJa3gMK8SXlp1RmJBZnxBeV5qQWH2KU
	4GBWEuE9cAMox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4O17DNQo
	WJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2Tgdp5y0uSMwFikK0
	nmJUlBLnnfkIKCEAksgozYMbC0sprxjFgb4U5l0G0s4DTEdw3a+ABjMBDW4IswMZXJKIkJJq
	YOwpfxR0UFLH/f3CpMjpD4s+ZIb8n1CTW/ldc3vHTSe35ET+N1efnbequD1FQINbwUR/3sGJ
	xmLlxun/UuZ9i3OZkdGgOaNo4oELl6PljSS9I6f/5gxxexX1bm/NxAdWX5MdZkaY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245811>

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
