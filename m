Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E7620401
	for <e@80x24.org>; Tue, 13 Jun 2017 02:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbdFMCb4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 22:31:56 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33442 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdFMCbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 22:31:55 -0400
Received: by mail-pg0-f51.google.com with SMTP id f185so53242107pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iBmLeIstupnBjNdM03gOoiS/XMa6MMUvme3HXwK4lFE=;
        b=jVTDEEhmDgYVhcOYfwjmCB6ZNALzxlrG4kwYKDaHqDhlHWW7fPVoZgUkT0jnqHnFqW
         p6juvMYMjVEEBwgjp3oY/h8tL1NC6Q+CxPXMyuntnA7qZE7wAxWT7aM7VIsFO7n+h6uh
         XgzdzJeZXw2B31G+n4rdy4/ma+eQiCOuIujzhdf5p7pWZ3tDVqyi+99JWlzI5KAHz5Fg
         feStDmKxf0/XSwk4a3VbAp8I7A6G2A99SFvQQH0rzcLEHZa9vLwEKVjFP7VMpE09oJaW
         b7ud0JZTK7Z8jSf0lpU9JDWedBiSyGmAPls5CDpxLMpI5kTQbf/ZtmWtSDSXSxMCYTdf
         eWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iBmLeIstupnBjNdM03gOoiS/XMa6MMUvme3HXwK4lFE=;
        b=PfLA0uSTGxVUpFnxsJzqlgq2H51NB8FXuzTHIkWv1ha3Th4SXUQj8226+b9QchbN+z
         V1sljyz85cwBDc99h0baBw/3Nzq7c8hkEravd/eJiFahHH1yGzLNFIUbOIWtI8MdGIA+
         U2c4wWrrepGmj8NeVgPoRyQQ3DWfKeKerJ/OXp7H9d0PZ5uiUbichauQu8zzSQiBsUz0
         aGTS4u9g+AbCQwX0eBQPmdqUp6aAGI+dYp3pg/Ws/zIVOhPRBCBBBNkdteDr5AKnR2fX
         hlMT6wUWMfPbOVrya9jmgFoKvLFu1PMcfL+yzPp6owZqbGkXyu+7lVdS2BZrQsPI3Ay8
         c4Ow==
X-Gm-Message-State: AKS2vOxM7JlmloSHJUwRoFYd08h6FCNV0o4XNxX64xFxOaMXG+97e1s0
        px3Ru32Qo0HWcxah59gDDQ==
X-Received: by 10.84.129.4 with SMTP id 4mr16154589plb.9.1497321114119;
        Mon, 12 Jun 2017 19:31:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d85:5ee9:13d8:3666])
        by smtp.gmail.com with ESMTPSA id n4sm21419532pgt.3.2017.06.12.19.31.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 19:31:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] builtin/blame: darken redundant line information
Date:   Mon, 12 Jun 2017 19:31:51 -0700
Message-Id: <20170613023151.9688-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gf3d7728391
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-blame lots of lines contain redundant information, for
example in hunks that consist of multiple lines, the metadata (commit name,
author, timezone) are repeated. A reader may not be interested in those,
so darken them. The darkening is not just based on hunk, but actually
takes the previous lines content for that field to compare to.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Example output (blame of blame): http://i.imgur.com/0Y12p2f.png

 builtin/blame.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++----------
 color.h         |   1 +
 2 files changed, 112 insertions(+), 24 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index d7a2df3b47..7f921df0e7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,6 +6,7 @@
  */
 
 #include "cache.h"
