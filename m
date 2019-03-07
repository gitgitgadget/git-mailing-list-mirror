Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231BF20248
	for <e@80x24.org>; Thu,  7 Mar 2019 19:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCGTpR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 14:45:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:43028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726207AbfCGTpR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 14:45:17 -0500
Received: (qmail 6322 invoked by uid 109); 7 Mar 2019 19:45:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 19:45:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27018 invoked by uid 111); 7 Mar 2019 19:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 14:45:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 14:45:15 -0500
Date:   Thu, 7 Mar 2019 14:45:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] line-log: suppress diff output with "-s"
Message-ID: <20190307194514.GA29260@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "-L" is in use, we ignore any diff output format that the user
provides to us, and just always print a patch (with extra context lines
covering the whole area of interest). It's not entirely clear what we
should do with all formats (e.g., should "--stat" show just the diffstat
of the touched lines, or the stat for the whole file?).

But "-s" is pretty clear: the user probably wants to see just the
commits that touched those lines, without any diff at all. Let's at
least make that work.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a repost from the thread at:

  https://public-inbox.org/git/CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com/

 line-log.c          | 6 ++++--
 t/t4211-line-log.sh | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/line-log.c b/line-log.c
index 24e21731c4..59248e37cc 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1103,10 +1103,12 @@ static int process_all_files(struct line_log_data **range_out,
 
 int line_log_print(struct rev_info *rev, struct commit *commit)
 {
-	struct line_log_data *range = lookup_line_range(rev, commit);
 
 	show_log(rev);
-	dump_diff_hacky(rev, range);
+	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
+		struct line_log_data *range = lookup_line_range(rev, commit);
+		dump_diff_hacky(rev, range);
+	}
 	return 1;
 }
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index bd5fe4d148..c9f2036f68 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -115,4 +115,11 @@ test_expect_success 'range_set_union' '
 	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
 '
 
+test_expect_success '-s shows only line-log commits' '
+	git log --format="commit %s" -L1,24:b.c >expect.raw &&
+	grep ^commit expect.raw >expect &&
+	git log --format="commit %s" -L1,24:b.c -s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.21.0.787.g929e938557
