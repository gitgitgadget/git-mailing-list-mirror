Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8308420286
	for <e@80x24.org>; Thu,  7 Sep 2017 14:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755388AbdIGOmF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:42:05 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:32996 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754273AbdIGOmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:42:04 -0400
Received: by mail-qt0-f178.google.com with SMTP id i50so28002731qtf.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ZeL0CTZpBTcplAxasf9wOTYnasp/GQORD+kjAbJMAQ=;
        b=Rv8+VQmdrWf+ndheGvyMKwB0NSp2v9E3CLdPFkX20g92J3NPx8YLDnSSUNfLQWHZxv
         mO0odjitQLupcET7bt9BJil9kAbNn1PYEfaAj/GxK7HqKD5z9dyjpwMXciD6BRgEgtOZ
         DGMQ8N382RXIORmk9h9E3mHJa700eJBV/r+gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ZeL0CTZpBTcplAxasf9wOTYnasp/GQORD+kjAbJMAQ=;
        b=R7/qSChhNHQSN7hktsDIJRuifVRhkBHOnMfQcOSUvo6y7lDMdcJ0zeF8aPUpnIIULw
         zcwP02qOOwey26N90SWKQrMKAPxBGEWM1W0yvvb9SVssuNOC/gjMvomwDJVukxJRGDYF
         P2PdykfxTfa4qfwrVrQqe2zMWxNVeLWKBMPrWVEYRRSmPA/KBsBJgUBNb8YXt22IzpzZ
         n7XCxPkNjwuNiRlvG1Q5YHY7244lZ3F+XVB0rqvpMgAnJa+hoFtkNrgWu8GttrZQZAO7
         Z+pfA04b+4lj/9PzD7KOYYUK1X/eWhrgYqsaKMTbaCNa7OFzdDJqjI9w7wt5Ui4FJTzc
         XTaA==
X-Gm-Message-State: AHPjjUip0EICxW8dQ1RMqv47z+dbpv1y6Ot7CbKyhlnoBdq9B61zHbZo
        /gakM8yb+Y7/tfZJ
X-Google-Smtp-Source: ADKCNb6zFZvHNZEIQ/K0IWd7ALQjtCoGPJCHsgZ6sW7A4k/1CSMMNrkg08AGym/iZwT2ghyhgf3xew==
X-Received: by 10.237.37.182 with SMTP id x51mr4321385qtc.9.1504795323512;
        Thu, 07 Sep 2017 07:42:03 -0700 (PDT)
Received: from AERODSK168.aerotechad.com ([64.58.240.2])
        by smtp.gmail.com with ESMTPSA id w20sm1712819qkb.72.2017.09.07.07.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Sep 2017 07:42:03 -0700 (PDT)
From:   Ross Kabus <rkabus@aerotech.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ross Kabus <rkabus@aerotech.com>
Subject: [PATCH] commit-tree: don't append a newline with -F
Date:   Thu,  7 Sep 2017 10:41:11 -0400
Message-Id: <20170907144111.7488-1-rkabus@aerotech.com>
X-Mailer: git-send-email 2.13.1.windows.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change makes it such that commit-tree -F never appends a newline
character to the supplied commit message (either from file or stdin).

Previously, commit-tree -F would always append a newline character to
the text brought in from file or stdin. This has caused confusion in a
number of ways:
  - This is a plumbing command and it is generally expected not to do
    text cleanup or other niceties.
  - stdin piping with "-F -" appends a newline but stdin piping without
    -F does not append a newline (inconsistent).
  - git-commit does not specifically append a newline to the "-F"
    input. The issue is somewhat muddled by the fact that git-commit
    does pass the message through its --cleanup option, which may add
    such a newline. But for commit-tree to match "commit --cleanup=verbatim",
    we should not do so here.

Signed-off-by: Ross Kabus <rkabus@aerotech.com>
---
 builtin/commit-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 19e898fa4..2177251e2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			if (fd && close(fd))
 				die_errno("git commit-tree: failed to close '%s'",
 					  argv[i]);
-			strbuf_complete_line(&buffer);
 			continue;
 		}
 
-- 
2.13.1.windows.2

