From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] use cache for function names in hunk headers
Date: Sun, 19 Sep 2010 11:59:29 +0200
Message-ID: <1284890369-4136-4-git-send-email-drizzd@aon.at>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 11:59:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGgN-0005V2-UZ
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab0ISJ7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 05:59:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44960 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab0ISJ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 05:59:21 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3701062bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1o9ROMG90dIbWoPTSLMUvHXeJBC0cSIROH7kOoVUO1A=;
        b=fkPWGBGaAWNAqDBuviEGly2Wjs2XP5ogpXrE6iD7NWT/YSC/hXj5OpUWNbQxkIF6ju
         EeACYJveLZ8SVt7UwcljsmCyLo5n6lE+PiDoQCBFRk4KBEzGVsBW1mg2yWgBwIVwmHTv
         9GdZaFyWI+eODCx0esDf6zB3u7FPr6FeDx+7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=NQ3AtrBB1/Duly9GCMqz48TNLgAOZP+yq6Ic9O7bfMyVwRShLwGIqYjkT4FzBbZSjs
         M8mQU93wq4A0iyNK/3fyZrLoE78bVp/zOdIXbjo0pkq0j0uR1wAbDC5Vzefsf8yodg18
         MV+qqPzBt5nAmo8QQziNPuIspM9BrqfWw4RfI=
Received: by 10.204.77.137 with SMTP id g9mr5463821bkk.189.1284890361242;
        Sun, 19 Sep 2010 02:59:21 -0700 (PDT)
Received: from darc.lan (p549A467A.dip.t-dialin.net [84.154.70.122])
        by mx.google.com with ESMTPS id x19sm5447168bkv.21.2010.09.19.02.59.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 02:59:20 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxGgp-00015Z-AY; Sun, 19 Sep 2010 12:00:07 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156492>

For each hunk, xdl_find_func searches the preimage
for a function name until the beginning of the
file. If the file does not contain any function
names, this search has complexity O(n^2) in the
number of hunks n.

Instead of searching the entire file for each hunk
individually, cache and reuse the search result
from previous hunks.

Diff performance for the 50000 line test in t3419
before and after this patch:

2.78user 0.01system 0:02.82elapsed 99%CPU
0.05user 0.01system 0:00.06elapsed 96%CPU

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 xdiff/xemit.c |   44 ++++++++++++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index c4bedf0..349bd6b 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -85,8 +85,15 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 	return -1;
 }
 
-static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
-		find_func_t ff, void *ff_priv) {
+struct xdl_find_func_cache {
+	char buf[80];
+	long len;
+	xdfile_t *xf;
+	int line;
+};
+
+static void xdl_find_func(xdfile_t *xf, long line, find_func_t ff,
+		          void *ff_priv, struct xdl_find_func_cache *cache) {
 
 	/*
 	 * Be quite stupid about this for now.  Find a line in the old file
@@ -96,13 +103,28 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
 
 	const char *rec;
 	long len;
+	int i, l;
 
-	while (i-- > 0) {
-		len = xdl_get_rec(xf, i, &rec);
-		if ((*ll = ff(rec, len, buf, sz, ff_priv)) >= 0)
+	if (line < cache->line)
+		cache->xf = 0;
+
+	i = line;
+	l = -1;
+	while (--i >= 0 && l < 0) {
+		if (xf == cache->xf && i < cache->line) {
+			cache->line = line;
 			return;
+		}
+
+		len = xdl_get_rec(xf, i, &rec);
+		l = ff(rec, len, cache->buf, sizeof(cache->buf), ff_priv);
 	}
-	*ll = 0;
+	if (l < 0)
+		l = 0;
+
+	cache->xf = xf;
+	cache->len = l;
+	cache->line = line;
 }
 
 
@@ -125,8 +147,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
-	char funcbuf[80];
-	long funclen = 0;
+	struct xdl_find_func_cache func_cache = { "", 0, NULL, -1 };
 	find_func_t ff = xecfg->find_func ?  xecfg->find_func : def_ff;
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
@@ -150,12 +171,11 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		 */
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
-			xdl_find_func(&xe->xdf1, s1, funcbuf,
-				      sizeof(funcbuf), &funclen,
-				      ff, xecfg->find_func_priv);
+			xdl_find_func(&xe->xdf1, s1, ff, xecfg->find_func_priv,
+					&func_cache);
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
-				      funcbuf, funclen, ecb) < 0)
+				      func_cache.buf, func_cache.len, ecb) < 0)
 			return -1;
 
 		/*
-- 
1.7.1.571.gba4d01
