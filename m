From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH mh/lockfile-retry] lockfile: replace random() by rand()
Date: Sat, 30 May 2015 08:23:44 +0200
Message-ID: <55695770.2040303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 30 08:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyaCB-000380-Ad
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 08:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbbE3GXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 02:23:51 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:42845 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751998AbbE3GXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 02:23:50 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lzCQB5xzjz5tlH;
	Sat, 30 May 2015 08:23:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0AA415282;
	Sat, 30 May 2015 08:23:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270280>

On Windows, we do not have functions srandom() and random(). Use srand()
and rand(). These functions produce random numbers of lesser quality,
but for the purpose (a retry time-out) they are still good enough.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
There you have it: Look the other way for a while, and people start
using exotic stuff... ;)

This is a build breakage of master on Windows. There are also a few
new test suite failures. On of them is in t1404#2, indicating that
a DF conflict takes a different error path. I haven't debugged, yet.
The lock file retry test fails, too. I'll report back as time permits.

 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 5a93bc7..ee5cb01 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -191,7 +191,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 		return lock_file(lk, path, flags);
 
 	if (!random_initialized) {
-		srandom((unsigned int)getpid());
+		srand((unsigned int)getpid());
 		random_initialized = 1;
 	}
 
@@ -218,7 +218,7 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
 
 		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
 		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
-		wait_us = (750 + random() % 500) * backoff_ms;
+		wait_us = (750 + rand() % 500) * backoff_ms;
 		sleep_microseconds(wait_us);
 		remaining_us -= wait_us;
 
-- 
2.3.2.245.gb5bf9d3
