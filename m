Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63D3201A7
	for <e@80x24.org>; Wed, 17 May 2017 18:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbdEQSlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 14:41:04 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:49783 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdEQSlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 14:41:03 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wSjnV1Wpdz5tlF;
        Wed, 17 May 2017 20:41:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 89A0142E7;
        Wed, 17 May 2017 20:41:01 +0200 (CEST)
Subject: Re: t5400 failure on Windows
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
 <20170515222406.hxab2wrapv75ybmj@sigill.intra.peff.net>
 <afca6bf5-472e-dda4-2c16-a2256080ac51@kdbg.org>
 <20170517054424.cq66cl5ukvhsz34y@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <83b6c8d3-2787-995a-a4e5-e6a437c53e89@kdbg.org>
Date:   Wed, 17 May 2017 20:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170517054424.cq66cl5ukvhsz34y@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.2017 um 07:44 schrieb Jeff King:
> I wonder if there's a way we could convince the trace for the two
> programs to go to separate locations. We don't care about receive-pack's
> trace at all. So maybe:

This works. Below it is with a commit message. I'm unsure about the
sign-off procedure, though.

>> * refs/files-backend.c: There are uses in functions open_or_create_logfile()
>> and log_ref_setup(). Sounds like it is in reflogs. Sounds like this is about
>> reflogs. If there are concurrent accesses, there is a danger that a reflog
>> is not recorded correctly. Then reflogs may be missing and objects may be
>> pruned earlier than expected. That's something to worry about, but I would
>> not count it as mission critical.

Of course, the reflog can also be corrupted, but:

> We should always hold the matching ref lock already when modifying a
> reflog. I seem to recall there was a case that missed this (I think
> maybe modifying the HEAD reflog without holding HEAD.lock), but it was
> fixed in the last few versions.

we should be fairly safe then.

---- 8< ----
From: Jeff King <peff@peff.net>
Subject: [PATCH jk/alternate-ref-optim] t5400: avoid concurrent writes into a trace file

One test in t5400 examines the packet exchange between git-push and
git-receive-pack. The latter inherits the GIT_TRACE_PACKET environment
variable, so that both processes dump trace data into the same file
concurrently. This should not be a problem because the trace file is
opened with O_APPEND.

On Windows, however, O_APPEND is not atomic as it should be: it is
emulated as lseek(SEEK_END) followed by write(). For this reason, the
test is unreliable: it can happen that one process overwrites a line
that was just written by the other process. As a consequence, the test
sometimes does not find one or another line that is expected (and it is
also successful occasionally).

The test case is actually only interested in the output of git-push.
To ensure that only git-push writes to the trace file, override the
receive-pack command such that it does not even open the trace file.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5400-send-pack.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3331e0f534..d375d7110d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,10 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace git push fork HEAD:foo &&
+	GIT_TRACE_PACKET=$(pwd)/trace \
+	    git push \
+		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
+		fork HEAD:foo &&
 	extract_ref_advertisement <trace >refs &&
 	test_cmp expect refs
 '
-- 
2.13.0.55.g17b7d13330
