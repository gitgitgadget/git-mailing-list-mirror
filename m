Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F0220281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969165AbdEXFQy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35483 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969159AbdEXFQu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id m17so31048047oik.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTfTfM3CfawwX4vfOdhpUT81gMaJHgLhJLGdWZXmP+Y=;
        b=onJlV73NR0nfTLjxqH51ZInqparEkCp6zZCX3CbgNYAsQPJtoKr3oEeuWhNCqlVRH7
         UPfjcKc0uVAb8dSaqOvyxlJQMGkAK+eandbkwISe7ao14stO2428pxjWICcxus1b6POs
         A/3D20VorWIPOVJlmvpb9xIeuaeY9g7r45TVx6nUo1yMVUCy4aE0aXjR96z109OL1v4G
         6JkqE3Xg2O2iEH6IbQWM6BJfMWEQnXKZdcXSBC/awsBpojFEyWXoK6ssyOH5SkSv0Qqd
         sv7Xw+oOe6K+2FAw3Psf1YnaZKJSrypU6birKw+C9FOkYi6Is38JLpaOe8VqBQPXYQ5i
         PJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTfTfM3CfawwX4vfOdhpUT81gMaJHgLhJLGdWZXmP+Y=;
        b=WEnMoWJKUNLLhZ917OQ8CUGWgVlYCCHSer8MFQszUJeruvXrNxy+Ew+6Jc2c5Pd28a
         OJKNkPvTp+UQUoHg2Sm1KQpUxtmIDMZOn5S7axu4MiXk3nokxbGzjfpCcwbBgl+pgB86
         7CKJf9vvHtBUVUeva2c2RTsI/pyTWrQWPMmWQLQRtklTYEt6KMFb0dq8MLqPcSRkAfY2
         4vTIJIWjSRR90NvdgYjbsB+cnh/xwgnkENucay0zV7CqlT9zIcT8apcKGBuzPEVuuIb5
         7gXZNfkfjf403UM4PkyTUYQoFK34vc039FUqVgtNsK6KZrUlixywmCNZkufviJfiXNgV
         BvSA==
X-Gm-Message-State: AODbwcCOledzosPfXhI6rsrKSL5ZyxcBniSllGqnaQrnOq3ReaSBn0QW
        USNhtcaHaXwbdA==
X-Received: by 10.157.40.93 with SMTP id h29mr4002647otd.184.1495602999957;
        Tue, 23 May 2017 22:16:39 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:38 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 16/29] blame: move no_whole_file_rename flag to scoreboard
Date:   Wed, 24 May 2017 00:15:24 -0500
Message-Id: <20170524051537.29978-17-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The no_whole_file_rename flag is used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8e676fb..90c643c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -386,6 +386,7 @@ struct blame_scoreboard {
 	int reverse;
 	int show_root;
 	int xdl_opts;
+	int no_whole_file_rename;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -1411,7 +1412,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
-	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
+	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
 		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
@@ -2889,6 +2890,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.show_root = show_root;
 	sb.xdl_opts = xdl_opts;
+	sb.no_whole_file_rename = no_whole_file_rename;
 
 	read_mailmap(&mailmap, NULL);
 
-- 
2.9.3

