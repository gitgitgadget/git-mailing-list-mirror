From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
Date: Wed, 22 Jul 2009 23:34:34 +0200
Message-ID: <1248298475-2990-3-git-send-email-madcoder@debian.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjZW-0001k8-6q
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZGVVlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZGVVlC
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:41:02 -0400
Received: from pan.madism.org ([88.191.52.104]:40951 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbZGVVlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:41:01 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2009 17:41:01 EDT
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D9CA346502;
	Wed, 22 Jul 2009 23:34:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 160202B1FF; Wed, 22 Jul 2009 23:34:37 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.192.g631f9
In-Reply-To: <1248298475-2990-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123780>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-compat-util.h |    3 ++-
 sha1_file.c       |    2 +-
 xdiff/xdiffi.c    |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 913f41a..6dfc0dd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -26,6 +26,7 @@
 #endif
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
@@ -33,7 +34,7 @@
 #define TYPEOF(x)
 #endif
 
-#define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (sizeof(x) * 8 - (bits))))
+#define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
 #define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
 
 /* Approximation of the length of the decimal representation of this type. */
diff --git a/sha1_file.c b/sha1_file.c
index b91a7dd..4ea0b18 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1170,7 +1170,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || sizeof(long) * 8 <= shift) {
+		if (len <= used || bitsizeof(long) <= shift) {
 			error("bad object header");
 			return 0;
 		}
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1ebab68..da67c04 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -26,7 +26,7 @@
 
 #define XDL_MAX_COST_MIN 256
 #define XDL_HEUR_MIN_COST 256
-#define XDL_LINE_MAX (long)((1UL << (8 * sizeof(long) - 1)) - 1)
+#define XDL_LINE_MAX (long)((1UL << (CHAR_BIT * sizeof(long) - 1)) - 1)
 #define XDL_SNAKE_CNT 20
 #define XDL_K_HEUR 4
 
-- 
1.6.4.rc1.192.g631f9
