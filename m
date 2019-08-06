Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A011F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfHFM11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:27:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:35152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726092AbfHFM11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:27:27 -0400
Received: (qmail 16546 invoked by uid 109); 6 Aug 2019 12:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1266 invoked by uid 111); 6 Aug 2019 12:29:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:29:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:27:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] common-main: delay trace2 initialization
Message-ID: <20190806122725.GB13513@sigill.intra.peff.net>
References: <20190806122601.GA21475@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806122601.GA21475@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We initialize the trace2 system in the common main() function so that
all programs (even ones that aren't builtins) will enable tracing. But
trace2 startup is relatively heavy-weight, as we have to actually read
on-disk config to decide whether to trace. This can cause unexpected
interactions with other common-main initialization. For instance, we'll
end up in the config code before calling initialize_the_repository(),
and the usual invariant that the_repository is never NULL will not hold.

Let's push the trace2 initialization further down in common-main, to
just before we execute cmd_main(). The other parts of the initialization
are much more self-contained and less likely to call library code that
depends on those kinds of invariants.

Originally the trace2 code tried to start as early as possible to get
accurate timings. But the timer initialization was split out from the
config reading in a089724958 (trace2: refactor setting process starting
time, 2019-04-15), so there shouldn't be any impact from this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common-main.c b/common-main.c
index 582a7b1886..71e21dd20a 100644
--- a/common-main.c
+++ b/common-main.c
@@ -39,16 +39,16 @@ int main(int argc, const char **argv)
 
 	git_resolve_executable_dir(argv[0]);
 
-	trace2_initialize();
-	trace2_cmd_start(argv);
-	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
-
 	git_setup_gettext();
 
 	initialize_the_repository();
 
 	attr_start();
 
+	trace2_initialize();
+	trace2_cmd_start(argv);
+	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
+
 	result = cmd_main(argc, argv);
 
 	trace2_cmd_exit(result);
-- 
2.23.0.rc1.436.g24d2e81391

