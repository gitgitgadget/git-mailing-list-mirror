From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] xdl_diff: identify call sites.
Date: Thu, 13 Dec 2007 14:31:28 -0800
Message-ID: <7vtzmmz0ov.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<7v7ijorwnc.fsf@gitster.siamese.dyndns.org>
	<7vabof5mze.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712122219160.20487@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2wbG-0006Pr-UT
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 23:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761989AbXLMWbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761758AbXLMWbr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 17:31:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759090AbXLMWbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 17:31:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A37884F3;
	Thu, 13 Dec 2007 17:31:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38EFC847F;
	Thu, 13 Dec 2007 17:31:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68196>

This inserts a new function xdi_diff() that currently does not
do anything other than calling the underlying xdl_diff() to the
callchain of current callers of xdl_diff() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Nicolas Pitre <nico@cam.org> writes:

 > On Wed, 12 Dec 2007, Junio C Hamano wrote:
 >
 >> Here are the topics that have been cooking.
 >
 > What about the blame speedup patch from Linus (Message-ID: 
 > <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>)

 I would prefer to do a bit more generic solution, not a special hack for
 speeding up blame on prepend-only files, with a proper log message.

 Here is the first installment of such.

 builtin-blame.c   |    2 +-
 builtin-rerere.c  |    2 +-
 combine-diff.c    |    2 +-
 diff.c            |   10 +++++-----
 merge-file.c      |    2 +-
 merge-tree.c      |    2 +-
 xdiff-interface.c |    5 +++++
 xdiff-interface.h |    1 +
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 5466d01..99ea0a0 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -542,7 +542,7 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	state.ret->chunks = NULL;
 	state.ret->num = 0;
 
-	xdl_diff(file_p, file_o, &xpp, &xecfg, &ecb);
+	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
 
 	if (state.ret->num) {
 		struct chunk *chunk;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 7449323..37e6248 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -260,7 +260,7 @@ static int diff_two(const char *file1, const char *label1,
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	ecb.outf = outf;
-	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
 	free(minus.ptr);
 	free(plus.ptr);
diff --git a/combine-diff.c b/combine-diff.c
index 5a658dc..e22db89 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -226,7 +226,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	state.num_parent = num_parent;
 	state.n = n;
 
-	xdl_diff(&parent_file, result_file, &xpp, &xecfg, &ecb);
+	xdi_diff(&parent_file, result_file, &xpp, &xecfg, &ecb);
 	free(parent_file.ptr);
 
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index 9c79ee2..3dd2f35 100644
--- a/diff.c
+++ b/diff.c
@@ -439,7 +439,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	ecb.outf = xdiff_outf;
 	ecb.priv = diff_words;
 	diff_words->xm.consume = fn_out_diff_words_aux;
-	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
 	free(minus.ptr);
 	free(plus.ptr);
@@ -1393,7 +1393,7 @@ static void builtin_diff(const char *name_a,
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
-		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 	}
@@ -1446,7 +1446,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		ecb.outf = xdiff_outf;
 		ecb.priv = diffstat;
-		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
  free_and_return:
@@ -1486,7 +1486,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xpp.flags = XDF_NEED_MINIMAL;
 		ecb.outf = xdiff_outf;
 		ecb.priv = &data;
-		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
  free_and_return:
 	diff_free_filespec_data(one);
@@ -2898,7 +2898,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		ecb.outf = xdiff_outf;
 		ecb.priv = &data;
-		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
 	SHA1_Final(sha1, &ctx);
diff --git a/merge-file.c b/merge-file.c
index 1e031ea..2a939c9 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -71,7 +71,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	res->size = 0;
 
 	ecb.priv = res;
-	return xdl_diff(f1, f2, &xpp, &xecfg, &ecb);
+	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
 }
 
 void *merge_file(struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
diff --git a/merge-tree.c b/merge-tree.c
index 7d4f628..e083246 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -119,7 +119,7 @@ static void show_diff(struct merge_list *entry)
 	if (!dst.ptr)
 		size = 0;
 	dst.size = size;
-	xdl_diff(&src, &dst, &xpp, &xecfg, &ecb);
+	xdi_diff(&src, &dst, &xpp, &xecfg, &ecb);
 	free(src.ptr);
 	free(dst.ptr);
 }
diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..69a022c 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -103,6 +103,11 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	return 0;
 }
 
+int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
+{
+	return xdl_diff(mf1, mf2, xpp, xecfg, xecb);
+}
+
 int read_mmfile(mmfile_t *ptr, const char *filename)
 {
 	struct stat st;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fb742db..f7f791d 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -13,6 +13,7 @@ struct xdiff_emit_state {
 	unsigned long remainder_size;
 };
 
+int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
-- 
1.5.4.rc0.1.g37d0
