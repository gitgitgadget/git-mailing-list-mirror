Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BFB1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423107AbdAISuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:50:40 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33297 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968682AbdAISuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:50:39 -0500
Received: by mail-pf0-f174.google.com with SMTP id y143so11829446pfb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cJ1Qlr5dlJk/ZWvcAiTwQIDyPk9D4KmtOEnhUQBDELE=;
        b=D5lZQXpWyGm+knjxvQgbtnCqwVgMARJKr65uKPmqWgISeGj+hRLoOTXzJvC9wKjvLe
         /HssgnTkgHrpL0rrFdMQZSOMW3GDRsKz+nCzLWi9dvcdYafNMtLT4TFT5h91m8Zazy/p
         /uGyhm5XHNxfvpEw9kjiVECM5egif0TlZkXvXR807BHkKCswYmACWc4IK6TpY4MkVBa7
         S5LozfVTorZvGwH7pD7+vrsdBaiVJYE3s00Bd2+LY+Ixg5IjMPBRWUgr5vMt6XuihsH0
         sKAg6YPpIQfxx8wDDaGiGn9PK7b06Gvs9WDHF1AA7TcDO+Xgn1p3Sg+OrV9EeIQFZf3Q
         bFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cJ1Qlr5dlJk/ZWvcAiTwQIDyPk9D4KmtOEnhUQBDELE=;
        b=fVmDR9mw69+qBURDox71Lxj9186f4Jbd7wtWSopVDhOCw2lpqKKufLQD8E16CDmhlo
         RfWwzIOVhXAANvhsyNfKWX1OFx6mXLscaDE3aYOy89K6uMkbtGs2RDqBrEXMclfe/7HR
         rx5b5ayOMXMGLPKMM4Ik3ssydN2/oOIFUqYUVClvzg/bcYPuc9pdipxx5/0ftV+P0//d
         CnbEmvVNOtYLtSQG3A5lpfdGUq39AzabcpFIQ7YPLhDjBPEECxjO8+XoEH3EuHPfPJoX
         6F8R5J200UDGxXGHxoxVB3Vm0NKYmRcCiXuiR4V9G/6x0y71GA7Bz1kUXubGmoEHpfeV
         AiSw==
X-Gm-Message-State: AIkVDXIl5Eq5+lVSbIm8ny0AvYUDofdcdaY0lM0yCCpH54rP+rwZQ1WC8CmAnaSvqvDHSHb/
X-Received: by 10.84.197.1 with SMTP id m1mr192923842pld.75.1483987838975;
        Mon, 09 Jan 2017 10:50:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id k192sm162988408pgc.3.2017.01.09.10.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 10:50:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: [PATCH 1/2] real_path: prevent redefinition of MAXSYMLINKS
Date:   Mon,  9 Jan 2017 10:50:23 -0800
Message-Id: <20170109185024.73006-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
References: <xmqqzij0t7uh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The macro 'MAXSYMLINKS' is already defined on macOS and Linux in
<sys/param.h>.  If 'MAXSYMLINKS' has already been defined, use the value
defined by the OS otherwise default to a value of 32 which is more
inline with what is allowed by many systems.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/abspath.c b/abspath.c
index 1d56f5ed9..0393213e5 100644
--- a/abspath.c
+++ b/abspath.c
@@ -62,7 +62,9 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 }
 
 /* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXSYMLINKS 5
+#ifndef MAXSYMLINKS
+#define MAXSYMLINKS 32
+#endif
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
-- 
2.11.0.390.gc69c2f50cf-goog

