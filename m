Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F3C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A624E6124C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhFROU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFROU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 10:20:57 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Jun 2021 07:18:47 PDT
Received: from mailg110.ethz.ch (mailg110.ethz.ch [IPv6:2001:67c:10ec:5605::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D75AC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 07:18:47 -0700 (PDT)
Received: from mailm115.d.ethz.ch (2001:67c:10ec:5602::27) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Fri, 18 Jun
 2021 16:03:37 +0200
Received: from kiwi.localdomain (129.132.70.10) by mailm115.d.ethz.ch
 (2001:67c:10ec:5602::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Fri, 18 Jun
 2021 16:03:41 +0200
From:   Fabian Wermelinger <fabianw@mavt.ethz.ch>
To:     <git@vger.kernel.org>
CC:     Fabian Wermelinger <fabianw@mavt.ethz.ch>
Subject: [PATCH] completion: bash: fix late declaration of __git_cmd_idx
Date:   Fri, 18 Jun 2021 16:02:57 +0200
Message-ID: <20210618140256.256481-1-fabianw@mavt.ethz.ch>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [129.132.70.10]
X-ClientProxiedBy: mailm116.d.ethz.ch (2001:67c:10ec:5602::28) To
 mailm115.d.ethz.ch (2001:67c:10ec:5602::27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent update to contrib/completion/git-completion.bash causes bash to fail
auto complete custom commands that are wrapped with __git_func_wrap. Declaring
__git_cmd_idx=0 inside __git_func_wrap resolves the issue.

Signed-off-by: Fabian Wermelinger <fabianw@mavt.ethz.ch>
---
Fixes `bash: [: -lt: unary operator expected` error for tab completions
of wrapped `git` commands.  For example, assume the convenience command
`gaa` defined in a shell script as

```bash
git aa "$@"
```

where `git aa` is an alias to `git add --all`.  Then `gaa` is wrapped
for bash completion like

```bash
__git_complete gaa _git_add
```

For this example, the current bash completion fails at
`contrib/completion/git-completion.bash:1190` due to empty local
variable `c` as `__git_cmd_idx` is empty at the definition in
`contrib/completion/git-completion.bash:1179`.  Defining
`__git_cmd_idx=0` earlier in `__git_func_wrap` attempts to solve this
problem.

 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..ca5b456173 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3512,6 +3512,7 @@ fi
 __git_func_wrap ()
 {
 	local cur words cword prev
+	local __git_cmd_idx=0
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
 }
-- 
2.32.0

