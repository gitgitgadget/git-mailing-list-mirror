Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4394020984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbcIKFmi (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:38 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33514 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbcIKFme (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:34 -0400
Received: by mail-pa0-f67.google.com with SMTP id h5so6030588pao.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgXitO9M8L07DsW/6r6kE8IkPxeJUDDMuvH/6xHGnnQ=;
        b=yDaTgieB5aFmWVYhvnNArByYSNvTyxl2iZ9B8TCxXpLwMXjhr5AM7OP8Vk10pzCcBq
         qFz7qzoUcIEQJO5lFdGwacHMX5m8Z6NKBnOKRtbu1bL1mFi8SU+axNGTnad4VD2L9D39
         n+6nTLtnCN7pyH5yQGMjnekzXHdr2VZidM+xFBQZw7KK4WD88RoM0ii0scYVfWJnvRAS
         wzsdq3m+2PB5AYy2mqzMNVVvJ4e6mpBReeuyBmFzAvnbVnjMjyUJLT9WKaf5nSf+/80W
         q1cxsW4CaipscRsLvOog734bhQuiLn+lt2oWsnsOBxEj0xB/k+n8w5eW6jOpiUgwK4bR
         D90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgXitO9M8L07DsW/6r6kE8IkPxeJUDDMuvH/6xHGnnQ=;
        b=USgnvAfs+ffjr3mRAFaEeHjlCImwfMxYBkfV2IFYIN0T92gshORYnOopA1jy6iIBFZ
         SN0CNeFNlwPNB4o4nqyVlAbNYBUMSReJCfS7klLQyiEMcQrJzNrQNnGBQpP0nAztIZNh
         zdA/BZN3tAjoyVoEMqIh93NKQmc90u3T0Dns0yNzP+XD2GBjoImrcrVhjNNucf+Er6l7
         PxXaASS+ScrUTgVdh1VkUtYiwztD1Dw7w5gQonqh9teeeEXKlmfhJ148ke09aOtI5XWM
         dh7NY7ADkKeFKTsBCX/1kWBIce8y/SheE0+gWTcUS3P3NPBN1BTJtSiF0WGTobXwlHGV
         OG2g==
X-Gm-Message-State: AE9vXwMLB6ITfGsr1amT8YOJikC5rZjCES8qGwiDGS4LSMwTZycBAU3jlLF3QbRnPAoMZw==
X-Received: by 10.66.19.201 with SMTP id h9mr21646715pae.45.1473572553984;
        Sat, 10 Sep 2016 22:42:33 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id tj5sm15485247pab.37.2016.09.10.22.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:33 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/10] diff: emit_{add, del, context}_line to increase {pre,post}image line count
Date:   Sat, 10 Sep 2016 22:42:02 -0700
Message-Id: <1473572530-25764-3-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

At all call sites of emit_{add, del, context}_line we increment the line
count, so move it into the respective functions to make the code at the
calling site a bit clearer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index aa50b2d..156c2aa 100644
--- a/diff.c
+++ b/diff.c
@@ -536,6 +536,7 @@ static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	ecbdata->lno_in_postimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_NEW, WSEH_NEW, '+');
 }
@@ -544,6 +545,7 @@ static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_OLD, WSEH_OLD, '-');
 }
@@ -552,6 +554,8 @@ static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
+	ecbdata->lno_in_postimage++;
+	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
 }
@@ -662,13 +666,10 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
-		if (prefix != '+') {
-			ecb->lno_in_preimage++;
+		if (prefix != '+')
 			emit_del_line(reset, ecb, data, len);
-		} else {
-			ecb->lno_in_postimage++;
+		else
 			emit_add_line(reset, ecb, data, len);
-		}
 		size -= len;
 		data += len;
 	}
@@ -1293,16 +1294,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	switch (line[0]) {
 	case '+':
-		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	case '-':
-		ecbdata->lno_in_preimage++;
 		emit_del_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	case ' ':
-		ecbdata->lno_in_postimage++;
-		ecbdata->lno_in_preimage++;
 		emit_context_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	default:
-- 
2.7.4

