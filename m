Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710E420281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969154AbdEXFQr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33608 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969139AbdEXFQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id h4so31066463oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieyFtVdzl4UNS/sl66XVbCwYSb9ICGuzT9bB6I/Ci+U=;
        b=a7XFRuyVoYXTziXP5v7MgZiPl1FeqD1nPiP5ZgUoz/xD8aDRWIbDYMSWCywnIveSas
         hqtdTxw/T4rvFCGq/K1QGD9y3bA6d1TDTn8mkh8LVEkGw+bR7/efouBNWJzmD6aXl9YV
         7/nbhOblPJTMSMWcDY/AIET0xkKseRTDH4Hy3E6CkIestfj99Teh+9WHRl8APTqbA9a4
         SR/Xf2bF2oKx3rxEocCG+/Uc86W3MWZF2xvQXsilCyPHwmIS7/mXcbBkUAdZ4JHoX+dk
         u+IGHAIZckisnht5RBpena+yfrd3IqnMF69L8PwWWtLB1jP9NU0U6/jYzQc7Ax17DSYq
         7DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieyFtVdzl4UNS/sl66XVbCwYSb9ICGuzT9bB6I/Ci+U=;
        b=Yo9cj4jOLgXRmucOGhSDLQYCzX1eznILnYlCFoo78fxu2/L7t/aPv/qR56u1fyl/va
         06OPdaiAHzNdinEs0y5Dogptq1R3iudiErR+1rOL/3mVoaGCnTxvRcCwmrogSyxTRfdp
         cheS8EgAS53CAw/pzgjz309x9Mq+w4FHydeF+6j+yTgzRFxKFehsY4O9rjcZsdoOkIde
         JY4U/N+qqgyAl9AvE5WciTAWn+iFswhr+FEYT9ronsgLAq2Sm1VHmHaUalCAj22RZE0x
         UrgLZ0XBDSRbeiToVVRcXt1A/xE933oAgmgJtxqdDe96rT2Jjw0COfHLgx28NUsaYpIV
         NuqQ==
X-Gm-Message-State: AODbwcC73Ct8k5OShA0dqWIzLZ7/bXAgYTlQ3BcSZr6mD/41EcOhDJMk
        7HaSrod+4nNRV30keLY=
X-Received: by 10.157.30.163 with SMTP id n32mr4014816otn.192.1495602993445;
        Tue, 23 May 2017 22:16:33 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:32 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 12/29] blame: move contents_from to scoreboard
Date:   Wed, 24 May 2017 00:15:20 -0500
Message-Id: <20170524051537.29978-13-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument from --contents is used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 643f847..0955fc1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -378,6 +378,9 @@ struct blame_scoreboard {
 	 */
 	unsigned move_score;
 	unsigned copy_score;
+
+	/* use this file's contents as the final image */
+	const char *contents_from;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -2735,6 +2738,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.copy_score = BLAME_DEFAULT_COPY_SCORE;
 
 	sb.revs = &revs;
+	sb.contents_from = contents_from;
 	if (!reverse) {
 		final_commit_name = prepare_final(&sb);
 		sb.commits.compare = compare_commits_by_commit_date;
-- 
2.9.3

