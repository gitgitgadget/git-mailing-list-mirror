Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F60E1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdFTCsz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:55 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35911 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdFTCsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:50 -0400
Received: by mail-pf0-f182.google.com with SMTP id x63so62653172pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sEfWPAEkPPQGlLfjVjKnYc6u42dfcquh4hjFdFEJgW0=;
        b=pGHXGAmOJQ1fNKft0SWc0ZowWGxoWkaH4qpJKIxTJWZz+lvIqXChZA/zUreXZAq+Jc
         y5R3hvm2zyhcqtv6iEX1HSpMCQxYWay38T2RVoGHtioYU0UAgRerH+2G/I8wqP+eObpA
         Jtxo9Le9ZhPoGp53ySGM8h+KzD4FKSY4Uj5gbPABCJu6S/b6qUvGnpeA9kWEAOUzCBqK
         Imt++eIkW1FEWFk8hCjKqHK+CqEoF6iwnUgLLqXF+lan3VyDgbMMxeebAyl7mOUNSvKI
         qEz8rbcBxwNioRq2WPr8cC73wAmfDQPZkW2iS75gIc1+EqwbgPBTgIDbBowg3PKnjk5z
         70dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sEfWPAEkPPQGlLfjVjKnYc6u42dfcquh4hjFdFEJgW0=;
        b=I5AUslNDu9LCJvJB/DKHUbUzjCA8dg/57yXJy7LX1cSLfDludawGDNPhjN0ZfqtUaj
         2B1nPusNWhUK/ZdqeOX/bfYJSSZSTtyGmdNoHIhDWZvv82Nz/OAthw/bl5FmRJrETXV4
         nx7Us2hFr64A//+MPvIVGqzMCBu/1oPRqJJTBDnShNPirMgA2Ql2lQ7lll9D7vTkCQff
         pIoUmFxLaoeGTuncXsA3jds7pshlhh4rhDdn/J83EYWu3tAvA3ewjcKUj6OabNDSjc/E
         0aSTyu3OYQTy2fls3U/JVWkrC4yGVZXxK/+/T3y93niXnORDvvKBy+tyseTpDaJR037O
         kK0g==
X-Gm-Message-State: AKS2vOw1ualNxJBNr5wVFlFf5SanR05inGUTRDzpLXEN9BOSHqGMOjE0
        jWYQo4HIMQeYmzkk
X-Received: by 10.99.38.133 with SMTP id m127mr28587182pgm.72.1497926924165;
        Mon, 19 Jun 2017 19:48:44 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id 186sm22545953pfv.15.2017.06.19.19.48.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 16/26] diff.c: convert emit_binary_diff_body to use emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:48:06 -0700
Message-Id: <20170620024816.20021-17-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 42a9020d95..e6ade5fde0 100644
--- a/diff.c
+++ b/diff.c
@@ -573,6 +573,11 @@ enum diff_symbol {
 	DIFF_SYMBOL_FILEPAIR,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_BINARY_FILES,
+	DIFF_SYMBOL_BINARY_DIFF_HEADER,
+	DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
+	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
+	DIFF_SYMBOL_BINARY_DIFF_BODY,
+	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
 	DIFF_SYMBOL_REWRITE_DIFF,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
@@ -581,6 +586,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_SUBMODULE_HEADER,
 	DIFF_SYMBOL_SUBMODULE_ERROR,
 	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
+
 };
 /*
  * Flags for content lines:
@@ -702,6 +708,22 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		fprintf(o->file, "%sBinary files %s differ\n",
 			diff_line_prefix(o), line);
 		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER:
+		fprintf(o->file, "%sGIT binary patch\n", diff_line_prefix(o));
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA:
+		fprintf(o->file, "%sdelta %s\n", diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL:
+		fprintf(o->file, "%sliteral %s\n", diff_line_prefix(o), line);
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_BODY:
+		emit_line(o, "", "", line, len);
+		break;
+	case DIFF_SYMBOL_BINARY_DIFF_FOOTER:
+		fputs(diff_line_prefix(o), o->file);
+		fputc('\n', o->file);
+		break;
 	case DIFF_SYMBOL_REWRITE_DIFF:
 		fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -2394,8 +2416,8 @@ static unsigned char *deflate_it(char *data,
 	return deflated;
 }
 
-static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
-				  const char *prefix)
+static void emit_binary_diff_body(struct diff_options *o,
+				  mmfile_t *one, mmfile_t *two)
 {
 	void *cp;
 	void *delta;
@@ -2424,13 +2446,18 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	}
 
 	if (delta && delta_size < deflate_size) {
-		fprintf(file, "%sdelta %lu\n", prefix, orig_size);
+		char *s = xstrfmt("%lu", orig_size);
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_DELTA,
+				 s, strlen(s), 0);
+		free(s);
 		free(deflated);
 		data = delta;
 		data_size = delta_size;
-	}
-	else {
-		fprintf(file, "%sliteral %lu\n", prefix, two->size);
+	} else {
+		char *s = xstrfmt("%lu", two->size);
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
+				 s, strlen(s), 0);
+		free(s);
 		free(delta);
 		data = deflated;
 		data_size = deflate_size;
@@ -2439,8 +2466,9 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
+		int len;
 		int bytes = (52 < data_size) ? 52 : data_size;
-		char line[70];
+		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
 			line[0] = bytes + 'A' - 1;
@@ -2448,20 +2476,24 @@ static void emit_binary_diff_body(FILE *file, mmfile_t *one, mmfile_t *two,
 			line[0] = bytes - 26 + 'a' - 1;
 		encode_85(line + 1, cp, bytes);
 		cp = (char *) cp + bytes;
-		fprintf(file, "%s", prefix);
-		fputs(line, file);
-		fputc('\n', file);
+
+		len = strlen(line);
+		line[len++] = '\n';
+		line[len] = '\0';
+
+		emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_BODY,
+				 line, len, 0);
 	}
-	fprintf(file, "%s\n", prefix);
+	emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_FOOTER, NULL, 0, 0);
 	free(data);
 }
 
-static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two,
-			     const char *prefix)
+static void emit_binary_diff(struct diff_options *o,
+			     mmfile_t *one, mmfile_t *two)
 {
-	fprintf(file, "%sGIT binary patch\n", prefix);
-	emit_binary_diff_body(file, one, two, prefix);
-	emit_binary_diff_body(file, two, one, prefix);
+	emit_diff_symbol(o, DIFF_SYMBOL_BINARY_DIFF_HEADER, NULL, 0, 0);
+	emit_binary_diff_body(o, one, two);
+	emit_binary_diff_body(o, two, one);
 }
 
 int diff_filespec_is_binary(struct diff_filespec *one)
@@ -2646,7 +2678,7 @@ static void builtin_diff(const char *name_a,
 		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
-			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
+			emit_binary_diff(o, &mf1, &mf2);
 		else {
 			strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
 			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
-- 
2.12.2.575.gb14f27f917

