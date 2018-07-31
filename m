Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557101F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeGaCJe (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:34 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:39328 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:34 -0400
Received: by mail-ua0-f202.google.com with SMTP id t14-v6so3336921uao.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RcYa34472xd7I5B5wGH/jd6zPPb6gJ87GDkpdoZDlDg=;
        b=Bxhe2d15VhLH/ZunGe+LETuvNGUTeZbeVLiMZ1Lh0RNPZNIuViEfrCWGeIkp7L0psN
         iSk5/xsRZMuIrFj09mPs6cdCEPw6e4IDxdY0Y957NdD3Er9CdeOPckQR0CTTFBjdZFXS
         WGJ26aZMaPO8eTKytSFc5Jhr2XrrENqHCRiZQzjLTlkugT+onL8QGTqyPCFnI/DDUU88
         ejSGMs1PR6sqOAuE0MU+Au9/3NBMJqO5dpxas1DV6YJvoEXNRRTfEf8W8niWV4YLXtmP
         7ZZuIFGcbHc3VWlYMd4lXgav8og1RXatXvBi6oysHg8J4lft97Pm1mKQ46B+G2RkZzeH
         E3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RcYa34472xd7I5B5wGH/jd6zPPb6gJ87GDkpdoZDlDg=;
        b=AIaWbLdQbjM7j6CEiIQ1kOX0SFC0zzv9ZBsQtLHqJbJHOqLBal233ISKNF1r2QzWYc
         d6APbgPIZNjB7kzaAU7bS/DMD+41X8A66FNqZxuPLIqpYltIWRkf9pbWZi6E8hRSg0Ne
         thxVIGGLUOQC+3/hAbg5pPUc938eHg5T3z7SsWE8O+lcviksQxBTzYBoA/cJ2NJ30sXQ
         VtwVEcq+W3xM+2FmTUQflqigyV2a3UY951DJKDGL5MY0Ti179Ynpl5yTy7dN49EAHRsQ
         xjNB0/tRoghncnFjz01rs7Q/bNX8gXAi/cgJBQ0FKe5UHECKLLof/huznjp99ilCzq/G
         +BTw==
X-Gm-Message-State: AOUpUlHWcosarD6G1Erk1o/v4QdobOYaxwLwWV75gMxq4ADsDloTpn+y
        zDu6+qeHAy1wpRrYzOOiyLZuEhE4aUSr
X-Google-Smtp-Source: AAOMgpdhoEWPhh4VDlTU2n6kbpvFzy3+h/Lkx+MfVH8mdi7QTFxGp3/kzBx5Ps6sTg9fqBQljLJvN4T1Op+x
MIME-Version: 1.0
X-Received: by 2002:a1f:b20d:: with SMTP id b13-v6mr9540261vkf.67.1532997121896;
 Mon, 30 Jul 2018 17:32:01 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:39 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-7-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 6/8] diff: use emit_line_0 once per line
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All lines that use emit_line_0 multiple times per line, are combined
into a single call to emit_line_0, making use of the 'set' argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index a36ed92c54c..fdad7ffdd77 100644
--- a/diff.c
+++ b/diff.c
@@ -583,10 +583,7 @@ static void emit_line_0(struct diff_options *o,
 	int nofirst;
 	FILE *file = o->file;
 
-	if (first)
-		fputs(diff_line_prefix(o), file);
-	else if (!len)
-		return;
+	fputs(diff_line_prefix(o), file);
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
@@ -606,13 +603,17 @@ static void emit_line_0(struct diff_options *o,
 	if (len || !nofirst) {
 		if (reverse && want_color(o->use_color))
 			fputs(GIT_COLOR_REVERSE, file);
-		if (set_sign && set_sign[0])
-			fputs(set_sign, file);
+		if (set_sign || set)
+			fputs(set_sign ? set_sign : set, file);
 		if (first && !nofirst)
 			fputc(first, file);
-		if (set)
-			fputs(set, file);
-		fwrite(line, len, 1, file);
+		if (len) {
+			if (set_sign && set && set != set_sign)
+				fputs(reset, file);
+			if (set)
+				fputs(set, file);
+			fwrite(line, len, 1, file);
+		}
 		fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
@@ -999,16 +1000,13 @@ static void emit_line_ws_markup(struct diff_options *o,
 	if (!ws && !set_sign)
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
 	else if (!ws) {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, NULL, !!set_sign, reset, sign, "", 0);
-		emit_line_0(o, set, NULL, 0, reset, 0, line, len);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
-- 
2.18.0.132.g195c49a2227

