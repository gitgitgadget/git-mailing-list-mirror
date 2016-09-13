Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60B2220985
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbcIMEqu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36493 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbcIMEqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:36 -0400
Received: by mail-pa0-f53.google.com with SMTP id id6so57732182pad.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Q8aik+lo1Fk/jzTZqM4zvjdZsY/E6INBs5gOpuBbYI=;
        b=VIOXJeIn9F+HQvvwCcjqVHwORYV5xBmMVmOHmlcgOcI45BFNp8X/EtjGb87oWvQnTS
         1jktqDn2HFsCkkVEwDp08Bbb8AAJND4CxLVTJgO1U/TXWJWzIywTKV7TAgihxe5LSxug
         ArSGLOF8hUw6SW0XqU8hfUYcCY7fZcQAL06E4/zDPRpONT2VM/NEmUiQaZWu4RKyhZ2a
         qInckTybAwbpLjJ2cF2X5VKILKg/rD9jcutrjnu5XBqfGeFxyQqDqO7s8Ed5OUS/zgzv
         MyEBpGAli93rvhy56M3Y04WogZIZOuJsmBhmLE6ea5rfFEPuS5cDhietiGFDYsjJhvSR
         gvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Q8aik+lo1Fk/jzTZqM4zvjdZsY/E6INBs5gOpuBbYI=;
        b=FC1HU/BCiaUP8OsMhHbSt766QHwebx/Ua/816kfJdCskLxakef5sdvL9Ih/cfr71fl
         owyi9Ibok0SvNzLRzOHSVgUNL+/JIcvItYSz/jirJISehy9Lg4s4Pr2oPQbmUy9e3G7d
         F5CQNvCmKkNIGuU5dcN65c8OjX/brTY8rDt1EjwB0uabz+BKEV9YBJPytJ684T4EorVU
         hlvKwkLOzYt7wBb2Mpu4xnh8+Li2R9/KclqM75iQPJoj05RBVXL2MLkjpZANVytJhaUD
         cKPckxwrwlLaIow3GVqSYJTTANg+0c/tuqZFRW3RK7KMXOdluF6+CgdR63/7vSYSIMrG
         39Yg==
X-Gm-Message-State: AE9vXwOKumUkikN5Z1xHT+yTRYRynSPsDLlWwRT5jJ4SBJ0fR/oY2084pz41yDgj7juiKRHr
X-Received: by 10.66.164.227 with SMTP id yt3mr39882274pab.117.1473741995362;
        Mon, 12 Sep 2016 21:46:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id p74sm27772419pfk.68.2016.09.12.21.46.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 10/17] submodule.c: convert show_submodule_summary to use emit_line_fmt
Date:   Mon, 12 Sep 2016 21:46:06 -0700
Message-Id: <20160913044613.1037-11-sbeller@google.com>
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

This prepares the code for submodules to go through the
emit_line_0 function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c      |  5 ++---
 diff.h      |  3 +++
 submodule.c | 42 +++++++++++++++++-------------------------
 submodule.h |  3 +--
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 3aa99d1..1892c2b 100644
--- a/diff.c
+++ b/diff.c
@@ -493,7 +493,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
-static void emit_line_fmt(struct diff_options *o,
+void emit_line_fmt(struct diff_options *o,
 			  const char *set, const char *reset,
 			  const char *fmt, ...)
 {
@@ -2306,8 +2306,7 @@ static void builtin_diff(const char *name_a,
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				one->oid.hash, two->oid.hash,
 				two->dirty_submodule,
 				meta, del, add, reset);
diff --git a/diff.h b/diff.h
index 7883729..1699d9c 100644
--- a/diff.h
+++ b/diff.h
@@ -180,6 +180,9 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
+		   const char *fmt, ...);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index 1b5cdfb..c817b46 100644
--- a/submodule.c
+++ b/submodule.c
@@ -304,8 +304,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *line_prefix,
+static void print_submodule_summary(struct rev_info *rev,
+		struct diff_options *o,
 		const char *del, const char *add, const char *reset)
 {
 	static const char format[] = "  %m %s";
@@ -317,24 +317,16 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
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
-		strbuf_addch(&sb, '\n');
-		fprintf(f, "%s", sb.buf);
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			emit_line_fmt(o, del, reset, "%s\n", sb.buf);
+		else if (add)
+			emit_line_fmt(o, add, reset, "%s\n", sb.buf);
 	}
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -359,30 +351,30 @@ void show_submodule_summary(FILE *f, const char *path,
 		message = "(revision walker failed)";
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
+		emit_line_fmt(o, 0, 0,
+			      "Submodule %s contains untracked content\n", path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+		emit_line_fmt(o, 0, 0,
+			      "Submodule %s contains modified content\n", path);
 
 	if (!hashcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
-	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
-			find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "Submodule %s %s..", path,
+		    find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
 	if (message)
-		strbuf_addf(&sb, " %s%s\n", message, reset);
+		strbuf_addf(&sb, " %s\n", message);
 	else
-		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
-	fwrite(sb.buf, sb.len, 1, f);
+		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+	emit_line_fmt(o, meta, reset, "%s", sb.buf);
 
 	if (!message) /* only NULL if we succeeded in setting up the walk */
-		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+		print_submodule_summary(&rev, o, del, add, reset);
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
diff --git a/submodule.h b/submodule.h
index 2af9390..fefc0ab 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,8 +41,7 @@ int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-- 
2.10.0.21.g1da280f.dirty

