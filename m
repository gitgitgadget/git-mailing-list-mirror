Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02EB20209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164176AbdEXVlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:07 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35609 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164162AbdEXVlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:41:00 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so147415607pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=allNl8k/uDRvsgO2nNvoswJoTkYjVxIu3an++m8HNeg=;
        b=REr70w3PXZpDKQ6g/jTqsgMsntLHqpnJww94831en5AotbHJSrpSGpP+lf06h3hSPQ
         +pelEHpI9vo72SFMPygcqZfxxqF6+rMfzmxGGHlx3TdxEm55k0ANVbO5PZqH5IcA8rIl
         lsT73JrdX05vLW3IYusu6x8RT39yFn8Ruk3ZnWv/uSFGMk1CWuNU2vbCyTQIr7LKIa9c
         603WNfCLOM+KVahGIgYvK4Axsn2R/Cqu9mt0C2YZycgkeJ2RwVsQebo1amlgGnXAyoUp
         sjdQKm9knEIXwkIUWcaSNTFJoPxitwOQ4q2iGruT69bZFF/+mcRS5B6rzSOF1iAobAVV
         ubTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=allNl8k/uDRvsgO2nNvoswJoTkYjVxIu3an++m8HNeg=;
        b=Mr13RSe9BgzVozXRkPtWVp9bW4snaBJyJUPPLoghJxhKQuZ022ftcyaUIomxSG7Yml
         sHFmSBVYIBWih8lpZ10VoZRXFHmDK5newJVGpwf5DIsRHo4bxuOCFKSMFV64u/mb3sM9
         PlbW1PMcP/1ojSP2RK/BW9J1u62uC6ibnres11Cg3J49+CzcFZVivaO5St35tsGfRIId
         u0kt6fN+BzpJTZ8PLNayFz8+U+d3q9cooWPoT2Y0yd108Aum3G8FmRbpEefqy51rQ3SU
         QfwWnDab3jgybgtQUMEnAX03kA8Sn04Z7VmFXLgNovCJrfijmDsmxYKC09PFBuDH3vlm
         X0BA==
X-Gm-Message-State: AODbwcDaAEfodzcGbsImvPQKcjkqwOxiKnJf7QvOc4jS3oes4g9tAUy4
        cUn/Yqaol6ocGIG0
X-Received: by 10.99.137.194 with SMTP id v185mr40697968pgd.206.1495662049930;
        Wed, 24 May 2017 14:40:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id n23sm10275601pfh.44.2017.05.24.14.40.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 07/17] diff.c: convert emit_rewrite_diff to use emit_line_*
Date:   Wed, 24 May 2017 14:40:26 -0700
Message-Id: <20170524214036.29623-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
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

