From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 18:38:37 +0200
Message-ID: <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOtci-0005gx-NG
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343Ab2D3Qil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:38:41 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48823 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192Ab2D3Qik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:38:40 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Mon, 30 Apr
 2012 18:38:37 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Apr
 2012 18:38:37 +0200
In-Reply-To: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Sun, 29 Apr 2012 16:52:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196575>

Hi Brian

I can reproduce this.  The problem is that __WORDSIZE is not defined,
either because it's Darwin or because the GCC is too old.  It winds up
compiling the 32-bit case, which of course doesn't work for 64-bit
builds.

Perhaps we can rewrite it in terms of sizeof(long) like this?

diff --git i/xdiff/xutils.c w/xdiff/xutils.c
index e05b5c9..1b3b471 100644
--- i/xdiff/xutils.c
+++ w/xdiff/xutils.c
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
Thomas Rast
trast@{inf,student}.ethz.ch
