Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC8C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C346620787
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgEAGXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:23:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728126AbgEAGXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:23:36 -0400
Received: (qmail 1859 invoked by uid 109); 1 May 2020 06:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 06:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15561 invoked by uid 111); 1 May 2020 06:23:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 02:23:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 02:23:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: [PATCH 2/2] gitcredentials(7): make shell-snippet example more
 realistic
Message-ID: <20200501062316.GB25603@coredump.intra.peff.net>
References: <20200501061917.GC23665@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501061917.GC23665@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's an example of using your own bit of shell to act as a credential
helper, but it's not very realistic:

 - It's stupid to hand out your secret password to _every_ host. In the
   real world you'd use the config-matcher to limit it to a particular
   host.

 - We never provided a username. We can easily do that in another config
   option (you can do it in the helper, too, but this is much more
   readable).

 - We were sending the secret even for store/erase operations. This
   is OK because Git would just ignore it, but a real system would
   probably be unlocking a password store, which you wouldn't want to do
   more than necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
This is in fact very close to what's in my own ~/.gitconfig, except that
I swap out "cat" for the "pass" tool.

 Documentation/gitcredentials.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 8a20343dd7..63b20fc6a5 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -233,8 +233,9 @@ helper = "foo --bar='whitespace arg'"
 helper = "/path/to/my/helper --with-arguments"
 
 # or you can specify your own shell snippet
-[credential]
-helper = "!f() { echo password=$(cat $HOME/.secret); }; f"
+[credential "https://example.com"]
+username = your_user
+helper = "!f() { test $1 = get && echo password=$(cat $HOME/.secret); }; f"
 ----------------------------------------------------
 
 Generally speaking, rule (3) above is the simplest for users to specify.
-- 
2.26.2.933.gdf62622942
