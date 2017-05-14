Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4263B20188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdENEBk (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:40 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33514 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdENEBh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so47224737pfh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UCEIrXC22j8KnthzIZP3oqzRuGC8oIFccyhoDV2cflc=;
        b=gyDJVDGm9i3pNk/joXltCHZB0RiNBwplfIs2b/iIm4QlHNnNfb+AXRxOQamyWrY1fh
         t6btBHatjVAqhx5xWmIVkwLmd1EAZsULJOA8d9Wyeqh5ig3aoqRiAZWC9s5dsbxXmUIV
         ilqltLnqiTyk9jnjrrt6IQS2/S5k4gy2zq+2iYNYvyTiLhuqn6H3buzGrMXEmNWESTOK
         IZKSaQi+MjYxcZSdfQ9s8EZSC0deIi/qrKWaZ1Lc4H8+3UjLQCu37Imuc1rYLiPbZNi7
         7Ju/t3/e7I+oIO57CFo4xzmApceBItN/QDHP2ldklxPCIjDyusRuEHyThQVBNFRHtfro
         X5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UCEIrXC22j8KnthzIZP3oqzRuGC8oIFccyhoDV2cflc=;
        b=iiRbjeJbzWqwVZAj1KurSph5PNzWFHKa4h6ekzB9AhJYanNtc+7b2Sy4WxwZTNQsbL
         tkyR1wzvySI7A72UHzNPH/SgGLZ9WDvZXfXuIyD/TOc3XyHBTG/0R8zdY5z2ViFEVTLh
         W/FlFgLcC+DuQQsJfzxZf6oqDj+5OZtb0Plta+eDzqV5dZWYQUYCaMgbOTHEijLbKr5N
         pbbxsl9GrV/VobooUNJzCBDPMplGShcRkSt52tUtZYQwKNtDAEQHcy+dWhGyuZolhoxP
         1t0oxhmeFNaMaUxG+n1X5n5uKQnu4zIeNpE/R1aCg0tfgE/aylL42idma136V6LmoSQ+
         h+5g==
X-Gm-Message-State: AODbwcDlxrW1ZxCf3OTNroWACODEuzxZzqlt7HGZm/pDvvY6l5n+y56t
        u6/HCd0TmVQ5yNXa
X-Received: by 10.84.134.34 with SMTP id 31mr15075714plg.178.1494734497074;
        Sat, 13 May 2017 21:01:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id q9sm11661804pfg.77.2017.05.13.21.01.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/19] diff.c: convert builtin_diff to use emit_line_*
Date:   Sat, 13 May 2017 21:01:06 -0700
Message-Id: <20170514040117.25865-9-sbeller@google.com>
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

This covers builtin_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 93343a9ccc..8e00010bf4 100644
--- a/diff.c
+++ b/diff.c
@@ -1293,8 +1293,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
-		strbuf_reset(ecbdata->header);
+		emit_line(o, NULL, NULL,
+			  ecbdata->header->buf, ecbdata->header->len);
+		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
 	}
 
@@ -2407,7 +2408,7 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
+	strbuf_addf(&header, "%sdiff --git %s %s%s\n", meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
@@ -2439,7 +2440,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, NULL, NULL, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2449,7 +2450,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		if (header.len)
+			emit_line(o, NULL, NULL, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2459,13 +2461,16 @@ static void builtin_diff(const char *name_a,
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
-				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+				if (must_show_header && header.len)
+					emit_line(o, NULL, NULL,
+						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			if (header.len)
+				emit_line(o, NULL, NULL,
+					  header.buf, header.len);
+			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2473,17 +2478,21 @@ static void builtin_diff(const char *name_a,
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
-			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+			if (must_show_header && header.len)
+				emit_line(o, NULL, NULL,
+					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		if (header.len)
+			emit_line(o, NULL, NULL,
+				  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
 		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line_fmt(o, NULL, NULL,
+				      "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
@@ -2494,8 +2503,8 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+		if (must_show_header && header.len) {
+			emit_line(o, NULL, NULL, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
-- 
2.13.0.18.g183880de0a

