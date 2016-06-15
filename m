From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/25] lock_file(): exit early if lockfile cannot be opened
Date: Mon,  7 Apr 2014 01:33:56 +0200
Message-ID: <1396827247-28465-15-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc2-00074B-C1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbaDFXf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44614 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754644AbaDFXfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:09 -0400
X-AuditID: 1207440d-f79d86d0000043db-13-5341e4aca683
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.4D.17371.CA4E1435; Sun,  6 Apr 2014 19:35:08 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX1011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:07 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvmiWOwwePHlhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PGqbesBdc5KrYumMrcwPiVrYuRk0NCwETi/YPD
	TBC2mMSFe+uB4lwcQgKXGSVWz1rHCuEcZ5K4vLEJrINNQFdiUU8zWIeIgJrExLZDLCBFzAI3
	GCXe7TvMApIQFvCTmPV+P2MXIwcHi4CqRHNPEkiYV8BV4u7MSywQ2+QkTh6bzApicwLF102e
	CxYXEnABGnOPbQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIaHH
	u4Px/zqZQ4wCHIxKPLwrDzkGC7EmlhVX5h5ilORgUhLltbwHFOJLyk+pzEgszogvKs1JLT7E
	KMHBrCTCe+AGUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHb9xio
	UbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7Z0O0s5bXJCYCxSF
	aD3FqCglzjvzEVBCACSRUZoHNxaWUF4xigN9Kcy7DKSdB5iM4LpfAQ1mAhrcEGYHMrgkESEl
	1cAocvvjs0vvZh/bUrZnr16wSYCbat3cnz6BQVVJgS2v54ienGjGuqhBqf7bib8Vkb99l1ht
	94kwalm7x0/pqdWvuXt/8k8z+NbKuWefu6LrZ6PGjF+2jTvXZjtolpxff/LwrEWO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245822>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1bd0ae1..0879214 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -213,16 +213,16 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= lk->fd) {
-		lk->owner = getpid();
-		if (adjust_shared_perm(lk->filename)) {
-			error("cannot fix permission bits on %s", lk->filename);
-			rollback_lock_file(lk);
-			return -1;
-		}
-	}
-	else
+	if (lk->fd < 0) {
 		lk->filename[0] = 0;
+		return -1;
+	}
+	lk->owner = getpid();
+	if (adjust_shared_perm(lk->filename)) {
+		error("cannot fix permission bits on %s", lk->filename);
+		rollback_lock_file(lk);
+		return -1;
+	}
 	return lk->fd;
 }
 
-- 
1.9.1
