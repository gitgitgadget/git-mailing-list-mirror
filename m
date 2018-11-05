Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F70F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeKEP52 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:57:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:57:28 -0500
Received: (qmail 21588 invoked by uid 109); 5 Nov 2018 06:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17110 invoked by uid 111); 5 Nov 2018 06:38:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:38:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:39:20 -0500
Date:   Mon, 5 Nov 2018 01:39:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/13] ls-files: mark exclude options as NONEG
Message-ID: <20181105063919.GC25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "git ls-files --no-exclude" will currently segfault, as its
option callback does not handle the "unset" parameter.

In theory this could be used to clear the exclude list, but it is not
clear how that would interact with the other exclude options, nor is the
current code capable of clearing the list. Let's just disable the broken
option.

Note that --no-exclude-from will similarly segfault, but
--no-exclude-standard will not. It just silently does the wrong thing
(pretending as if --exclude-standard was specified).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f9919a362..2787453eb1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -548,15 +548,16 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			    N_("show resolve-undo information")),
 		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
 			N_("skip files matching pattern"),
-			0, option_parse_exclude },
+			PARSE_OPT_NONEG, option_parse_exclude },
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
 			N_("exclude patterns are read from <file>"),
-			0, option_parse_exclude_from },
+			PARSE_OPT_NONEG, option_parse_exclude_from },
 		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
 			N_("read additional per-directory exclude patterns in <file>")),
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
 			N_("add the standard git exclusions"),
-			PARSE_OPT_NOARG, option_parse_exclude_standard },
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			option_parse_exclude_standard },
 		OPT_SET_INT_F(0, "full-name", &prefix_len,
 			      N_("make the output relative to the project top directory"),
 			      0, PARSE_OPT_NONEG),
-- 
2.19.1.1505.g9cd28186cf

