Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385572023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbdEWClV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:21 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35212 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935989AbdEWClM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:12 -0400
Received: by mail-pf0-f178.google.com with SMTP id n23so99565412pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+olj/rTakmt6CYAxsgFJDe5Ss91wPltJ9jpKX37k//Q=;
        b=N6IN3VPv6ytR4KfD8eALeket6bv84X2VU0Yobpp/VEIhekvhJSuyOsRPlhmKSe74oK
         i0k9TCRm07tXkwSweVFExFJUv5Y/UyUFImOlMdr8Qj9S/8kx7o40kEirD1HyhKOE0/ay
         MUhISDhi89nTxwUKTSnuGp0++YqVpSngy87OpADOuA50gp/YSvXTqjTB2tldB154cahU
         fMfxIOehF1kJqYoJIvlfoPXNifAlPxVb1+NHGIp6xRYWxk+JTdEsrAQyT+cU2bhaKnYX
         8etlNwciiFuP3ggliQFpR/gHaenrQ0a7vUt0LxVHnIED6cHA30hIidnSkxE9SBQOrvYg
         laHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+olj/rTakmt6CYAxsgFJDe5Ss91wPltJ9jpKX37k//Q=;
        b=jJXkydltZLkdtUt4dqNuqhYIK8qDr7PIJmC4QByz7Uw6MOZAVf7niYBBS2sq1rmLaz
         t6kv76txyZXw4+OjpUYWm+1XcBMm9sdcvnTaVzZZGP/bgOr9Z7fNK54W5/iqI1FC1pks
         FqcGv6zojF87d8K6kDriXBrCShzYH89LnXDZZxCqJKsSFDFlcMpoLBNLu6ajwuqcItrH
         0pgLWUXlZiqECgltXMGDd/suh0vgc49rSr745e+fCsBLuNUdKkr2GPAHRF0pfZt0nr+9
         cTWgjuJRIsHjS9tAW2giyVWLk8XjWMV5IWZlLBFdk64ozkhJL4MKpAnHJKdMZCXtWBhv
         JA9A==
X-Gm-Message-State: AODbwcBBVXq9fDUE0D9kmVqCQKNoait18Hg/H8jhS+YFaIvRj+LEAY5k
        HYksKqvogDzXLFL3
X-Received: by 10.99.125.67 with SMTP id m3mr29342753pgn.153.1495507271360;
        Mon, 22 May 2017 19:41:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id o89sm34021132pfj.88.2017.05.22.19.41.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 08/17] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Mon, 22 May 2017 19:40:39 -0700
Message-Id: <20170523024048.16879-9-sbeller@google.com>
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

