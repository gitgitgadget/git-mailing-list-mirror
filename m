From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 09/10] pickaxe: call strlen only when necessary in diffcore_pickaxe_count()
Date: Sat, 22 Mar 2014 18:15:59 +0100
Message-ID: <1395508560-19893-10-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPY9-00030i-Bf
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbaCVRQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:53 -0400
Received: from mout.web.de ([212.227.15.14]:54442 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbaCVRQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:36 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MWj7r-1Wcg2y155v-00XtZ8; Sat, 22 Mar 2014 18:16:27
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:xxIGA/C06E2/9OeIZUUVmK3rOMUuwd6KcweTYRQ41XbKHL9GbXq
 4orEEvfHTcbxCz5jbuZylTHe4b9HKG8lkkvxkuXxFFRwVpEejyMWoJ9biWFrT5ri7vf6UkP
 OKNc1fUCDSkX8XyKCrq61DOlpvNIy7oXZrQ2PRmamhPzArf8TCh/E7v2H4P5v6x5/WSEWcw
 Vnqv/JD15FVYI40XDCsIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244781>

We need to determine the search term's length only when fixed-string
matching is used; regular expression compilation takes a NUL-terminated
string directly.  Only call strlen() in the former case.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diffcore-pickaxe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 827a7d7..70753d0 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -205,7 +205,6 @@ void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
-	unsigned long len = strlen(needle);
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
 
@@ -226,7 +225,7 @@ void diffcore_pickaxe(struct diff_options *o)
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
 			       ? tolower_trans_tbl : NULL);
-		kwsincr(kws, needle, len);
+		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
 	}
 
-- 
1.9.1
