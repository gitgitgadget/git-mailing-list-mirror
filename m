From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Optionally emit function names in the hunk headers.
Date: Thu, 22 Jun 2006 11:58:02 -0700
Message-ID: <7v8xnpm30l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Thu Jun 22 20:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUNY-0004Ih-H6
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWFVS6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWFVS6H
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:07 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46573 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161193AbWFVS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:58:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185804.PNLJ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:58:04 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22354>

From: Mark Wooding <mdw@distorted.org.uk>

This is a patch on top of libxdiff 0.21 we use in the git project.
---
 xdiff.h   |    5 ++++-
 xemit.c   |   41 ++++++++++++++++++++++++++++++++++++++++-
 xpatchi.c |    2 +-
 xutils.c  |   31 ++++++++++++++++++++++---------
 xutils.h  |    3 ++-
 5 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/xdiff.h b/xdiff.h
index d051216..f4af41b 100644
--- a/xdiff.h
+++ b/xdiff.h
@@ -34,7 +34,9 @@ #define XDL_PATCH_NORMAL '-'
 #define XDL_PATCH_REVERSE '+'
 #define XDL_PATCH_MODEMASK ((1 << 8) - 1)
 #define XDL_PATCH_IGNOREBSPACE (1 << 8)
-	
+
+#define XDL_EMIT_FUNCNAMES (1 << 0)
+
 #define XDL_MMB_READONLY (1 << 0)
 
 #define XDL_MMF_ATOMIC (1 << 0)
@@ -82,6 +84,7 @@ typedef struct s_xdemitcb {
 
 typedef struct s_xdemitconf {
 	long ctxlen;
+	unsigned long flags;
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xemit.c b/xemit.c
index 2e5d54c..ad5bfb1 100644
--- a/xemit.c
+++ b/xemit.c
@@ -69,10 +69,43 @@ static xdchange_t *xdl_get_hunk(xdchange
 }
 
 
+static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
+
+	/*
+	 * Be quite stupid about this for now.  Find a line in the old file
+	 * before the start of the hunk (and context) which starts with a
+	 * plausible character.
+	 */
+
+	const char *rec;
+	long len;
+
+	*ll = 0;
+	while (i-- > 0) {
+		len = xdl_get_rec(xf, i, &rec);
+		if (len > 0 &&
+		    (isalpha((unsigned char)*rec) || /* identifier? */
+		     *rec == '_' ||	/* also identifier? */
+		     *rec == '(' ||	/* lisp defun? */
+		     *rec == '#')) {	/* #define? */
+			if (len > sz)
+				len = sz;
+			if (len && rec[len - 1] == '\n')
+				len--;
+			memcpy(buf, rec, len);
+			*ll = len;
+			return;
+		}
+	}
+}
+
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
+	char funcbuf[40];
+	long funclen = 0;
 
 	for (xch = xche = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(xch, xecfg);
@@ -90,7 +123,13 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange
 		/*
 		 * Emit current hunk header.
 		 */
-		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2, ecb) < 0)
+
+		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
+			xdl_find_func(&xe->xdf1, s1, funcbuf,
+				      sizeof(funcbuf), &funclen);
+		}
+		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
+				      funcbuf, funclen, ecb) < 0)
 			return -1;
 
 		/*
diff --git a/xpatchi.c b/xpatchi.c
index dc984f8..da4e018 100644
--- a/xpatchi.c
+++ b/xpatchi.c
@@ -530,7 +530,7 @@ static int xdl_reject_hunk(recfile_t *rf
 		c2 = pch->hi.c1;
 	}
 	s1 += pch->ps.adds - pch->ps.dels;
-	if (xdl_emit_hunk_hdr(s1 + 1, c1, s2 + 1, c2, rjecb) < 0) {
+	if (xdl_emit_hunk_hdr(s1 + 1, c1, s2 + 1, c2, NULL, 0, rjecb) < 0) {
 
 		return -1;
 	}
diff --git a/xutils.c b/xutils.c
index 2fe09d8..a776706 100644
--- a/xutils.c
+++ b/xutils.c
@@ -542,7 +542,8 @@ long xdl_atol(char const *str, char cons
 }
 
 
-int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb) {
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
+		      const char *func, long funclen, xdemitcb_t *ecb) {
 	int nb = 0;
 	mmbuffer_t mb;
 	char buf[128];
@@ -552,23 +553,35 @@ int xdl_emit_hunk_hdr(long s1, long c1, 
 
 	nb += xdl_num_out(buf + nb, c1 ? s1: s1 - 1);
 
-	memcpy(buf + nb, ",", 1);
-	nb += 1;
+	if (c1 != 1) {
+		memcpy(buf + nb, ",", 1);
+		nb += 1;
 
-	nb += xdl_num_out(buf + nb, c1);
+		nb += xdl_num_out(buf + nb, c1);
+	}
 
 	memcpy(buf + nb, " +", 2);
 	nb += 2;
 
 	nb += xdl_num_out(buf + nb, c2 ? s2: s2 - 1);
 
-	memcpy(buf + nb, ",", 1);
-	nb += 1;
+	if (c2 != 1) {
+		memcpy(buf + nb, ",", 1);
+		nb += 1;
 
-	nb += xdl_num_out(buf + nb, c2);
+		nb += xdl_num_out(buf + nb, c2);
+	}
 
-	memcpy(buf + nb, " @@\n", 4);
-	nb += 4;
+	memcpy(buf + nb, " @@", 3);
+	nb += 3;
+	if (func && funclen) {
+		buf[nb++] = ' ';
+		if (funclen > sizeof(buf) - nb - 1)
+			funclen = sizeof(buf) - nb - 1;
+		memcpy(buf + nb, func, funclen);
+		nb += funclen;
+	}
+	buf[nb++] = '\n';
 
 	mb.ptr = buf;
 	mb.size = nb;
diff --git a/xutils.h b/xutils.h
index 4ceae33..5a3e13b 100644
--- a/xutils.h
+++ b/xutils.h
@@ -39,7 +39,8 @@ unsigned long xdl_hash_record(char const
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
-int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb);
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
+		      const char *func, long funclen, xdemitcb_t *ecb);
 
 
 
-- 
1.4.0.gbf9e
