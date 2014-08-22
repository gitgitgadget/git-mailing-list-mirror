From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v4 3/4] Change GIT_ALLOC_LIMIT check to use ssize_t for consistency
Date: Fri, 22 Aug 2014 16:01:22 +0200
Message-ID: <1408716083-9093-4-git-send-email-prohaska@zib.de>
References: <1408716083-9093-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:02:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKpQG-0001dS-2C
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 16:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbaHVOCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 10:02:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:33007 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110AbaHVOCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 10:02:23 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1wQ3009796;
	Fri, 22 Aug 2014 16:01:58 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7ME1vrU009676;
	Fri, 22 Aug 2014 16:01:58 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1408716083-9093-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53F74D56.003 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53F74D56.003 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53F74D56.003 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255671>

GIT_ALLOC_LIMIT limits xmalloc()'s size, which is of type size_t.  Use
ssize_t to store the limit for consistency.  The change has no direct
practical impact, because we use GIT_ALLOC_LIMIT to test small sizes.

The cast of size in the call to die() is changed to uintmax_t to match
the format string PRIuMAX.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 wrapper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..e91f6e9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -11,14 +11,14 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
 
 static void memory_limit_check(size_t size)
 {
-	static int limit = -1;
+	static ssize_t limit = -1;
 	if (limit == -1) {
 		const char *env = getenv("GIT_ALLOC_LIMIT");
-		limit = env ? atoi(env) * 1024 : 0;
+		limit = env ? atol(env) * 1024 : 0;
 	}
 	if (limit && size > limit)
-		die("attempting to allocate %"PRIuMAX" over limit %d",
-		    (intmax_t)size, limit);
+		die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
+		    (uintmax_t)size, (uintmax_t)limit);
 }
 
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
-- 
2.1.0.6.gb452461
