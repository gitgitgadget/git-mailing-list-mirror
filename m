Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CCB207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbcIMEqg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:36 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33193 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbcIMEqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:30 -0400
Received: by mail-pa0-f44.google.com with SMTP id cm16so57857611pac.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=szHFShtbq5nX1rIl63G6RzdIqwIemu4mWA/40G4m4MM=;
        b=XedLhdTvA/9U1y9yrFRr7ms3hGLxKWPeL0JaETMNTLeCsnXw+UIPxK11tDBeCjwPOC
         4yzTFRgwIOnfTrHc53R50S+tIP+NWSRZhWyfR5GJ7F8YhRu/aCToDM/i9rPD097WhY8z
         hlmj61Dj07XgVwvUmNVcvuJp0oEuX90ULCqMm3iidkTcXM2RtoA+7k92/859w5+VUtQl
         awtP/YM8JzhAGcEWjSlcQnI99y1CX+yzRkSWdjOF9P3mIrF6d46m/le9xZbDdiSTQhW1
         nz8ieowo0E34n6wnthXYq1C52zTLuKzvCtKzhEChhX7MRE4nLxjd9ol+XeCjveUowMSr
         fsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=szHFShtbq5nX1rIl63G6RzdIqwIemu4mWA/40G4m4MM=;
        b=IvjuF4JmjLxBObnL/oEY+Yqoq1Sf+PEtze/VljActUmoWy4wIkowiWy8M3Vwd80V9v
         KNqDK3K2805pmJygoxY5Tuo6urwRg0lBziOg9aAia1ceBnggLk9oevD9GpNawVoqNOCv
         iogTZ6dtwZBM2qrAGtotY58eTJKo+aOgIuqJZksy1ki3cjZe1IS5rs6fPuZ4XomzkOJs
         KNMw6jyw0lLDSEPvYB669h6OO5Vim16isX83Isbi9lEQto8R3UIijpncv2UV3foB5ptO
         uw0NeCX+ThiNxC0lDhUcXeIfiNpSSyTysDrPrML/tnPbzuR6KqhnWek41D0tujIDLlkr
         Q/iA==
X-Gm-Message-State: AE9vXwOgx99NWy7d91hxerLypaERXBi2ck+xJNgH1It0lGDwgf1m1ut1Qv5v1PnqwzOpZMQR
X-Received: by 10.66.164.227 with SMTP id yt3mr39881789pab.117.1473741989526;
        Mon, 12 Sep 2016 21:46:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id ty6sm27875512pac.18.2016.09.12.21.46.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 07/17] diff.c: convert builtin_diff to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:03 -0700
Message-Id: <20160913044613.1037-8-sbeller@google.com>
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

This covers builtin_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index b4f4b75..cbd4ba7 100644
--- a/diff.c
+++ b/diff.c
@@ -1234,8 +1234,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	o->found_changes = 1;
 
 	if (ecbdata->header) {
-		fprintf(o->file, "%s", ecbdata->header->buf);
-		strbuf_reset(ecbdata->header);
+		emit_line(o, 0, 0, ecbdata->header->buf, ecbdata->header->len);
+		strbuf_release(ecbdata->header);
 		ecbdata->header = NULL;
 	}
 
@@ -2333,7 +2333,7 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
+	strbuf_addf(&header, "%sdiff --git %s %s%s\n", meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
 		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
@@ -2365,7 +2365,7 @@ static void builtin_diff(const char *name_a,
 		if (complete_rewrite &&
 		    (textconv_one || !diff_filespec_is_binary(one)) &&
 		    (textconv_two || !diff_filespec_is_binary(two))) {
-			fprintf(o->file, "%s", header.buf);
+			emit_line(o, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
 						textconv_one, textconv_two, o);
@@ -2375,7 +2375,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->irreversible_delete && lbl[1][0] == '/') {
-		fprintf(o->file, "%s", header.buf);
+		if (header.len)
+			emit_line(o, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
@@ -2385,13 +2386,14 @@ static void builtin_diff(const char *name_a,
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
 			if (!oidcmp(&one->oid, &two->oid)) {
-				if (must_show_header)
-					fprintf(o->file, "%s", header.buf);
+				if (must_show_header && header.len)
+					emit_line(o, 0, 0, header.buf, header.len);
 				goto free_ab_and_return;
 			}
-			fprintf(o->file, "%s", header.buf);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			if (header.len)
+				emit_line(o, 0, 0, header.buf, header.len);
+			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2399,17 +2401,18 @@ static void builtin_diff(const char *name_a,
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
-			if (must_show_header)
-				fprintf(o->file, "%s", header.buf);
+			if (must_show_header && header.len)
+				emit_line(o, 0, 0, header.buf, header.len);
 			goto free_ab_and_return;
 		}
-		fprintf(o->file, "%s", header.buf);
+		if (header.len)
+			emit_line(o, 0, 0, header.buf, header.len);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
 		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			emit_line_fmt(o, 0, 0, "Binary files %s and %s differ\n",
+				      lbl[0], lbl[1]);
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
@@ -2420,8 +2423,8 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (must_show_header) {
-			fprintf(o->file, "%s", header.buf);
+		if (must_show_header && header.len) {
+			emit_line(o, 0, 0, header.buf, header.len);
 			strbuf_reset(&header);
 		}
 
-- 
2.10.0.21.g1da280f.dirty

