Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417931FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbcLQTy0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 14:54:26 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33697 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbcLQTyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 14:54:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id g1so1761819pgn.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BM6+/Vj71+6kdoknT2/GBRrKTugJSxIP1dI22ctN7zA=;
        b=h7CX7+hEJVJhSIXoHlaGs9tN0saVMNt/xuFhuWJ3us/H+VaLUUOF0neu5AjincZO9e
         LYdyUV5H1O4w7ZNovNiaLX7UbEbZCSehY7H18JWizoT0gOW+4MvTUUf/gtdwYf7QWRCa
         HJGVyc7hAX0gMrDxw7dLn1P2Mjt5mSw4r4HAbWfvvFtqjQTe/zDJJihvwZgqijiFRKSV
         1lFueGV+ZFRJTVh4QgljLfhZviV+xwYyIUukjZMhpfRYLEDU8QlP+IMwlxc4QgtmVXH+
         EHV+bSWjue7Z0/qrroFpyHOlItgZ9Jf9Ean5seeeFz4uVBAc0+HqWfO147F12yP7WpDR
         dEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BM6+/Vj71+6kdoknT2/GBRrKTugJSxIP1dI22ctN7zA=;
        b=PJEtVjJHkB1We+DZJAZyj/PbCdKTTDxroMyEUQ5m6iKkvFP4sH8gJZp/+R0021vkjn
         SMSProe8YY1Op+nnw5BIT0sPpRE4OO/Cv+rTMBikfWMxL28FQjnVyZ7sVVdtQU9Qhhfp
         xMzJD9va6D+PLpb17ZxOUXaHuPLxHQ1qLDx1bZFmvEDvWiWcKTsOYidnBaxyNT7Ykp/D
         Tlg5sOj2We+wuHhZLfgOhjDkdx8+bk7NNQGf+OrKRMRpqBIDZWzcVDdnLZkfppUdBAUc
         XCzEv8nydDy4nm9U9QSI2Wa13IaDbU5vYA91bt4YLKSSzDISsjTrwdu65Zb835aciKyO
         G40w==
X-Gm-Message-State: AIkVDXL9j87J9Oj9sZ+px1JNVo/hUYfZbf2OAzybCu413RLTESntbzmO02/mxha6Viji+A==
X-Received: by 10.99.49.11 with SMTP id x11mr1771648pgx.92.1482004464091;
        Sat, 17 Dec 2016 11:54:24 -0800 (PST)
Received: from localhost.localdomain ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id 186sm20678311pfv.61.2016.12.17.11.54.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 11:54:23 -0800 (PST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] mailinfo.c: move side-effects outside of assert
Date:   Sat, 17 Dec 2016 11:54:18 -0800
Message-Id: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 6b4b013f18 (mailinfo: handle in-body header continuations,
2016-09-20, v2.11.0) mailinfo.c has contained new code with an
assert of the form:

	assert(call_a_function(...))

The function in question, check_header, has side effects.  This
means that when NDEBUG is defined during a release build the
function call is omitted entirely, the side effects do not
take place and tests (fortunately) start failing.

Move the function call outside of the assert and assert on
the result of the function call instead so that the code
still works properly in a release build and passes the tests.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

Notes:
    Please include this PATCH in 2.11.x maint

 mailinfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index 2fb3877e..47442fb5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -708,9 +708,12 @@ static int is_scissors_line(const char *line)
 
 static void flush_inbody_header_accum(struct mailinfo *mi)
 {
+	int okay;
+
 	if (!mi->inbody_header_accum.len)
 		return;
-	assert(check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0));
+	okay = check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0);
+	assert(okay);
 	strbuf_reset(&mi->inbody_header_accum);
 }
 
---
