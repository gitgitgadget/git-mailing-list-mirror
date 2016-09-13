Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FC920985
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbcIMEqe (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:34 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36029 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbcIMEqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id 128so59454577pfb.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTeyAhZK7ir2zQUb/+xYOW+/dZOc160jmaubiKm1Nyg=;
        b=WHoZDu3MYgeaVTQbmDpwHLrHMiZm/iLbg60oZb05CFX9MmwQCfdbvR+Jket8ddBGqE
         Jt4ntcliGW8c8PU/ui3s58CEQvFGL9UNeKoIHtuXLDB1QfDQkEg/UuytIkjh+94Utg0O
         auh+6XWU85T8DLOBz043ZBZeZWSLNEBjoq8zJYMIip6JBV9fZdJ1kKdjh21KctV8OeGw
         lddKdgWygTGQhbrtgE6FEGWZXOWFWILR74iKrGiFhvnyNzTcagv/UOc6BX8Tn5Kg6sob
         7JZi8BwT1mR78YIPxVnJWEHWNWygyP5Pfo8gKgj3iDWlQTluBUuZhHbx5k2XwrpZJZKE
         3T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTeyAhZK7ir2zQUb/+xYOW+/dZOc160jmaubiKm1Nyg=;
        b=NCPc/fSb9YTmoziSUbcddqyYE7SK6fKWizSUMwNMPMZ0xFiupzA5XnZAzwAWGp/W9S
         ZrS6DrlwSQgsc58VGI5Pca3Hu/P8L8HcMKFt2/JIiVs2qbVi/0wt0Em7mpdRd2Jn0ch7
         VHGK+1cey2k+NzX1cPRRcH7d4GCyQAVZaZ2nE0vwCBrN4w4141QyUULEZHd9/VVBTUIG
         O6pO6weUMeGsvE1hPoRhoZbFC8IhXc9AJ1JeadBf6vzT30GwNqZInDtRvmxAxKWbKcnw
         +QLaMz8057d4JoMKOw+enrsrapHPhN1a11opgcfWESZBm6UsMhmpFu8ViIxhh4GGhoig
         HaDA==
X-Gm-Message-State: AE9vXwOCPXpfQqhDaU1DykTrKreCv2p9M6FRlLPj2KuFhAEuq0NelR84dUMg6O5qOOTZJzJ5
X-Received: by 10.98.211.193 with SMTP id z62mr18123088pfk.124.1473741991401;
        Mon, 12 Sep 2016 21:46:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id ty6sm27875700pac.18.2016.09.12.21.46.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 08/17] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:04 -0700
Message-Id: <20160913044613.1037-9-sbeller@google.com>
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

This covers emit_rewrite_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index cbd4ba7..ee4c9d4 100644
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
2.10.0.21.g1da280f.dirty

