Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526C120985
	for <e@80x24.org>; Tue, 13 Sep 2016 04:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbcIMErC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:47:02 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34058 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcIMEqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:45 -0400
Received: by mail-pa0-f44.google.com with SMTP id wk8so3854978pab.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zH0S4BjGDbvH8QLeNze33zG+CYNlSJ0jFjDXUNXeeDs=;
        b=CUY0lVH9ZcTnHOIX/tTINAPHkCZDHtxu1k2O8tNZC3tnlW/uOA6GtFqHbhuO6wx80q
         CPawQBc+fUGLdwHAnqG9ocx6C6Z/v45XeUMn/LRovtG74zj85ljWVBvTg5pQhGrttuIJ
         HOEwN7BdnFowJwExMhzNaKoRmekfxhNN1juEujEd4BrJOAKYxYGM9fglcDbU3SVxURYa
         Rb0OUwJaVQ63smWgrPNU9bLC1MZ7MMOk5Uq4V6d1QEr4ixWoPQf5PcmWDpk1WnhIwn6i
         8uCOCtRwcBWk5KXkzi0fDcx+pjCayVrAkfMlNtM+lZa7nVS270Hx8Oumx97U4r5DYJI2
         auhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zH0S4BjGDbvH8QLeNze33zG+CYNlSJ0jFjDXUNXeeDs=;
        b=l5yZmlblH/LFCES7j3OT4PGOUSfssgAZ7mvjFxq0DITXxepyoQfb0PT2IROJoEBTa6
         1f8qIR1vIBS9W80xOotvr3j1O+buQN1gE5xiTNZ0j7689qgfvfTsv2Ck+UO+GqXbGPMe
         gjjW5FYJpJRdrUepRkXTKPhOmsTwpMuUa5+XQapnMHatHQGl+SKD7HDjBbnQdT/W9XIO
         CC7/FZ08FDFS/uvvc3LIgn6cY2JjRQda0SI6MWvYzyC4DXOFtcCRmt53gNLlt+luXOnR
         BZsko7FgWtw4sZdx0624s+4kUD42Xg2ITCvO2J3bfSv6apqqDWegdMUbsXUdqIOGhl1B
         Eg4Q==
X-Gm-Message-State: AE9vXwOFzhSvaWSFKfkTlsiKMcET/LbEAZqjsF4s4iSZw2FL8WC/3UGK3Ls7tNKbAqLuR8ct
X-Received: by 10.66.180.111 with SMTP id dn15mr8915834pac.125.1473742004786;
        Mon, 12 Sep 2016 21:46:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id e72sm27792016pfb.49.2016.09.12.21.46.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 15/17] diff.c: convert diff_summary to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:11 -0700
Message-Id: <20160913044613.1037-16-sbeller@google.com>
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

This covers diff_summary.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 62 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index 2b1ebcc..68da135 100644
--- a/diff.c
+++ b/diff.c
@@ -4382,67 +4382,71 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 	}
 }
 
-static void show_file_mode_name(FILE *file, const char *newdelete, struct diff_filespec *fs)
+static void show_file_mode_name(struct diff_options *opt, const char *newdelete, struct diff_filespec *fs)
 {
+	struct strbuf sb = STRBUF_INIT;
 	if (fs->mode)
-		fprintf(file, " %s mode %06o ", newdelete, fs->mode);
+		strbuf_addf(&sb, " %s mode %06o ", newdelete, fs->mode);
 	else
-		fprintf(file, " %s ", newdelete);
-	write_name_quoted(fs->path, file, '\n');
+		strbuf_addf(&sb, " %s ", newdelete);
+
+	quote_c_style(fs->path, &sb, NULL, 0);
+	strbuf_addch(&sb, '\n');
+	emit_line(opt, NULL, NULL, sb.buf, sb.len);
+	strbuf_release(&sb);
 }
 
 
-static void show_mode_change(FILE *file, struct diff_filepair *p, int show_name,
-		const char *line_prefix)
+static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
+		int show_name)
 {
 	if (p->one->mode && p->two->mode && p->one->mode != p->two->mode) {
-		fprintf(file, "%s mode change %06o => %06o%c", line_prefix, p->one->mode,
-			p->two->mode, show_name ? ' ' : '\n');
+		struct strbuf sb = STRBUF_INIT;
 		if (show_name) {
-			write_name_quoted(p->two->path, file, '\n');
+			strbuf_addch(&sb, ' ');
+			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		emit_line_fmt(opt, NULL, NULL,
+			      " mode change %06o => %06o%s\n",
+			      p->one->mode, p->two->mode,
+			      show_name ? sb.buf : "");
+		strbuf_release(&sb);
 	}
 }
 
-static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_filepair *p,
-			const char *line_prefix)
+static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
+		struct diff_filepair *p)
 {
 	char *names = pprint_rename(p->one->path, p->two->path);
-
-	fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
+	emit_line_fmt(opt, NULL, NULL, " %s %s (%d%%)\n", renamecopy, names, similarity_index(p));
 	free(names);
-	show_mode_change(file, p, 0, line_prefix);
+	show_mode_change(opt, p, 0);
 }
 
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
-	FILE *file = opt->file;
-	const char *line_prefix = diff_line_prefix(opt);
-
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "delete", p->one);
+		show_file_mode_name(opt, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
-		fputs(line_prefix, file);
-		show_file_mode_name(file, "create", p->two);
+		show_file_mode_name(opt, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "copy", p, line_prefix);
+		show_rename_copy(opt, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
-		fputs(line_prefix, file);
-		show_rename_copy(file, "rename", p, line_prefix);
+		show_rename_copy(opt, "rename", p);
 		break;
 	default:
 		if (p->score) {
-			fprintf(file, "%s rewrite ", line_prefix);
-			write_name_quoted(p->two->path, file, ' ');
-			fprintf(file, "(%d%%)\n", similarity_index(p));
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addstr(&sb, " rewrite ");
+			quote_c_style(p->two->path, &sb, NULL, 0);
+			strbuf_addf(&sb, " (%d%%)\n", similarity_index(p));
+			emit_line(opt, NULL, NULL, sb.buf, sb.len);
 		}
-		show_mode_change(file, p, !p->score, line_prefix);
+		show_mode_change(opt, p, !p->score);
 		break;
 	}
 }
-- 
2.10.0.21.g1da280f.dirty

