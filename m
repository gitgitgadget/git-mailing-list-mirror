Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E53201CF
	for <e@80x24.org>; Sun, 14 May 2017 04:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbdENECK (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:02:10 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36064 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdENEBo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:44 -0400
Received: by mail-pg0-f47.google.com with SMTP id x64so26487137pgd.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcyhJ1ClvI00XrIMFGA0BznEIzAvOqIA6jVKnE4WZ1M=;
        b=oBCsQeSrlIzBdlYT36mXwuzLOiIcHAFlAC/CAwUVsKBP0xyEKJEZa2vvmNTgCfoaQu
         juvO2drLDDeorfD3H2B6433ypplIkVcdYkluBa5wbHBBIvCiWgtasSIqRAoh/TgIWfEm
         uVZvF0kWefK4Sp7enQ2BJU2PJiZe/eJAx0g8PO/H1augtPOYNtSeaWPAgOPTVDmjExL+
         6xOFiz2IVSJH2pX0fGkAurJeJe58Ir6QO4F4CiCtU8aEuTSlI8ox1MB4PPcVrLr75Tay
         /fZQk2WFbHKHI81cSNO/oxQuaJrRghSfBtzX4dQPufQln8th6R1imqXn5usxG2KLlmYi
         Z+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcyhJ1ClvI00XrIMFGA0BznEIzAvOqIA6jVKnE4WZ1M=;
        b=dGGLFRPmRH2t22iFCTvSQgT6gH2/rf76z9UbxLog92lds6uT4K/OG/U0sIORlLanNN
         ahZbYznuzxuVeNEaV4d9j46MuWZjB6BKI7IxuyAh0TubIBtekLOPOkF6OV//OyEYgTcH
         Coxp1dKHA68sG55RTWwwl+M8EzJiSiu8nktlFdT5CNM3x9rWY9ADENGDEQ44461t8Hq1
         OvhDR6BQb2pGUdMuwVMBhMHLWufqltENvnpQh7MtZ03XXVa/2QTKlIHRW9sHM9CoISgE
         HmF/R9/9gduHC0/ZyZBN5IkNcTZXCA1+IRE21ucJHXVJeOkF23vNTsd05IBXUBzpTdhI
         Wfsw==
X-Gm-Message-State: AODbwcCuj6B0wM3P6qciD2vO2g7AzIJW8KJNsyqpgEC+lswjE73z3Zv+
        VMJm9PaCSQyE7nMc
X-Received: by 10.84.135.34 with SMTP id 31mr15667247pli.99.1494734503899;
        Sat, 13 May 2017 21:01:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id n5sm12622914pfa.78.2017.05.13.21.01.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/19] diff.c: convert show_stats to use emit_line_*
Date:   Sat, 13 May 2017 21:01:11 -0700
Message-Id: <20170514040117.25865-14-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
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
 diff.c | 89 ++++++++++++++++++++++++++++++++++++++----------------------------
 diff.h |  4 +--
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/diff.c b/diff.c
index ffdb728810..91dc045a45 100644
--- a/diff.c
+++ b/diff.c
@@ -1529,20 +1529,19 @@ static int scale_linear(int it, int width, int max_change)
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
@@ -1566,14 +1565,16 @@ static void fill_print_name(struct diffstat_file *file)
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
+		emit_line(options, NULL, NULL, sb.buf, sb.len);
+		return;
 	}
 
 	strbuf_addf(&sb,
@@ -1600,9 +1601,17 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	ret = fputs(sb.buf, fp);
+	emit_line(options, NULL, NULL, sb.buf, sb.len);
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
@@ -1612,13 +1621,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1772,26 +1781,29 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
+				emit_line(options, NULL, NULL, out.buf, out.len);
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
+			emit_line(options, NULL, NULL, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " Unmerged\n");
+			show_name(&out, prefix, name, len);
+			strbuf_addstr(&out, " Unmerged\n");
+			emit_line(options, NULL, NULL, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 
@@ -1814,14 +1826,15 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
+		emit_line(options, NULL, NULL, out.buf, out.len);
+		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
@@ -1842,11 +1855,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			fprintf(options->file, "%s ...\n", line_prefix);
+			emit_line(options, NULL, NULL,
+				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -1858,7 +1872,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -1868,8 +1882,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index addebd5a0f..5e89481769 100644
--- a/diff.h
+++ b/diff.h
@@ -394,8 +394,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.13.0.18.g183880de0a

