From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [FYI/PATCH] diff: add diff_flush_patch_id()
Date: Fri, 23 Jun 2006 17:44:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231743150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90606221732k6d93bcceic2761081d7a7c72b@mail.gmail.com>
 <Pine.LNX.4.63.0606231357420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060623152321.2c20e9f8.tihirvon@gmail.com>
 <Pine.LNX.4.63.0606231431420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 17:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftnq1-00044d-LM
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 17:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWFWPou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFWPou
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 11:44:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25560 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751244AbWFWPou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 11:44:50 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 0BBEE2485;
	Fri, 23 Jun 2006 17:44:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id F3B122357;
	Fri, 23 Jun 2006 17:44:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id D5AFE1D59;
	Fri, 23 Jun 2006 17:44:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0606231431420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22426>


Call it like this:

unsigned char id[20];
if (diff_flush_patch_id(diff_options, id))
	printf("And the patch id is: %s\n", sha1_to_hex(id));

This patch also adds a switch "--with-patch-id" to the diff family, to
print out the patch id before each patch.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---


	> > > 	- add a DIFF_FORMAT_PATCH_ID
	> > 
	> > Please don't add any DIFF_FORMAT_*.  I'm cleaning the diff output code
	> > and replacing diff_options.output_format with one-bit flags.
	> 
	> Okay. For the purposes of git-format-patch, this is not needed 
	> anyway, but rather a function which takes two tree objects and 
	> returns the patch id. When you are finished it should be easy to 
	> add this as a display format.

	Timo, I am prepared to redo this patch when you finished
	the cleanup.

 diff.c |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h |    3 +
 2 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5b34f73..1140d54 100644
--- a/diff.c
+++ b/diff.c
@@ -1460,6 +1460,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_stat = 1;
 	}
+	else if (!strcmp(arg, "--with-patch-id"))
+		options->with_patch_id = 1;
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -2027,12 +2029,139 @@ static void diff_summary(struct diff_fil
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
+int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
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
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 	int diff_output_format = options->output_format;
 	struct diffstat_t *diffstat = NULL;
+	unsigned char sha1[20];
+
+	if (options->with_patch_id && !diff_flush_patch_id(options, sha1))
+		printf("patch-id %s\n", sha1_to_hex(sha1));
 
 	if (diff_output_format == DIFF_FORMAT_DIFFSTAT || options->with_stat) {
 		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
diff --git a/diff.h b/diff.h
index 7d7b6cd..29aac52 100644
--- a/diff.h
+++ b/diff.h
@@ -27,6 +27,7 @@ struct diff_options {
 	unsigned recursive:1,
 		 with_raw:1,
 		 with_stat:1,
+		 with_patch_id:1,
 		 tree_in_recursive:1,
 		 binary:1,
 		 full_index:1,
@@ -185,4 +186,6 @@ extern int run_diff_files(struct rev_inf
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
+extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
+
 #endif /* DIFF_H */
-- 
1.4.0.g319e-dirty
