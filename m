Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335DA20838
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbdFWB3x (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:53 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35581 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdFWB3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:50 -0400
Received: by mail-pg0-f43.google.com with SMTP id 132so15007849pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGYaD6XEVMsYL9GCgqIIRX9SS6E/ebonxV6OM7cxwtw=;
        b=Jxt1JevJJ4TD1u+FDihHgGP3b/rDHSiDmE8YezYPF8ZmztpIi7eFOjJNSWv8+tWbKw
         QVHfLJoxixKhR68xur49IobVKqip/yKvlyxas11XjJACNK5XHusVsz47V43Rhj1Lkpby
         UEC2flvrbPdFZ7Zeo54TUX1cDOdH2oR1cL2sLoZKdrdUW+0qglLZ4x6JrMivCRV7a5+9
         2SxSGxO+kQJn5ZUqbpoqlKpXF2twnDMO8a7kqKLrmR5yxUQ+s6tgijA/pFFq965mQ85F
         6ac2jdvKypCqrQ2ylAmOPq3ZHn0ZuwSzgdMJzXLsMuQj/EsfeUVtSi/Rfcrkk+X4jfIC
         pnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QGYaD6XEVMsYL9GCgqIIRX9SS6E/ebonxV6OM7cxwtw=;
        b=l6kyMbu0oNM/XEgEnCy+6CDWHTZr+UWB1a7AAbvk3OQHp5XjhRcCDWdlwT1w/XuFKU
         TF91e0IZJBQaxnqcCZCX+J57qsvTYLHlR4BCPd8SsoAoKgRFxv2a2eOcMt2c4O2F7C8H
         qU/fXR+tlFBWzHlKwDp42W8secospglU14A4Ss3lHj/L75QT2cm3BayQFO+taExZSFN3
         jZElseEiuah/yEclyddPDjFjnQgUmX4wuExuKnZQKIOWXcYmyWjZNbnRItlrcBKLxQk6
         UEwK97VrfhdwHwII5nJwpV8m8VREJGnKEtkkiIOK9tJq4OYthH2Hlkt9eovlsgt2tjr7
         lI+Q==
X-Gm-Message-State: AKS2vOxKyDyN7JvANrz3t9O19iDJc6pp/ZIpI5krHgKaZQgBunL3D/zc
        Ip9R04rvNeC8jDDt
X-Received: by 10.99.0.212 with SMTP id 203mr5410942pga.259.1498181389729;
        Thu, 22 Jun 2017 18:29:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id j22sm6446266pfj.56.2017.06.22.18.29.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 17/25] diff.c: convert show_stats to use emit_diff_symbol
Date:   Thu, 22 Jun 2017 18:29:11 -0700
Message-Id: <20170623012919.28693-18-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call print_stat_summary from builtin/apply, so we still
need the version with a file pointer, so introduce
print_stat_summary_0 that uses emit_string machinery and
keep print_stat_summary with the same arguments around.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 114 +++++++++++++++++++++++++++++++++++++++++------------------------
 diff.h |   4 +--
 2 files changed, 74 insertions(+), 44 deletions(-)

diff --git a/diff.c b/diff.c
index 7c92675f6f..2108c191a3 100644
--- a/diff.c
+++ b/diff.c
@@ -565,6 +565,10 @@ enum diff_symbol {
 	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
 	DIFF_SYMBOL_BINARY_DIFF_BODY,
 	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
+	DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
+	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
+	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
+	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -628,6 +632,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *meta, *fraginfo;
+	struct strbuf sb = STRBUF_INIT;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -639,6 +644,8 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_STATS_LINE:
 	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
@@ -747,9 +754,17 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		fprintf(o->file, "%sSubmodule %s contains modified content\n",
 			diff_line_prefix(o), line);
 		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
+		emit_line(o, "", "", " 0 files changed\n",
+			  strlen(" 0 files changed\n"));
+		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
+		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
+	strbuf_release(&sb);
 }
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line)
@@ -1705,20 +1720,14 @@ static int scale_linear(int it, int width, int max_change)
 	return 1 + (it * (width - 1) / max_change);
 }
 
