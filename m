Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE9420D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdE3FMg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:12:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:59605 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdE3FMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:12:35 -0400
Received: (qmail 12586 invoked by uid 109); 30 May 2017 05:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:12:36 +0000
Received: (qmail 20801 invoked by uid 111); 30 May 2017 05:13:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:13:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:12:33 -0400
Date:   Tue, 30 May 2017 01:12:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/8] credential: handle invalid arguments earlier
Message-ID: <20170530051233.3nqjtrxtokoudkww@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-credential command only takes one argument: the
operation to perform. If we don't have one, we complain
immediately. But if we have one that we don't recognize, we
don't notice until after we've read the credential from
stdin. This is likely to confuse a user invoking "git
credential -h", as the program will hang waiting for their
input before showing anything.

Let's detect this case early. Likewise, we never noticed
when there are extra arguments beyond the one we're
expecting. Let's catch this with the same conditional.

Note that we don't need to handle "--help" similarly,
because the git wrapper does this before even calling
cmd_credential().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/credential.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index 0412fa00f..879acfbcd 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -10,9 +10,9 @@ int cmd_credential(int argc, const char **argv, const char *prefix)
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
 
-	op = argv[1];
-	if (!op)
+	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage(usage_msg);
+	op = argv[1];
 
 	if (credential_read(&c, stdin) < 0)
 		die("unable to read credential from stdin");
-- 
2.13.0.613.g11c956365

