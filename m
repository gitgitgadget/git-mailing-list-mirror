Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7C81F453
	for <e@80x24.org>; Wed, 17 Oct 2018 09:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJQRT5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 13:19:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:43242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726482AbeJQRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 13:19:57 -0400
Received: (qmail 18266 invoked by uid 109); 17 Oct 2018 09:25:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 09:25:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18786 invoked by uid 111); 17 Oct 2018 09:24:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 05:24:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 05:25:07 -0400
Date:   Wed, 17 Oct 2018 05:25:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] test-tool: show tool list on error
Message-ID: <20181017092506.GA15503@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before we switched to one big test-tool binary, if you
forgot the name of a tool, you could use tab-completion in
the shell to get a hint. But these days, all you get is:

  $ t/helper/test-tool approxidate
  fatal: There is no test named 'approxidate'

and you're stuck reading the source code to find it. Let's
print a list of the available tools in this case.

Signed-off-by: Jeff King <peff@peff.net>
---
Not really user-facing, but this bugged me enough earlier to write the
patch. ;)

Some of the individual tools have nice help, too (try
"t/helper/test-tool date", which shows the approxidate command I was
looking for), but some of them could probably stand to improve their
friendliness (try "t/helper/test-tool config"). I think it's fine for
people to improve them over time if and when they get annoyed.

 t/helper/test-tool.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 6b5836dc1b..5df8b682aa 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -55,13 +55,23 @@ static struct test_cmd cmds[] = {
 	{ "write-cache", cmd__write_cache },
 };
 
+static NORETURN void die_usage(void)
+{
+	size_t i;
+
+	fprintf(stderr, "usage: test-tool <toolname> [args]\n");
+	for (i = 0; i < ARRAY_SIZE(cmds); i++)
+		fprintf(stderr, "  %s\n", cmds[i].name);
+	exit(128);
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	int i;
 
 	BUG_exit_code = 99;
 	if (argc < 2)
-		die("I need a test name!");
+		die_usage();
 
 	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
@@ -70,5 +80,6 @@ int cmd_main(int argc, const char **argv)
 			return cmds[i].fn(argc, argv);
 		}
 	}
-	die("There is no test named '%s'", argv[1]);
+	error("there is no tool named '%s'", argv[1]);
+	die_usage();
 }
-- 
2.19.1.790.g519f91cad4
