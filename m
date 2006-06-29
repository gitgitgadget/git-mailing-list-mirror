From: Linus Torvalds <torvalds@osdl.org>
Subject: xdiff: generate "anti-diffs" aka what is common to two files
Date: Wed, 28 Jun 2006 21:57:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606282149060.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jun 29 06:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvoag-0006Wg-BZ
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 06:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWF2E5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 00:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWF2E5S
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 00:57:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751730AbWF2E5R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 00:57:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5T4vDnW000364
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Jun 2006 21:57:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5T4vCX5008592;
	Wed, 28 Jun 2006 21:57:13 -0700
To: Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22839>


This fairly trivial patch adds a new XDL_EMIT_xxx flag to tell libxdiff 
that we don't want to generate the _diff_ between two files, we want to 
see the lines that are _common_ to two files.

So when you set XDL_EMIT_COMMON, xdl_diff() will do everything exactly 
like it used to do, but the output records it generates just contain the 
lines that aren't part of the diff.

This is for doing things like generating the common base case for a file 
that was added in both branches.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Davide, I say it's a "fairly trivial patch", but quite frankly, I'm 
winging it. I'm not that comfortable with the libxdiff internal workings, 
so while this seems to work for me and make sense, can you please take a 
quick look.

Junio: the patch that actually _uses_ this comes next. It's based on my 
previous "throw-away" example patches, if you want me to base it on 
something else, please holler.

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2ce10b4..c9f8178 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -39,6 +39,7 @@ #define XDL_PATCH_MODEMASK ((1 << 8) - 1
 #define XDL_PATCH_IGNOREBSPACE (1 << 8)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
+#define XDL_EMIT_COMMON (1 << 1)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad5bfb1..3604ca1 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -100,6 +100,21 @@ static void xdl_find_func(xdfile_t *xf, 
 }
 
 
+int xdl_emit_common(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+		    xdemitconf_t const *xecfg) {
+	xdfile_t *xdf = &xe->xdf1;
+	const char *rchg = xdf->rchg;
+	long ix;
+
+	for (ix = 0; ix < xdf->nrec; ix++) {
+		if (rchg[ix])
+			continue;
+		if (xdl_emit_record(xdf, ix, "", ecb))
+			return -1;
+	}
+	return 0;
+}		
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
@@ -107,6 +122,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange
 	char funcbuf[40];
 	long funclen = 0;
 
+	if (xecfg->flags & XDL_EMIT_COMMON)
+		return xdl_emit_common(xe, xscr, ecb, xecfg);
+
 	for (xch = xche = xscr; xch; xch = xche->next) {
 		xche = xdl_get_hunk(xch, xecfg);
 
