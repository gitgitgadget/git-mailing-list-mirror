Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF81FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdFTCss (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:48 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36688 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdFTCsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:43 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so37277168pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WurRHAxvmDJOXfJkSe6x7XfH65JPglJQeSIACrpIzg=;
        b=lL+d2OMvynfGDnHVZ3XERjojTXDclPpQXsam1nP3yr82he1iKiUWWqE3ftUlg8rb2Q
         rH/Re4lmGCimTeRYQzoJ9ZpARGsZKdcSG4kiyarjeX8MUapwErKrBniGav7f0MxWOZFs
         QhOOTxiRPvOXCYsiLYexqTz7eQn1oXuYfv4dcL9swbDTHVBYWqlc8jJ4ACDlzMsM6YL+
         ugtp5VAUKgu2TRX38Dz4AW76aG0FKpu9CDV2Q8mk3oC9Jr+dx4pMmjR3ZXmyoho1S18U
         v2UQMaT/4uOdG82TzFyINKLxJd1vK0H/JYA0s2Na182Mh0tb7pjQApzXSwSNXxYhDQRD
         vQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WurRHAxvmDJOXfJkSe6x7XfH65JPglJQeSIACrpIzg=;
        b=ZZe09cHGgFvzPIdfGzKku72BP+HaE0X8zxXydEGZKN4KPqL5oFyIyH/9T1W6igNYSL
         S0D+A97QJLQi3X2n4drbvWTSMneEUfenhlAMLvJlpODnY1JJk76k3UyC+gBqY6z6vHi2
         s8ZXYxEkuWW3xJuMGSwuUNm23SGfQLdM9hJj2geKOlwdFXTc9QfZZ9xXvAWmyw50Nauh
         ha7tmUb0mY5KSj22qvk9pJJpw46mxZxlhHQY93l2gfasc/FIyG+t3PDYXvadba0o8pa8
         MSdNrLun9ugJEodUTnvJKmoV/54QujF9AJiT959sBMd3VRWUjsH8ewH8D7ajpSGSr7hb
         fl/Q==
X-Gm-Message-State: AKS2vOxoy9RmZmHfMXf+FmDnWFaRnwbfvq+aTyUEgozt06hD+3LtDTT3
        s8yTkHCbzRknGqiG
X-Received: by 10.98.8.81 with SMTP id c78mr28282426pfd.213.1497926922799;
        Mon, 19 Jun 2017 19:48:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id q68sm25432327pfj.40.2017.06.19.19.48.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 15/26] submodule.c: migrate diff output to use emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:48:05 -0700
Message-Id: <20170620024816.20021-16-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the submodule process is no longer attached to the same stdout as
the superprojects process, we need to pass coloring explicitly.

Remove the colors from the function signatures, as all the coloring
decisions will be made either inside the child process or the final
emit_diff_symbol.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 diff.h      |  9 +++++++
 submodule.c | 85 ++++++++++++++++++++++++++--------------------------------
 submodule.h | 13 +++------
 4 files changed, 128 insertions(+), 68 deletions(-)

diff --git a/diff.c b/diff.c
index 96ce53c5cf..42a9020d95 100644
--- a/diff.c
+++ b/diff.c
@@ -574,6 +574,13 @@ enum diff_symbol {
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_REWRITE_DIFF,
+	DIFF_SYMBOL_SUBMODULE_ADD,
+	DIFF_SYMBOL_SUBMODULE_DEL,
+	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
+	DIFF_SYMBOL_SUBMODULE_MODIFIED,
+	DIFF_SYMBOL_SUBMODULE_HEADER,
+	DIFF_SYMBOL_SUBMODULE_ERROR,
+	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
 };
 /*
  * Flags for content lines:
@@ -700,11 +707,77 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line(o, fraginfo, reset, line, len);
 		break;
+	case DIFF_SYMBOL_SUBMODULE_ADD:
+		set = diff_get_color_opt(o, DIFF_FILE_NEW);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, set, reset, line, len);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_DEL:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, set, reset, line, len);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_UNTRACKED:
+		fprintf(o->file, "%sSubmodule %s contains untracked content\n",
+			diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_MODIFIED:
+		fprintf(o->file, "%sSubmodule %s contains modified content\n",
+			diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_HEADER:
+		fprintf(o->file, "%s%s", diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_ERROR:
+		emit_line(o, "", "", line, len);
+		break;
+	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+		emit_line(o, "", "", line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
 }
 
+void diff_emit_submodule_del(struct diff_options *o, const char *line)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_DEL, line, strlen(line), 0);
+}
+
+void diff_emit_submodule_add(struct diff_options *o, const char *line)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_ADD, line, strlen(line), 0);
+}
+
+void diff_emit_submodule_untracked(struct diff_options *o, const char *path)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_UNTRACKED,
+			 path, strlen(path), 0);
+}
+
+void diff_emit_submodule_modified(struct diff_options *o, const char *path)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_MODIFIED,
+			 path, strlen(path), 0);
+}
+
+void diff_emit_submodule_header(struct diff_options *o, const char *header)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_HEADER,
+			 header, strlen(header), 0);
+}
+
+void diff_emit_submodule_error(struct diff_options *o, const char *err)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_ERROR, err, strlen(err), 0);
+}
+
+void diff_emit_submodule_pipethrough(struct diff_options *o,
+				     const char *line, int len)
+{
+	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_PIPETHROUGH, line, len, 0);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -2465,24 +2538,16 @@ static void builtin_diff(const char *name_a,
 	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
 	    (!one->mode || S_ISGITLINK(one->mode)) &&
 	    (!two->mode || S_ISGITLINK(two->mode))) {
-		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
-		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
-				two->dirty_submodule,
-				meta, del, add, reset);
+				two->dirty_submodule);
 		return;
 	} else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
 		   (!one->mode || S_ISGITLINK(one->mode)) &&
 		   (!two->mode || S_ISGITLINK(two->mode))) {
-		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
-		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_inline_diff(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
-				two->dirty_submodule,
-				meta, del, add, reset, o);
+				two->dirty_submodule);
 		return;
 	}
 
diff --git a/diff.h b/diff.h
index 8483ca0991..2ee0ef3908 100644
--- a/diff.h
+++ b/diff.h
@@ -188,6 +188,15 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void diff_emit_submodule_del(struct diff_options *o, const char *line);
+void diff_emit_submodule_add(struct diff_options *o, const char *line);
+void diff_emit_submodule_untracked(struct diff_options *o, const char *path);
+void diff_emit_submodule_modified(struct diff_options *o, const char *path);
+void diff_emit_submodule_header(struct diff_options *o, const char *header);
+void diff_emit_submodule_error(struct diff_options *o, const char *err);
+void diff_emit_submodule_pipethrough(struct diff_options *o,
+				     const char *line, int len);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index d3299e29c0..71471f3241 100644
--- a/submodule.c
+++ b/submodule.c
@@ -362,9 +362,7 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *line_prefix,
-		const char *del, const char *add, const char *reset)
+static void print_submodule_summary(struct rev_info *rev, struct diff_options *o)
 {
 	static const char format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
@@ -375,18 +373,12 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
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
+			diff_emit_submodule_del(o, sb.buf);
+		else
+			diff_emit_submodule_add(o, sb.buf);
 	}
 	strbuf_release(&sb);
 }
@@ -413,11 +405,9 @@ void prepare_submodule_repo_env(struct argv_array *out)
  * attempt to lookup both the left and right commits and put them into the
  * left and right pointers.
  */