-static void show_name(FILE *file,
-		      const char *prefix, const char *name, int len)
-{
-	fprintf(file, " %s%-*s |", prefix, len, name);
-}
-
-static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
+static void show_graph(struct strbuf *out, char ch, int cnt,
+		       const char *set, const char *reset)
 {
 	if (cnt <= 0)
 		return;
-	fprintf(file, "%s", set);
-	while (cnt--)
-		putc(ch, file);
-	fprintf(file, "%s", reset);
+	strbuf_addstr(out, set);
+	strbuf_addchars(out, ch, cnt);
+	strbuf_addstr(out, reset);
 }
 
 static void fill_print_name(struct diffstat_file *file)
@@ -1742,14 +1751,16 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+static void print_stat_summary_inserts_deletes(struct diff_options *options,
+		int files, int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
 
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
-		return fprintf(fp, "%s\n", " 0 files changed");
+		emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
+				 NULL, 0, 0);
+		return;
 	}
 
 	strbuf_addf(&sb,
@@ -1776,9 +1787,19 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	ret = fputs(sb.buf, fp);
+	emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
+			 sb.buf, sb.len, 0);
 	strbuf_release(&sb);
-	return ret;
+}
+
+void print_stat_summary(FILE *fp, int files,
+			int insertions, int deletions)
+{
+	struct diff_options o;
+	memset(&o, 0, sizeof(o));
+	o.file = fp;
+
+	print_stat_summary_inserts_deletes(&o, files, insertions, deletions);
 }
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
@@ -1788,13 +1809,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
-	const char *line_prefix = "";
 	int extra_shown = 0;
+	const char *line_prefix = diff_line_prefix(options);
+	struct strbuf out = STRBUF_INIT;
 
 	if (data->nr == 0)
 		return;
 
-	line_prefix = diff_line_prefix(options);
 	count = options->stat_count ? options->stat_count : data->nr;
 
 	reset = diff_get_color_opt(options, DIFF_RESET);
@@ -1948,26 +1969,32 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (file->is_binary) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " %*s", number_width, "Bin");
+			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
-				putc('\n', options->file);
+				strbuf_addch(&out, '\n');
+				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+						 out.buf, out.len, 0);
+				strbuf_reset(&out);
 				continue;
 			}
-			fprintf(options->file, " %s%"PRIuMAX"%s",
+			strbuf_addf(&out, " %s%"PRIuMAX"%s",
 				del_c, deleted, reset);
-			fprintf(options->file, " -> ");
-			fprintf(options->file, "%s%"PRIuMAX"%s",
+			strbuf_addstr(&out, " -> ");
+			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
-			fprintf(options->file, " bytes");
-			fprintf(options->file, "\n");
+			strbuf_addstr(&out, " bytes\n");
+			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+					 out.buf, out.len, 0);
+			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " Unmerged\n");
+			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addstr(&out, " Unmerged\n");
+			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+					 out.buf, out.len, 0);
+			strbuf_reset(&out);
 			continue;
 		}
 
@@ -1990,14 +2017,16 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				add = total - del;
 			}
 		}
-		fprintf(options->file, "%s", line_prefix);
-		show_name(options->file, prefix, name, len);
-		fprintf(options->file, " %*"PRIuMAX"%s",
+		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
-		show_graph(options->file, '+', add, add_c, reset);
-		show_graph(options->file, '-', del, del_c, reset);
-		fprintf(options->file, "\n");
+		show_graph(&out, '+', add, add_c, reset);
+		show_graph(&out, '-', del, del_c, reset);
+		strbuf_addch(&out, '\n');
+		emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+				 out.buf, out.len, 0);
+		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
@@ -2018,11 +2047,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			fprintf(options->file, "%s ...\n", line_prefix);
+			emit_diff_symbol(options,
+					 DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
+					 NULL, 0, 0);
 		extra_shown = 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+
+	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -2034,7 +2065,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -2044,8 +2075,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 2ee0ef3908..b73f7a1e75 100644
--- a/diff.h
+++ b/diff.h
@@ -398,8 +398,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.12.2.575.gb14f27f917

