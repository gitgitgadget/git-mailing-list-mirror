Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6161B20188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdENEBs (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:48 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34226 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdENEBr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:47 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so45918753pgn.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kagQxKiOSWw8e55eoNoKUZSGdMzkSNzng7sLh1U993M=;
        b=h3FfmaYNIxxLaCA04KNpxyUK3pofOIw/QlHM44UHRF1OqD/Kawty+g96K9xUFZb7yd
         1PpIT8USEldoaJswALgsOnAHsErQWzXUfNyIhsMTKdwJNw2kP9EuVGWkqTOXgWMuYmnK
         FHanqybJ9+puwFZmP5nK0zj/nrBzR2N/3iWfTes6QI4ShWUzDruTfEffz9sgWaXX7Ob6
         wNhIee0G329uOS875Dc8dlK90YnR2WGj/OUgiDkNe60dNmfg9UxEJ1GaXM1DaWTMrtME
         gp/qkXnRae1jMZ/Vs6pRLY90lAAnYgrot3mclq3ukqytbtsU/NazgrpDlqPcw+Mi7frI
         Xg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kagQxKiOSWw8e55eoNoKUZSGdMzkSNzng7sLh1U993M=;
        b=mzc+uhoY1+tGxhsUMlMqxr30s1i1n035YEvraRQ9KyYe71UMHNDZr1l1iutCzDPxmk
         BNjOEC3C4yYmheyHnQyUKMPumQ5/jpPGiSv/JdzcI1e8431PApahJ9dGmXygfuaFWPXP
         tFxGMNgaNDerOUDXywuhwqBGsRS382EkpMTHpIaCya7x0zSx/CAm99RVSAkYQLK7OF4P
         Kr8v0N4HRhcoBTRUw73nVz9vAOumSYkH5WO03CJXE2UJutqYqCxi+XxQ/38FNWXF/8qE
         MnxdK5sPyF56WZ557O+QFU4YB1jWdBOkE4vaRTkKA3aj0gfE55m8K8g4XVXDfgxmxCdD
         keVA==
X-Gm-Message-State: AODbwcBVKfQzKlpLknTOpazhgjUf6ikyaaQJUSHSdlpUUFr7TsDfxTSl
        jWUFikOS2G7j3H7i
X-Received: by 10.98.197.133 with SMTP id j127mr12191843pfg.239.1494734501087;
        Sat, 13 May 2017 21:01:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id c77sm12706478pfe.37.2017.05.13.21.01.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/19] submodule.c: convert show_submodule_summary to use emit_line_fmt
Date:   Sat, 13 May 2017 21:01:09 -0700
Message-Id: <20170514040117.25865-12-sbeller@google.com>
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

This prepares the code for submodules to go through the
emit_line function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      | 18 +++++++-------
 diff.h      |  5 ++++
 submodule.c | 78 ++++++++++++++++++++++++++++++-------------------------------
 submodule.h |  9 +++----
 4 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/diff.c b/diff.c
index 369c804f03..45ec311828 100644
--- a/diff.c
+++ b/diff.c
@@ -546,15 +546,15 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
-static void emit_line(struct diff_options *o, const char *set, const char *reset,
-		      const char *line, int len)
+void emit_line(struct diff_options *o, const char *set, const char *reset,
+	       const char *line, int len)
 {
 	emit_line_0(o, set, reset, 0, line, len);
 }
 
-static void emit_line_fmt(struct diff_options *o,
-			  const char *set, const char *reset,
-			  const char *fmt, ...)
+void emit_line_fmt(struct diff_options *o,
+		   const char *set, const char *reset,
+		   const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
 	va_list ap;
@@ -2379,8 +2379,7 @@ static void builtin_diff(const char *name_a,
 	    (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule,
 				meta, del, add, reset);
@@ -2390,11 +2389,10 @@ static void builtin_diff(const char *name_a,
 		   (!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_inline_diff(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule,
-				meta, del, add, reset, o);
+				meta, del, add, reset);
 		return;
 	}
 
diff --git a/diff.h b/diff.h
index 5be1ee77a7..addebd5a0f 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,11 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
+		   const char *fmt, ...);
+void emit_line(struct diff_options *o, const char *set, const char *reset,
+	       const char *line, int len);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index d3299e29c0..cfad469a2f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -362,8 +362,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *line_prefix,
+static void print_submodule_summary(struct rev_info *rev,
+		struct diff_options *o,
 		const char *del, const char *add, const char *reset)
 {
 	static const char format[] = "  %m %s";
@@ -375,18 +375,12 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		strbuf_addstr(&sb, line_prefix);
-		if (commit->object.flags & SYMMETRIC_LEFT) {
-			if (del)
-				strbuf_addstr(&sb, del);
-		}
-		else if (add)
-			strbuf_addstr(&sb, add);
 		format_commit_message(commit, format, &sb, &ctx);
-		if (reset)
-			strbuf_addstr(&sb, reset);
 		strbuf_addch(&sb, '\n');
-		fprintf(f, "%s", sb.buf);
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			emit_line(o, del, reset, sb.buf, sb.len);
+		else if (add)
+			emit_line(o, add, reset, sb.buf, sb.len);
 	}
 	strbuf_release(&sb);
 }
