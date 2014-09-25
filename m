From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] Receive-pack: include entire SHA1 in nonce
Date: Thu, 25 Sep 2014 11:02:20 -0400
Message-ID: <1411657340-62950-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:11:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXAi0-0000uh-72
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 17:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbaIYPLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 11:11:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38371 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbaIYPLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 11:11:40 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Sep 2014 11:11:40 EDT
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E642016223E2;
	Thu, 25 Sep 2014 15:02:34 +0000 (UTC)
X-Mailer: git-send-email 2.1.1.445.gb8dfbef.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257477>

clang gives the following warning:

builtin/receive-pack.c:327:35: error: sizeof on array function
parameter will return size of 'unsigned char *' instead of 'unsigned
char [20]' [-Werror,-Wsizeof-array-argument]
        git_SHA1_Update(&ctx, out, sizeof(out));
                                         ^
builtin/receive-pack.c:292:37: note: declared here
static void hmac_sha1(unsigned char out[20],
                                    ^
---

 I dislike changing sizeof to a magic constant, but clang informs me that
 sizeof is doing the wrong thing.  Perhaps there's an appropriate constant
 #defined in the code somewhere?

 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aab3df7..92388e5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -324,7 +324,7 @@ static void hmac_sha1(unsigned char out[20],
 	/* RFC 2104 2. (6) & (7) */
 	git_SHA1_Init(&ctx);
 	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
-	git_SHA1_Update(&ctx, out, sizeof(out));
+	git_SHA1_Update(&ctx, out, 20);
 	git_SHA1_Final(out, &ctx);
 }
 
-- 
2.1.1.445.gb8dfbef.dirty
