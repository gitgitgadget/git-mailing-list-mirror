From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [WIP/PATCH] Combined diffstat
Date: Sat, 15 Apr 2006 20:08:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604152006440.10192@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 20:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUpCl-00040L-Ir
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 20:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWDOSIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 14:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWDOSIy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 14:08:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60584 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030298AbWDOSIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 14:08:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id D7B341D31;
	Sat, 15 Apr 2006 20:08:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CBB8A11C0;
	Sat, 15 Apr 2006 20:08:51 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id AAB76110E;
	Sat, 15 Apr 2006 20:08:51 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18754>


I ended up implementing both proposals for merge diffstats:

Junio)

 pack-objects.c |  923 ++++++++----- ++++++++++++++++++++++++++++------ +++--
 rev-list.c     |    5
 send-pack.c    |   86               +-                                 +
 upload-pack.c  |    7
 4 files changed, 786 insertions(+), 235 deletions(-)

Marco)

 pack-objects.c |   22 ++++++++++++++--------
 rev-list.c     |    0
 send-pack.c    |    0
 upload-pack.c  |    0
 4 files changed, 156 insertions(+), 86 deletions(-)

 pack-objects.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++---------
 send-pack.c    |    4 +++-
 upload-pack.c  |    0
 3 files changed, 532 insertions(+), 103 deletions(-)

 pack-objects.c |    9 ++++++---
 rev-list.c     |    0
 send-pack.c    |    4 +++-
 upload-pack.c  |    0
 4 files changed, 98 insertions(+), 46 deletions(-)

For the moment, I like Junio's better, if only because it was more difficult
to implement.

If you want to try it, I suggest using this as a test case:

	git log --stat f0b0af1b04

To get the output with separate diffstats for each parent, just define the
environment variable NO_COMBINED_DIFFSTAT before calling git.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 combine-diff.c |  271 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h         |    1 
 log-tree.c     |    6 +
 3 files changed, 278 insertions(+), 0 deletions(-)

9e802df5d029d44938568060d4d567a4fd130d79
diff --git a/combine-diff.c b/combine-diff.c
index 9bd27f8..b82ee8c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -148,6 +148,15 @@ static void append_lost(struct sline *sl
 	sline->lost_tail = &lline->next;
 }
 
+struct diffstat_t {
+        struct diffstat_file {
+                char *name;
+                struct diffstat_parent {
+			unsigned int added, deleted;
+		} *parent;
+        } *files, *current;
+};
+
 struct combine_diff_state {
 	struct xdiff_emit_state xm;
 
@@ -557,6 +566,35 @@ static void dump_sline(struct sline *sli
 	}
 }
 
