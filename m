From: Linus Torvalds <torvalds@osdl.org>
Subject: Improved three-way blob merging code
Date: Wed, 28 Jun 2006 22:06:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 07:06:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvojq-0007ls-I1
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 07:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWF2FGm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 01:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWF2FGm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 01:06:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750855AbWF2FGl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 01:06:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5T56anW000904
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Jun 2006 22:06:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5T56a4h008866;
	Wed, 28 Jun 2006 22:06:36 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22840>


This fleshes out the code that generates a three-way merge of a set of 
blobs.

It still actually does the three-way merge using an external executable 
(ie just calling "merge"), but the interfaces have been cleaned up a lot 
and are now fully based on the 'mmfile_t' interface, so if libxdiff were 
to ever grow a compatible three-way-merge, it could probably be directly
plugged in.

It also uses the previous XDL_EMIT_COMMON functionality extension to 
libxdiff to generate a made-up base file for the merge for the case where 
no base file previously existed. This should be equivalent to what we 
currently do in git-merge-one-file.sh:

	diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add

except it should be much simpler and can be done using the direct libxdiff 
interfaces.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

It would be lovely if libxdiff did a 3-way merge on its own, but this 
basically approximates it within that three_way_filemerge() function 
using external functionality.

The caller is, of course, still expected to do all the other proper magic 
(ie do things like resolve renames, mode differences, and all the trivial 
cases), and the example merge-tree.c code I posted earlier is obviously 
_not_ careful enough to be a real merge routine.

But we all have to start somewhere.


diff --git a/merge-file.c b/merge-file.c
index 4fedd6b..f32c653 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -1,19 +1,19 @@
 #include "cache.h"
 #include "run-command.h"
+#include "xdiff-interface.h"
 #include "blob.h"
 
 static void rm_temp_file(const char *filename)
 {
 	unlink(filename);
+	free((void *)filename);
 }
 
-static const char *write_temp_file(struct blob *blob)
+static const char *write_temp_file(mmfile_t *f)
 {
 	int fd;
 	const char *tmp = getenv("TMPDIR");
-	unsigned long size;
-	char *filename, type[20];
-	void *buf;
+	char *filename;
 
 	if (!tmp)
 		tmp = "/tmp";
@@ -22,13 +22,9 @@ static const char *write_temp_file(struc
 	if (fd < 0)
 		return NULL;
 	filename = strdup(filename);
-	buf = read_sha1_file(blob->object.sha1, type, &size);
-	if (buf) {
-		if (size != xwrite(fd, buf, size)) {
-			rm_temp_file(filename);
-			return NULL;
-		}
-		free(buf);
+	if (f->size != xwrite(fd, f->ptr, f->size)) {
+		rm_temp_file(filename);
+		return NULL;
 	}
 	close(fd);
 	return filename;
@@ -53,55 +49,118 @@ static void *read_temp_file(const char *
 	return buf;
 }
 
-void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
-	const char *t1, *t2, *t3;
+	void *buf;
+	unsigned long size;
 	char type[20];
 
-	if (base) {
-		int code;
-		void *res;
-
-		/*
-		 * Removed in either branch?
-		 *
-		 * NOTE! This depends on the caller having done the
-		 * proper warning about removing a file that got
-		 * modified in the other branch!
-		 */
-		if (!our || !their)
-			return NULL;
-		t1 = write_temp_file(base);
-		t2 = write_temp_file(our);
-		t3 = write_temp_file(their);
-		res = NULL;
-		if (t1 && t2 && t3) {
-			code = run_command("merge", t2, t1, t3, NULL);
-			if (!code || code == -1)
-				res = read_temp_file(t2, size);
-		}
-		rm_temp_file(t1);
-		rm_temp_file(t2);
-		rm_temp_file(t3);
-		return res;
+	buf = read_sha1_file(obj->object.sha1, type, &size);
+	if (!buf)
+		return -1;
+	if (strcmp(type, blob_type))
+		return -1;
+	f->ptr = buf;
+	f->size = size;
+	return 0;
+}
+
+static void free_mmfile(mmfile_t *f)
+{
+	free(f->ptr);
+}
+
+static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+{
+	void *res;
+	const char *t1, *t2, *t3;
+
+	t1 = write_temp_file(base);
+	t2 = write_temp_file(our);
+	t3 = write_temp_file(their);
+	res = NULL;
+	if (t1 && t2 && t3) {
+		int code = run_command("merge", t2, t1, t3, NULL);
+		if (!code || code == -1)
+			res = read_temp_file(t2, size);
 	}
+	rm_temp_file(t1);
+	rm_temp_file(t2);
+	rm_temp_file(t3);
+	return res;
+}
 
-	if (!our)
-		return read_sha1_file(their->object.sha1, type, size);
-	if (!their)
-		return read_sha1_file(our->object.sha1, type, size);
+static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+{
+	int i;
+	mmfile_t *dst = priv_;
+
+	for (i = 0; i < nbuf; i++) {
+		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
+		dst->size += mb[i].size;
+	}
+	return 0;
+}
+
+static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
+{
+	unsigned long size = f1->size < f2->size ? f1->size : f2->size;
+	void *ptr = xmalloc(size);
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
+	xpp.flags = XDF_NEED_MINIMAL;
+	xecfg.ctxlen = 3;
+	xecfg.flags = XDL_EMIT_COMMON;
+	ecb.outf = common_outf;
+
+	res->ptr = ptr;
+	res->size = 0;
+
+	ecb.priv = res;
+	return xdl_diff(f1, f2, &xpp, &xecfg, &ecb);
+}
+
+void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+{
+	void *res = NULL;
+	mmfile_t f1, f2, common;
 
 	/*
-	 * Added in both!
-	 *
-	 * This is nasty.
-	 *
-	 * We should do something like 
+	 * Removed in either branch?
 	 *
-	 *	git diff our their | git-apply --no-add
-	 *
-	 * to generate a "minimal common file" to be used
-	 * as a base. Right now we punt.
+	 * NOTE! This depends on the caller having done the
+	 * proper warning about removing a file that got
+	 * modified in the other branch!
 	 */
-	return NULL;
+	if (!our || !their) {
+		char type[20];
+		if (base)
+			return NULL;
+		if (!our)
+			our = their;
+		return read_sha1_file(our->object.sha1, type, size);
+	}
+
+	if (fill_mmfile_blob(&f1, our) < 0)
+		goto out_no_mmfile;
+	if (fill_mmfile_blob(&f2, their) < 0)
+		goto out_free_f1;
+
+	if (base) {
+		if (fill_mmfile_blob(&common, base) < 0)
+			goto out_free_f2_f1;
+	} else {
+		if (generate_common_file(&common, &f1, &f2) < 0)
+			goto out_free_f2_f1;
+	}
+	res = three_way_filemerge(&common, &f1, &f2, size);
+	free_mmfile(&common);
+out_free_f2_f1:
+	free_mmfile(&f2);
+out_free_f1:
+	free_mmfile(&f1);
+out_no_mmfile:
+	return res;
 }
