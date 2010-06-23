From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/4] msvc: Fix some compiler warnings
Date: Wed, 23 Jun 2010 20:47:50 +0100
Message-ID: <4C2264E6.4030209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVyx-000081-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab0FWTv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:51:26 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:52094 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab0FWTvZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:51:25 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1ORVym-0004qs-nY; Wed, 23 Jun 2010 19:51:25 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149541>


In particular, using the normal (or production) compiler
warning level (-W3), msvc complains as follows:

.../sha1.c(244) : warning C4018: '<' : signed/unsigned mismatch
.../sha1.c(270) : warning C4244: 'function' : conversion from \
   'unsigned __int64' to 'unsigned long', possible loss of data
.../sha1.c(271) : warning C4244: 'function' : conversion from \
   'unsigned __int64' to 'unsigned long', possible loss of data

Note that gcc issues a similar complaint about line 244 when
compiling with -Wextra.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 block-sha1/sha1.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index e102856..c0054a0 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -237,13 +237,13 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
 {
-	int lenW = ctx->size & 63;
+	unsigned int lenW = ctx->size & 63;
 
 	ctx->size += len;
 
 	/* Read the data into W and process blocks as they get full */
 	if (lenW) {
-		int left = 64 - lenW;
+		unsigned int left = 64 - lenW;
 		if (len < left)
 			left = len;
 		memcpy(lenW + (char *)ctx->W, data, left);
@@ -270,8 +270,8 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 	int i;
 
 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
-	padlen[0] = htonl(ctx->size >> 29);
-	padlen[1] = htonl(ctx->size << 3);
+	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
+	padlen[1] = htonl((uint32_t)(ctx->size << 3));
 
 	i = ctx->size & 63;
 	blk_SHA1_Update(ctx, pad, 1+ (63 & (55 - i)));
-- 
1.7.1
