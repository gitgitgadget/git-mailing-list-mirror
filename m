Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F64220188
	for <e@80x24.org>; Sun, 14 May 2017 04:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbdENECC (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:02:02 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35702 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdENEBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:53 -0400
Received: by mail-pg0-f46.google.com with SMTP id q125so26488947pgq.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGOGLr86jtZ1iu6t5oOgqHj1JeecXeb5VE+Ys4XNXOs=;
        b=cbPoyp6EERBJvYxGSQRAx6iT03dQ2imZtIMSc1DoF4PU6W8ZcLBdPIu4Q2oTZGCnZI
         qWv9tRCkrBLoeA3wH2/MKzG4kKMbR/3j1uvKcC2VB+iBdRgYLdjDRb8pzdsaMY9O8InT
         WpErQeojiQoKtY96iu5/Wv66UF0GOr9dnODzqgaUFkdXc/OfAlIbXBt7X/weO4hFWMWM
         mgs0HRogX1x4Zf0rnL3+wDdfVN+HZyJgmlVd3Ov0klfmQVFtpPtDedOlBBDToTnUtp/1
         juPWkU8moZsLD/VK0/uZiRIpntYyjCiGWR8lE0v7fqLdYFtvemAIdwj7hA9diEg/tHaB
         35lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGOGLr86jtZ1iu6t5oOgqHj1JeecXeb5VE+Ys4XNXOs=;
        b=rSwRHDKzyGDi7Zz+C5t5CF3+Alz3K2OKdfkwOWO0SBpjIOzF9u2f78EG2vCuRuiXVG
         zLGWo8uWJmYvO834uFiTOkdqioONc3Nq4cRpTlNDifLrXYidNUQHyS0B6DC1w/2csJhj
         QsonpZIWXME7WLmvktNoCDqzGA+i4l/eGtQxIIeur/H5Y42DX/pJ2khg9FA+QntF0vVX
         VjM1aSU0Au1UqjH1IoIGQS8lMuIzHNQdgKhtHy8vw21m3d5sg2u5IhZaAnY36yQ40AlP
         Mx/VIeGQ0tnmcUYfBZZwK1xcSt8fvepDMQy/+MeTeBZuiWmtvV4ceiS7cVWsgyXAu6er
         6k7g==
X-Gm-Message-State: AODbwcBTvjuiWHnvNqD91jV4BOYmwU+m4Ga+rUxHkrsphkJ9I6Gw9cbM
        yRDBGVnads3aNufX
X-Received: by 10.99.177.8 with SMTP id r8mr11962788pgf.109.1494734507807;
        Sat, 13 May 2017 21:01:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id e76sm12411855pfh.121.2017.05.13.21.01.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/19] diff.c: convert diff_summary to use emit_line_*
Date:   Sat, 13 May 2017 21:01:14 -0700
Message-Id: <20170514040117.25865-17-sbeller@google.com>
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

This covers diff_summary.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 62 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index 386b28cf47..899dc69dff 100644
--- a/diff.c
+++ b/diff.c
@@ -4504,67 +4504,71 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
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
2.13.0.18.g183880de0a

