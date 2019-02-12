Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19E21F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfBLW1F (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLW1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so254496edt.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePXM7FhkCgO3lJqYKMyCH6eac5RW533wyq2qZRgbEeI=;
        b=i/Q7kYHCyTupqr5fwpNOGsB6BQdCSqh3UtYrF+TZ+rWNjy6mBMHzopwU1WVBEEmUSv
         adMgZ2RuZS0yWJfdmBZISo74RbxOZTCvqRCXwSunkQyjzxW8bnJCg4qpevDBIrdwahHU
         nb0oFTyHZHOk3s5MGJCrvbrstc2oimE12qcoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePXM7FhkCgO3lJqYKMyCH6eac5RW533wyq2qZRgbEeI=;
        b=FzpFKCv/BqdeQ59yc2gBhqPRSwg8N4Hlq7/oB2ek0uH7W34LnjQDfKumJ8rHANSstH
         dz4WKjosTO4j8wdkYdNOYVfOEViAZ6qGOZWkHo6U05/ka9lTvzYg6f8KZscRLiHDRcau
         lEt4vbukS2MZb5/dTYgHn5lm4PYx6SlMW6+rIuMNCPRvySPpcD1UpasEwAfRv9OU8p/q
         IYDGYbJ8QUX9Qtgcnr29kO7sXI++uw0/z6t5xUDyu9loKeTLC1EhshbES1Fl2hTud9Zn
         CcPsuB46UA6Z+GcM7gmYAyBsK8FFFYBE4lNzLcAgia+CpJyJt2xmifhO4pFOLlx4OFsY
         X1JA==
X-Gm-Message-State: AHQUAubbTStvmOHeTmUKuKg3kPqxZrviKb5u78+xCJaGodSfKQiG+pl7
        NBu2DITTKKNSzXaBH0riJNedUMbnfMMFSe//
X-Google-Smtp-Source: AHgI3IZoBAXlDRAYDTJauVP6l9wuCjbhHoGGuh2TYL2BpAtNvrhCJvtPZZrBjVD5nZlfAQwE/CtkoA==
X-Received: by 2002:a17:906:7e57:: with SMTP id z23mr4190314ejr.222.1550010421942;
        Tue, 12 Feb 2019 14:27:01 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id ay20sm3349582ejb.32.2019.02.12.14.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 14:27:01 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC PATCH 2/5] builtin/grep.c: refactor loop in work_done() slightly
Date:   Tue, 12 Feb 2019 23:26:51 +0100
Message-Id: <20190212222654.7432-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
References: <20190212222654.7432-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As preparation for changing all accesses to the todo array to use a
helper function, do the .done check in the loop body.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 6c1e90d43b..211ae54222 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -137,9 +137,11 @@ static void work_done(struct work_item *w)
 	grep_lock();
 	w->done = 1;
 	old_done = todo_done;
-	for(; todo[todo_done].done && todo_done != todo_start;
+	for(; todo_done != todo_start;
 	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
 		w = &todo[todo_done];
+		if (!w->done)
+			break;
 		if (w->out.len) {
 			const char *p = w->out.buf;
 			size_t len = w->out.len;
-- 
2.20.1

