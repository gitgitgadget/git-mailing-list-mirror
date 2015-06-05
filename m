From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/4] lockfile: wait using sleep_millisec() instead of select()
Date: Fri,  5 Jun 2015 21:45:07 +0200
Message-ID: <983f4b270c5bb8a8c436a5a12be826b16e67c861.1433532968.git.j6t@kdbg.org>
References: <55700F10.8030806@kdbg.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xZD-00085z-QN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbFETqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:46:08 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12416 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751732AbbFETqG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:46:06 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m3Dx86NZBz5tlC;
	Fri,  5 Jun 2015 21:46:04 +0200 (CEST)
Received: from dx.lan (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 9A5EA1D0;
	Fri,  5 Jun 2015 21:46:04 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <55700F10.8030806@kdbg.org>
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org>
References: <cover.1433532967.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270882>

Use the new function sleep_millisec() to delay execution for a short
time. This avoids the invocation of select() with just a timeout, but
no file descriptors. Such a use of select() is quit with EINVAL on
Windows, leading to no delay at all.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 lockfile.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 3f5b699..fb78bda 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -157,14 +157,6 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-static int sleep_microseconds(long us)
-{
-	struct timeval tv;
-	tv.tv_sec = 0;
-	tv.tv_usec = us;
-	return select(0, NULL, NULL, NULL, &tv);
-}
-
 /*
  * Constants defining the gaps between attempts to lock a file. The
  * first backoff period is approximately INITIAL_BACKOFF_MS
@@ -214,7 +206,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
 		wait_ms = (750 + rand() % 500) * backoff_ms / 1000;
-		sleep_microseconds(wait_ms*1000);
+		sleep_millisec(wait_ms);
 		remaining_ms -= wait_ms;
 
 		/* Recursion: (n+1)^2 = n^2 + 2n + 1 */
-- 
2.3.2.245.gb5bf9d3