+static void diffstat_sline(struct diffstat_t *diffstat,
+		struct sline *sline, unsigned long cnt, int num_parent)
+{
+	struct diffstat_parent *data = diffstat->current->parent;
+	unsigned long interesting = (1UL<<num_parent);
+	int lno;
+	for (lno = 0; lno <= cnt; lno++) {
+		struct sline *sl = sline + lno;
+		struct lline *ll;
+		int j;
+
+		if (!(sl->flag & interesting))
+			continue;
+
+		
+		for (ll = sl->lost_head; ll; ll = ll->next)
+			for (j = 0; j < num_parent; j++)
+				if (ll->parent_map & (1UL<<j))
+					data[j].deleted++;
+
+		if (cnt < lno)
+			break;
+
+		for (j = 0; j < num_parent; j++)
+			if (sl->flag & (1UL<<j))
+				data[j].added++;
+	}
+}
+
 static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 			       int i, int j)
 {
@@ -596,6 +634,7 @@ static int show_patch_diff(struct combin
 	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
+	struct diffstat_t *diffstat = opt->diffstat;
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
@@ -686,6 +725,12 @@ static int show_patch_diff(struct combin
 
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
 
+	if (diffstat) {
+		diffstat->current->name = strdup(elem->path);
+		diffstat_sline(diffstat, sline, cnt, num_parent);
+		show_hunks = 0;
+	}
+
 	if (show_hunks || mode_differs || working_tree_file) {
 		const char *abb;
 
@@ -826,11 +871,213 @@ int show_combined_diff(struct combine_di
 		return 1;
 
 	default:
+	case DIFF_FORMAT_DIFFSTAT:
 	case DIFF_FORMAT_PATCH:
 		return show_patch_diff(p, num_parent, dense, header, opt);
 	}
 }
 
+static const char pluses[] = "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
+static const char minuses[]= "----------------------------------------------------------------------";
+
+static void show_stats(struct diffstat_t *diffstat,
+		int num_paths, int num_parent)
+{
+	int show_combined_diffstat = (getenv("NO_COMBINED_DIFFSTAT") == NULL);
+	int i, j;
+	int max_length = 0, max_change = 0;
+	int *parent_max_change;
+	char *prefix = "";
+	int len, add, del, total, adds, dels, total_files, max;
+
+	if (num_paths == 0)
+		return;
+
+	parent_max_change = xcalloc(sizeof(int), num_parent);
+
+	for (i = 0; i < num_paths; i++) {
+		int len;
+		char *name = diffstat->files[i].name;
+		if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
+			char *qname = xmalloc(len + 1);
+			quote_c_style(name, qname, NULL, 0);
+			free(name);
+			diffstat->files[i].name = name = qname;
+		} else
+			len = strlen(name);
+
+		if (max_length < len)
+			max_length = len;
+
+		for (j = 0; j < num_parent; j++) {
+			struct diffstat_parent *data =
+				diffstat->files[i].parent + j;
+			int change = data->added + data->deleted;
+			if (parent_max_change[j] < change) {
+				parent_max_change[j] = change;
+				if (max_change < change)
+					max_change = change;
+			}
+		}
+	}
+
+	if (max_change == 0)
+		return;
+
+	printf("---\n");
+
+	if (show_combined_diffstat) {
+		char buffer[80];
+		max_change = 0;
+		for (j = 0; j < num_parent; j++)
+			max_change += parent_max_change[j];
+		
+		prefix = "";
+		total_files = num_paths;
+		adds = dels = 0;
+
+		for (i = 0; i < num_paths; i++) {
+			int offset;
+			char *name = diffstat->files[i].name;
+
+			/*
+			 * "scale" the filename
+			 */
+			len = strlen(name);
+			max = max_length;
+			if (max > 50)
+				max = 50;
+			if (len > max) {
+				char *slash;
+				prefix = "...";
+				max -= 3;
+				name += len - max;
+				slash = strchr(name, '/');
+				if (slash)
+					name = slash;
+			}
+			len = max;
+
+			/*
+			 * scale the add/delete
+			 */
+			max = max_change + num_parent - 1;
+			if (max + len > 70)
+				max = 70 - len;
+
+			memset(buffer, ' ', 70);
+			buffer[max + 1] = 0;
+
+			max -= num_parent - 1;
+			offset = add = del = 0;
+			for (j = 0; j < num_parent; j++) {
+				struct diffstat_parent *data =
+					diffstat->files[i].parent + j;
+				int a, d, size;
+
+				size = max * parent_max_change[j] / max_change;
+				if (size == 0)
+					size = 1;
+
+				a = data->added;
+				d = a + data->deleted;
+
+				a = a * size / parent_max_change[j];
+				d = d * size / parent_max_change[j];
+
+				memset(buffer + offset, '+', a);
+				memset(buffer + offset + a, '-', d - a);
+
+				add += data->added;
+				del += data->deleted;
+
+				offset += size + 1;
+			}
+
+			if (add + del == 0) {
+				total_files--;
+				continue;
+			}
+
+			adds += add;
+			dels += del;
+
+			printf(" %s%-*s |%5d %s\n", prefix, len, name,
+					add + del, buffer);
+		}
+		printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
+				total_files, adds, dels);
+	} else {
+		for (j = 0; j < num_parent; j++) {
+			prefix = "";
+			total_files = num_paths;
+			adds = dels = 0;
+
+			for (i = 0; i < num_paths; i++) {
+				char *name = diffstat->files[i].name;
+				struct diffstat_parent *data =
+					diffstat->files[i].parent + j;
+
+				/*
+				 * "scale" the filename
+				 */
+				len = strlen(name);
+				max = max_length;
+				if (max > 50)
+					max = 50;
+				if (len > max) {
+					char *slash;
+					prefix = "...";
+					max -= 3;
+					name += len - max;
+					slash = strchr(name, '/');
+					if (slash)
+						name = slash;
+				}
+				len = max;
+
+				/*
+				 * scale the add/delete
+				 */
+				max = max_change;
+				if (max + len > 70)
+					max = 70 - len;
+
+				add = data->added;
+				del = data->deleted;
+
+				if (add + del == 0) {
+					total_files--;
+					continue;
+				}
+
+				total = add + del;
+				adds += add;
+				dels += del;
+
+				if (max_change > 0) {
+					total = (total * max + max_change / 2) / max_change;
+					add = (add * max + max_change / 2) / max_change;
+					del = total - add;
+				}
+				printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
+						len, name, add + del,
+						add, pluses, del, minuses);
+			}
+			printf(" %d files changed, %d insertions(+), %d deletions(-)\n\n",
+					total_files, adds, dels);
+		}
+	}
+
+	for (i = 0; i < num_paths; i++) {
+		free(diffstat->files[i].parent);
+		free(diffstat->files[i].name);
+	}
+	free(diffstat->files);
+	diffstat->files = NULL;
+	free(parent_max_change);
+}
+
 const char *diff_tree_combined_merge(const unsigned char *sha1,
 			     const char *header, int dense,
 			     struct diff_options *opt)
