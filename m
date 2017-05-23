Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8102023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965558AbdEWClP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:15 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35197 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935985AbdEWClK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:10 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so99564683pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EwLGcql8lEibsMq/IH9zcI2vJMclM4W7nE7k+ftGbOk=;
        b=fVVXRPZHWxXGmZfQWPpLQJnAAbFDxkzvsB/SCCTZNUbEIpQy33141K5q4FJ/zxcH2L
         NjG/+sEk5TE94Brxu400dCr9HhEodGA3pJKHxY3h93Suxwp2PMk0SSq38djCrj8jeIDC
         RfaATITE1q5CSgUEgVYwVVf4F3Js1Y/MGFdwXsv8ERESqheeSGajaijLpEE3ev7tcxat
         Y8DmkEi+H79lAnPJKWB+58HzlONYPYoLz2BJv93wQdhq2jdqDqW9J2PHac40ZpnSM2bw
         Jr/mU2Ln0dABif8TovZ70BCa5hj6IjcgtjOqs0upqdF5QOSdG8Fgk59N9+zc14piH3tX
         7yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EwLGcql8lEibsMq/IH9zcI2vJMclM4W7nE7k+ftGbOk=;
        b=h3VPd4rAqohARRh3/bEjvM7K6d5uDArPeVFaP/Z6vn4PCQkpzM0PRnDwyQIpOxPRmJ
         /VXYkg6la7cclIryrTcwm1k85c+D7OFz79VJxtyPVhbVDO7KMDdfMKERTiMuPOuXtJkp
         F+IzAfKhXZoDx2c5oYgUMLC7IG03yb8XJSbD/b9/juUiC9FnR1Rg+3FEIYQfSvvXMVeq
         YVuC8GG2JSABaOjR7NSkz8m1C/xvSpEao1jN0ZB3Rm9ms/IQbstdaNJmdse3NLfbIHZa
         GDh88mUq/xuUb9IYOBuOY5hhxZYSUiHn2cSzrzJClbGjmSK6mg1n58t+RZT3ztRQLgmx
         ArxA==
X-Gm-Message-State: AODbwcDfqmqtgQ3rUO7xqg4NSpWga9eDozg1zAkV+XgXz4/AUxua3fCy
        6SALarAgQuDM/Abi
X-Received: by 10.99.177.69 with SMTP id g5mr28603799pgp.106.1495507269194;
        Mon, 22 May 2017 19:41:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id b129sm14655572pfg.102.2017.05.22.19.41.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 06/17] diff.c: convert builtin_diff to use emit_line_*
Date:   Mon, 22 May 2017 19:40:37 -0700
Message-Id: <20170523024048.16879-7-sbeller@google.com>
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

This covers builtin_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