-static void show_submodule_header(FILE *f, const char *path,
-		const char *line_prefix,
+static void show_submodule_header(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule, const char *meta,
-		const char *reset,
+		unsigned dirty_submodule,
 		struct commit **left, struct commit **right,
 		struct commit_list **merge_bases)
 {
@@ -426,11 +416,10 @@ static void show_submodule_header(FILE *f, const char *path,
 	int fast_forward = 0, fast_backward = 0;
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
+		diff_emit_submodule_untracked(o, path);
+
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+		diff_emit_submodule_modified(o, path);
 
 	if (is_null_oid(one))
 		message = "(new submodule)";
@@ -472,31 +461,29 @@ static void show_submodule_header(FILE *f, const char *path,
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
+	diff_emit_submodule_header(o, sb.buf);
 
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset)
+		unsigned dirty_submodule)
 {
 	struct rev_info rev;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
-			      meta, reset, &left, &right, &merge_bases);
+	show_submodule_header(o, path, one, two, dirty_submodule,
+			      &left, &right, &merge_bases);
 
 	/*
 	 * If we don't have both a left and a right pointer, there is no
@@ -508,11 +495,11 @@ void show_submodule_summary(FILE *f, const char *path,
 
 	/* Treat revision walker failure the same as missing commits */
 	if (prepare_submodule_summary(&rev, path, left, right, merge_bases)) {
-		fprintf(f, "%s(revision walker failed)\n", line_prefix);
+		diff_emit_submodule_error(o, "(revision walker failed)\n");
 		goto out;
 	}
 
-	print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+	print_submodule_summary(&rev, o);
 
 out:
 	if (merge_bases)
@@ -521,21 +508,18 @@ void show_submodule_summary(FILE *f, const char *path,
 	clear_commit_marks(right, ~0);
 }
 
-void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *o)
+		unsigned dirty_submodule)
 {
 	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
-	struct strbuf submodule_dir = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
-	show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
-			      meta, reset, &left, &right, &merge_bases);
+	show_submodule_header(o, path, one, two, dirty_submodule,
+			      &left, &right, &merge_bases);
 
 	/* We need a valid left and right commit to display a difference */
 	if (!(left || is_null_oid(one)) ||
@@ -547,15 +531,16 @@ void show_submodule_inline_diff(FILE *f, const char *path,
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
+	argv_array_pushf(&cp.args, "--color=%s", want_color(o->use_color) ?
+			 "always" : "never");
+
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
@@ -578,11 +563,17 @@ void show_submodule_inline_diff(FILE *f, const char *path,
 		argv_array_push(&cp.args, oid_to_hex(new));
 
 	prepare_submodule_repo_env(&cp.env_array);
-	if (run_command(&cp))
-		fprintf(f, "(diff failed)\n");
+	if (start_command(&cp))
+		diff_emit_submodule_error(o, "(diff failed)\n");
+
+	while (strbuf_getwholeline_fd(&sb, cp.out, '\n') != EOF)
+		diff_emit_submodule_pipethrough(o, sb.buf, sb.len);
+
+	if (finish_command(&cp))
+		diff_emit_submodule_error(o, "(diff failed)\n");
 
 done:
-	strbuf_release(&submodule_dir);
+	strbuf_release(&sb);
 	if (merge_bases)
 		free_commit_list(merge_bases);
 	if (left)
diff --git a/submodule.h b/submodule.h
index 1277480add..e7358863e9 100644
--- a/submodule.h
+++ b/submodule.h
@@ -53,17 +53,12 @@ extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
-extern void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+extern void show_submodule_summary(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset);
-extern void show_submodule_inline_diff(FILE *f, const char *path,
-		const char *line_prefix,
+		unsigned dirty_submodule);
+extern void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule, const char *meta,
-		const char *del, const char *add, const char *reset,
-		const struct diff_options *opt);
+		unsigned dirty_submodule);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
 /* Check if we want to update any submodule.*/
-- 
2.12.2.575.gb14f27f917

