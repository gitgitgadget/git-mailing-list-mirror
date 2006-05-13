From: Linus Torvalds <torvalds@osdl.org>
Subject: [RFC] Add "rcs format diff" support
Date: Sat, 13 May 2006 14:14:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605131405590.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat May 13 23:14:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff1Rc-0001oG-4m
	for gcvg-git@gmane.org; Sat, 13 May 2006 23:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWEMVOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 17:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWEMVOX
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 17:14:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751351AbWEMVOW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 17:14:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4DLEGtH015731
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 May 2006 14:14:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4DLEFqY021711;
	Sat, 13 May 2006 14:14:16 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19948>


Al was asking for the "diff -n" format, which is the old RCS format, and 
which is really easy to parse.

Now, we can't use the "-n" flag, because we use that for something else, 
and quite frankly, I don't know what to do about the diff _header_ (RCS 
format doesn't have a header, afaik), but this implements the actual core 
"xdiff" rcs-format patch emit logic, and exposes it with the 
XDL_EMIT_RCSFORMAT flag. 

(In order to get valid diffs, you also have to set the context to zero 
when you set the RCSFORMAT flag).

It also adds a "--rcs-format" flag to the git diff option parsing, so you 
can test it out, but as mentioned, we will still emit the full git header.

Davide - I think the "xdiff/" sub-part of the patch should apply fine to 
the standard xdiff sources, but I'm not sure you're really interested. The 
header issue doesn't matter there, of course, since xdiff doesn't output 
any headers (ie that is an issue for the higher-level user).

The biggest issue for the xdiff library was that I needed to pass down 
the xecfg parameter deeper into the call-chain (ie down to xdl_emit_record 
& co). The rest is pretty trivial.

Al - feel free to play with this. I didn't test it heavily, but it gave 
the right output for the one case I compared with "diff -n". This patch is 
on top of my previous patch to parse "-U" and "--unified".

Junio - this is not really meant for applying, although I don't think 
there is any real down-side to this either. 

		Linus

---
diff --git a/diff.c b/diff.c
index be925a3..fd8f454 100644
--- a/diff.c
+++ b/diff.c
@@ -568,6 +568,10 @@ static void builtin_diff(const char *nam
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
 		ecb.outf = fn_out;
 		ecb.priv = &ecbdata;
+		if (o->rcs_format) {
+			xecfg.flags |= XDL_EMIT_RCSFORMAT;
+			xecfg.ctxlen = 0;
+		}
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
@@ -1277,6 +1281,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_format = DIFF_FORMAT_PATCH;
 	else if (opt_arg(arg, 'U', "unified", &options->context))
 		options->output_format = DIFF_FORMAT_PATCH;
+	else if (!strcmp(arg, "--rcs-format"))
+		options->rcs_format = 1;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
diff --git a/diff.h b/diff.h
index bef586d..953beb9 100644
--- a/diff.h
+++ b/diff.h
@@ -29,6 +29,7 @@ struct diff_options {
 		 with_stat:1,
 		 tree_in_recursive:1,
 		 binary:1,
+		 rcs_format:1,
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2540e8a..a52359e 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -36,6 +36,7 @@ #define XDL_PATCH_MODEMASK ((1 << 8) - 1
 #define XDL_PATCH_IGNOREBSPACE (1 << 8)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
+#define XDL_EMIT_RCSFORMAT (1 << 1)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index ad5bfb1..e127469 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -26,7 +26,7 @@ #include "xinclude.h"
 
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb, xdemitconf_t const *xecfg);
 static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
 
 
@@ -40,12 +40,13 @@ static long xdl_get_rec(xdfile_t *xdf, l
 }
 
 
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre,
+	xdemitcb_t *ecb, xdemitconf_t const *xecfg) {
 	long size, psize = strlen(pre);
 	char const *rec;
 
 	size = xdl_get_rec(xdf, ri, &rec);
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0) {
+	if (xdl_emit_diffrec(rec, size, pre, psize, ecb, xecfg) < 0) {
 
 		return -1;
 	}
@@ -129,14 +130,14 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange
 				      sizeof(funcbuf), &funclen);
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
-				      funcbuf, funclen, ecb) < 0)
+				      funcbuf, funclen, ecb, xecfg) < 0)
 			return -1;
 
 		/*
 		 * Emit pre-context.
 		 */
 		for (; s1 < xch->i1; s1++)
