Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC3C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B48E6137D
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhDPTUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:20:10 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39790 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhDPTUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:20:09 -0400
Received: by mail-lf1-f54.google.com with SMTP id x20so16090274lfu.6
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 12:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CUqFGVERy9nKLbheatF1V/2XdggipRXf25E/LeHIUw=;
        b=kWikdreOTSXoCeDT85BnHWgtysgYyqg6z30qoRRBDyfQGDNIzJMLT2V5AjqX/xanx/
         5CS8/HprYxfCwU0DI9S1/oEeIEZ4AQ/YKqi8nfiUnQ7QJ2+N6xby0+J6Sz6sDdJZyaxn
         Ze+FbtwVL3L4WKhSLQAOQMR3S7kXOARuqf24voqkF9GwHz9DYCwrqE9CiZv1WYlBd34w
         p6W7uGb4gUgb6CPFMVEbOfKlN+4jEoIdsZ7BmGXF5HRA3BCCfxJspTDJOdgaJoptrXPX
         QcM2uL61sZEWmj68dMT4Gbkh8CdU0RdmFrCknSom7rSOVhBEBa1zZ7ZK1YYTJ5MHDEX0
         hLjA==
X-Gm-Message-State: AOAM530Dql9hRkgLTp6PcQPDTPBwRCSxXAHYpslMbpbDcgzJfDrMSlu1
        Co4HvaS1QJPq07H9XFRtmdSdGFj5WwY6ZQ==
X-Google-Smtp-Source: ABdhPJxG5WELn1fBuU1A8up3Dp0V0c8o8fFJQNkfvKZE4EXkKRkowutRwg+qeYi5LkNX5N2VUmMKiA==
X-Received: by 2002:a19:a410:: with SMTP id q16mr4139491lfc.73.1618600782171;
        Fri, 16 Apr 2021 12:19:42 -0700 (PDT)
Received: from localhost.localdomain (dygkyxjnl9h7-9h5z0nly-4.rev.dnainternet.fi. [2001:14bb:150:99d:69e9:b7fe:9b34:f2d2])
        by smtp.gmail.com with ESMTPSA id o16sm1071670lfu.228.2021.04.16.12.19.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:19:41 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: avoid aliased command lookup error in nounset mode
Date:   Fri, 16 Apr 2021 22:19:39 +0300
Message-Id: <20210416191939.1120651-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aliased command lookup accesses the `list` variable before it has been
set, causing an error in "nounset" mode. Initialize to an empty string
to avoid that.

    $ git nonexistent-command <Tab>bash: list: unbound variable

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dfa735ea62..49e76e9d08 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1129,7 +1129,7 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local cur=$1 last list word cmdline
+	local cur=$1 last list= word cmdline
 
 	while [[ -n "$cur" ]]; do
 		if [[ "$list" == *" $cur "* ]]; then
-- 
2.25.1

