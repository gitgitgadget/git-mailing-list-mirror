From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/4] refactor merge flags into xmparam_t
Date: Mon,  1 Mar 2010 22:46:26 +0100
Message-ID: <386850ac4b3c19e3a10ca4c6bca754487fc1adf2.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDS2-0000k2-4S
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab0CAVqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:46:40 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:46151 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0CAVqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:46:38 -0500
Received: by mail-bw0-f212.google.com with SMTP id 4so2233909bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NMIssvMd/n/XtLmfpN35TOcY4bTpDl6oEh2AOPBbZ0A=;
        b=mELtUWqJ3+5yeHWBzkLeUHfFxjep87m/4mYZMKsdnIn7fC0/RLwgNyYEaKL+bRWojM
         ngIyLGPQzHf/z+g8d1IAtOOzOnRxHwNWMqlMD3mmhdwiEWi14Howhj+QpWhyN4Yl3LY0
         cLgwpAktO3Yk/0lVSDygAyJXsHxz3qvg4Z2wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZCoLyHVbA8c3p9gL2+n6bGGQ0Q64W2NHuubn28QvMnT3MIywggW84Mqi7W+A7IPGx2
         QaVFY/0CsmWUBHwcCfeCNtoIGJAz5Xh2U/b9NarDY7U4upEP74Lr2/Hf+Dcid5YhcS6Q
         MWDUlycthjO9MDDPhnGRfVDNRYYa23I9s7Mn0=
Received: by 10.204.135.154 with SMTP id n26mr3560975bkt.18.1267479994732;
        Mon, 01 Mar 2010 13:46:34 -0800 (PST)
Received: from localhost (drsd-4dbd936b.pool.mediaWays.net [77.189.147.107])
        by mx.google.com with ESMTPS id p13sm927527bkp.21.2010.03.01.13.46.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:46:33 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141358>

Include the merge level, favor, and style flags into the xmparam_t struct.
This removes the bit twiddling with these three values into the one flags
parameter.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 builtin-merge-file.c |   18 ++++++++++--------
 ll-merge.c           |   12 ++++--------
 xdiff/xdiff.h        |   11 +++++------
 xdiff/xmerge.c       |   12 ++++++------
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 1e70073..3389dd0 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -27,17 +27,19 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmbuffer_t result = {NULL, 0};
 	xmparam_t xmp = {{XDF_NEED_MINIMAL}};
 	int ret = 0, i = 0, to_stdout = 0;
-	int level = XDL_MERGE_ZEALOUS_ALNUM;
-	int style = 0, quiet = 0;
-	int favor = 0;
+	int quiet = 0;
 	int nongit;
 
+	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
+	xmp.style = 0;
+	xmp.favor = 0;
+
 	struct option options[] = {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard output"),
-		OPT_SET_INT(0, "diff3", &style, "use a diff3 based merge", XDL_MERGE_DIFF3),
-		OPT_SET_INT(0, "ours", &favor, "for conflicts, use our version",
+		OPT_SET_INT(0, "diff3", &xmp.style, "use a diff3 based merge", XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "ours", &xmp.favor, "for conflicts, use our version",
 			    XDL_MERGE_FAVOR_OURS),
-		OPT_SET_INT(0, "theirs", &favor, "for conflicts, use their version",
+		OPT_SET_INT(0, "theirs", &xmp.favor, "for conflicts, use their version",
 			    XDL_MERGE_FAVOR_THEIRS),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
@@ -50,7 +52,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
 		if (0 <= git_xmerge_style)
-			style = git_xmerge_style;
+			xmp.style = git_xmerge_style;
 	}
 
 	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
@@ -73,7 +75,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xmp, XDL_MERGE_FLAGS(level, style, favor), &result);
+			&xmp, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/ll-merge.c b/ll-merge.c
index a4b2f4c..82c7742 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -63,8 +63,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			int flag, int marker_size)
 {
 	xmparam_t xmp;
-	int style = 0;
-	int favor = (flag >> 1) & 03;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
@@ -79,15 +77,13 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
+	xmp.level = XDL_MERGE_ZEALOUS;
+	xmp.favor= (flag >> 1) & 03;
 	if (git_xmerge_style >= 0)
-		style = git_xmerge_style;
+		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;
-	return xdl_merge(orig,
-			 src1, name1,
-			 src2, name2,
-			 &xmp, XDL_MERGE_FLAGS(XDL_MERGE_ZEALOUS, style, favor),
-			 result);
+	return xdl_merge(orig, src1, name1, src2, name2, &xmp, result);
 }
 
 static int ll_union_merge(const struct ll_merge_driver *drv_unused,
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 22614d5..a71763a 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -56,18 +56,14 @@ extern "C" {
 #define XDL_MERGE_EAGER 1
 #define XDL_MERGE_ZEALOUS 2
 #define XDL_MERGE_ZEALOUS_ALNUM 3
-#define XDL_MERGE_LEVEL_MASK 0x0f
 
 /* merge favor modes */
 #define XDL_MERGE_FAVOR_OURS 1
 #define XDL_MERGE_FAVOR_THEIRS 2
 #define XDL_MERGE_FAVOR_UNION 3
-#define XDL_MERGE_FAVOR(flags) (((flags)>>4) & 3)
-#define XDL_MERGE_FLAGS(level, style, favor) ((level)|(style)|((favor)<<4))
 
 /* merge output styles */
-#define XDL_MERGE_DIFF3 0x8000
-#define XDL_MERGE_STYLE_MASK 0x8000
+#define XDL_MERGE_DIFF3 1
 
 typedef struct s_mmfile {
 	char *ptr;
@@ -118,13 +114,16 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 typedef struct s_xmparam {
 	xpparam_t xpp;
 	int marker_size;
+	int level;
+	int favor;
+	int style;
 } xmparam_t;
 
 #define DEFAULT_CONFLICT_MARKER_SIZE 7
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xmparam_t const *xmp, int flags, mmbuffer_t *result);
+		xmparam_t const *xmp, mmbuffer_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index c901ecb..87cafa7 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -400,13 +400,13 @@ static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
  */
 static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		xdfenv_t *xe2, xdchange_t *xscr2, const char *name2,
-		int flags, xmparam_t const *xmp, mmbuffer_t *result) {
+		xmparam_t const *xmp, mmbuffer_t *result) {
 	xdmerge_t *changes, *c;
 	xpparam_t const *xpp = &xmp->xpp;
 	int i0, i1, i2, chg0, chg1, chg2;
-	int level = flags & XDL_MERGE_LEVEL_MASK;
-	int style = flags & XDL_MERGE_STYLE_MASK;
-	int favor = XDL_MERGE_FAVOR(flags);
+	int level = xmp->level;
+	int style = xmp->style;
+	int favor = xmp->favor;
 
 	if (style == XDL_MERGE_DIFF3) {
 		/*
@@ -556,7 +556,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xmparam_t const *xmp, int flags, mmbuffer_t *result) {
+		xmparam_t const *xmp, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
@@ -593,7 +593,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 	} else {
 		status = xdl_do_merge(&xe1, xscr1, name1,
 				      &xe2, xscr2, name2,
-				      flags, xmp, result);
+				      xmp, result);
 	}
 	xdl_free_script(xscr1);
 	xdl_free_script(xscr2);
-- 
1.7.0.584.g2da2b
