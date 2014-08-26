From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v6 3/6] Change GIT_ALLOC_LIMIT check to use git_env_ulong()
Date: Tue, 26 Aug 2014 17:23:22 +0200
Message-ID: <1409066605-4851-4-git-send-email-prohaska@zib.de>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 17:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMIbe-0001Np-NY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 17:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbaHZPYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 11:24:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:35567 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbaHZPYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 11:24:11 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNesV011309;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7QFNcNc011272;
	Tue, 26 Aug 2014 17:23:40 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1409066605-4851-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FCA67C.003 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FCA67C.003 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FCA67C.003 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255914>

GIT_ALLOC_LIMIT limits xmalloc()'s size, which is of type size_t.
Better use git_env_ulong() to parse the environment variable, so that
the postfixes 'k', 'm', and 'g' can be used; and use size_t to store the
limit for consistency.  The change to size_t has no direct practical
impact, because we use GIT_ALLOC_LIMIT to test small sizes.

The cast of size in the call to die() is changed to uintmax_t to match
the format string PRIuMAX.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t1050-large.sh |  2 +-
 wrapper.c        | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index aea4936..e7657ab 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	echo X | dd of=large2 bs=1k seek=2000 &&
 	echo X | dd of=large3 bs=1k seek=2000 &&
 	echo Y | dd of=huge bs=1k seek=2500 &&
-	GIT_ALLOC_LIMIT=1500 &&
+	GIT_ALLOC_LIMIT=1500k &&
 	export GIT_ALLOC_LIMIT
 '
 
diff --git a/wrapper.c b/wrapper.c
index bc1bfb8..c5204f7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -11,14 +11,15 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
 
 static void memory_limit_check(size_t size)
 {
-	static int limit = -1;
-	if (limit == -1) {
-		const char *env = getenv("GIT_ALLOC_LIMIT");
-		limit = env ? atoi(env) * 1024 : 0;
+	static size_t limit = 0;
+	if (!limit) {
+		limit = git_env_ulong("GIT_ALLOC_LIMIT", 0);
+		if (!limit)
+			limit = SIZE_MAX;
 	}
-	if (limit && size > limit)
-		die("attempting to allocate %"PRIuMAX" over limit %d",
-		    (intmax_t)size, limit);
+	if (size > limit)
+		die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
+		    (uintmax_t)size, (uintmax_t)limit);
 }
 
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
-- 
2.1.0.8.gf3a29c8