@@ -413,8 +407,7 @@ void prepare_submodule_repo_env(struct argv_array *out)
  * attempt to lookup both the left and right commits and put them into the
  * left and right pointers.
  */
-static void show_submodule_header(FILE *f, const char *path,
-		const char *line_prefix,
+static void show_submodule_header(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *reset,
@@ -426,11 +419,11 @@ static void show_submodule_header(FILE *f, const char *path,
 	int fast_forward = 0, fast_backward = 0;
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
+		emit_line_fmt(o, NULL, NULL,
+			      "Submodule %s contains untracked content\n", path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+		emit_line_fmt(o, NULL, NULL,
+			      "Submodule %s contains modified content\n", path);
 
 	if (is_null_oid(one))
 		message = "(new submodule)";
@@ -472,21 +465,20 @@ static void show_submodule_header(FILE *f, const char *path,
 	}
 
 output_header:
-	strbuf_addf(&sb, "%s%sSubmodule %s ", line_prefix, meta, path);
+	strbuf_addf(&sb, "Submodule %s ", path);
 	strbuf_add_unique_abbrev(&sb, one->hash, DEFAULT_ABBREV);
 	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
 	strbuf_add_unique_abbrev(&sb, two->hash, DEFAULT_ABBREV);
 	if (message)
-		strbuf_addf(&sb, " %s%s\n", message, reset);
+		strbuf_addf(&sb, " %s\n", message);
 	else
-		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
-	fwrite(sb.buf, sb.len, 1, f);
+		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+	emit_line(o, meta, reset, sb.buf, sb.len);
 
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -495,7 +487,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+	show_submodule_header(o, path, one, two, dirty_submodule,
 			      meta, reset, &left, &right, &merge_bases);
 
 	/*
@@ -508,11 +500,12 @@ void show_submodule_summary(FILE *f, const char *path,
 
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
-		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		const char *error = "(revision walker failed)\n";
+		emit_line(o, NULL, NULL, error, strlen(error));
 		goto out;
 	}
 
-	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	print_submodule_summary(&rev, o, del, add, reset);
 
 out:
 	if (merge_bases)
@@ -521,20 +514,18 @@ void show_submodule_summary(FILE *f, const char *path,
 	clear_commit_marks(right, ~0);
 }
 
-void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *o)
+		const char *del, const char *add, const char *reset)
 {
 	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
-	struct strbuf submodule_dir = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
+	show_submodule_header(o, path, one, two, dirty_submodule,
 			      meta, reset, &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
@@ -547,15 +538,14 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 	if (right)
 		new = two;
 
-	fflush(f);
 	cp.git_cmd = 1;
 	cp.dir = path;
-	cp.out = dup(fileno(f));
+	cp.out = -1;
 	cp.no_stdin = 1;
 
 	/* TODO: other options may need to be passed here. */
 	argv_array_push(&cp.args, "diff");
-	argv_array_pushf(&cp.args, "--line-prefix=%s", line_prefix);
+	argv_array_pushf(&cp.args, "--line-prefix=%s", diff_line_prefix(o));
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
@@ -578,11 +568,21 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		argv_array_push(&cp.args, oid_to_hex(new));
 
 	prepare_submodule_repo_env(&cp.env_array);
-	if (run_command(&cp))
-		fprintf(f, "(diff failed)\n");
+	if (start_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		emit_line(o, NULL, NULL, error, strlen(error));
+	}
+
+	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
+		emit_line(o, NULL, NULL, sb.buf, sb.len);
+
+	if (finish_command(&cp)) {
+		const char *error = "(diff failed)\n";
+		emit_line(o, NULL, NULL, error, strlen(error));
+	}
 
 done:
-	strbuf_release(&submodule_dir);
+	strbuf_release(&sb);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	if (left)
diff --git a/submodule.h b/submodule.h
index 1277480add..9df0a3aea2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -53,17 +53,14 @@ extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
-extern void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+extern void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-extern void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+extern void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *opt);
+		const char *del, const char *add, const char *reset);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
 /* Check if we want to update any submodule.*/
-- 
2.13.0.18.g183880de0a

