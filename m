Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91AE2023D
	for <e@80x24.org>; Wed, 17 May 2017 03:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbdEQC7X (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:23 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35284 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdEQC7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:21 -0400
Received: by mail-pg0-f42.google.com with SMTP id q125so66047762pgq.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r8pbJxQI9wcHNldGmPxxwILXBS9BaqIm0Y6z3+UeJvA=;
        b=fZXNVn+K5y/0nooMzymmF3Pd85futlEtZJ07JpnEDfAcGrEId2c7JMxnIe78YCCKu0
         zKljE8utDlCfKWVqMmpsVOYk4lV+s0LertzBwB5PNalaZhxp17Pe5F5NN2RWUCZHcMzY
         sd14DASr/D1ocb5yh+xgkaA9k0ZdlCCb/rutVaPyztceFb316t0ncuPSOvdJtufOIfMH
         Rs3/dnoVbKGxZ9BIOZUW6fdjhH5Uad+gPef+2WaWLQlKlJN1f6jUrveT94msQcPkarwJ
         xRrnbuMpExzwej0kzp9lqHLdftZXkc9y7rfHnXHLYCe9+X2cVMkSHsK7kBenX7RVGERO
         0Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r8pbJxQI9wcHNldGmPxxwILXBS9BaqIm0Y6z3+UeJvA=;
        b=Ns+1ozJ1LhTobkP90VuCdIvkm/rFhYjtX0FtLh0FutL553jCS3SwXFXqoV1xECCEJb
         crZfM/EdO+MW3so6PwoK764fLJLOdowsGhS5AXBfq1TAraWWnsoBuXmyddczylcOatmM
         m37UMOyNp32+VqEioXFnji1ZgbTddvAxZ9YoxhfzYOMJk/kGS7N0WVXHRSY8IJCgF2ow
         Sm3mFGqpVYhoMAy4iKL8/jOMiqkZKdo4XWk/w49RWf2012CraIykNE5KxroCfjvKYBJD
         jGgLC04GynnmE7u9+iA4pF+pr6IvlKDAveLUzCdJS96SRPYnoxMQaIDfFMI0Cd7OkIQx
         WIOQ==
X-Gm-Message-State: AODbwcCif1qaxsXLpADHG0NoO24+6aiyVkau7FguqayDdXZxbUlAtRTL
        u6goVKfDF3IV8Jjp
X-Received: by 10.98.61.207 with SMTP id x76mr1295920pfj.170.1494989955251;
        Tue, 16 May 2017 19:59:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id r64sm664727pfr.38.2017.05.16.19.59.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 09/20] diff.c: convert builtin_diff to use emit_line_*
Date:   Tue, 16 May 2017 19:58:46 -0700
Message-Id: <20170517025857.32320-10-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
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

