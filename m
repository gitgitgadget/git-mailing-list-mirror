From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff-options: add --stat (take 2)
Date: Fri, 14 Apr 2006 00:15:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604140012560.10924@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Apr 14 00:15:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUA6C-0007My-Ju
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 00:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWDMWPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 18:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWDMWPd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 18:15:33 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4069 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932472AbWDMWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 18:15:33 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9941C1C5B;
	Fri, 14 Apr 2006 00:15:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8D6931C53;
	Fri, 14 Apr 2006 00:15:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5D13C1C37;
	Fri, 14 Apr 2006 00:15:31 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18677>


Now, you can say "git diff --stat" (to get an idea how many changes are
uncommitted), or "git log --stat".
    
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Thanks to Junio's comments, this looks much better now; I am
	reasonably happy about it (it even lost some pounds: 31 lines).

	I still did not find a way to share code with git-apply's diffstat
	code, though. But then, it is only one function (show_stats).

 Documentation/diff-options.txt |    3 +
 diff.c                         |  220 +++++++++++++++++++++++++++++++++++++++-
 diff.h                         |    2 
 git-diff.sh                    |    6 +
 4 files changed, 225 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 338014c..447e522 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -7,6 +7,9 @@
 --patch-with-raw::
 	Generate patch but keep also the default raw diff output.
 
+--stat::
+	Generate a diffstat instead of a patch.
+
 -z::
 	\0 line termination on output
 
diff --git a/diff.c b/diff.c
index a14e664..ad8478b 100644
--- a/diff.c
+++ b/diff.c
@@ -8,7 +8,7 @@ #include "cache.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "xdiff/xdiff.h"
+#include "xdiff-interface.h"
 
 static int use_size_cache;
 
@@ -195,6 +195,137 @@ static int fn_out(void *priv, mmbuffer_t
 	return 0;
 }
 
+struct diffstat_t {
+	struct xdiff_emit_state xm;
+
+	int nr;
+	int alloc;
+	struct diffstat_file {
+		char *name;
+		unsigned int added, deleted;
+	} **files;
+};
+
+static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
+		const char *name)
+{
+	struct diffstat_file *x;
+	x = xcalloc(sizeof (*x), 1);
+	if (diffstat->nr == diffstat->alloc) {
+		diffstat->alloc = alloc_nr(diffstat->alloc);
+		diffstat->files = xrealloc(diffstat->files,
+				diffstat->alloc * sizeof(x));
+	}
+	diffstat->files[diffstat->nr++] = x;
+	x->name = strdup(name);
+	return x;
+}
+
+static void diffstat_consume(void *priv, char *line, unsigned long len)
+{
+	struct diffstat_t *diffstat = priv;
+	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
+
+	if (line[0] == '+')
+		x->added++;
+	else if (line[0] == '-')
+		x->deleted++;
+}
+
+static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
+static const char minuses[]= "----------------------------------------------------------------------";
+
+static void show_stats(struct diffstat_t* data)
+{
+	char *prefix = "";
+	int i, len, add, del, total, adds = 0, dels = 0;
+	int max, max_change = 0, max_len = 0;
+	int total_files = data->nr;
+
+	if (data->nr == 0)
+		return;
+
+	printf("---\n");
+
+	for (i = 0; i < data->nr; i++) {
+		struct diffstat_file *file = data->files[i];
+		
+		if (max_change < file->added + file->deleted)
+			max_change = file->added + file->deleted;
+		len = strlen(file->name);
+		if (max_len < len)
+			max_len = len;
+	}
+
+	for (i = 0; i < data->nr; i++) {
+		char *name = data->files[i]->name;
+		int added = data->files[i]->added;
+		int deleted = data->files[i]->deleted;
+
+		if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
+			char *qname = xmalloc(len + 1);
+			quote_c_style(name, qname, NULL, 0);
+			free(name);
+			name = qname;
+		}
+
+		/*
+		 * "scale" the filename
+		 */
+		len = strlen(name);
+		max = max_len;
+		if (max > 50)
+			max = 50;
+		if (len > max) {
+			char *slash;
+			prefix = "...";
+			max -= 3;
+			name += len - max;
+			slash = strchr(name, '/');
+			if (slash)
+				name = slash;
+		}
+		len = max;
+
+		/*
+		 * scale the add/delete
+		 */
+		max = max_change;
+		if (max + len > 70)
+			max = 70 - len;
+
+		if (added < 0) {
+			/* binary file */
+			printf(" %s%-*s |  Bin\n", prefix, len, name);
+			continue;
+		} else if (added + deleted == 0) {
+			total_files--;
+			continue;
+		}
+
+		add = added;
+		del = deleted;
+		total = add + del;
+		adds += add;
+		dels += del;
+
+		if (max_change > 0) {
+			total = (total * max + max_change / 2) / max_change;
+			add = (add * max + max_change / 2) / max_change;
+			del = total - add;
+		}
+		/* TODO: binary */
+		printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
+				len, name, added + deleted,
+				add, pluses, del, minuses);
+		free(name);
+		free(data->files[i]);
+	}
+	free(data->files);
+	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
+			total_files, adds, dels);
+}
+
 #define FIRST_FEW_BYTES 8000
 static int mmfile_is_binary(mmfile_t *mf)
 {
@@ -285,7 +416,36 @@ static void builtin_diff(const char *nam
 	free(b_two);
 	return;
 }
+
+static void builtin_diffstat(const char *name_a, const char *name_b,
+		struct diff_filespec *one, struct diff_filespec *two,
+		struct diffstat_t *diffstat)
+{
+	mmfile_t mf1, mf2;
+	struct diffstat_file *data;
 
+	data = diffstat_add(diffstat, name_a ? name_a : name_b);
+
+	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+		die("unable to read files to diff");
+
+	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))
+		data->added = -1;
+	else {
+		/* Crazy xdl interfaces.. */
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+		xdemitcb_t ecb;
+
+		xpp.flags = XDF_NEED_MINIMAL;
+		xecfg.ctxlen = 3;
+		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		ecb.outf = xdiff_outf;
+		ecb.priv = diffstat;
+		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+	}
+}
+
 struct diff_filespec *alloc_filespec(const char *path)
 {
 	int namelen = strlen(path);
@@ -818,7 +978,28 @@ static void run_diff(struct diff_filepai
 	free(name_munged);
 	free(other_munged);
 }
+
+static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
+		struct diffstat_t *diffstat)
+{
+	const char *name;
+	const char *other;
 
+	if (DIFF_PAIR_UNMERGED(p)) {
+		/* unmerged */
+		builtin_diffstat(p->one->path, NULL, NULL, NULL, diffstat);
+		return;
+	}
+
+	name = p->one->path;
+	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+
+	diff_fill_sha1_info(p->one);
+	diff_fill_sha1_info(p->two);
+
+	builtin_diffstat(name, other, p->one, p->two, diffstat);
+}
+
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
@@ -866,6 +1047,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
 	}
