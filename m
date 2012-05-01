From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Choose XDL_FAST_HASH code on sizeof(long) instead of __WORDSIZE
Date: Tue, 1 May 2012 10:36:51 +0200
Message-ID: <399c9a1f0dd548da3144eff3c50d04a8f343ab24.1335860033.git.trast@student.ethz.ch>
References: <7v4ns0cy3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	<git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 10:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP8Zx-0005Ox-A2
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 10:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab2EAIg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 04:36:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20123 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab2EAIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 04:36:55 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Tue, 1 May
 2012 10:36:51 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 1 May
 2012 10:36:51 +0200
X-Mailer: git-send-email 1.7.10.512.g5bfc6
In-Reply-To: <7v4ns0cy3l.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196668>

Darwin does not define __WORDSIZE, and compiles the 32-bit code path
on 64-bit systems, resulting in a totally broken git.

I could not find an alternative -- other than the platform symbols
(__x86_64__ etc.) -- that does the test in the preprocessor.  However,
we can also just test for the size of a 'long', which is what really
matters here.  Any compiler worth its salt will leave only the branch
relevant for its platform, and indeed on Linux/GCC the numbers don't
change:

 Test                                  tr/darwin-xdl-fast-hash   origin/next              origin/master
 ------------------------------------------------------------------------------------------------------------------
 4000.1: log -3000 (baseline)          0.09(0.07+0.01)           0.09(0.07+0.01) -5.5%*   0.09(0.07+0.01) -4.1%
 4000.2: log --raw -3000 (tree-only)   0.47(0.41+0.05)           0.47(0.40+0.05) -0.5%    0.45(0.38+0.06) -3.5%.
 4000.3: log -p -3000 (Myers)          1.81(1.67+0.12)           1.81(1.67+0.13) +0.3%    1.99(1.84+0.12) +10.2%***
 4000.4: log -p -3000 --histogram      1.79(1.66+0.11)           1.80(1.67+0.11) +0.4%    1.96(1.82+0.10) +9.2%***
 4000.5: log -p -3000 --patience       2.17(2.02+0.13)           2.20(2.04+0.13) +1.3%.   2.33(2.18+0.13) +7.4%***
 ------------------------------------------------------------------------------------------------------------------
 Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Incidentally, on the OS X machine I have access to, the difference is
even bigger, something like 14% for 'log -p -3000'.  I'm too lazy to
work out the exact numbers since the perf code doesn't work there.

 xdiff/xutils.c |   52 +++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index e05b5c9..1b3b471 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -290,39 +290,33 @@ static inline unsigned long has_zero(unsigned long a)
 	return ((a - ONEBYTES) & ~a) & HIGHBITS;
 }
 
-#if __WORDSIZE == 64
-
-/*
- * Jan Achrenius on G+: microoptimized version of
- * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
- * that works for the bytemasks without having to
- * mask them first.
- */
 static inline long count_masked_bytes(unsigned long mask)
 {
-	return mask * 0x0001020304050608 >> 56;
-}
-
-#else	/* 32-bit case */
-
-/* Modified Carl Chatfield G+ version for 32-bit */
-static inline long count_masked_bytes(long mask)
-{
-	/*
-	 * (a) gives us
-	 *   -1 (0, ff), 0 (ffff) or 1 (ffffff)
-	 * (b) gives us
-	 *   0 for 0, 1 for (ff ffff ffffff)
-	 * (a+b+1) gives us
-	 *   correct 0-3 bytemask count result
-	 */
-	long a = (mask - 256) >> 23;
-	long b = mask & 1;
-	return a + b + 1;
+	if (sizeof(long) == 8) {
+		/*
+		 * Jan Achrenius on G+: microoptimized version of
+		 * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+		 * that works for the bytemasks without having to
+		 * mask them first.
+		 */
+		return mask * 0x0001020304050608 >> 56;
+	} else {
+		/*
+		 * Modified Carl Chatfield G+ version for 32-bit *
+		 *
+		 * (a) gives us
+		 *   -1 (0, ff), 0 (ffff) or 1 (ffffff)
+		 * (b) gives us
+		 *   0 for 0, 1 for (ff ffff ffffff)
+		 * (a+b+1) gives us
+		 *   correct 0-3 bytemask count result
+		 */
+		long a = (mask - 256) >> 23;
+		long b = mask & 1;
+		return a + b + 1;
+	}
 }
 
-#endif
-
 unsigned long xdl_hash_record(char const **data, char const *top, long flags)
 {
 	unsigned long hash = 5381;
-- 
1.7.10.512.g5bfc6
