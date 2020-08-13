Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E9C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0565720715
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgHMFZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:25:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgHMFZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:25:32 -0400
Received: (qmail 15561 invoked by uid 109); 13 Aug 2020 05:25:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 05:25:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10619 invoked by uid 111); 13 Aug 2020 05:25:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 01:25:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 01:25:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: [PATCH 3/3] blame: only coalesce lines that are adjacent in result
Message-ID: <20200813052531.GC2514880@coredump.intra.peff.net>
References: <20200813052054.GA1962792@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813052054.GA1962792@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After blame has finished but before we produce any output, we coalesce
groups of lines that were adjacent in the original suspect (which may
have been split apart by lines in intermediate commits which went away).
However, this can cause incorrect output if the lines are not also
adjacent in the result. For instance, the case in t8003 has:

  ABC
  DEF

which becomes

  ABC
  SPLIT
  DEF

Blaming only lines 1 and 3 in the result yields two blame groups (one
for each line) that were adjacent in the original. That's enough for us
to coalesce them into a single group, but that loses information: our
output routines assume they're adjacent in the result as well, and we
output:

  <oid> 1) ABC
  <oid> 2) SPLIT

This is nonsense for two reasons:

  - we were asked about line 3, not line 2; we should not output the
    SPLIT line at all

  - commit <oid> did not touch the SPLIT line at all! We found the
    correct blame for line 3, but the bug is actually in the output
    stage, which is showing the wrong line number and content from the
    final file.

We can fix this by only coalescing when both the suspect and result
lines are adjacent. That fixes this bug, but keeps coalescing in cases
where want it (e.g., the existing test in t8003 where SPLIT goes away,
and the lines really are adjacent in the result).

Reported-by: Nuthan Munaiah <nm6061@rit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 blame.c                       | 1 +
 t/t8003-blame-corner-cases.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/blame.c b/blame.c
index 82fa16d658..1be1cd82a2 100644
--- a/blame.c
+++ b/blame.c
@@ -1184,6 +1184,7 @@ void blame_coalesce(struct blame_scoreboard *sb)
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (ent->suspect == next->suspect &&
 		    ent->s_lno + ent->num_lines == next->s_lno &&
+		    ent->lno + ent->num_lines == next->lno &&
 		    ent->ignored == next->ignored &&
 		    ent->unblamable == next->unblamable) {
 			ent->num_lines += next->num_lines;
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 7f39a84289..ba8013b002 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -310,4 +310,13 @@ test_expect_success 'blame coalesce' '
 	test_cmp expect actual
 '
 
+test_expect_success 'blame does not coalesce non-adjacent result lines' '
+	cat >expect <<-EOF &&
+	$orig 1) ABC
+	$orig 3) DEF
+	EOF
+	git blame --no-abbrev -s -L1,1 -L3,3 $split giraffe >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.570.ge2c3ee08e4
