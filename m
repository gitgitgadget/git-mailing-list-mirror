Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F12207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbcIMEqb (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:31 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34007 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbcIMEq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id wk8so3852330pab.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3txntLkWLSwAgSG6VunvXOhnBozMwg5h3Zh5I1Pzk3A=;
        b=pI48xFV3hBb4uYkLjxzZXJhQQJFdWPupT0jPflZ7ZJUUeiTX/CpFWR69n4Gmx/mXbn
         QTyKHCjQ5pIDXgMwLCKO4uTGvdW9wryslNK3yJZ1P2GznB7f2ztOtFiizFJcidqWu8P0
         C1VrRF5jKZZZB986tYlsvL7csHoodejb7HLGdmYnyS8sShkB70g6VxQko/4xYhTKiS8K
         7/xycudzLCyh/zOgxhskdQNvux5pUgqQyIx8HwTqbdLFN+Gfgm0tYdwFmD9mDR4S99o3
         W7/KFdEv6OJos3V6NJ5sqj/x+hBQSMo8e9pqTPX80t7IKOKuySBkhAdvyvVUyT4f+9Op
         L6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3txntLkWLSwAgSG6VunvXOhnBozMwg5h3Zh5I1Pzk3A=;
        b=mbiBrnAGwe8AhW8ZhGAeQg/glg+kP3o9Lf3zNA0sEPk0jR1dr4OBS3ltcIXk7PyuH+
         ClTcxf4sUONHaxW42T/rI+c/084JVFL4e5O7zhJWHRjxARXLE4uLi6DP+mHGJieDQd3O
         B87qd/mrjdP4Erobbx+iqkmEMH2YQPlbD1bmYTjx1ledOSFgCjbD1JbIwA5h1EnlJTDn
         AIFYm08Yg0U8hns7bX8VZ4CJ7/T/J6zhHiD+fi17E+05uTTZJN560WSGlO4r2aF0KJR/
         nP03VJtjdLPnc29qsiotW7mrc0g9sn9bOYsGfW3oyM56vfC7ZbQIUz5QFL2AUUYdM13T
         fvtA==
X-Gm-Message-State: AE9vXwO3aGbYUUBg0xPQGHskrjUOsaPiuf6E5m/iRu8vbBHwVir0eNyjKi4LiZymDPnnKbKP
X-Received: by 10.67.23.4 with SMTP id hw4mr24031929pad.7.1473741985735;
        Mon, 12 Sep 2016 21:46:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id h86sm27799819pfh.46.2016.09.12.21.46.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:25 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 05/17] diff.c: emit_line_0 can handle no color setting
Date:   Mon, 12 Sep 2016 21:46:01 -0700
Message-Id: <20160913044613.1037-6-sbeller@google.com>
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

In later patches we may pass lines that are not colored to
the central function emit_line_0, so we
need to emit the color only when it is non-NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index b6a40ae..5d57130 100644
--- a/diff.c
+++ b/diff.c
@@ -473,11 +473,13 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 	}
 
 	if (len || !nofirst) {
-		fputs(set, file);
+		if (set)
+			fputs(set, file);
 		if (!nofirst)
 			fputc(first, file);
 		fwrite(line, len, 1, file);
-		fputs(reset, file);
+		if (reset)
+			fputs(reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
-- 
2.10.0.21.g1da280f.dirty

