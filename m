Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E0D1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJCCwv (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 22:52:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:4996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJCCwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 22:52:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 13:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="268937592"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.177.161])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2018 13:07:11 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3] coccicheck: process every source file at once
Date:   Tue,  2 Oct 2018 13:07:10 -0700
Message-Id: <20181002200710.15721-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.18.0.219.gaf81d287a9da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

make coccicheck is used in order to apply coccinelle semantic patches,
and see if any of the transformations found within contrib/coccinelle/
can be applied to the current code base.

Pass every file to a single invocation of spatch, instead of running
spatch once per source file.

This reduces the time required to run make coccicheck by a significant
amount of time:

Prior timing of make coccicheck
  real    6m14.090s
  user    25m2.606s
  sys     1m22.919s

New timing of make coccicheck
  real    1m36.580s
  user    7m55.933s
  sys     0m18.219s

This is nearly a 4x decrease in the time required to run make
coccicheck. This is due to the overhead of restarting spatch for every
file. By processing all files at once, we can amortize this startup cost
across the total number of files, rather than paying it once per file.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index df1df9db78da..da692ece9e12 100644
--- a/Makefile
+++ b/Makefile
@@ -2715,10 +2715,8 @@ endif
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
 	ret=0; \
-	for f in $(COCCI_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-			{ ret=$$?; break; }; \
-	done >$@+ 2>$@.log; \
+	$(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
+	ret=$$?; \
 	if test $$ret != 0; \
 	then \
 		cat $@.log; \
-- 
2.18.0.219.gaf81d287a9da

