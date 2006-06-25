From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] add diff_flush_patch_id() to calculate the patch id
Date: Sun, 25 Jun 2006 03:51:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250350530.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 25 03:51:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJmL-0005fm-M0
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWFYBvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWFYBvL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:51:11 -0400
Received: from mail.gmx.de ([213.165.64.21]:14061 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751314AbWFYBvK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:51:10 -0400
Received: (qmail invoked by alias); 25 Jun 2006 01:51:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 25 Jun 2006 03:51:09 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22567>


Call it like this:

unsigned char id[20];
if (diff_flush_patch_id(diff_options, id))
	printf("And the patch id is: %s\n", sha1_to_hex(id));

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 diff.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h |    2 +
 2 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5b34f73..3beecb9 100644
--- a/diff.c
+++ b/diff.c
@@ -2027,6 +2027,145 @@ static void diff_summary(struct diff_fil
 	}
 }
 
+struct patch_id_t {
+	struct xdiff_emit_state xm;
+	SHA_CTX *ctx;
+	int patchlen;
+};
+
+static int remove_space(char *line, int len)
+{
+	int i;
+        char *dst = line;
+        unsigned char c;
+
+        for (i = 0; i < len; i++)
+                if (!isspace((c = line[i])))
+                        *dst++ = c;
+
+        return dst - line;
+}
+
+static void patch_id_consume(void *priv, char *line, unsigned long len)
+{
+	struct patch_id_t *data = priv;
+	int new_len;
+
+	/* Ignore line numbers when computing the SHA1 of the patch */
+	if (!strncmp(line, "@@ -", 4))
+		return;
+
+	new_len = remove_space(line, len);
+
+	SHA1_Update(data->ctx, line, new_len);
+	data->patchlen += new_len;
+}
+
+/* returns 0 upon success, and writes result into sha1 */
+static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	int i;
+	SHA_CTX ctx;
+	struct patch_id_t data;
+	char buffer[PATH_MAX * 4 + 20];
+
+	SHA1_Init(&ctx);
+	memset(&data, 0, sizeof(struct patch_id_t));
+	data.ctx = &ctx;
+	data.xm.consume = patch_id_consume;
+	
+	for (i = 0; i < q->nr; i++) {
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+		xdemitcb_t ecb;
+		mmfile_t mf1, mf2;
+		struct diff_filepair *p = q->queue[i];
+		int len1, len2;
+
+		if (p->status == 0)
+			return error("internal diff status error");
+		if (p->status == DIFF_STATUS_UNKNOWN)
+			continue;
+		if (diff_unmodified_pair(p))
+			continue;
+		if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+		    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
+			continue;
+		if (DIFF_PAIR_UNMERGED(p))
+			continue;
+
+		diff_fill_sha1_info(p->one);
+		diff_fill_sha1_info(p->two);
+		if (fill_mmfile(&mf1, p->one) < 0 ||
+				fill_mmfile(&mf2, p->two) < 0)
+			return error("unable to read files to diff");
+
+		/* Maybe hash p->two? into the patch id? */
+		if (mmfile_is_binary(&mf2))
+			continue;
+
+		len1 = remove_space(p->one->path, strlen(p->one->path));
+		len2 = remove_space(p->two->path, strlen(p->two->path));
+		if (p->one->mode == 0)
+			len1 = snprintf(buffer, sizeof(buffer),
+					"diff--gita/%.*sb/%.*s"
+					"newfilemode%06o"
+					"---/dev/null"
+					"+++b/%.*s",
+					len1, p->one->path,
+					len2, p->two->path,
+					p->two->mode,
+					len2, p->two->path);
+		else if (p->two->mode == 0)
+			len1 = snprintf(buffer, sizeof(buffer),
+					"diff--gita/%.*sb/%.*s"
+					"deletedfilemode%06o"
+					"---a/%.*s"
+					"+++/dev/null",
+					len1, p->one->path,
+					len2, p->two->path,
+					p->one->mode,
+					len1, p->one->path);
+		else
+			len1 = snprintf(buffer, sizeof(buffer),
+					"diff--gita/%.*sb/%.*s"
+					"---a/%.*s"
+					"+++b/%.*s",
+					len1, p->one->path,
+					len2, p->two->path,
+					len1, p->one->path,
+					len2, p->two->path);
+		SHA1_Update(&ctx, buffer, len1);
+
+		xpp.flags = XDF_NEED_MINIMAL;
+		xecfg.ctxlen = 3;
+		xecfg.flags = 3;
+		ecb.outf = xdiff_outf;
+		ecb.priv = &data;
+		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+	}
+
+	SHA1_Final(sha1, &ctx);
+	return 0;
+}
+
+int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	int i;
+	int result = diff_get_patch_id(options, sha1);
+
+	for (i = 0; i < q->nr; i++)
+		diff_free_filepair(q->queue[i]);
+
+	free(q->queue);
+	q->queue = NULL;
+	q->nr = q->alloc = 0;
+
+	return result;
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
diff --git a/diff.h b/diff.h
index 7d7b6cd..850c15f 100644
--- a/diff.h
+++ b/diff.h
@@ -185,4 +185,6 @@ extern int run_diff_files(struct rev_inf
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
+extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
+
 #endif /* DIFF_H */
-- 
1.4.0.g7a200-dirty
