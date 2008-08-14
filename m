From: Brian Downing <bdowning@lavos.net>
Subject: [PATCHv2 2/2] Use strbuf for struct xdiff_emit_state's remainder
Date: Thu, 14 Aug 2008 00:13:22 -0500
Message-ID: <1218690802-30536-2-git-send-email-bdowning@lavos.net>
References: <7viqu4gx8c.fsf@gitster.siamese.dyndns.org>
 <1218690802-30536-1-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:14:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVAN-00079F-PX
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbYHNFN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 01:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYHNFN2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:13:28 -0400
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:40823 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751908AbYHNFN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 01:13:27 -0400
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id 1txi1a0020EPchoA25DQor; Thu, 14 Aug 2008 05:13:24 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id 25DP1a0064BqYqi8M5DPre; Thu, 14 Aug 2008 05:13:24 +0000
X-Authority-Analysis: v=1.0 c=1 a=g5Ek3Xm0xi0A:10 a=2mXvQkZ5vegA:10
 a=Dtkb_Dkjc0f87TARwqYA:9 a=epT4o_jl-uhmw23dYmIA:7
 a=VjZGoGTzyh0OYmkbnqmMSeLw3JcA:4 a=GB4YReQY-hoA:10 a=6bqG61NMjcsA:10
Received: from silvara.lavos.net (silvara.lavos.net [10.4.0.20])
	by mnementh.lavos.net (Postfix) with SMTP id 5ADBE309F24;
	Thu, 14 Aug 2008 00:13:21 -0500 (CDT)
Received: (nullmailer pid 30563 invoked by uid 1000);
	Thu, 14 Aug 2008 05:13:22 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1218690802-30536-1-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92316>

Continually xreallocing and freeing the remainder member of struct
xdiff_emit_state was a noticeable performance hit.  Use a strbuf
instead.

This yields a decent performance improvement on "git blame" on certain
repositories.  For example, before this commit:

$ time git blame -M -C -C -p --incremental server.c >/dev/null
101.52user 0.17system 1:41.73elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+39561minor)pagefaults 0swaps

With this commit:

$ time git blame -M -C -C -p --incremental server.c >/dev/null
80.38user 0.30system 1:20.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+50979minor)pagefaults 0swaps

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 xdiff-interface.c |   32 ++++++++++----------------------
 xdiff-interface.h |    4 ++--
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index be448a0..c999469 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -69,36 +69,22 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	for (i = 0; i < nbuf; i++) {
 		if (mb[i].ptr[mb[i].size-1] != '\n') {
 			/* Incomplete line */
-			priv->remainder = xrealloc(priv->remainder,
-						   priv->remainder_size +
-						   mb[i].size);
-			memcpy(priv->remainder + priv->remainder_size,
-			       mb[i].ptr, mb[i].size);
-			priv->remainder_size += mb[i].size;
+			strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
 			continue;
 		}
 
 		/* we have a complete line */
-		if (!priv->remainder) {
+		if (!priv->remainder.len) {
 			consume_one(priv, mb[i].ptr, mb[i].size);
 			continue;
 		}
-		priv->remainder = xrealloc(priv->remainder,
-					   priv->remainder_size +
-					   mb[i].size);
-		memcpy(priv->remainder + priv->remainder_size,
-		       mb[i].ptr, mb[i].size);
-		consume_one(priv, priv->remainder,
-			    priv->remainder_size + mb[i].size);
-		free(priv->remainder);
-		priv->remainder = NULL;
-		priv->remainder_size = 0;
+		strbuf_add(&priv->remainder, mb[i].ptr, mb[i].size);
+		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		strbuf_reset(&priv->remainder);
 	}
-	if (priv->remainder) {
-		consume_one(priv, priv->remainder, priv->remainder_size);
-		free(priv->remainder);
-		priv->remainder = NULL;
-		priv->remainder_size = 0;
+	if (priv->remainder.len) {
+		consume_one(priv, priv->remainder.buf, priv->remainder.len);
+		strbuf_reset(&priv->remainder);
 	}
 	return 0;
 }
@@ -148,7 +134,9 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	int ret;
 	xecb->outf = xdiff_outf;
 	xecb->priv = state;
+	strbuf_init(&state->remainder, 0);
 	ret = xdl_diff(mf1, mf2, xpp, xecfg, xecb);
+	strbuf_release(&state->remainder);
 	return ret;
 }
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 6f3b361..f6a1ec2 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -2,6 +2,7 @@
 #define XDIFF_INTERFACE_H
 
 #include "xdiff/xdiff.h"
+#include "strbuf.h"
 
 struct xdiff_emit_state;
 
@@ -9,8 +10,7 @@ typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
-	char *remainder;
-	unsigned long remainder_size;
+	struct strbuf remainder;
 };
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
-- 
1.5.6.1
