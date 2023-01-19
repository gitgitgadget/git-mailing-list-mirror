Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9FC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjASXAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjASW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:31 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FB582B3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:49:10 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 57A26CD7;
        Thu, 19 Jan 2023 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1674167948;
        bh=5+0Jy5ChPbm88gJ3fn7joWwVuTvoSlv4Pos9ai0ZgRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNKyn/qpUrHQ1tC1p80UoStS5c9hQ513NhUxLLymoMSGAV0IJU+nHl1XmWYIWiDFh
         9NqVg9dRDzgFWAyaqYyMlyflBaUYEyTAoaaTecxXe6aRQ2CfVJhS5y2kPTSRMcCOnq
         MQubk/bKZ22Tsw2S90gHSfsBwHtBc6oYSZUSzxW8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     git@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Emma Brooks <me@pluvano.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Hemmer <git@stormcloud9.net>
Subject: [PATCH 3/5] log: Push to/cc handling down into show_log()
Date:   Thu, 19 Jan 2023 14:38:56 -0800
Message-Id: <20230119223858.29262-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119223858.29262-1-zev@bewilderbeest.net>
References: <20230119223858.29262-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rearrangement is a measure to facilitate adding --to-cmd/--cc-cmd
support to format-patch.  The command will need to be run separately
for each commit, so the lists of individual recipients specified via
--to and --cc (and potentially --add-header) need to be available at
the per-commit level instead of just the combined headers in a single
string as has been the case until now.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 builtin/log.c |  6 +++---
 log-tree.c    | 22 +++++++++++++++++++---
 log-tree.h    |  3 +--
 revision.h    |  2 ++
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ad9d7ebc6d73..c0c7b8544d73 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1326,6 +1326,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	format_recipients(rev, &sb);
 	prepare_cover_text(&pp, branch_name, &sb, encoding, need_8bit_cte);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
@@ -2028,9 +2029,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	recipients_to_header_buf("To", &buf, &extra_to);
-	recipients_to_header_buf("Cc", &buf, &extra_cc);
-
+	rev.to_recipients = &extra_to;
+	rev.cc_recipients = &extra_cc;
 	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
 
 	if (from) {
diff --git a/log-tree.c b/log-tree.c
index 0e8863fe545a..7aa2841dd803 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -426,8 +426,8 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 	}
 }
 
-void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
-			      const struct string_list *recipients)
+static void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
+				     const struct string_list *recipients)
 {
 	for (int i = 0; i < recipients->nr; i++) {
 		if (!i)
@@ -441,6 +441,14 @@ void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
 	}
 }
 
+void format_recipients(struct rev_info *rev, struct strbuf *sb)
+{
+	if (rev->to_recipients)
+		recipients_to_header_buf("To", sb, rev->to_recipients);
+	if (rev->cc_recipients)
+		recipients_to_header_buf("Cc", sb, rev->cc_recipients);
+}
+
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
@@ -647,10 +655,12 @@ static void next_commentary_block(struct rev_info *opt, struct strbuf *sb)
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
+	struct strbuf hdrbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
 	const char *extra_headers = opt->extra_headers;
+	char *to_free;
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
@@ -770,6 +780,11 @@ void show_log(struct rev_info *opt)
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
+	format_recipients(opt, &hdrbuf);
+
+	if (extra_headers)
+		strbuf_addstr(&hdrbuf, extra_headers);
+
 	/*
 	 * And then the pretty-printed message itself
 	 */
@@ -779,7 +794,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
-	ctx.after_subject = extra_headers;
+	ctx.after_subject = to_free = strbuf_detach(&hdrbuf, NULL);
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.encode_email_headers = opt->encode_email_headers;
 	ctx.reflog_info = opt->reflog_info;
@@ -828,6 +843,7 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+	free(to_free);
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
 		struct diff_queue_struct dq;
diff --git a/log-tree.h b/log-tree.h
index 227edc564121..ace50dad6c83 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -25,8 +25,7 @@ void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
 #define format_decorations(strbuf, commit, color) \
 			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
 void show_decorations(struct rev_info *opt, struct commit *commit);
-void recipients_to_header_buf(const char *hdr, struct strbuf *buf,
-			      const struct string_list *recipients);
+void format_recipients(struct rev_info *rev, struct strbuf *sb);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
diff --git a/revision.h b/revision.h
index 30febad09a1e..330d351b2e4c 100644
--- a/revision.h
+++ b/revision.h
@@ -283,6 +283,8 @@ struct rev_info {
 	struct ident_split from_ident;
 	struct string_list *ref_message_ids;
 	int		add_signoff;
+	struct string_list *to_recipients;
+	struct string_list *cc_recipients;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
-- 
2.39.1.236.ga8a28b9eace8

