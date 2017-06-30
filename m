Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495C6202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdF3AHw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:52 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35017 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdF3AHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:50 -0400
Received: by mail-pg0-f41.google.com with SMTP id j186so55114906pge.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmlbnO694CVmONxv9lkv20HV7BYzkO0RJC/4+ku4sO0=;
        b=rdJo0OkiyztOJIQ+Yo5ANni3QVT53UUTdxpIEXL+7TYFcQbGL/Rxm9TlYCU6gdl23A
         7L2vWWzcx/u3YOgNd39ckOeJi1uoPZHUewrTXWX782Jnar+6Awx9Y+RqahZHIghreLuB
         +wtxcd76QlRWziez+wHiVAL5sWQiRY7s47mmE9bkAlNqGZID2BvxIFWbiF0V6VPzLKC3
         hqX9bYcOXempZ5eINi0eVj0uhd7eY6Nr7tBlVUkTIORcDHw3iQm8aff6DTtAXVcO37Yn
         gNbC/edXwwPmES3lv2P2d8JhV+lZYL2FwQaAQvn0FviTpULQiTkTX6eAG5puawAXcu7+
         AZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmlbnO694CVmONxv9lkv20HV7BYzkO0RJC/4+ku4sO0=;
        b=F7pdWs2ep9ZfIjEpxe/J1ML+m0vlmW+MC7KtyiaU6EVJlWoLKNnILuQcbau6hH4DuH
         4/Mwecjyt5b2dK4qW3+5a+sO73mwEMxYMRr7rtatxZ+pVlRVI/ERHL+dvbuAB/1BKkIE
         5iV42xaGVXIgme9Jh5BzD2qCpKZUyVFiFDBspizHrGN3CIPhX5u9ddXCZyUStREeqWGy
         9R5JyDBynCF0xJhVKbfu6QtiL19WXdUbUuz5LUIe0s8e5tnjnz3/JzUDbDWBMCrD3A6V
         1g9XWIMcU1C5neV2HFFfZxd0SvT8X+39NmYlfnMEfMIfxxc6qMT4vA5vkVdGeCHyGY6T
         lobA==
X-Gm-Message-State: AKS2vOyN4AdcYaNq/kBswUANZLBpknW5P1AIaPC29ZLSkyeMNbZZ/AFI
        nc32w9FnFVtuvz78
X-Received: by 10.84.217.148 with SMTP id p20mr21074057pli.148.1498781260083;
        Thu, 29 Jun 2017 17:07:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id n81sm12557853pfb.31.2017.06.29.17.07.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/25] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
Date:   Thu, 29 Jun 2017 17:06:58 -0700
Message-Id: <20170630000710.10601-14-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

we could save a little bit of memory when buffering in a later mode
by just passing the inner part ("%s and %s", file1, file 2), but
those a just a few bytes, so instead let's reuse the implementation from
DIFF_SYMBOL_HEADER and keep the whole line around.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 78f7c6f82f..1d0f8b509f 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_BINARY_FILES,
 	DIFF_SYMBOL_HEADER,
 	DIFF_SYMBOL_FILEPAIR_PLUS,
 	DIFF_SYMBOL_FILEPAIR_MINUS,
@@ -690,6 +691,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			line, reset,
 			strchr(line, ' ') ? "\t" : "");
 		break;
+	case DIFF_SYMBOL_BINARY_FILES:
 	case DIFF_SYMBOL_HEADER:
 		fprintf(o->file, "%s", line);
 		break;
@@ -2542,6 +2544,7 @@ static void builtin_diff(const char *name_a,
 	} else if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
 		    !DIFF_OPT_TST(o, BINARY)) {
@@ -2554,8 +2557,11 @@ static void builtin_diff(const char *name_a,
 			}
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 					 header.buf, header.len, 0);
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
 			goto free_ab_and_return;
 		}
 		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
@@ -2572,9 +2578,13 @@ static void builtin_diff(const char *name_a,
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
-		else
-			fprintf(o->file, "%sBinary files %s and %s differ\n",
-				line_prefix, lbl[0], lbl[1]);
+		else {
+			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
+				    diff_line_prefix(o), lbl[0], lbl[1]);
+			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
+					 sb.buf, sb.len, 0);
+			strbuf_release(&sb);
+		}
 		o->found_changes = 1;
 	} else {
 		/* Crazy xdl interfaces.. */
-- 
2.13.0.31.g9b732c453e

