Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACBC7619A
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjC3Tay (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjC3Tau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:30:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49674EB49
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:30:49 -0700 (PDT)
Received: (qmail 31354 invoked by uid 109); 30 Mar 2023 19:30:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 19:30:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20689 invoked by uid 111); 30 Mar 2023 19:30:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 15:30:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 15:30:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 4/5] tests: drop here-doc check from internal chain-linter
Message-ID: <20230330193047.GD27989@coredump.intra.peff.net>
References: <20230330192712.GA27719@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330192712.GA27719@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 99a64e4b73c (tests: lint for run-away here-doc, 2017-03-22)
tweaked the chain-lint test to catch unclosed here-docs. It works by
adding an extra "echo" command after the test snippet, and checking that
it is run (if it gets swallowed by a here-doc, naturally it is not run).

The downside here is that we introduced an extra $() substitution, which
happens in a subshell. This has a measurable performance impact when
run for many tests.

The tradeoff in safety was undoubtedly worth it when 99a64e4b73c was
written. But since the external chainlint.pl learned to find these
recently, we can just rely on it. By switching back to a simpler
chain-lint, hyperfine reports a measurable speedup on t3070 (which has
1800 tests):

  'HEAD' ran
    1.12 ± 0.01 times faster than 'HEAD~1'

Signed-off-by: Jeff King <peff@peff.net>
---
Now with 90% less hand-waving.

 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cfcbd899c5a..0048ec7b6f6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1101,9 +1101,10 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		test_eval_ "fail_117 && $1"
+		if test $? != 117
 		then
-			BUG "broken &&-chain or run-away HERE-DOC: $1"
+			BUG "broken &&-chain: $1"
 		fi
 		trace=$trace_tmp
 	fi
-- 
2.40.0.692.g7c4c956fc5c

