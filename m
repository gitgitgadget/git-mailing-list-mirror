Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25854201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757688AbdERTiJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:09 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33347 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdERTiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:06 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so28547342pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8pbJxQI9wcHNldGmPxxwILXBS9BaqIm0Y6z3+UeJvA=;
        b=j0TYmIF7+x5QuwUE6rEiQgA/in8tVLRpL+xEN42ZZfUAvjKgZIvTdynCx6KuBKvdjo
         dwaPmOIxO4X6kEeHN0BCqToPvxHHBK7hCqOOL8Gm5P0DckMS+g8d5brqw5qPnb68q6EX
         4KLNgNrACgBu4jpvMWiLfmYOEdmLu/sOxQryEcVYzMj2/UuQxRCa5yLCo7oBtwPfoUeA
         cTbZZUAQnp5XFw1EzAwggjcVgt3QrrXSoufN6exT2o4GI4toxsW+w0gjDtoJ91HGk009
         ak33zvybj0fzNfwUY9r1KxqDO/tH4ZGv6GYYSCwkTomV31OQGQ/oIqqa1BMIMIJ2WD3z
         SzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8pbJxQI9wcHNldGmPxxwILXBS9BaqIm0Y6z3+UeJvA=;
        b=N6OlXChE+30PU0g53pH5zJI9lUyj1bluzaBZV7MEniR+NjWVZEe289m47wISYtMmwQ
         uCU51LzK8fP/tnCNH7iiWERps3AYHZLSmXbn84zqpUzXmqxO+0Ljx3Epir+xeFhx9iXV
         jkGxdycTdv3YHO6h7YkIwcqyh1iANj5WTZxG6wqVlasBtdHuGZ04EMsvueoxlRLhtk4Y
         syDIXco0Q+pCYsdyybRR5sv5NOVNCFEVliKZDpNL2wS2XG0U7O29xGuLLEW1y3KODf0H
         y5i0w5RQZba6oFV2RFhsJZz1KKGahgMr1SEnr7D6GNmo6QD2XQrYwrwrQ5l2doaS3bDZ
         ofNw==
X-Gm-Message-State: AODbwcBkDmW4DjGgfEA/QqPMUeYV0tBJEArr13EjrDga43iEhsgsPDqD
        ERKDl/FhsnhZE3Zv
X-Received: by 10.98.217.5 with SMTP id s5mr6231424pfg.42.1495136285191;
        Thu, 18 May 2017 12:38:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id d3sm10507893pfb.110.2017.05.18.12.38.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 09/20] diff.c: convert builtin_diff to use emit_line_*
Date:   Thu, 18 May 2017 12:37:35 -0700
Message-Id: <20170518193746.486-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
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
 diff.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 8186289734..4fa976d43c 100644
--- a/diff.c
+++ b/diff.c
@@ -1289,8 +1289,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
-		strbuf_reset(ecbdata->header);
+		emit_line(o, NULL, NULL, 0, 0,
+			  ecbdata->header->buf, ecbdata->header->len);
+		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
 	}
 
@@ -2435,7 +2436,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2445,7 +2446,7 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2456,12 +2457,15 @@ static void builtin_diff(const char *name_a,
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+					emit_line(o, NULL, NULL, 0, 0,
+						  header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line(o, NULL, NULL, 0, 0,
+				  header.buf, header.len);
+			emit_line_fmt(o, NULL, NULL, 1,
+				      "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2470,16 +2474,19 @@ static void builtin_diff(const char *name_a,
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
 			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+				emit_line(o, NULL, NULL, 0, 0,
+					  header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		emit_line(o, NULL, NULL, 0, 0,
+			  header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
 		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line_fmt(o, NULL, NULL, 1,
+				      "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
@@ -2491,7 +2498,7 @@ static void builtin_diff(const char *name_a,
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, NULL, NULL, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
-- 
2.13.0.18.g7d86cc8ba0

