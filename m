Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA9920984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbcIKFmz (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:55 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36711 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755464AbcIKFmn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:43 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so6009171pab.3
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8TunlWaG9jdCpifIOP9B2lu8vmfCpUW0drxbxsvuNU=;
        b=RYU5qi+U+7DTo093pro5Fr+5KyTdlQ+VHDOsjelKNnJ6uA46U2MhQchKfxdlfeIiWS
         OHQjAIluhHM2rVx+7BJt/B/QcpkaznJEMYeFGm+dsF9lBMG/vgGZlUyXEftDh+/25wUE
         sF/Dqdg2EHEoxK/JN9hyTIeuTn/mJKU0Pt7ilnW3pQW82hycGvFHCx7Elgb2YmBgajb8
         JrQ90PowGrS9lKM3bSfkzkOUNjYQCfq8mHE8P8JvYIHyx/ZvJuLJy8fEKq5H7PvL2oS3
         8bno69dSRjb2GEDgDcZEg25MJBBIaM0UzHzUjngaET/tpfHUax/42edEpreMbNs97lNV
         lT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8TunlWaG9jdCpifIOP9B2lu8vmfCpUW0drxbxsvuNU=;
        b=L6ZQbQ4z8V5n9PG89t0MQoXQIgnxqp+C1Crg1KNtYPKSCYtfsWf/1b6Qx5osDlgrVb
         U6TUuN7ZN9eGGbP2CyL7ngEdSYUUvW2r88uSr0vC2T3PislrdOn9APCMr/PppXDHdVGk
         KN4KmXVnDwH/nkje00I/s9PT3PnkWrA3WUkru5v5bpXfcyZPDouk7yqSbQE46j/qfBgf
         Q7/8qIjDjbtWaKECJxSd0JD8tKZlVHVXl59b7/J+HPfs/DMfo/gWB2LFOtcxP4VBqNuP
         AFhh7VAZL/b1X/+K0dgTB+eRyndotJe0MxUSIdvDdEYZr5FxeiE8upasqArLe+zoBMLq
         ntMg==
X-Gm-Message-State: AE9vXwNmvOwlEXdKPOTEkgXF+d3Ja+pHBvON6oep0/4A1jUIRXkdI6ALtIYisnh+/XwMJA==
X-Received: by 10.66.67.9 with SMTP id j9mr22001650pat.27.1473572562880;
        Sat, 10 Sep 2016 22:42:42 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id 184sm15491416pfg.20.2016.09.10.22.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:42 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/10] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Sat, 10 Sep 2016 22:42:08 -0700
Message-Id: <1473572530-25764-9-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 7dcef73..98d6655 100644
--- a/diff.c
+++ b/diff.c
@@ -653,17 +653,17 @@ static void remove_tempfile(void)
 	}
 }
 
-static void print_line_count(FILE *file, int count)
+static void add_line_count(struct strbuf *out, int count)
 {
 	switch (count) {
 	case 0:
-		fprintf(file, "0,0");
+		strbuf_addstr(out, "0,0");
 		break;
 	case 1:
-		fprintf(file, "1");
+		strbuf_addstr(out, "1");
 		break;
 	default:
-		fprintf(file, "1,%d", count);
+		strbuf_addf(out, "1,%d", count);
 		break;
 	}
 }
@@ -714,7 +714,7 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -752,20 +752,23 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.lno_in_preimage = 1;
 	ecbdata.lno_in_postimage = 1;
 
+	emit_line_fmt(o, metainfo, reset, "--- %s%s\n", a_name.buf, name_a_tab);
+	emit_line_fmt(o, metainfo, reset, "+++ %s%s\n", b_name.buf, name_b_tab);
+
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	strbuf_addstr(&out, "@@ -");
 	if (!o->irreversible_delete)
-		print_line_count(o->file, lc_a);
+		add_line_count(&out, lc_a);
 	else
-		fprintf(o->file, "?,?");
-	fprintf(o->file, " +");
-	print_line_count(o->file, lc_b);
-	fprintf(o->file, " @@%s\n", reset);
+		strbuf_addstr(&out, "?,?");
+	strbuf_addstr(&out, " +");
+	add_line_count(&out, lc_b);
+	strbuf_addstr(&out, " @@\n");
+	emit_line(o, fraginfo, reset, out.buf, out.len);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.7.4

