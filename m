Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A595C201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757699AbdERTiL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:38:11 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35115 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757683AbdERTiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:08 -0400
Received: by mail-pg0-f49.google.com with SMTP id q125so27306653pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phc84LnN9XCscloCeISnt3Ufms1A68XX5FPStK7zMHU=;
        b=Lq5ZnyFFmZMTu3eDnLO8QoRDaCguO0reOL544tMKtwQ9JvDOlJUywmuZIH3PUx08er
         5nKzPzuO8HqEUKFSudzbCFNGTocQzhUBQqL0vzQn7Aac17N2uIh5PyPp5oGqs6dvHtHv
         ditEehkrCg3HIwk+EKiUEvGqo5eqj3EKHToBhtbTsG9mcODa3ppjJq8HDiolCMB220eV
         MGk+wEVGq4/+OWVE3Rap552jLY3tFqAPPAcpZKnTlYAL5kf66Jf0nCs/pUKEOzn84bCd
         p8kHK4eQy8mZQdDbv4+l8adFoEVjb1K317EtCBfQPiKSJQq8WmmXprDHtp8nyeHt8urV
         qfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phc84LnN9XCscloCeISnt3Ufms1A68XX5FPStK7zMHU=;
        b=mrXHDEaYle1bM6fEonr+b9bjtCeC49NIPuvXqMsIi+h99JPfsPT+SYZ06Jhq62lFJu
         55ipM0xO/ineuGAVcTllzUKf0T0gy1wsoaYRLn8f3ACSlqu3ZOYUkgqty3Q1fhkjM5o0
         cxICY3jEksCvZ4YkQ1B34jPGgiUx5wm195bdoFZsfqny+x91Ohp8W/1HUdJ+URZGZ4ic
         jmRT/B4QRLWXWLpHN5mwskU1uqgaZ5Mokl68VYl3Yr2aDFpluGGbPR76j9DB4cjhn3vr
         U6ZxtKOvfFh5aS6u4BYUL6/2Rb/GULoqLT+ipvq3KrcgI1HHUd8G1rUEhaiLk0N3TsLL
         N+kQ==
X-Gm-Message-State: AODbwcB9UfANm3aBsF26+TAjbX9eQhE3ix+XEEe/seiXUIqHoT5UrjH4
        1VO9wNLtZDq///tU
X-Received: by 10.98.153.76 with SMTP id d73mr6316739pfe.223.1495136287590;
        Thu, 18 May 2017 12:38:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id l67sm10238529pfc.18.2017.05.18.12.38.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 11/20] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Thu, 18 May 2017 12:37:37 -0700
Message-Id: <20170518193746.486-12-sbeller@google.com>
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

This covers emit_rewrite_lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
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