+#include "color.h"
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
@@ -282,7 +283,8 @@ static void found_guilty_entry(struct blame_entry *ent, void *data)
 }
 
 static const char *format_time(timestamp_t time, const char *tz_str,
-			       int show_raw_time)
+			       int show_raw_time,
+			       timestamp_t difftime, const char *difftz_str)
 {
 	static struct strbuf time_buf = STRBUF_INIT;
 
@@ -291,12 +293,41 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 		strbuf_addf(&time_buf, "%"PRItime" %s", time, tz_str);
 	}
 	else {
-		const char *time_str;
+		const char *time_str, *prev_str;
 		size_t time_width;
 		int tz;
+
+		if (difftime)
+			prev_str = xstrdup(show_date(difftime,
+						     atoi(difftz_str),
+						     &blame_date_mode));
 		tz = atoi(tz_str);
 		time_str = show_date(time, tz, &blame_date_mode);
-		strbuf_addstr(&time_buf, time_str);
+
+
+		if (difftime) {
+			int len = strlen(prev_str) > strlen(time_str) ?
+				  strlen(time_str) : strlen(prev_str);
+			int i, j;
+			int last_nondigit = 0;
+			for (i = 0; i < len; i++) {
+				if (isdigit(time_str[i]) &&
+				    time_str[i] != prev_str[i])
+					break;
+				if (!isdigit(time_str[i])) {
+					strbuf_addstr(&time_buf, GIT_COLOR_DARK);
+					for (j = last_nondigit; j < i; j++)
+						strbuf_addch(&time_buf, time_str[j]);
+					strbuf_addstr(&time_buf, GIT_COLOR_RESET);
+					last_nondigit = i;
+				}
+			}
+			for (i = last_nondigit; i < strlen(time_str); i++)
+				strbuf_addch(&time_buf, time_str[i]);
+		} else {
+			strbuf_addstr(&time_buf, time_str);
+		}
+
 		/*
 		 * Add space paddings to time_buf to display a fixed width
 		 * string, and use time_width for display width calibration.
@@ -319,6 +350,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_SHOW_REDUNDANT 02000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -366,19 +398,43 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb,
+		       struct blame_entry *ent,
+		       struct blame_entry *prev,
+		       int opt)
 {
 	int cnt;
 	const char *cp;
 	struct blame_origin *suspect = ent->suspect;
-	struct commit_info ci;
+	struct commit_info ci, prev_ci;
 	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int prev_same_field = 0;
+	const char *use_color, *reset_color = GIT_COLOR_RESET;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	commit_info_init(&prev_ci);
+	if ((opt & OUTPUT_SHOW_REDUNDANT) && prev) {
+		get_commit_info(prev->suspect->commit, &prev_ci, 1);
+		if ((opt & OUTPUT_SHOW_SCORE) && ent->score == prev->score)
+			prev_same_field |= OUTPUT_SHOW_SCORE;
+		if ((opt & OUTPUT_SHOW_NAME) && prev->suspect && !strcmp(suspect->path, prev->suspect->path))
+			prev_same_field |= OUTPUT_SHOW_NAME;
+		if ((opt & OUTPUT_SHOW_NUMBER) &&
+		    ent->s_lno == prev->s_lno + prev->num_lines - 1)
+			prev_same_field |= OUTPUT_SHOW_NUMBER;
+		if (!(opt & OUTPUT_NO_AUTHOR)) {
+			if (((opt & OUTPUT_SHOW_EMAIL) &&
+			     !strcmp(ci.author_mail.buf, prev_ci.author_mail.buf)) ||
+			    !strcmp(ci.author.buf, prev_ci.author.buf))
+				prev_same_field |= OUTPUT_NO_AUTHOR;
+		}
+	}
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -391,8 +447,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				putchar('^');
 			}
 		}
+		use_color = GIT_COLOR_NORMAL;
+		if ((opt & OUTPUT_SHOW_REDUNDANT) && cnt > 0)
+			use_color = GIT_COLOR_DARK;
+
+		printf("%s%.*s%s", use_color, length, hex, reset_color);
 
-		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
@@ -401,20 +461,36 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				name = ci.author.buf;
 			printf("\t(%10s\t%10s\t%d)", name,
 			       format_time(ci.author_time, ci.author_tz.buf,
-					   show_raw_time),
+					   show_raw_time, 0, NULL),
 			       ent->lno + 1 + cnt);
 		} else {
-			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
+			if (opt & OUTPUT_SHOW_SCORE) {
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_REDUNDANT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_SHOW_SCORE))
+					use_color = GIT_COLOR_DARK;
+				printf(" %s%*d %02d%s", use_color,
 				       max_score_digits, ent->score,
-				       ent->suspect->refcnt);
-			if (opt & OUTPUT_SHOW_NAME)
-				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
-			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
-
+				       ent->suspect->refcnt, reset_color);
+			}
+			if (opt & OUTPUT_SHOW_NAME) {
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_REDUNDANT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_SHOW_NAME))
+					use_color = GIT_COLOR_DARK;
+				printf(" %s%-*.*s%s", use_color, longest_file,
+						      longest_file,
+						      suspect->path,
+						      reset_color);
+			}
+			if (opt & OUTPUT_SHOW_NUMBER) {
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_REDUNDANT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_SHOW_NUMBER))
+					use_color = GIT_COLOR_DARK;
+				printf(" %s%*d%s", use_color, max_orig_digits,
+				       ent->s_lno + 1 + cnt, reset_color);
+			}
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -422,12 +498,21 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
+
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_REDUNDANT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_NO_AUTHOR))
+					use_color = GIT_COLOR_DARK;
+
 				pad = longest_author - utf8_strwidth(name);
-				printf(" (%s%*s %10s",
-				       name, pad, "",
-				       format_time(ci.author_time,
-						   ci.author_tz.buf,
-						   show_raw_time));
+				printf(" %s(%s%*s%s", use_color,
+						      name, pad, "",
+						      reset_color);
+				printf(" %10s", format_time(ci.author_time,
+							    ci.author_tz.buf,
+							    show_raw_time,
+							    prev_ci.author_time,
+							    prev_ci.author_tz.buf));
 			}
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
@@ -447,7 +532,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 static void output(struct blame_scoreboard *sb, int option)
 {
-	struct blame_entry *ent;
+	struct blame_entry *ent, *prev = NULL;
 
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
@@ -469,7 +554,8 @@ static void output(struct blame_scoreboard *sb, int option)
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent, option);
 		else {
-			emit_other(sb, ent, option);
+			emit_other(sb, ent, prev, option);
+			prev = ent;
 		}
 	}
 }
@@ -680,6 +766,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT('r', "redundant", &output_option, N_("darken redundancy from previous line (Default: off)"), OUTPUT_SHOW_REDUNDANT),
 
 		/*
 		 * The following two options are parsed by parse_revision_opt()
diff --git a/color.h b/color.h
index 90627650fc..bad2d7e29c 100644
--- a/color.h
+++ b/color.h
@@ -30,6 +30,7 @@ struct strbuf;
 #define GIT_COLOR_BLUE		"\033[34m"
 #define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
+#define GIT_COLOR_DARK		"\033[1;30m"
 #define GIT_COLOR_BOLD_RED	"\033[1;31m"
 #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
 #define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"
-- 
2.13.0.17.gf3d7728391

