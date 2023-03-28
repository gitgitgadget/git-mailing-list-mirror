Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE54C761A6
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1UXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjC1UXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:23:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA1EB
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:23:03 -0700 (PDT)
Received: (qmail 1958 invoked by uid 109); 28 Mar 2023 20:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1759 invoked by uid 111); 28 Mar 2023 20:23:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:23:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:23:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 2/4] tests: replace chainlint subshell with a function
Message-ID: <20230328202302.GB1241631@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To test that we don't break the &&-chain, test-lib.sh does something
like:

   (exit 117) && $test_commands

and checks that the result is exit code 117. We don't care what that
initial command is, as long as it exits with a unique code. Using "exit"
works and is simple, but is a bit expensive since it requires a subshell
(to avoid exiting the whole script!). This isn't usually very
noticeable, but it can add up for scripts which have a large number of
tests.

Using "return" naively won't work here, because we'd return from the
function eval-ing the snippet (and it wouldn't find &&-chain breakages).
But if we further push that into its own function, it does exactly what
we want, without extra subshell overhead.

According to hyperfine, this produces a measurable improvement when
running t3070 (which has 1800 tests, all of them quite short):

  'HEAD' ran
    1.09 ± 0.01 times faster than 'HEAD~1'

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 09789566374..cfcbd899c5a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1086,6 +1086,10 @@ test_eval_ () {
 	return $test_eval_ret_
 }
 
+fail_117 () {
+	return 117
+}
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
@@ -1097,7 +1101,7 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			BUG "broken &&-chain or run-away HERE-DOC: $1"
 		fi
-- 
2.40.0.616.gf524ec75088

