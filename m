Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F2E1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbeGMRMK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:31839 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbeGMRMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 66E9D3F481C;
        Fri, 13 Jul 2018 12:56:42 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F32283F4817;
        Fri, 13 Jul 2018 12:56:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 20/25] structured-logging: add structured logging to remote-curl
Date:   Fri, 13 Jul 2018 16:56:16 +0000
Message-Id: <20180713165621.52017-21-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

remote-curl is not a builtin command and therefore, does not inherit
the common cmd_main() startup in git.c

Wrap cmd_main() with slog_cmd_main() in remote-curl to initialize
logging.

Add slog timers around push, fetch, and list verbs.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 remote-curl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 99b0bed..ed910f8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1322,8 +1322,9 @@ static int stateless_connect(const char *service_name)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+static int real_cmd_main(int argc, const char **argv)
 {
+	int slog_tid;
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
@@ -1333,6 +1334,8 @@ int cmd_main(int argc, const char **argv)
 		return 1;
 	}
 
+	slog_set_command_name("remote-curl");
+
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
@@ -1362,14 +1365,20 @@ int cmd_main(int argc, const char **argv)
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit)
 				die("remote-curl: fetch attempted without a local repo");
+			slog_tid = slog_start_timer("curl", "fetch");
 			parse_fetch(&buf);
+			slog_stop_timer(slog_tid);
 
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
 			int for_push = !!strstr(buf.buf + 4, "for-push");
+			slog_tid = slog_start_timer("curl", "list");
 			output_refs(get_refs(for_push));
+			slog_stop_timer(slog_tid);
 
 		} else if (starts_with(buf.buf, "push ")) {
+			slog_tid = slog_start_timer("curl", "push");
 			parse_push(&buf);
+			slog_stop_timer(slog_tid);
 
 		} else if (skip_prefix(buf.buf, "option ", &arg)) {
 			char *value = strchr(arg, ' ');
@@ -1411,3 +1420,8 @@ int cmd_main(int argc, const char **argv)
 
 	return 0;
 }
+
+int cmd_main(int argc, const char **argv)
+{
+	return slog_wrap_main(real_cmd_main, argc, argv);
+}
-- 
2.9.3

