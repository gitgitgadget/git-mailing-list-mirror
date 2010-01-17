From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] xdl_merge(): introduce xmparam_t for merge specific
 parameters
Date: Sun, 17 Jan 2010 01:38:58 -0800
Message-ID: <1263721144-18605-3-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbP-0003nL-Rz
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab0AQJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663Ab0AQJjT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab0AQJjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C64691403
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ISLe
	x32Gpg9Ido3fGilM/TGM358=; b=D0EvXRXs5eUy+rkwSX3T94qGHsrOvGDg3qcw
	Wm5qK2YdL30n/m3ElbGWsIbGFGrpSRoToAJ3+y4yyYEe0DX+JJori1h4+4X0UJ34
	voTXJQK6RvZd65C0ZRJ9vKkeGsAt9SrUM0SjzoncVlXD9jWnCdK5kRR3/t9nr6Vi
	rR7JUgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=D/0thJ
	NZHNlWTtImibujo74gmcyOqgfxzFzyFQbcVJ0ISJTfPla3rZpL6d0ImqyX9HiPGP
	gUYig0AQtHVkSZj10QWDNzRMvfXASV30vsnaKjG3WvxlTEGrixm/jbG7LcftYV/T
	8/p5oRw86LTBrOQ7GSY09ufisouoCHI3hWWfE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2924B91402
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8058B91401 for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:09 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 29FF610E-034C-11DF-9659-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137283>

So far we have only needed to be able to pass an option that is generic to
xdiff family of functions to this function.  Extend the interface so that
we can give it merge specific parameters.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge-file.c |    4 ++--
 ll-merge.c           |    6 +++---
 merge-file.c         |    6 +++---
 rerere.c             |    4 ++--
 xdiff/xdiff.h        |    6 +++++-
 xdiff/xmerge.c       |    3 ++-
 6 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index afd2ea7..11c3524 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -25,7 +25,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	const char *names[3] = { NULL, NULL, NULL };
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
-	xpparam_t xpp = {XDF_NEED_MINIMAL};
+	xmparam_t xmp = {{XDF_NEED_MINIMAL}};
 	int ret = 0, i = 0, to_stdout = 0;
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
 	int merge_style = 0, quiet = 0;
@@ -68,7 +68,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
-			&xpp, merge_level | merge_style, &result);
+			&xmp, merge_level | merge_style, &result);
 
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
diff --git a/ll-merge.c b/ll-merge.c
index f4b0a07..be2bf43 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -61,7 +61,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *src2, const char *name2,
 			int virtual_ancestor)
 {
-	xpparam_t xpp;
+	xmparam_t xmp;
 	int style = 0;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
@@ -76,13 +76,13 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       virtual_ancestor);
 	}
 
-	memset(&xpp, 0, sizeof(xpp));
+	memset(&xmp, 0, sizeof(xmp));
 	if (git_xmerge_style >= 0)
 		style = git_xmerge_style;
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
-			 &xpp, XDL_MERGE_ZEALOUS | style,
+			 &xmp, XDL_MERGE_ZEALOUS | style,
 			 result);
 }
 
diff --git a/merge-file.c b/merge-file.c
index 3120a95..5c00c7e 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -27,12 +27,12 @@ static void free_mmfile(mmfile_t *f)
 static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
 {
 	mmbuffer_t res;
-	xpparam_t xpp;
+	xmparam_t xmp;
 	int merge_status;
 
-	memset(&xpp, 0, sizeof(xpp));
+	memset(&xmp, 0, sizeof(xmp));
 	merge_status = xdl_merge(base, our, ".our", their, ".their",
-		&xpp, XDL_MERGE_ZEALOUS, &res);
+		&xmp, XDL_MERGE_ZEALOUS, &res);
 
 	if (merge_status < 0)
 		return NULL;
diff --git a/rerere.c b/rerere.c
index d92990a..adb0694 100644
--- a/rerere.c
+++ b/rerere.c
@@ -332,7 +332,7 @@ static int merge(const char *name, const char *path)
 	int ret;
 	mmfile_t cur, base, other;
 	mmbuffer_t result = {NULL, 0};
-	xpparam_t xpp = {XDF_NEED_MINIMAL};
+	xmparam_t xmp = {{XDF_NEED_MINIMAL}};
 
 	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
@@ -342,7 +342,7 @@ static int merge(const char *name, const char *path)
 			read_mmfile(&other, rerere_path(name, "postimage")))
 		return 1;
 	ret = xdl_merge(&base, &cur, "", &other, "",
-			&xpp, XDL_MERGE_ZEALOUS, &result);
+			&xmp, XDL_MERGE_ZEALOUS, &result);
 	if (!ret) {
 		FILE *f = fopen(path, "w");
 		if (!f)
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4da052a..b265909 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -108,9 +108,13 @@ long xdl_mmfile_size(mmfile_t *mmf);
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 
+typedef struct s_xmparam {
+	xpparam_t xpp;
+} xmparam_t;
+
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int level, mmbuffer_t *result);
+		xmparam_t const *xmp, int level, mmbuffer_t *result);
 
 #ifdef __cplusplus
 }
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1cb65a9..5c37b4e 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -538,10 +538,11 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 
 int xdl_merge(mmfile_t *orig, mmfile_t *mf1, const char *name1,
 		mmfile_t *mf2, const char *name2,
-		xpparam_t const *xpp, int flags, mmbuffer_t *result) {
+		xmparam_t const *xmp, int flags, mmbuffer_t *result) {
 	xdchange_t *xscr1, *xscr2;
 	xdfenv_t xe1, xe2;
 	int status;
+	xpparam_t const *xpp = &xmp->xpp;
 
 	result->ptr = NULL;
 	result->size = 0;
-- 
1.6.6.405.g80ed6.dirty