+	else if (!strcmp(arg, "--stat"))
+		options->output_format = DIFF_FORMAT_DIFFSTAT;
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -1163,6 +1346,19 @@ static void diff_flush_patch(struct diff
 		return; /* no tree diffs in patch format */ 
 
 	run_diff(p, o);
+}
+
+static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
+		struct diffstat_t *diffstat)
+{
+	if (diff_unmodified_pair(p))
+		return;
+
+	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
+		return; /* no tree diffs in patch format */ 
+
+	run_diffstat(p, o, diffstat);
 }
 
 int diff_queue_is_empty(void)
@@ -1276,7 +1472,8 @@ static void diff_resolve_rename_copy(voi
 
 static void flush_one_pair(struct diff_filepair *p,
 			   int diff_output_format,
-			   struct diff_options *options)
+			   struct diff_options *options,
+			   struct diffstat_t *diffstat)
 {
 	int inter_name_termination = '\t';
 	int line_termination = options->line_termination;
@@ -1291,6 +1488,9 @@ static void flush_one_pair(struct diff_f
 		break;
 	default:
 		switch (diff_output_format) {
+		case DIFF_FORMAT_DIFFSTAT:
+			diff_flush_stat(p, options, diffstat);
+			break;
 		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p, options);
 			break;
@@ -1316,19 +1516,31 @@ void diff_flush(struct diff_options *opt
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 	int diff_output_format = options->output_format;
+	struct diffstat_t *diffstat = NULL;
 
+	if (diff_output_format == DIFF_FORMAT_DIFFSTAT) {
+		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
+		diffstat->xm.consume = diffstat_consume;
+	}
+
 	if (options->with_raw) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			flush_one_pair(p, DIFF_FORMAT_RAW, options);
+			flush_one_pair(p, DIFF_FORMAT_RAW, options, NULL);
 		}
 		putchar(options->line_termination);
 	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		flush_one_pair(p, diff_output_format, options);
+		flush_one_pair(p, diff_output_format, options, diffstat);
 		diff_free_filepair(p);
 	}
+
+	if (diffstat) {
+		show_stats(diffstat);
+		free(diffstat);
+	}
+
 	free(q->queue);
 	q->queue = NULL;
 	q->nr = q->alloc = 0;
diff --git a/diff.h b/diff.h
index 236095f..2f8aff2 100644
--- a/diff.h
+++ b/diff.h
@@ -119,6 +119,7 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  -u            synonym for -p.\n" \
 "  --patch-with-raw\n" \
 "                output both a patch and the diff-raw format.\n" \
+"  --stat        show diffstat instead of patch.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
 "  --full-index  show full object name on index lines.\n" \
@@ -142,6 +143,7 @@ #define DIFF_FORMAT_PATCH	2
 #define DIFF_FORMAT_NO_OUTPUT	3
 #define DIFF_FORMAT_NAME	4
 #define DIFF_FORMAT_NAME_STATUS	5
+#define DIFF_FORMAT_DIFFSTAT	6
 
 extern void diff_flush(struct diff_options*);
 
diff --git a/git-diff.sh b/git-diff.sh
index dc0dd31..0fe6770 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -30,9 +30,11 @@ case " $flags " in
 	cc_or_p=--cc ;;
 esac
 
-# If we do not have --name-status, --name-only, -r, or -c default to --cc.
+# If we do not have --name-status, --name-only, -r, -c or --stat,
+# default to --cc.
 case " $flags " in
-*" '--name-status' "* | *" '--name-only' "* | *" '-r' "* | *" '-c' "* )
+*" '--name-status' "* | *" '--name-only' "* | *" '-r' "* | *" '-c' "* | \
+*" '--stat' "*)
 	;;
 *)
 	flags="$flags'$cc_or_p' " ;;
