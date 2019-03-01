Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E5B20248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfCASQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:16:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:34632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728212AbfCASQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:16:49 -0500
Received: (qmail 19643 invoked by uid 109); 1 Mar 2019 18:16:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 18:16:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32140 invoked by uid 111); 1 Mar 2019 18:17:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 13:17:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 13:16:47 -0500
Date:   Fri, 1 Mar 2019 13:16:47 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] completion: fix multiple command removals
Message-ID: <20190301181647.GA30847@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-4-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301173443.16429-4-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 12:34:43PM -0500, Todd Zullinger wrote:

> The commit message could probably be worded better, particularly since it's
> forged in your name.

What you have is OK, but I'd have probably written it like this:

-- >8 --
Subject: [PATCH] completion: fix multiple command removals

Commit 6532f3740b ("completion: allow to customize the completable
command list", 2018-05-20) tried to allow multiple space-separated
entries in completion.commands. To do this, it copies each parsed token
into a strbuf so that the result is NUL-terminated.

However, for tokens starting with "-", it accidentally passes the
original non-terminated string, meaning that only the final one worked.
Switch to using the strbuf.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 help.c                | 4 ++--
 t/t9902-completion.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 520c9080e8..026f881715 100644
--- a/help.c
+++ b/help.c
@@ -393,8 +393,8 @@ void list_cmds_by_config(struct string_list *list)
 		const char *p = strchrnul(cmd_list, ' ');
 
 		strbuf_add(&sb, cmd_list, p - cmd_list);
-		if (*cmd_list == '-')
-			string_list_remove(list, cmd_list + 1, 0);
+		if (sb.buf[0] == '-')
+			string_list_remove(list, sb.buf + 1, 0);
 		else
 			string_list_insert(list, sb.buf);
 		strbuf_release(&sb);
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index dd11bb660d..d7daa1ca92 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1483,7 +1483,7 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
 
-test_expect_failure 'completion.commands removes multiple commands' '
+test_expect_success 'completion.commands removes multiple commands' '
 	echo cherry-pick >expected &&
 	test_config_global completion.commands "-cherry -mergetool" &&
 	git --list-cmds=list-mainporcelain,list-complete,config |
-- 
2.21.0.675.g01c085a870

