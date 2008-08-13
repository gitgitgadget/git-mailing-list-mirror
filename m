From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 2/2] Use strbuf for struct xdiff_emit_state's remainder
Date: Wed, 13 Aug 2008 02:07:19 -0500
Message-ID: <20080813070719.GC4396@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:08:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAT5-0005F8-C8
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYHMHHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYHMHHY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:07:24 -0400
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:55727 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbYHMHHX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 03:07:23 -0400
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id 1ixN1a0090QkzPwA9j7MZT; Wed, 13 Aug 2008 07:07:21 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA02.emeryville.ca.mail.comcast.net with comcast
	id 1j7K1a0074BqYqi8Nj7Lhj; Wed, 13 Aug 2008 07:07:21 +0000
X-Authority-Analysis: v=1.0 c=1 a=ub2J-iLhTbsA:10 a=okfeYmnVdu8A:10
 a=RV2KCPfeohWhKwn3gvMA:9 a=TWH0ydkigSCkKbdMv_8A:7
 a=DXuWzZFeDgHd0t5vflK30KNsfnIA:4 a=GB4YReQY-hoA:10 a=6bqG61NMjcsA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id B1229309F23; Wed, 13 Aug 2008 02:07:19 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92184>

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
 xdiff-interface.c |   33 +++++++++++----------------------
 xdiff-interface.h |    4 ++--
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 9c5e277..4462177 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -66,6 +66,7 @@ void xdiff_outf_init(xdemitcb_t *ecb, void *priv_)
 	struct xdiff_emit_state *priv = priv_;
 	ecb->outf = xdiff_outf;
 	ecb->priv = priv;
+	strbuf_init(&priv->remainder, 0);
 }
 
 int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
@@ -76,42 +77,30 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
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
 
 void xdiff_outf_release(void *priv_)
 {
+	struct xdiff_emit_state *priv = priv_;
+	strbuf_release(&priv->remainder);
 }
 
 /*
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fca6200..9b7e4a8 100644
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
