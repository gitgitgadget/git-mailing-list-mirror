From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] diffcore-pickaxe: use memmem()
Date: Tue, 03 Mar 2009 00:00:55 +0100
Message-ID: <49AC6527.5010808@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:02:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeH9o-00065g-CA
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbZCBXBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbZCBXBG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:01:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:54774 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbZCBXBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 18:01:05 -0500
Received: from [10.0.1.101] (p57B7FBAD.dip.t-dialin.net [87.183.251.173])
	by india601.server4you.de (Postfix) with ESMTPSA id 2E1632F8055;
	Tue,  3 Mar 2009 00:01:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <cover.1235629933.git.gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111974>

Use memmem() instead of open-coding it.  The system libraries usually have a
much faster version than the memcmp()-loop here.  Even our own fall-back in
compat/, which is used on Windows, is slightly faster.

The following commands were run in a Linux kernel repository and timed, the
best of five results is shown:

  $ STRING='Ensure that the real time constraints are schedulable.'
  $ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null

On Ubuntu 8.10 x64, before (v1.6.2-rc2):

  8.09user 0.04system 0:08.14elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+30952minor)pagefaults 0swaps

And with the patch:

  1.50user 0.04system 0:01.54elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+30645minor)pagefaults 0swaps

On Fedora 10 x64, before:

  8.34user 0.05system 0:08.39elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+29268minor)pagefaults 0swaps

And with the patch:

  1.15user 0.05system 0:01.20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+32253minor)pagefaults 0swaps

On Windows Vista x64, before:

  real    0m9.204s
  user    0m0.000s
  sys     0m0.000s

And with the patch:

  real    0m8.470s
  user    0m0.000s
  sys     0m0.000s

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index af9fffe..574b3e8 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -10,7 +10,7 @@ static unsigned int contains(struct diff_filespec *one,
 			     regex_t *regexp)
 {
 	unsigned int cnt;
-	unsigned long offset, sz;
+	unsigned long sz;
 	const char *data;
 	if (diff_populate_filespec(one, 0))
 		return 0;
@@ -33,15 +33,13 @@ static unsigned int contains(struct diff_filespec *one,
 		}
 
 	} else { /* Classic exact string match */
-		/* Yes, I've heard of strstr(), but the thing is *data may
-		 * not be NUL terminated.  Sue me.
-		 */
-		for (offset = 0; offset + len <= sz; offset++) {
-			/* we count non-overlapping occurrences of needle */
-			if (!memcmp(needle, data + offset, len)) {
-				offset += len - 1;
-				cnt++;
-			}
+		while (sz) {
+			const char *found = memmem(data, sz, needle, len);
+			if (!found)
+				break;
+			sz -= found - data + len;
+			data = found + len;
+			cnt++;
 		}
 	}
 	diff_free_filespec_data(one);
-- 
1.6.2.rc2
