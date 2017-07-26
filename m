Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1652E2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbdGZXEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:04:34 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37852 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdGZXEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:04:33 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so89918136pgy.4
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uzp0g8YgA3fggoIwRKKRYRWkhyklMHUckEFZrgAEib8=;
        b=kAStd19HQ6KSRPoz8iWnqQcAWkN/KjQ+qzZ7nZOKcaIIS8+WkIGojlAEycJFf0tDUD
         8KfpGuJSoIZk05czlZ0aWj7c7Vz32PiqVMaMUwnbm90o98X8+jFNhr05Mrmfa+J4Budf
         FkC3bKV0l4S+ktN0pcKqBnhg2Eb/e2+7OltZ2N7EGRAcFMDHPe/Ov/Hn8w+4UT3f2NaP
         zhGva3s8ghWDCKsjcVh+9N71mmCW1jYoMdVnZymbnbBsbE0CJrlPptm9O4QEhZBACQGn
         dx+Rwd+SUi/BcjlLvAQUQ/gXghXp/l4PBdHG7t8WaZrcC8ygjxbLdBblTBKwoHwlq7HN
         WrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uzp0g8YgA3fggoIwRKKRYRWkhyklMHUckEFZrgAEib8=;
        b=GoSATaEI4vQiFsUQoTguFiB5CMBf5VGva5pAzpaaOcA0mSmQTd+SV6MEVkrab7WmQ5
         latnFyohJC5XnZAxjomU8BwdVOw7ItLUgJcbzQa0QO/z4CprBB3DccjWSQeORq2kZE7b
         9T2pl7XA40TW2bBv9d8UmmSUam+7+B+i5EPLIqh7Y1D8AntEX+R0N6f0qq8qgQLM+FEQ
         6f1gsXF8vPyt/1lpyLp4Pry1zff3iVPmTE5ACHjyjSs6uKcNjtn4aWNNiDQ4wUCrS8S0
         ZxEZKNBPV/leZwlTybI/oPsu9wJ1i9TyhyCiFnKWb1SRymlt/7E7sFCxc738W/CuJosC
         oNDw==
X-Gm-Message-State: AIVw110B4m7LxJqQY/C2E6Fthu55FZ1fx3wRsvw44a5m7UzZZ4yBepMu
        ULDt/Jl7b6PicQut
X-Received: by 10.84.217.19 with SMTP id o19mr2330771pli.305.1501110272226;
        Wed, 26 Jul 2017 16:04:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b827:7828:2b7f:c1e7])
        by smtp.gmail.com with ESMTPSA id f66sm9234358pfc.114.2017.07.26.16.04.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:04:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCHv2] builtin/blame: highlight interesting things
Date:   Wed, 26 Jul 2017 16:04:25 -0700
Message-Id: <20170726230425.24307-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170613023151.9688-1-sbeller@google.com>
References: <20170613023151.9688-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git-blame lots of lines contain redundant information, for
example in hunks that consist of multiple lines, the metadata (commit name,
author) are repeated. A reader may not be interested in those, so darken
(commit, author) information that is the same as in the previous line.

Choose a different approach for dates and imitate a 'temperature cool down'
for the dates. Compute the time range of all involved blamed commits
and then color
 * lines of old commits dark (aged 0-50% in that time range)
 * lines of medium age normal (50-80%)
 * lines of new age red (80-95%)
 * lines just introduced bright yellow (95-100%)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  I played around with it a bit more, using a different color scheme
  for dates, http://i.imgur.com/redhaLi.png


 builtin/blame.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++----------
 color.h         |   1 +
 2 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78726..552ea8e6f7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -7,6 +7,7 @@
 
 #include "cache.h"
 #include "config.h"
+#include "color.h"
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
@@ -283,11 +284,14 @@ static void found_guilty_entry(struct blame_entry *ent, void *data)
 }
 
 static const char *format_time(timestamp_t time, const char *tz_str,
-			       int show_raw_time)
+			       int show_raw_time, const char *color,
+			       const char *reset)
 {
 	static struct strbuf time_buf = STRBUF_INIT;
 
 	strbuf_reset(&time_buf);
+	if (color)
+		strbuf_addstr(&time_buf, color);
 	if (show_raw_time) {
 		strbuf_addf(&time_buf, "%"PRItime" %s", time, tz_str);
 	}
@@ -307,6 +311,8 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 		     time_width++)
 			strbuf_addch(&time_buf, ' ');
 	}
+	if (reset)
+		strbuf_addstr(&time_buf, reset);
 	return time_buf.buf;
 }
 
