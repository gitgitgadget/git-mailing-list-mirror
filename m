Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5A720248
	for <e@80x24.org>; Tue, 26 Feb 2019 21:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfBZVxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 16:53:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:4631 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfBZVxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 16:53:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 13:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="121030847"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.244.182])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2019 13:53:50 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] describe: bail of --contains --all is used with --exclude or --match
Date:   Tue, 26 Feb 2019 13:53:48 -0800
Message-Id: <20190226215348.5119-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.18.0.219.gaf81d287a9da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If you try to use git describe --contains with --all, the exclude and
match patterns are silently ignored.

This results in unexpected behavior, as you may try to provide patterns
and expect it to change the result.

Check for this, and have describe die when it encounters this, instead
of silently ignoring the provided options.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I just found this while trying to use it, the patterns weren't being applied
properly.

This is pretty quick/dirty, I haven't had time to write a test, or anything.

 builtin/describe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1409cedce2fb..1bf4b6e3d0ae 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -589,6 +589,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				argv_array_pushf(&args, "--refs=refs/tags/%s", item->string);
 			for_each_string_list_item(item, &exclude_patterns)
 				argv_array_pushf(&args, "--exclude=refs/tags/%s", item->string);
+		} else {
+			if (patterns.nr || exclude_patterns.nr)
+				die(_("--contains with --all does not support --match or --exclude"));
 		}
 		if (argc)
 			argv_array_pushv(&args, argv);
-- 
2.18.0.219.gaf81d287a9da

