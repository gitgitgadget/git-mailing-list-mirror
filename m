From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 03:23:31 +0100
Message-ID: <11435126113456-git-send-email-mdw@distorted.org.uk>
Reply-To: Mark Wooding <mdw@distorted.org.uk>
Cc: Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Tue Mar 28 04:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO3s5-00036B-Gf
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWC1CXe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWC1CXe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:23:34 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:40795 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932177AbWC1CXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 21:23:33 -0500
Received: (qmail 24900 invoked from network); 28 Mar 2006 02:23:31 -0000
Received: from localhost (HELO localhost.localdomain) (127.0.0.1)
  by localhost with SMTP; 28 Mar 2006 02:23:31 -0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.rc1.g7464
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18102>

The speed of the built-in diff generator is nice; but the function names
shown by `diff -p' are /really/ nice.  And I hate having to choose.  So,
we hack xdiff to find the function names and print them.

xdiff has grown a flag to say whether to dig up the function names.  The
builtin_diff function passes this flag unconditionally.  I suppose it
could parse GIT_DIFF_OPTS, but it doesn't at the moment.  I've also
reintroduced the `function name' into the test suite, from which it was
removed in commit 3ce8f089.

The function names are parsed by a particularly stupid algorithm at the
moment: it just tries to find a line in the `old' file, from before the
start of the hunk, whose first character looks plausible.  Still, it's
most definitely a start.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>

---

 diff.c                 |    1 +
 t/t4001-diff-rename.sh |    2 +-
 xdiff/xdiff.h          |    3 +++
 xdiff/xemit.c          |   41 ++++++++++++++++++++++++++++++++++++++++-
 xdiff/xinclude.h       |    1 +
 xdiff/xutils.c         |   15 ++++++++++++---
 xdiff/xutils.h         |    3 ++-
 7 files changed, 60 insertions(+), 6 deletions(-)

746418a20769c003886d7f4bbec6563af7aabd4b
diff --git a/diff.c b/diff.c
index 5eae094..8b37477 100644
--- a/diff.c
+++ b/diff.c
@@ -267,6 +267,7 @@ static void builtin_diff(const char *nam
 		ecbdata.label_path = lbl;
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
+		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
 			;
 		else if (!strncmp(diffopts, "--unified=", 10))
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 08c1131..2e3c20d 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -49,7 +49,7 @@ rename from path0
 rename to path1
 --- a/path0
 +++ b/path1
-@@ -8,7 +8,7 @@
+@@ -8,7 +8,7 @@ Line 7
  Line 8
  Line 9
  Line 10
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 71cb939..2540e8a 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -35,6 +35,8 @@ #define XDL_PATCH_REVERSE '+'
 #define XDL_PATCH_MODEMASK ((1 << 8) - 1)
 #define XDL_PATCH_IGNOREBSPACE (1 << 8)
 
+#define XDL_EMIT_FUNCNAMES (1 << 0)
+
 #define XDL_MMB_READONLY (1 << 0)
 
 #define XDL_MMF_ATOMIC (1 << 0)
@@ -65,6 +67,7 @@ typedef struct s_xdemitcb {
 
 typedef struct s_xdemitconf {
 	long ctxlen;
+	unsigned long flags;
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 2e5d54c..ad5bfb1 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
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
diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
index 9490fc5..04a9da8 100644
--- a/xdiff/xinclude.h
+++ b/xdiff/xinclude.h
@@ -23,6 +23,7 @@
 #if !defined(XINCLUDE_H)
 #define XINCLUDE_H
 
+#include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 8221806..afaada1 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -235,7 +235,8 @@ long xdl_atol(char const *str, char cons
 }
 
 
-int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb) {
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
+		      const char *func, long funclen, xdemitcb_t *ecb) {
 	int nb = 0;
 	mmbuffer_t mb;
 	char buf[128];
@@ -264,8 +265,16 @@ int xdl_emit_hunk_hdr(long s1, long c1, 
 		nb += xdl_num_out(buf + nb, c2);
 	}
 
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
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 428a4bb..55b0d39 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -36,7 +36,8 @@ unsigned long xdl_hash_record(char const
 unsigned int xdl_hashbits(unsigned int size);
 int xdl_num_out(char *out, long val);
 long xdl_atol(char const *str, char const **next);
-int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2, xdemitcb_t *ecb);
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
+		      const char *func, long funclen, xdemitcb_t *ecb);
 
 
 
-- 
1.3.0.rc1.g7464
