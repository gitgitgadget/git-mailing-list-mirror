Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57002C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2124E619EC
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhCXFhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 01:37:40 -0400
Received: from smtp46.hk.chengmail.me ([113.10.190.102]:46214 "EHLO
        smtp46.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhCXFhX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 01:37:23 -0400
X-CHENGMAILHOST: 113.10.190.102
X-CHENGMAIL-INSTANCEID: 4d90.605ad00c.38468.1
From:   lilinchao@oschina.cn
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, lilinchao <lilinchao@oschina.cn>
Subject: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
Date:   Wed, 24 Mar 2021 13:36:48 +0800
X-source-message-id: <20210324053648.25584-2-lilinchao@oschina.cn>
X-Mailer: git-send-email 2.30.0.1006.g4a81e96670
In-Reply-To: <20210324053648.25584-1-lilinchao@oschina.cn>
References: <20210324053648.25584-1-lilinchao@oschina.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <006547b28c6311eb93820024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lilinchao <lilinchao@oschina.cn>

When clone with http protocol version 1, the server side
just tells client that "invalid server response, got version 1",
this is not clear enough, because version 0 is ok, and
version 2 is ok, then version 1 should be ok too intuitively,
but the other side just treat it as "invalid response", this
can't explain why is not ok.

>From receive-pack/upload-pack, there is a comment which I think,
can explain it:
"v1 is just the original protocol with a version string".
So I made this patch to try to fix it.

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
 remote-curl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0290b04891..1fe1f3c475 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -434,7 +434,8 @@ static void check_smart_http(struct discovery *d, const char *service,
 		 * be handled elsewhere.
 		 */
 		d->proto_git = 1;
-
+	} else if (!strcmp(reader.line, "version 1")) {
+		die(_("v1 is just the original protocol with a version string, use v0 or v2 instead."));
 	} else {
 		die(_("invalid server response; got '%s'"), reader.line);
 	}
-- 
2.30.0.1006.g4a81e96670

