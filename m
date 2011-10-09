From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] xdiff: factor out get_func_line()
Date: Sun, 09 Oct 2011 13:34:49 +0200
Message-ID: <4E9186D9.4060805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 13:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCrf0-0007vN-VJ
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 13:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab1JILfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 07:35:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:56506 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1JILfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 07:35:09 -0400
Received: from [192.168.2.104] (p4FFDBD6A.dip.t-dialin.net [79.253.189.106])
	by india601.server4you.de (Postfix) with ESMTPSA id 7F06B2F8030;
	Sun,  9 Oct 2011 13:35:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183197>

Move the code to search for a function line to be shown in the hunk
header into its own function and to make returning the length-limited
result string easier, introduce struct func_line.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff/xemit.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 277e2ee..64eb17a 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -100,14 +100,35 @@ static int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }
 
+struct func_line {
+	long len;
+	char buf[80];
+};
+
+static void get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
+			  struct func_line *func_line, long start, long limit)
+{
+	find_func_t ff = xecfg->find_func ? xecfg->find_func : def_ff;
+	long l, size = sizeof(func_line->buf);
+	char *buf = func_line->buf;
+
+	for (l = start; l > limit && 0 <= l; l--) {
+		const char *rec;
+		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
+		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);
+		if (len >= 0) {
+			func_line->len = len;
+			break;
+		}
+	}
+}
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
-	char funcbuf[80];
-	long funclen = 0;
 	long funclineprev = -1;
-	find_func_t ff = xecfg->find_func ?  xecfg->find_func : def_ff;
+	struct func_line func_line = { 0 };
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
 		return xdl_emit_common(xe, xscr, ecb, xecfg);
@@ -130,22 +151,12 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		 */
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
-			long l;
-			for (l = s1 - 1; l >= 0 && l > funclineprev; l--) {
-				const char *rec;
-				long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
-				long newfunclen = ff(rec, reclen, funcbuf,
-						     sizeof(funcbuf),
-						     xecfg->find_func_priv);
-				if (newfunclen >= 0) {
-					funclen = newfunclen;
-					break;
-				}
-			}
+			get_func_line(xe, xecfg, &func_line,
+				      s1 - 1, funclineprev);
 			funclineprev = s1 - 1;
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
-				      funcbuf, funclen, ecb) < 0)
+				      func_line.buf, func_line.len, ecb) < 0)
 			return -1;
 
 		/*
-- 
1.7.7
