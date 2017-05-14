Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D83B20188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbdENEBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:42 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32915 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdENEBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:40 -0400
Received: by mail-pg0-f50.google.com with SMTP id u187so45854856pgb.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JiUrSdrgCvhdKzHLSOxEdqPAUZunNAZqKygeoZ9pgf8=;
        b=CvFACD3R1ZRv1/5zKdo9qDBEjYNQcjVdDM61QsnvLgCaZEMXAg35yYx5Qhuvruzoxp
         qk6kLX2E7g/SqCpvae5mCq5mNWWFEM/8EEitJn40FJkEhvYnjLS351CWnPJNnJ3fUaPd
         vg2QCErp6JbJAm9Sdh5wWPRnenYq8lStasENDt+Nc2K18iXIJbDvuxu4s6sOVGO1RiCY
         cdxhPwdfhL8Eql03XEQgVxkg8ladPBV/atl5y+6nEiJQW8qCaWpWnpbzrhYI11DsSF4M
         4BOKFZe1PPgzO6ergnAtNdrc4S3Dtz6blaXyZLGygpBubl8BwCMkEMbUu/pp5Utbf+Z4
         nvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JiUrSdrgCvhdKzHLSOxEdqPAUZunNAZqKygeoZ9pgf8=;
        b=n+vYitkNm8Q74PRIw6PVRQxV5h2kHyUBGkxvnT5UnCkLKbN1zhPcIZBEpUuNSI54on
         lYQY3/1t9IzBY+ZMZifqsJo8KabL0TzjKfRTtsn4ujqGD0fYHhofADHRNRGZYqcLM2Pn
         PxICN/uLwZsHrQDTULIxx/04pkySSNnYKRNBAORv7j5A/e1YCJTxw2h5TTP3DEw+sr6N
         v0e2St9ugOBBUIXiXO5UpZAk1WTO877nWf4Y0VhKxGALtSe2bKLx8dfrOjZZT1+DM8Nb
         25CShhbExu99VmJKiLhQkUZePiyeJ4fIivIddKlLHdAdfY6kAxx9+SZ3+x2whwnHt+yc
         MU8A==
X-Gm-Message-State: AODbwcABHGGp9Zr/ewM54A0wbPok3eOzk+YxoOUkOsAWDg9slWPKaaUg
        i864Qg8Zgjh1NnAi
X-Received: by 10.84.174.197 with SMTP id r63mr16100739plb.67.1494734499702;
        Sat, 13 May 2017 21:01:39 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id q28sm12302589pgc.0.2017.05.13.21.01.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:38 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/19] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Sat, 13 May 2017 21:01:08 -0700
Message-Id: <20170514040117.25865-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
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
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index e4b46fee4f..369c804f03 100644
--- a/diff.c
+++ b/diff.c
@@ -748,7 +748,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 	if (!endp) {
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
+		emit_line(ecb->opt, NULL, NULL, "\n", 1);
 		emit_line_0(ecb->opt, context, reset, '\\',
 			    nneof, strlen(nneof));
 	}
-- 
2.13.0.18.g183880de0a

