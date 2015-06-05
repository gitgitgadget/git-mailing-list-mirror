From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/4] lockfile: convert retry timeout computations to millisecond
Date: Fri,  5 Jun 2015 21:45:06 +0200
Message-ID: <e47ba0d3c1ba83b50d2d241047863b2ba7b7341b.1433532968.git.j6t@kdbg.org>
References: <55700F10.8030806@kdbg.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xZ9-00083c-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbFETqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:46:04 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:7068 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751939AbbFETqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:46:02 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m3Dx470rJz5tlN;
	Fri,  5 Jun 2015 21:46:00 +0200 (CEST)
Received: from dx.lan (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id A038F1D0;
	Fri,  5 Jun 2015 21:45:59 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <55700F10.8030806@kdbg.org>
In-Reply-To: <cover.1433532967.git.j6t@kdbg.org>
References: <cover.1433532967.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270883>

When the goal is to wait for some random amount of time up to one
second, it is not necessary to compute with microsecond precision.
This is a preparation to re-use sleep_millisec().

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 lockfile.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 738f202..3f5b699 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -184,7 +184,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 {
 	int n = 1;
 	int multiplier = 1;
-	long remaining_us = 0;
+	long remaining_ms = 0;
 	static int random_initialized = 0;
 
 	if (timeout_ms == 0)
@@ -195,16 +195,11 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		random_initialized = 1;
 	}
 
-	if (timeout_ms > 0) {
-		/* avoid overflow */
-		if (timeout_ms <= LONG_MAX / 1000)
-			remaining_us = timeout_ms * 1000;
-		else
-			remaining_us = LONG_MAX;
-	}
+	if (timeout_ms > 0)
+		remaining_ms = timeout_ms;
 
 	while (1) {
-		long backoff_ms, wait_us;
+		long backoff_ms, wait_ms;
 		int fd;
 
 		fd = lock_file(lk, path, flags);
@@ -213,14 +208,14 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 			return fd; /* success */
 		else if (errno != EEXIST)
 			return -1; /* failure other than lock held */
-		else if (timeout_ms > 0 && remaining_us <= 0)
+		else if (timeout_ms > 0 && remaining_ms <= 0)
 			return -1; /* failure due to timeout */
 
 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
-		wait_us = (750 + rand() % 500) * backoff_ms;
-		sleep_microseconds(wait_us);
-		remaining_us -= wait_us;
+		wait_ms = (750 + rand() % 500) * backoff_ms / 1000;
+		sleep_microseconds(wait_ms*1000);
+		remaining_ms -= wait_ms;
 
 		/* Recursion: (n+1)^2 = n^2 + 2n + 1 */
 		multiplier += 2*n + 1;
-- 
2.3.2.245.gb5bf9d3
