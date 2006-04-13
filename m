From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 03:02:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 13 03:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTqDy-0003dX-58
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 03:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWDMBCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 21:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWDMBCP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 21:02:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2741 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932341AbWDMBCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 21:02:14 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BFA2D1F71;
	Thu, 13 Apr 2006 03:02:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B39CF1EB0;
	Thu, 13 Apr 2006 03:02:10 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 8A1AB1D78;
	Thu, 13 Apr 2006 03:02:10 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18643>


Now you can say "git diff --stat" (to get an idea how many changes are
uncommitted), or "git log --stat" (to get an idea how many changes were
committed).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Probably it would be nicer to pass down the diff_options to
	builtin_diff(), run_diff() and run_diff_cmd(), but I am *way*
	too tired to change that now.

	It would have been nice to not just rip out and modify the diffstat
	code from apply.c, but I did not want to fake patch structures.
	Maybe someone more intelligent than me wants to fix this...

 Documentation/diff-options.txt |    3 
 diff.c                         |  250 ++++++++++++++++++++++++++++++++++------
 diff.h                         |    3 
 git-diff.sh                    |    6 +
 4 files changed, 222 insertions(+), 40 deletions(-)

c706aa10bc5e2e2e22fb07aeaff1418f3d4caee0
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
index a14e664..7f2b652 100644
--- a/diff.c
+++ b/diff.c
@@ -177,6 +177,7 @@ static int fill_mmfile(mmfile_t *mf, str
 
 struct emit_callback {
 	const char **label_path;
+	struct diffstat_t *diffstat;
 };
 
 static int fn_out(void *priv, mmbuffer_t *mb, int nbuf)
@@ -195,6 +196,150 @@ static int fn_out(void *priv, mmbuffer_t
 	return 0;
 }
 
+struct diffstat_t {
+	int nr;
+	int alloc;
+	struct diffstat_file {
+		char *name;
+		unsigned int added, deleted;
+	} **files;
+};
+
+static int fn_diffstat(void *priv, mmbuffer_t *mb, int nbuf)
+{
+	int i;
+	struct emit_callback *data = priv;
+	struct diffstat_file *x;
+	struct diffstat_t *diffstat = data->diffstat;
+
+	if (data->label_path[0]) {
+		x = xcalloc(sizeof (*x), 1);
+		if (diffstat->nr == diffstat->alloc) {
+			diffstat->alloc = alloc_nr(diffstat->alloc);
+			diffstat->files = xrealloc(diffstat->files,
+					diffstat->alloc * sizeof(x));
+		}
+		diffstat->files[diffstat->nr++] = x;
+		x->name = strdup(data->label_path[0] + 2);
+		data->label_path[0] = data->label_path[1] = NULL;
+	} else
+		x = diffstat->files[diffstat->nr - 1];
+
+	for (i = 0; i < nbuf; i++)
+		if (mb[i].ptr[0] == '+')
+			x->added++;
+		else if (mb[i].ptr[0] == '-')
+			x->deleted++;
+	return 0;
+}
+
+static void diffstat_binary(struct diffstat_t *diffstat, const char *name)
+{
+	struct diffstat_file *x = xcalloc(sizeof (*x), 1);
+	if (diffstat->nr == diffstat->alloc) {
+		diffstat->alloc = alloc_nr(diffstat->alloc);
+		diffstat->files = xrealloc(diffstat->files,
+				diffstat->alloc * sizeof(x));
+	}
+	diffstat->files[diffstat->nr++] = x;
+	x->name = strdup(name + 2);
+	x->added = -1;
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
@@ -211,7 +356,8 @@ static void builtin_diff(const char *nam
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 struct diffstat_t* diffstat)
 {
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
@@ -221,43 +367,49 @@ static void builtin_diff(const char *nam
 	b_two = quote_two("b/", name_b);
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("diff --git %s %s\n", a_one, b_two);
-	if (lbl[0][0] == '/') {
-		/* /dev/null */
-		printf("new file mode %06o\n", two->mode);
-		if (xfrm_msg && xfrm_msg[0])
-			puts(xfrm_msg);
-	}
-	else if (lbl[1][0] == '/') {
-		printf("deleted file mode %06o\n", one->mode);
-		if (xfrm_msg && xfrm_msg[0])
-			puts(xfrm_msg);
-	}
-	else {
-		if (one->mode != two->mode) {
-			printf("old mode %06o\n", one->mode);
-			printf("new mode %06o\n", two->mode);
+	if (!diffstat) {
+		printf("diff --git %s %s\n", a_one, b_two);
+		if (lbl[0][0] == '/') {
+			/* /dev/null */
+			printf("new file mode %06o\n", two->mode);
+			if (xfrm_msg && xfrm_msg[0])
+				puts(xfrm_msg);
 		}
-		if (xfrm_msg && xfrm_msg[0])
-			puts(xfrm_msg);
-		/*
-		 * we do not run diff between different kind
-		 * of objects.
-		 */
-		if ((one->mode ^ two->mode) & S_IFMT)
-			goto free_ab_and_return;
-		if (complete_rewrite) {
-			emit_rewrite_diff(name_a, name_b, one, two);
-			goto free_ab_and_return;
+		else if (lbl[1][0] == '/') {
+			printf("deleted file mode %06o\n", one->mode);
+			if (xfrm_msg && xfrm_msg[0])
+				puts(xfrm_msg);
 		}
+		else {
+			if (one->mode != two->mode) {
+				printf("old mode %06o\n", one->mode);
+				printf("new mode %06o\n", two->mode);
+			}
+			if (xfrm_msg && xfrm_msg[0])
+				puts(xfrm_msg);
+			/*
+			 * we do not run diff between different kind
+			 * of objects.
+			 */
+			if ((one->mode ^ two->mode) & S_IFMT)
+				goto free_ab_and_return;
+			if (complete_rewrite) {
+				emit_rewrite_diff(name_a, name_b, one, two);
+				goto free_ab_and_return;
+			}
+		}
 	}
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))
-		printf("Binary files %s and %s differ\n", lbl[0], lbl[1]);
-	else {
+	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
+		if (diffstat)
+			diffstat_binary(diffstat, lbl[0]);
+		else
+			printf("Binary files %s and %s differ\n",
+					lbl[0], lbl[1]);
+	} else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
@@ -266,6 +418,7 @@ static void builtin_diff(const char *nam
 		struct emit_callback ecbdata;
 
 		ecbdata.label_path = lbl;
+		ecbdata.diffstat = diffstat;
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -275,7 +428,7 @@ static void builtin_diff(const char *nam
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!strncmp(diffopts, "-u", 2))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecb.outf = fn_out;
+		ecb.outf = diffstat ? fn_diffstat : fn_out;
 		ecb.priv = &ecbdata;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
@@ -690,16 +843,19 @@ static void run_diff_cmd(const char *pgm
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 struct diffstat_t *diffstat)
 {
 	if (pgm) {
+		if (diffstat)
+			die ("Cannot use diffstat with external diff");
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
 				  complete_rewrite);
 		return;
 	}
 	if (one && two)
 		builtin_diff(name, other ? other : name,
-			     one, two, xfrm_msg, complete_rewrite);
+			     one, two, xfrm_msg, complete_rewrite, diffstat);
 	else
 		printf("* Unmerged path %s\n", name);
 }
@@ -733,7 +889,8 @@ static void run_diff(struct diff_filepai
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, 0);
+		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, 0,
+			o->diffstat);
 		return;
 	}
 
@@ -805,15 +962,17 @@ static void run_diff(struct diff_filepai
 		 * needs to be split into deletion and creation.
 		 */
 		struct diff_filespec *null = alloc_filespec(two->path);
-		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, 0,
+			o->diffstat);
 		free(null);
 		null = alloc_filespec(one->path);
-		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, 0,
+			o->diffstat);
 		free(null);
 	}
 	else
 		run_diff_cmd(pgm, name, other, one, two, xfrm_msg,
-			     complete_rewrite);
+			     complete_rewrite, o->diffstat);
 
 	free(name_munged);
 	free(other_munged);
