Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47D62023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965589AbdEWClT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:19 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36135 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935988AbdEWClL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:11 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so99601653pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=allNl8k/uDRvsgO2nNvoswJoTkYjVxIu3an++m8HNeg=;
        b=r/uK9Qizq90E6laCHJJLBinpSICBFurfH/C2OVrMRwBC43jhyb2dGbKR/Fu+ih5nBx
         u2f/9QAq3gyc7FEQCW3AK6bIt307Qt0A0yA3sVWwiAZOsZD4pbojdrAb1Q7g8N11LhCC
         2U8llKl6jSZZCX9w57lxBZXczoXUhfvMGE3jJgF10ESaSf9wjV5jRXCosubTfcwf8q/y
         e8BmCAWCcp67j23w0mEKHNvDMqmWSkn387/OgaH5p5Vd51ze4kWpvUDK4d6MKUuVx9HC
         04RT2oXmjekmZI/uDEaWFTYGQEBDSsem2T/V6v0Vv+wI2j0N6J1WKgp44iY+797YN7KJ
         k9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=allNl8k/uDRvsgO2nNvoswJoTkYjVxIu3an++m8HNeg=;
        b=M8B18O4g6dDUrbzwM9ur18aRRidUK4xsrATteBdub+iJ4ymvFyvRSqFyIusu8rcQk0
         vrndhV8ZNdhRFOtZEz9PDeJFJC5DLe34T5vdXdO4hr8/amXpR6xbohXeJvnLqFJcCnU8
         AG2m7BjtmeTOqUTzrkQzTjXVIFPiZCUsVdFNr/uM53n6OnD9gBGtY6vMQNcnv/nSs6sa
         gT2O1UWm+7mCZGfbiSoNSsByWmpF5tNPbXyVnXQ+fqtyEmmy4IYWvlcgpqy8Lc8MQXU6
         NFcXYahPLHg7QmUnhj5uSxmmhrrn5gZ+KPOyGhO0jBO29hNWY/Ywc7TNQqcyo4IS7t1+
         6L8A==
X-Gm-Message-State: AODbwcBYpwRip09aCGn/+ZigoazdBVESN4n4bC8M6EGQMymghR8fNN/J
        ZBmp6/vi6HXD71eb
X-Received: by 10.98.131.142 with SMTP id h136mr29542158pfe.138.1495507270299;
        Mon, 22 May 2017 19:41:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id e76sm28642363pfh.121.2017.05.22.19.41.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 07/17] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Mon, 22 May 2017 19:40:38 -0700
Message-Id: <20170523024048.16879-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
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

This covers emit_rewrite_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 4fa976d43c..3dda9f3c8e 100644
--- a/diff.c
+++ b/diff.c
@@ -704,17 +704,17 @@ static void remove_tempfile(void)
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
@@ -768,7 +768,7 @@ static void emit_rewrite_diff(const char *name_a,
 	char *data_one, *data_two;
 	size_t size_one, size_two;
 	struct emit_callback ecbdata;
-	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf out = STRBUF_INIT;
 
 	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
 		a_prefix = o->b_prefix;
@@ -806,20 +806,23 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.lno_in_preimage = 1;
 	ecbdata.lno_in_postimage = 1;
 
+	emit_line_fmt(o, metainfo, reset, 1, "--- %s%s\n", a_name.buf, name_a_tab);
+	emit_line_fmt(o, metainfo, reset, 1, "+++ %s%s\n", b_name.buf, name_b_tab);
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
+	emit_line(o, fraginfo, reset, 1, 0, out.buf, out.len);
+	strbuf_release(&out);
+
 	if (lc_a && !o->irreversible_delete)
 		emit_rewrite_lines(&ecbdata, '-', data_one, size_one);
 	if (lc_b)
-- 
2.13.0.18.g7d86cc8ba0