@@ -319,7 +325,8 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_SHOW_SCORE      0100
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
-#define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_LINE_PORCELAIN	01000
+#define OUTPUT_SHOW_HIGHLIGHT	02000
 
 static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 {
@@ -367,19 +374,62 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb,
+		       struct blame_entry *ent,
+		       struct blame_entry *prev,
+		       int opt,
+		       timestamp_t min_t,
+		       timestamp_t max_t)
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
+	const char *date_color = NULL;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
 	cp = blame_nth_line(sb, ent->lno);
+
+	commit_info_init(&prev_ci);
+	if ((opt & OUTPUT_SHOW_HIGHLIGHT) && prev) {
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
+	if (opt & OUTPUT_SHOW_HIGHLIGHT) {
+		if (max_t == min_t) {
+			date_color = GIT_COLOR_NORMAL;
+		} else {
+			float score = 1.0 * (ci.author_time - min_t);
+			score /= (1.0 * (max_t - min_t));
+			if (score > 0.95)
+				date_color = GIT_COLOR_BOLD_YELLOW;
+			else if (score > 0.8)
+				date_color = GIT_COLOR_RED;
+			else if (score > 0.5)
+				date_color = GIT_COLOR_NORMAL;
+			else
+				date_color = GIT_COLOR_DARK;
+		}
+	}
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
@@ -392,8 +442,12 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				putchar('^');
 			}
 		}
+		use_color = GIT_COLOR_NORMAL;
+		if ((opt & OUTPUT_SHOW_HIGHLIGHT) && cnt > 0)
+			use_color = GIT_COLOR_DARK;
+
+		printf("%s%.*s%s", use_color, length, hex, reset_color);
 
-		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
@@ -402,20 +456,36 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 				name = ci.author.buf;
 			printf("\t(%10s\t%10s\t%d)", name,
 			       format_time(ci.author_time, ci.author_tz.buf,
-					   show_raw_time),
+					   show_raw_time, NULL, NULL),
 			       ent->lno + 1 + cnt);
 		} else {
-			if (opt & OUTPUT_SHOW_SCORE)
-				printf(" %*d %02d",
+			if (opt & OUTPUT_SHOW_SCORE) {
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_HIGHLIGHT) &&
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
+				if ((opt & OUTPUT_SHOW_HIGHLIGHT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_SHOW_NAME))
+					use_color = GIT_COLOR_DARK;
+				printf(" %s%-*.*s%s", use_color, longest_file,
+						      longest_file,
+						      suspect->path,
+						      reset_color);
+			}
+			if (opt & OUTPUT_SHOW_NUMBER) {
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_HIGHLIGHT) &&
+				    (cnt > 0 || prev_same_field & OUTPUT_SHOW_NUMBER))
+					use_color = GIT_COLOR_DARK;
+				printf(" %s%*d%s", use_color, max_orig_digits,
+				       ent->s_lno + 1 + cnt, reset_color);
+			}
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -423,12 +493,21 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
+
+				use_color = GIT_COLOR_NORMAL;
+				if ((opt & OUTPUT_SHOW_HIGHLIGHT) &&
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
+							    date_color,
+							    reset_color));
 			}
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
@@ -448,7 +527,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 static void output(struct blame_scoreboard *sb, int option)
 {
-	struct blame_entry *ent;
+	struct blame_entry *ent, *prev = NULL;
+	timestamp_t min_t = TIME_MAX, max_t = 0;
 
 	if (option & OUTPUT_PORCELAIN) {
 		for (ent = sb->ent; ent; ent = ent->next) {
@@ -466,11 +546,24 @@ static void output(struct blame_scoreboard *sb, int option)
 		}
 	}
 
+	if (option & OUTPUT_SHOW_HIGHLIGHT) {
+		/* find oldest and youngest date for timestamp coloring */
+		struct commit_info ci;
+		for (ent = sb->ent; ent; ent = ent->next) {
+			get_commit_info(ent->suspect->commit, &ci, 1);
+			if (ci.author_time < min_t)
+				min_t = ci.author_time;
+			if (ci.author_time > max_t)
+				max_t = ci.author_time;
+		}
+	}
+
 	for (ent = sb->ent; ent; ent = ent->next) {
 		if (option & OUTPUT_PORCELAIN)
 			emit_porcelain(sb, ent, option);
 		else {
-			emit_other(sb, ent, option);
+			emit_other(sb, ent, prev, option, min_t, max_t);
+			prev = ent;
 		}
 	}
 }
@@ -681,6 +774,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
+		OPT_BIT('h', "highlights", &output_option, N_("darken redundancy from previous line; highlight dates (Default: off)"), OUTPUT_SHOW_HIGHLIGHT),
 
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
2.14.0.rc0.3.g6c2e499285

