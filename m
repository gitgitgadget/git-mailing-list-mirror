From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 2/4] Change GIT_ALLOC_LIMIT check to use git_parse_ulong()
Date: Sun, 24 Aug 2014 18:07:44 +0200
Message-ID: <1408896466-23149-3-git-send-email-prohaska@zib.de>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 18:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLaLC-0003oS-So
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 18:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbaHXQIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 12:08:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:49585 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbaHXQIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 12:08:15 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81Ua016859;
	Sun, 24 Aug 2014 18:08:01 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7OG81sE016835;
	Sun, 24 Aug 2014 18:08:01 +0200 (CEST)
X-Mailer: git-send-email 2.0.1.448.g1eafa63
In-Reply-To: <1408896466-23149-1-git-send-email-prohaska@zib.de>
X-Miltered: at mailer.zib.de with ID 53FA0DE1.002 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FA0DE1.002 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FA0DE1.002 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255798>

GIT_ALLOC_LIMIT limits xmalloc()'s size, which is of type size_t.
Better use git_parse_ulong() to parse the environment variable, so that
the postfixes 'k', 'm', and 'g' can be used; and use size_t to store the
limit for consistency.  The change to size_t has no direct practical
impact, because we use GIT_ALLOC_LIMIT to test small sizes.

The cast of size in the call to die() is changed to uintmax_t to match
the format string PRIuMAX.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t1050-large.sh |  2 +-
 wrapper.c        | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index bc1bfb8..69d1c9b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -11,14 +11,18 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
 
 static void memory_limit_check(size_t size)
 {
-	static int limit = -1;
-	if (limit == -1) {
-		const char *env = getenv("GIT_ALLOC_LIMIT");
-		limit = env ? atoi(env) * 1024 : 0;
+	static size_t limit = SIZE_MAX;
+	if (limit == SIZE_MAX) {
+		const char *var = "GIT_ALLOC_LIMIT";
+		unsigned long val = 0;
+		const char *env = getenv(var);
+		if (env && !git_parse_ulong(env, &val))
+			die("Failed to parse %s", var);
+		limit = val;
 	}
 	if (limit && size > limit)
-		die("attempting to allocate %"PRIuMAX" over limit %d",
-		    (intmax_t)size, limit);
+		die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
+		    (uintmax_t)size, (uintmax_t)limit);
 }
 
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
-- 
2.1.0.8.gd3b6067