-			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb, xecfg) < 0)
 				return -1;
 
 		for (s1 = xch->i1, s2 = xch->i2;; xch = xch->next) {
@@ -144,21 +145,21 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange
 			 * Merge previous with current change atom.
 			 */
 			for (; s1 < xch->i1 && s2 < xch->i2; s1++, s2++)
-				if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+				if (xdl_emit_record(&xe->xdf1, s1, " ", ecb, xecfg) < 0)
 					return -1;
 
 			/*
 			 * Removes lines from the first file.
 			 */
 			for (s1 = xch->i1; s1 < xch->i1 + xch->chg1; s1++)
-				if (xdl_emit_record(&xe->xdf1, s1, "-", ecb) < 0)
+				if (xdl_emit_record(&xe->xdf1, s1, "-", ecb, xecfg) < 0)
 					return -1;
 
 			/*
 			 * Adds lines from the second file.
 			 */
 			for (s2 = xch->i2; s2 < xch->i2 + xch->chg2; s2++)
-				if (xdl_emit_record(&xe->xdf2, s2, "+", ecb) < 0)
+				if (xdl_emit_record(&xe->xdf2, s2, "+", ecb, xecfg) < 0)
 					return -1;
 
 			if (xch == xche)
@@ -171,7 +172,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange
 		 * Emit post-context.
 		 */
 		for (s1 = xche->i1 + xche->chg1; s1 < e1; s1++)
-			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb) < 0)
+			if (xdl_emit_record(&xe->xdf1, s1, " ", ecb, xecfg) < 0)
 				return -1;
 	}
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 21ab8e7..b0d075a 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -43,10 +43,20 @@ long xdl_bogosqrt(long n) {
 
 
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
-		     xdemitcb_t *ecb) {
+		     xdemitcb_t *ecb, xdemitconf_t const *xecfg) {
 	mmbuffer_t mb[3];
 	int i;
 
+	if (xecfg->flags & XDL_EMIT_RCSFORMAT) {
+		if (*pre != '+')
+			return 0;
+		mb[0].ptr = (char *) rec;
+		mb[0].size = size;
+		if (ecb->outf(ecb->priv, mb, 1) < 0)
+			return -1;
+		return 0;
+	}
+
 	mb[0].ptr = (char *) pre;
 	mb[0].size = psize;
 	mb[1].ptr = (char *) rec;
@@ -249,11 +259,34 @@ long xdl_atol(char const *str, char cons
 
 
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-		      const char *func, long funclen, xdemitcb_t *ecb) {
+		      const char *func, long funclen,
+		      xdemitcb_t *ecb, xdemitconf_t const *xecfg) {
 	int nb = 0;
 	mmbuffer_t mb;
 	char buf[128];
 
+	if (xecfg->flags & XDL_EMIT_RCSFORMAT) {
+		if (c1) {
+			buf[nb++] = 'd';
+			nb += xdl_num_out(buf + nb, s1);
+			buf[nb++] = ' ';
+			nb += xdl_num_out(buf + nb, c1);
+			buf[nb++] = '\n';
+		}
+		if (c2) {
+			buf[nb++] = 'a';
+			nb += xdl_num_out(buf + nb, s2);
+			buf[nb++] = ' ';
+			nb += xdl_num_out(buf + nb, c2);
+			buf[nb++] = '\n';
+		}
+		mb.ptr = buf;
+		mb.size = nb;
+		if (ecb->outf(ecb->priv, &mb, 1) < 0)
+			return -1;
+		return 0;
+	}
+
 	memcpy(buf, "@@ -", 4);
 	nb += 4;
 
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index ea38ee9..e5c6ed0 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -26,7 +26,7 @@ #define XUTILS_H
 
 long xdl_bogosqrt(long n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
-		     xdemitcb_t *ecb);
+		     xdemitcb_t *ecb, xdemitconf_t const *xecfg);
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
@@ -38,7 +38,8 @@ unsigned int xdl_hashbits(unsigned int s
 int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
 int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-		      const char *func, long funclen, xdemitcb_t *ecb);
+		      const char *func, long funclen,
+		      xdemitcb_t *ecb, xdemitconf_t const *xecfg);
 
 
 
