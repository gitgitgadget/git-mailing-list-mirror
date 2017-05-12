Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9D8201A7
	for <e@80x24.org>; Fri, 12 May 2017 21:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758583AbdELVeh (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 17:34:37 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39450 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758370AbdELVeg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 17:34:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 13B5C280AD;
        Fri, 12 May 2017 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494624875;
        bh=R94ula5Hlt+ikES7punsl5xAaZgdBVKHUfhB5tHRMNE=;
        h=From:To:Cc:Subject:Date:From;
        b=hZi2nTicvntUzuDWAqjflEDCmwFPtz91fcGBYGfRId96NHkkORujeekuKtX5/yOjg
         lSj7rwG2r5wSnAlPvofn8gFvlPkusSmZcZLYwQzPNe/l3J035Dt/jl1V267zBtXxhU
         jBx/Vt2gKIk9m0efIS4FtRGt4JL7XpPt6ht7whCvDOKtYtetrJtPcZacmZz/GXmB0x
         oAVnOREDf4PHHXQCmWwvYAUGOTSprRAUiN5wzGOw4Us0rB1tRpQYTkN9MnuPahZo+l
         7u5w87pcuJnf0XjSHrZDbeqpLE2VrnfdS6VotIYg4K0ARRtOMKbZ151oOoKCDXk6zM
         x6FOqF16DD11WrwTu4eaKaZPShpa+9u/2EX1NiCGH1KHAEzFd9t8DLKBw0JMVlhYwD
         nvZVka/OsAbPiVf8XUzfSB/RbdZvYeGyaH1i7WKEcO5mhYY/yoMvnqKb/zBLw0NWmQ
         A5N9qAcH8Atat7ouXHtuqjlPO5mi7owXiX6fGSvrnYQZZGGR66i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/log: honor log.decorate
Date:   Fri, 12 May 2017 21:34:07 +0000
Message-Id: <20170512213407.46251-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent change that introduced autodecorating of refs accidentally
broke the ability of users to set log.decorate = false to override it.
When the git_log_config was traversed a second time with an option other
than log.decorate, the decoration style would be set to the automatic
style, even if the user had already overridden it.  Only set the option
to its default value if we haven't set it already.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1e..304923836 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -34,7 +34,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int default_follow;
 static int default_show_signature;
-static int decoration_style;
+static int decoration_style = -1;
 static int decoration_given;
 static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
@@ -410,7 +410,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		if (decoration_style < 0)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
-	} else {
+	} else if (decoration_style == -1) {
 		decoration_style = auto_decoration_style();
 	}
 	if (!strcmp(var, "log.showroot")) {
