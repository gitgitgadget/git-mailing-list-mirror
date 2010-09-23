From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3 v2] use cache for function names in hunk headers
Date: Thu, 23 Sep 2010 09:04:39 +0200
Message-ID: <20100923070439.GA29764@localhost>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 09:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyfqS-0007qb-U4
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 09:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0IWHDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 03:03:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34354 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab0IWHDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 03:03:46 -0400
Received: by bwz11 with SMTP id 11so1045465bwz.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:sender:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=yod2UF0v8PKTaV3L3hKSNekb2ml2OpwlZ5snVgxKepA=;
        b=MQILMGeuBsh8GTop/M9lxZGWBv1mRRgSvBAiG3hcgxf185rhKQcWohnrOGDyuEio5o
         yWDgrtaWVPLylXiVdpAHy9GjiTlG3T4a6dvk8LTDaVdkq9jAHf3nLi4NOyUHfuiWVBC1
         e0+KGfU2oq+Fhwzs6IdOeiJZ/3otzmdfHpsME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:sender:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xMYo6mcA8KB2x0mnMyg285q8b19mrnIZLsXT6eLE/bP+xS99F5a2g+nYjs95WPgyrv
         993heSuKrPc9qieJWv2/k/fP6SRnkBK2DbB/ZbvSgeEWpYw7mVpShNObPCH70JuJ0y+Z
         wzrhz991nbghBYC8e76IGi504dHoOiH2Xo97k=
Received: by 10.204.133.129 with SMTP id f1mr837262bkt.91.1285225425007;
        Thu, 23 Sep 2010 00:03:45 -0700 (PDT)
Received: from darc.lan (p549A5826.dip.t-dialin.net [84.154.88.38])
        by mx.google.com with ESMTPS id x19sm330929bkv.21.2010.09.23.00.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 00:03:44 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OyfrD-0007l1-5B; Thu, 23 Sep 2010 09:04:39 +0200
Content-Disposition: inline
In-Reply-To: <1284890369-4136-1-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156853>

For each hunk, xdl_find_func searches the preimage
for a function name until the beginning of the
file. If the file does not contain any function
names, this search has complexity O(n^2) in the
number of hunks n.

The timing test in t3419 creates a file with 50000
lines and a one-line change every 10 lines, i.e.,
about 5000 hunks. Since none of the lines matches
a function definition the file is searched 5000
times.

Instead of searching the entire file for each hunk
individually, cache and reuse the search result
from previous hunks.

Diff performance for the test described above
before and after this optimization:

2.78user 0.01system 0:02.82elapsed 99%CPU
0.05user 0.01system 0:00.06elapsed 96%CPU

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I have added the test description as requested by
Sverre. There are no code changes with respect to
the previous version of the patch.

The test scenario might seem quite obscure.  But I
have this case in some text files which are not
edited directly by humans.

Clemens

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

