Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF902082F
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbdFWB34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:56 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35560 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbdFWB3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id 132so15006852pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kw45VTX+KxH9ggoR8qyIe6lMuc2NYu89JBjp7JCxt4=;
        b=HE4qLt/jhmaTKTnmBMGlWLYN19EITMZkCmYEIZets1jGygjHmOUvIFR3vDADuuO67A
         5IP76QxGc1n2dtn0Os2Ow2iXNaWHIgP/K/epwnuFmKXZ4WiSQUe+V/APzBbuJX/3gkkv
         1I1pSWimOVfyMYSJ9ce1i3cxfs1A8f/0mYH7mpVNprp+IlyAeyfobylBKZmFMtUFDD40
         fi/+Kv9BWwB7uOJDB6Gf+y1fldHQLnUCNyHtkJYxJpvnX42tNjgaLWS3rRG5m46nZ/rm
         Et8H68MFfITN6BDGDdw89H/Xp9u+a748WO0/Rg95ym7gnT2gaOESd7e4VzXds4acKtON
         JIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/kw45VTX+KxH9ggoR8qyIe6lMuc2NYu89JBjp7JCxt4=;
        b=YWOXSu+pDZO1UOjPr4UlB/0x2uQuGJJsRrei7dmy5vxOqa+WvXzEdmVrlnfo0W4nCa
         985tzBXy0PXOqskJCYxeSKh7We3pEXANbOkAYmEsC3YTR2/H6d7nSPjWaPzYwikhoYfs
         RSYWV9/ebDzKNlGMS9scVGTJICv8i8qaYEe9p0kcU87oQJ+VnavrQEB2XW7sLYr6V38m
         gKOwufkvn3TsSDbVXFmWsg84v6YZP+kBjwTKh56C3vtBAuymhBDAt8RSZ118iQyTcxuO
         CQm5+U83xnU9uDdpqiR6KFvQoFFkP4prVRgzUfDieXDfTNrqMU+KJHw1RSTF347ldaVu
         eNsA==
X-Gm-Message-State: AKS2vOzZk8JIBsD25MOJAKVyZ/w4xPWpHSGdSCLo5/gEihQUcsuu2rV2
        I+gdxH5Tb49W/ofP
X-Received: by 10.99.2.144 with SMTP id 138mr5462551pgc.265.1498181383412;
        Thu, 22 Jun 2017 18:29:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id k70sm5669160pfg.72.2017.06.22.18.29.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 12/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
Date:   Thu, 22 Jun 2017 18:29:06 -0700
Message-Id: <20170623012919.28693-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The header is constructed lazily including line breaks, so just emit
the raw string as is.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 761ee581ad..34314455b5 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
 	DIFF_SYMBOL_FILEPAIR_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
@@ -688,6 +689,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
+	case DIFF_SYMBOL_HEADER:
+		fprintf(o->file, "%s", line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1385,7 +1389,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+				 ecbdata->header->buf, ecbdata->header->len, 0);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -2519,7 +2524,8 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2529,7 +2535,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf,
+				 header.len, 0);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2540,10 +2547,13 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+					emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+							 header.buf, header.len,
+							 0);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			fprintf(o->file, "%sBinary files %s and %s differ\n",
 				line_prefix, lbl[0], lbl[1]);
 			goto free_ab_and_return;
@@ -2554,10 +2564,11 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+				emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+						 header.buf, header.len, 0);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
@@ -2575,7 +2586,8 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
+					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 		}
 
-- 
2.12.2.575.gb14f27f917

