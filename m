Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412331F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeC2SBj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:01:39 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:25434 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeC2SBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1480; q=dns/txt; s=iport;
  t=1522346497; x=1523556097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rJzZzyzR50+/p8rT5XTSJs4IHhCLi3RpwAcHn7YLkYQ=;
  b=FIM457Q/8Fzc0G1ocoqh5FAMjBsRD7VlYWjfFn/EBzjJyHPhPotfNaPm
   feOLEidhyWpZp4iC/nFeYzpdGf6sVsRZrn3ASHOk5Y6dQInM5Ws5f5hs9
   7xtRxSmGipszqj8CWLGd9ZGrjtUo+f4GbbxJ6YzRjipxVNixAVD8K/6Os
   I=;
X-IronPort-AV: E=Sophos;i="5.48,378,1517875200"; 
   d="scan'208";a="372330864"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2018 18:01:31 +0000
Received: from sjc-ark-dv01.cisco.com (sjc-ark-dv01.cisco.com [10.30.219.73])
        by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id w2TI1UNF001607;
        Thu, 29 Mar 2018 18:01:30 GMT
Received: by sjc-ark-dv01.cisco.com (Postfix, from userid 5489)
        id 664313FC0C; Thu, 29 Mar 2018 11:01:30 -0700 (PDT)
From:   Erik E Brady <brady@cisco.com>
To:     git@vger.kernel.org
Cc:     Erik E Brady <brady@cisco.com>
Subject: [PATCH] credential: ignore SIGPIPE when writing to credential helpers
Date:   Thu, 29 Mar 2018 11:00:56 -0700
Message-Id: <20180329180056.9941-1-brady@cisco.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180329175501.GE31833@sigill.intra.peff.net>
References: <20180329175501.GE31833@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The credential subsystem can trigger SIGPIPE when writing to an
external helper if that helper closes its stdin before reading the
whole input. Normally this is rare, since helpers would need to read
that input to make a decision about how to respond, but:

1. It's reasonable to configure a helper which only handles "get"
   while ignoring "store".  Such a handler might not read stdin
   for "store", thereby rapidly closing stdin upon helper exit.

2. A broken or misbehaving helper might exit immediately. That's an
   error, but it's not reasonable for it to take down the parent Git
   process with SIGPIPE.

Even with such a helper, seeing this problem should be rare. Getting
SIGPIPE requires the helper racily exiting before we've written the
fairly small credential output.

Signed-off-by: Erik E Brady <brady@cisco.com>
---
 credential.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/credential.c b/credential.c
index 9747f47b1..62be651b0 100644
--- a/credential.c
+++ b/credential.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "url.h"
 #include "prompt.h"
+#include "sigchain.h"
 
 void credential_init(struct credential *c)
 {
@@ -227,8 +228,10 @@ static int run_credential_helper(struct credential *c,
 		return -1;
 
 	fp = xfdopen(helper.in, "w");
+	sigchain_push(SIGPIPE, SIG_IGN);
 	credential_write(c, fp);
 	fclose(fp);
+	sigchain_pop(SIGPIPE);
 
 	if (want_output) {
 		int r;
-- 
2.16.3.dirty

