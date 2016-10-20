Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E7E1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbcJTUib (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:38:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:38936 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbcJTUia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:38:30 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP; 20 Oct 2016 13:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,372,1473145200"; 
   d="scan'208";a="1056813694"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2016 13:38:30 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] rev-list: use hdr_termination instead of a always using a newline
Date:   Thu, 20 Oct 2016 13:38:25 -0700
Message-Id: <4d43c7686b2c39b3615ad303066fd222f8d2ed75.1476995794.git-series.jacob.keller@gmail.com>
X-Mailer: git-send-email 2.10.1.637.g1dc9b33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When adding support for prefixing output of log and other commands using
--line-prefix, commit 660e113ce118 ("graph: add support for
--line-prefix on all graph-aware output", 2016-08-31) accidentally
broke rev-list --header output.

In order to make the output appear with a line-prefix, the flow was
changed to always use the graph subsystem for display. Unfortunately
the graph flow in rev-list did not use info->hdr_termination as it was
assumed that graph output would never need to putput NULs.

Since we now always use the graph code in order to handle the case of
line-prefix, simply replace putchar('\n') with
putchar(info->hdr_termination) which will correct this issue.

Add a test for the --header case to make sure we don't break it in the
future. Implement a helper function test_ends_with_nul() to make it more
obvious what sort of check we are looking for.

Reported-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Changes in v2
* Squash Junio's suggested (better) test
* Add Junio's signed-off-by since he wrote the new test

 builtin/rev-list.c       |  2 +-
 t/t6000-rev-list-misc.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git c/builtin/rev-list.c c/builtin/rev-list.c
index 8479f6ed28aa..c43decda7011 100644
--- c/builtin/rev-list.c
+++ c/builtin/rev-list.c
@@ -145,7 +145,7 @@ static void show_commit(struct commit *commit, void *data)
 			 */
 			if (buf.len && buf.buf[buf.len - 1] == '\n')
 				graph_show_padding(revs->graph);
-			putchar('\n');
+			putchar(info->hdr_termination);
 		} else {
 			/*
 			 * If the message buffer is empty, just show
diff --git c/t/t6000-rev-list-misc.sh c/t/t6000-rev-list-misc.sh
index 3e752ce03280..969e4e9e5261 100755
--- c/t/t6000-rev-list-misc.sh
+++ c/t/t6000-rev-list-misc.sh
@@ -100,4 +100,18 @@ test_expect_success '--bisect and --first-parent can not be combined' '
 	test_must_fail git rev-list --bisect --first-parent HEAD
 '
 
+test_expect_success '--header shows a NUL after each commit' '
+	# We know that there is no Q in the true payload; names and
+	# addresses of the authors and the committers do not have
+	# any, and object names or header names do not, either.
+	git rev-list --header --max-count=2 HEAD |
+	nul_to_q |
+	grep "^Q" >actual &&
+	cat >expect <<-EOF &&
+	Q$(git rev-parse HEAD~1)
+	Q
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: 659889482ac63411daea38b2c3d127842ea04e4d
-- 
git-series 0.8.10
