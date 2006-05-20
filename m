From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-patch: add --check option
Date: Sat, 20 May 2006 23:43:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605202342160.1057@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 20 23:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhZEF-0004xG-LD
	for gcvg-git@gmane.org; Sat, 20 May 2006 23:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWETVnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 17:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWETVnQ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 17:43:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47818 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932394AbWETVnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 17:43:14 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 55BAFB55;
	Sat, 20 May 2006 23:43:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 49FCCB52;
	Sat, 20 May 2006 23:43:13 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2AF6BB46;
	Sat, 20 May 2006 23:43:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20397>


Actually, it is a diff option now, so you can say

	git diff --check

to ask if what you are about to commit is a good patch.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	The temptation to bastardize diff_flush_patch was not high
	enough. It would be ugly.

	Internally, I called it checkdiff, not just check, to make it
	more obvious what it does.

 diff.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 diff.h |    1 +
 2 files changed, 115 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 3e2828b..af26dda 100644
--- a/diff.c
+++ b/diff.c
@@ -397,6 +397,46 @@ static void show_stats(struct diffstat_t
 			total_files, adds, dels);
 }
 
+struct checkdiff_t {
+	struct xdiff_emit_state xm;
+	const char *filename;
+	int lineno;
+};
+
+static void checkdiff_consume(void *priv, char *line, unsigned long len)
+{
+	struct checkdiff_t *data = priv;
+
+	if (line[0] == '+') {
+		int i, spaces = 0;
+
+		data->lineno++;
+
+		/* check space before tab */
+		for (i = 1; i < len && (line[i] == ' ' || line[i] == '\t'); i++)
+			if (line[i] == ' ')
+				spaces++;
+		if (line[i - 1] == '\t' && spaces)
+			printf("%s:%d: space before tab:%.*s\n",
+				data->filename, data->lineno, (int)len, line);
+
+		/* check white space at line end */
+		if (line[len - 1] == '\n')
+			len--;
+		if (isspace(line[len - 1]))
+			printf("%s:%d: white space at end: %.*s\n",
+				data->filename, data->lineno, (int)len, line);
+	} else if (line[0] == ' ')
+		data->lineno++;
+	else if (line[0] == '@') {
+		char *plus = strchr(line, '+');
+		if (plus)
+			data->lineno = strtol(plus, line + len, 10);
+		else
+			die("invalid diff");
+	}
+}
+
 static unsigned char *deflate_it(char *data,
 				 unsigned long size,
 				 unsigned long *result_size)
@@ -624,6 +664,41 @@ static void builtin_diffstat(const char 
 	}
 }
 
+static void builtin_checkdiff(const char *name_a, const char *name_b,
+			     struct diff_filespec *one,
+			     struct diff_filespec *two)
+{
+	mmfile_t mf1, mf2;
+	struct checkdiff_t data;
+
+	if (!two)
+		return;
+
+	memset(&data, 0, sizeof(data));
+	data.xm.consume = checkdiff_consume;
+	data.filename = name_b ? name_b : name_a;
+	data.lineno = 0;
+
+	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+		die("unable to read files to diff");
+
+	if (mmfile_is_binary(&mf2))
+		return;
+	else {
+		/* Crazy xdl interfaces.. */
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+		xdemitcb_t ecb;
+
+		xpp.flags = XDF_NEED_MINIMAL;
+		xecfg.ctxlen = 0;
+		xecfg.flags = 0;
+		ecb.outf = xdiff_outf;
+		ecb.priv = &data;
+		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+	}
+}
+
 struct diff_filespec *alloc_filespec(const char *path)
 {
 	int namelen = strlen(path);
@@ -1180,6 +1255,25 @@ static void run_diffstat(struct diff_fil
 	builtin_diffstat(name, other, p->one, p->two, diffstat, complete_rewrite);
 }
 
+static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
+{
+	const char *name;
+	const char *other;
+
+	if (DIFF_PAIR_UNMERGED(p)) {
+		/* unmerged */
+		return;
+	}
+
+	name = p->one->path;
+	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+
+	diff_fill_sha1_info(p->one);
+	diff_fill_sha1_info(p->two);
+
+	builtin_checkdiff(name, other, p->one, p->two);
+}
+
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
@@ -1205,7 +1299,8 @@ int diff_setup_done(struct diff_options 
 	 * recursive bits for other formats here.
 	 */
 	if ((options->output_format == DIFF_FORMAT_PATCH) ||
-	    (options->output_format == DIFF_FORMAT_DIFFSTAT))
+	    (options->output_format == DIFF_FORMAT_DIFFSTAT) ||
+	    (options->output_format == DIFF_FORMAT_CHECKDIFF))
 		options->recursive = 1;
 
 	if (options->detect_rename && options->rename_limit < 0)
@@ -1288,6 +1383,8 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--stat"))
 		options->output_format = DIFF_FORMAT_DIFFSTAT;
+	else if (!strcmp(arg, "--check"))
+		options->output_format = DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->summary = 1;
 	else if (!strcmp(arg, "--patch-with-stat")) {
@@ -1610,6 +1707,19 @@ static void diff_flush_stat(struct diff_
 	run_diffstat(p, o, diffstat);
 }
 
+static void diff_flush_checkdiff(struct diff_filepair *p,
+		struct diff_options *o)
+{
+	if (diff_unmodified_pair(p))
+		return;
+
+	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
+		return; /* no tree diffs in patch format */
+
+	run_checkdiff(p, o);
+}
+
 int diff_queue_is_empty(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -1740,6 +1850,9 @@ static void flush_one_pair(struct diff_f
 		case DIFF_FORMAT_DIFFSTAT:
 			diff_flush_stat(p, options, diffstat);
 			break;
+		case DIFF_FORMAT_CHECKDIFF:
+			diff_flush_checkdiff(p, options);
+			break;
 		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p, options);
 			break;
diff --git a/diff.h b/diff.h
index 83619eb..08b3fed 100644
--- a/diff.h
+++ b/diff.h
@@ -155,6 +155,7 @@ #define DIFF_FORMAT_NO_OUTPUT	3
 #define DIFF_FORMAT_NAME	4
 #define DIFF_FORMAT_NAME_STATUS	5
 #define DIFF_FORMAT_DIFFSTAT	6
+#define DIFF_FORMAT_CHECKDIFF	7
 
 extern void diff_flush(struct diff_options*);
 
-- 
1.3.3.g734b-dirty