@@ -840,6 +1087,11 @@ const char *diff_tree_combined_merge(con
 	struct commit_list *parents;
 	struct combine_diff_path *p, *paths = NULL;
 	int num_parent, i, num_paths;
+	struct diffstat_t *diffstat = NULL;
+
+	if (opt->output_format == DIFF_FORMAT_DIFFSTAT)
+		opt->diffstat = diffstat =
+			xcalloc(sizeof(struct diffstat_t), 1);
 
 	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -870,6 +1122,15 @@ const char *diff_tree_combined_merge(con
 			num_paths++;
 	}
 	if (num_paths) {
+		if (diffstat) {
+			diffstat->files = xcalloc(sizeof(struct diffstat_file),
+					num_paths);
+			for (i = 0; i < num_paths; i++)
+				diffstat->files[i].parent =
+					xcalloc(sizeof(struct diffstat_parent),
+							num_parent);
+			diffstat->current = diffstat->files;
+		}
 		if (opt->with_raw) {
 			int saved_format = opt->output_format;
 			opt->output_format = DIFF_FORMAT_RAW;
@@ -882,12 +1143,22 @@ const char *diff_tree_combined_merge(con
 			putchar(opt->line_termination);
 		}
 		for (p = paths; p; p = p->next) {
+			if (p->len == 0)
+				continue;
 			if (show_combined_diff(p, num_parent, dense,
 					       header, opt))
 				header = NULL;
+			if (diffstat)
+				diffstat->current++;
 		}
 	}
 
+	if (diffstat) {
+		show_stats(diffstat, num_paths, num_parent);
+		free(diffstat);
+		opt->diffstat = diffstat = NULL;
+	}
+
 	/* Clean things up */
 	while (paths) {
 		struct combine_diff_path *tmp = paths;
diff --git a/diff.h b/diff.h
index f783bae..26e3c02 100644
--- a/diff.h
+++ b/diff.h
@@ -45,6 +45,7 @@ struct diff_options {
 	int *pathlens;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	struct diffstat_t *diffstat;
 };
 
 extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
diff --git a/log-tree.c b/log-tree.c
index cb0d0b1..bb46f06 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -232,6 +232,12 @@ int parse_whatchanged_opt(int ac, const 
 			opt->diffopt.output_format = DIFF_FORMAT_PATCH;
 		if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
 			opt->diffopt.recursive = 1;
+		if (opt->diffopt.output_format == DIFF_FORMAT_DIFFSTAT) {
+			opt->ignore_merges = 0;
+			opt->combine_merges = 1;
+			opt->dense_combined_merges = 1;
+			opt->diffopt.recursive = 1;
+		}
 		if (!wcopt->full_diff && rev->prune_data)
 			diff_tree_setup_paths(rev->prune_data, &opt->diffopt);
 		diff_setup_done(&opt->diffopt);
-- 
1.3.0.rc4.g667c