@@ -866,6 +1025,8 @@ int diff_opt_parse(struct diff_options *
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
 	}
+	else if (!strcmp(arg, "--stat"))
+		options->output_format = DIFF_FORMAT_DIFFSTAT;
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -1291,6 +1452,7 @@ static void flush_one_pair(struct diff_f
 		break;
 	default:
 		switch (diff_output_format) {
+		case DIFF_FORMAT_DIFFSTAT:
 		case DIFF_FORMAT_PATCH:
 			diff_flush_patch(p, options);
 			break;
@@ -1316,6 +1478,12 @@ void diff_flush(struct diff_options *opt
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 	int diff_output_format = options->output_format;
+	struct diffstat_t *diffstat = NULL;
+
+	if (diff_output_format == DIFF_FORMAT_DIFFSTAT) {
+		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
+		options->diffstat = diffstat;
+	}
 
 	if (options->with_raw) {
 		for (i = 0; i < q->nr; i++) {
@@ -1329,6 +1497,12 @@ void diff_flush(struct diff_options *opt
 		flush_one_pair(p, diff_output_format, options);
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
index 236095f..5c1526c 100644
--- a/diff.h
+++ b/diff.h
@@ -44,6 +44,7 @@ struct diff_options {
 	int *pathlens;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	struct diffstat_t *diffstat;
 };
 
 extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
@@ -119,6 +120,7 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  -u            synonym for -p.\n" \
 "  --patch-with-raw\n" \
 "                output both a patch and the diff-raw format.\n" \
+"  --stat        show diffstat instead of patch.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
 "  --full-index  show full object name on index lines.\n" \
@@ -142,6 +144,7 @@ #define DIFF_FORMAT_PATCH	2
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
-- 
1.2.0.gd507-dirty
