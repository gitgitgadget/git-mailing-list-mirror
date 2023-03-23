Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0790C76195
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCWUkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCWUku (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:40:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755BEF8F
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:40:48 -0700 (PDT)
Received: (qmail 26313 invoked by uid 109); 23 Mar 2023 20:40:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Mar 2023 20:40:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28080 invoked by uid 111); 23 Mar 2023 20:40:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Mar 2023 16:40:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Mar 2023 16:40:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] pack-redundant: escalate deprecation warning to an error
Message-ID: <20230323204047.GA9290@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In c3b58472be2 (pack-redundant: gauge the usage before proposing its
removal, 2020-08-25), we added a big, ugly warning when pack-redundant
is run. The plan there indicated that we would ratchet that up to an
error before finally removing it. Since it has been 2.5 years (and 9
releases) since then, let's continue with the plan.

Note that we did get one bite on the warning, which was somebody asking
about alternatives:

  https://lore.kernel.org/git/CAKvOHKAFXQwt4D8yUCCkf_TQL79mYaJ=KAKhtpDNTvHJFuX1NA@mail.gmail.com/

but we didn't undo the ugly warning (and the advice continues to be "use
repack -d" instead).

There was also some discussion around the time of the deprecation that
pack-redundant was invoked by the bitbake tool, and it still seems to do
so now:

  https://git.openembedded.org/bitbake

That use should probably just go away in favor of an occasional repack
(which probably even happens via auto-gc after fetch these days).

But since neither of those data points caused us to cancel the
deprecation plan by dropping the warning, it seems like we should
proceed with the next step.

Signed-off-by: Jeff King <peff@peff.net>
---
I was looking in this file recently, and was reminded of the deprecation
plan. The two data points above do give me a little bit of pause, but it
seems like the current state is the worst of both worlds: we do not have
the benefit of dropping the code, and people who try to use the command
have a bad experience. So we should probably either proceed (as with
this patch), or decide we need to keep pack-redundant.

 builtin/pack-redundant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 82115c5808c..5e93d873208 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -604,6 +604,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			"option, '--i-still-use-this', on the command line\n"
 			"and let us know you still use it by sending an e-mail\n"
 			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
+		die(_("refusing to run without --i-still-use-this"));
 	}
 
 	if (load_all_packs)
-- 
2.40.0.597.ge37e901cd8f
