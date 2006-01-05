From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix nasty approxidate bug
Date: Wed, 4 Jan 2006 19:33:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601041930510.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jan 05 04:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuLt9-0003RE-Kp
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 04:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWAEDeD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 22:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbWAEDeD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 22:34:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751891AbWAEDeC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 22:34:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k053XuDZ017565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Jan 2006 19:33:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k053Xtd1010266;
	Wed, 4 Jan 2006 19:33:56 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14183>


Stupid me.

If approxidate ends up with a month that is ahead of the current month, it 
decrements the year to last year.

Which is correct, and means that "last december" does the right thing.

HOWEVER. It should only do so if the year is the same as the current year.

Without this fix, "5 days ago" ends up being in 2004, because it first 
decrements five days, getting us to December 2005 (correct), but then it 
also ends up decrementing the year once more to turn that December into 
"last year" (incorrect, since it already _was_ last year).

Duh. Pass me a donut.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/date.c b/date.c
index 3e11500..73037c7 100644
--- a/date.c
+++ b/date.c
@@ -640,7 +640,7 @@ unsigned long approxidate(const char *da
 	}
 	if (number > 0 && number < 32)
 		tm.tm_mday = number;
-	if (tm.tm_mon > now.tm_mon)
+	if (tm.tm_mon > now.tm_mon && tm.tm_year == now.tm_year)
 		tm.tm_year--;
 	return mktime(&tm);
 }
