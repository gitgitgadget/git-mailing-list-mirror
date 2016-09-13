Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B654207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbcIMEqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:48 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33783 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbcIMEqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:40 -0400
Received: by mail-pf0-f179.google.com with SMTP id g202so59757946pfb.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IBLQ1RCkamuIHZkpLRh4EWX1gABFGMdnEg3Lvj+ZuvE=;
        b=bsu3KEPrKLpPgknt8CqZ3bg5TZjrn3kNsCetPBdbOOqckEmk2YRh+hEVSNCA/6sIH3
         KgRJJnUTjvAv2Qv/3JFVIsHFQ8dbRc+48kL1tJE8oBZMfSQogZl1SDOGJqA8X2vJMAOT
         J3boJzsj40ppWX6U/D8Bhh9fn0EwPmoEHSwVeqsqSlMJE03tsMJh1zKkfe76XeDX7tTq
         Xx5WNVgdnhl1dFRVJOGg4fHz7qRFLJCHK+UGwmTjn+x4Xs7MStnlp9OvXeV57kHTDGMG
         mSkV22D4ntP2caGFoVj5j4ViDXLb6ppRZC/R/RYFbjLsORMNkSjOkSlzlsusKdg8T3cl
         iyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IBLQ1RCkamuIHZkpLRh4EWX1gABFGMdnEg3Lvj+ZuvE=;
        b=O+F/G1z/uPPelt7P/+v8NXOpq+NhI7NGXaEU9oeXtf3FOXTYh5gebtpahlPiwuERnG
         PGCCBcwfMQiCuQPCX3RBQsz0iS1Qs3E4gXITemfTZZ8uQhdA54AXh0tVIGRp8vOSMScz
         MTfuzUaOAsreqVDZxkDV8ZQY2etQa8m4adwrbqEY8veFHlYEDnBxQWXf07N+JJPhTE9o
         cvzJB8rtMJBY136MmOwwDHK749hwMCh+jEvpZx9+bwOLqaexddLy5SmA4sia7dPrbqPO
         KLQ/AZAmC0E76q51mUrRZmx7WqiTrm6ECzxHybNcTcGnlr7cJiOaUmiaET2GiPVMoBaQ
         uQzw==
X-Gm-Message-State: AE9vXwOWO4jp+rivn0yt8iEuPbB1bP0sJYs1tkZ6/dMAc/ynSASO5nQaNVFqipfVTgj4ctPR
X-Received: by 10.98.14.20 with SMTP id w20mr4907006pfi.9.1473741999193;
        Mon, 12 Sep 2016 21:46:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id xx7sm27880098pac.3.2016.09.12.21.46.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 12/17] diff.c: convert show_stats to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:08 -0700
Message-Id: <20160913044613.1037-13-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

We call print_stat_summary from builtin/apply, so we still
need the version with a file pointer, so introduce
print_stat_summary_0 that uses emit_line_* machinery and
keep print_stat_summary with the same arguments around.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 87 +++++++++++++++++++++++++++++++++++++-----------------------------
 diff.h |  4 +--
 2 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/diff.c b/diff.c
index ff1e829..00a5a4e 100644
--- a/diff.c
+++ b/diff.c
@@ -1465,20 +1465,19 @@ static int scale_linear(int it, int width, int max_change)
 	return 1 + (it * (width - 1) / max_change);
 }
 
-static void show_name(FILE *file,
+static void show_name(struct strbuf *out,
 		      const char *prefix, const char *name, int len)
 {
-	fprintf(file, " %s%-*s |", prefix, len, name);
+	strbuf_addf(out, " %s%-*s |", prefix, len, name);
 }
 
-static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
+static void show_graph(struct strbuf *out, char ch, int cnt, const char *set, const char *reset)
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
@@ -1502,14 +1501,16 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+void print_stat_summary_0(struct diff_options *options, int files,
+			  int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
 
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
-		return fprintf(fp, "%s\n", " 0 files changed");
+		strbuf_addstr(&sb, " 0 files changed");
+		emit_line_0(options, 0, 0, 0, sb.buf, sb.len);
+		return;
 	}
 
 	strbuf_addf(&sb,
@@ -1536,9 +1537,17 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	ret = fputs(sb.buf, fp);
+	emit_line_0(options, 0, 0, 0, sb.buf, sb.len);
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
+	print_stat_summary_0(&o, files, insertions, deletions);
 }
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
@@ -1548,13 +1557,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
-	const char *line_prefix = "";
 	int extra_shown = 0;
+	struct strbuf out = STRBUF_INIT;
 
 	if (data->nr == 0)
 		return;
 
-	line_prefix = diff_line_prefix(options);
 	count = options->stat_count ? options->stat_count : data->nr;
 
 	reset = diff_get_color_opt(options, DIFF_RESET);
@@ -1708,26 +1716,29 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (file->is_binary) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " %*s", number_width, "Bin");
+			show_name(&out, prefix, name, len);
+			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
-				putc('\n', options->file);
+				strbuf_addch(&out, '\n');
+				emit_line(options, 0, 0, out.buf, out.len);
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
+			emit_line(options, 0, 0, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " Unmerged\n");
+			show_name(&out, prefix, name, len);
+			strbuf_addstr(&out, " Unmerged\n");
+			emit_line(options, 0, 0, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 
@@ -1750,14 +1761,15 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				add = total - del;
 			}
 		}
-		fprintf(options->file, "%s", line_prefix);
-		show_name(options->file, prefix, name, len);
-		fprintf(options->file, " %*"PRIuMAX"%s",
+		show_name(&out, prefix, name, len);
+		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
-		show_graph(options->file, '+', add, add_c, reset);
-		show_graph(options->file, '-', del, del_c, reset);
-		fprintf(options->file, "\n");
+		show_graph(&out, '+', add, add_c, reset);
+		show_graph(&out, '-', del, del_c, reset);
+		strbuf_addch(&out, '\n');
+		emit_line(options, 0, 0, out.buf, out.len);
+		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
@@ -1778,11 +1790,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			fprintf(options->file, "%s ...\n", line_prefix);
+			emit_line_0(options, 0, 0, 0, " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -1794,7 +1806,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -1804,8 +1816,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 1699d9c..cc5d038 100644
--- a/diff.h
+++ b/diff.h
@@ -379,8 +379,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.10.0.21.g1da280f.dirty

