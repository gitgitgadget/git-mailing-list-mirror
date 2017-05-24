Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63DCF20209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161070AbdEXVl0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35615 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164167AbdEXVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:41:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so147415931pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+olj/rTakmt6CYAxsgFJDe5Ss91wPltJ9jpKX37k//Q=;
        b=l3bele6Xqgb5ypzlr724ImMbMRDlD7UtJVB0E3eVxP6vTploZfKLOh1dbtLGyNzGds
         CEbzMGnhtX0dPNU8w+zOXftc0zek31lmR8mixBObrKsNgxCIR0ZngxIkTG37ckNVA3Sk
         TgnX1Jd06BGeyNzOx0migzV2KZV1Dxs2y7o7bK+v9a9tFN3q4H4LpXBzmuPCrt9tJkVS
         N1KpdBGZex+sdRdm9BXr/6fkO6/NvOgZCreeWDAFqgbD4UhHfe5DUHwUKTOY8MVc7OSs
         du/Cx0Ljyl0tXaQFOtxed2KjxlKZY0w+FEdBX8TaP73bS1+7lBYei5uBEu1Cs6+a0n3Z
         qRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+olj/rTakmt6CYAxsgFJDe5Ss91wPltJ9jpKX37k//Q=;
        b=STLEXt6i21l46NAnPSPj3/bQ5teOc5WgO6B6Hn9LNoazOSxmmL7cpidC5P0zqq+5Tf
         UAfY6tPQulJ+++bzHQY1D6A8ZuYoPPLyOXZCODweIO8ZaSR7oqMlCX8QjScBfykbe7me
         WfCHui5uFvxFhiP/3FwBR4ouMRXZZYwUaXBkQvHEgoZvPCDKdJytaMpQYSceCAOvj9j2
         li1eZwbjUb0YFp1ksVhIBcWMuT29i0Kt2zTdLroZ3gZS5LT3HQRLVHcRVlDBDaIEHFK3
         8yS+zWgLjj5tJG8D/Ni3xENo30lygdyLOfr0UddTTTSiC0/MBi2D+HExDNNRUllq20m6
         Xy8A==
X-Gm-Message-State: AODbwcB0kzwYewPPwatyOcXO33fDxuwSjekugev/PgxF2+0JXulaVryc
        A2zIIutjoZ5i/8Ia
X-Received: by 10.98.139.206 with SMTP id e75mr40143556pfl.64.1495662051006;
        Wed, 24 May 2017 14:40:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id 134sm9224890pgh.43.2017.05.24.14.40.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 08/17] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Wed, 24 May 2017 14:40:27 -0700
Message-Id: <20170524214036.29623-9-sbeller@google.com>
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

This covers emit_rewrite_lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3dda9f3c8e..ca6b48cf49 100644
--- a/diff.c
+++ b/diff.c
@@ -722,15 +722,23 @@ static void add_line_count(struct strbuf *out, int count)
 static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
-	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
+	struct strbuf sb = STRBUF_INIT;
 
 	while (0 < size) {
 		int len;
 
-		endp = memchr(data, '\n', size);
-		len = endp ? (endp - data + 1) : size;
+		const char *endp = memchr(data, '\n', size);
+		if (endp)
+			len = endp - data + 1;
+		else {
+			strbuf_add(&sb, data, size);
+			strbuf_addch(&sb, '\n');
+			size = 0; /* to exit the loop. */
+
+			data = sb.buf;
+			len = sb.len;
+		}
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
 			emit_del_line(reset, ecb, data, len);
@@ -741,12 +749,13 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
+	if (sb.len) {
+		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line(ecb->opt, context, reset, 1, '\\',
-			  nneof, strlen(nneof));
+		emit_line(ecb->opt, context, reset, 1, 0,
+			    nneof, strlen(nneof));
+		strbuf_release(&sb);
 	}
 }
 
-- 
2.13.0.18.g7d86cc8ba0

