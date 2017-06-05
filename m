Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504DA1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdFES4E (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:56:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:34995 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdFES4D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:56:03 -0400
Received: (qmail 30946 invoked by uid 109); 5 Jun 2017 18:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 18:56:02 +0000
Received: (qmail 16791 invoked by uid 111); 5 Jun 2017 18:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 14:56:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 14:56:01 -0400
Date:   Mon, 5 Jun 2017 14:56:01 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: t5313-pack-bounds-checks.sh flaky?
Message-ID: <20170605185601.yzbq5e6r2tfbgzqw@sigill.intra.peff.net>
References: <9A7C995F-ED4F-4AEB-B2B7-00FF05B80E84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9A7C995F-ED4F-4AEB-B2B7-00FF05B80E84@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 12:33:44PM +0200, Lars Schneider wrote:

> Hi Peff,
> 
> t5313.7 failed recently on master [1]. Are you aware of any flaky parts
> in this test?

No, I've never seen it fail. I poked at it some in response to your
message and couldn't convince it fail under load. We corrupt the pack
index and expect that Git can't read the pack, but in your test output
somehow we could:

> expecting success: 
> 	# We need two objects here, so we can plausibly require
> 	# an extended table (if the first object were larger than 2^31).
> 	do_pack "$object $(git rev-parse HEAD)" --index-version=2 &&
> 
> 	# We have to make extra room for the table, so we cannot
> 	# just munge in place as usual.
> 	{
> 		dd if=$idx bs=1 count=$(($(ofs_table 2) + 4)) &&
> 		printf "\200\0\0\0" &&
> 		printf "\377\0\0\0\0\0\0\0" &&
> 		dd if=$idx bs=1 skip=$(extended_table 2)
> 	} >tmp &&
> 	mv tmp "$idx" &&
> 	clear_base &&
> 	test_must_fail git cat-file blob $object &&
> 	test_must_fail git index-pack --verify $pack
> 
> 1084+0 records in
> 1084+0 records out
> 1084 bytes (1.1 kB) copied, 0.00119315 s, 909 kB/s
> 40+0 records in
> 40+0 records out
> 40 bytes (40 B) copied, 6.9825e-05 s, 573 kB/s
> 74
> test_must_fail: command succeeded: git cat-file blob fff0a2476aa5c8e60a3ef21cfc66e0cc670920be

I'm not sure where we would have found that object. It _is_ in another
packfile, but our clear_base() call should drop that (and restore it
after the test finishes).

Hmm. This test does have _two_ objects in the pack, and the other is a
commit whose sha1 may vary based on the timestamp. The object whose
entry we corrupt always has a sha1 starting with fff0a24. That's
generally likely to be the second object in index-order, and I think the
test probably relies on that when doing its corruption. But there's a
1-in-16^3 probability that the commit sha1 also starts with fff and
sorts after $object.

So if that was the case I'd expect it to fail about once in every 4096
runs. I'm surprised not to have hit it in my stress-testing, but I don't
actually keep a count of runs. So maybe I didn't do that many runs, or
maybe I was just lucky.

Doing this:

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index a8a587abc..46665368d 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -139,7 +139,8 @@ test_expect_success 'bogus offset into v2 extended table' '
 test_expect_success 'bogus offset inside v2 extended table' '
 	# We need two objects here, so we can plausibly require
 	# an extended table (if the first object were larger than 2^31).
-	do_pack "$object $(git rev-parse HEAD)" --index-version=2 &&
+	second=$(echo 8038 | git hash-object -w --stdin) &&
+	do_pack "$object $second" --index-version=2 &&
 
 	# We have to make extra room for the table, so we cannot
 	# just munge in place as usual.

causes the same failure you saw (I picked 8038 because it's the first
blob I found whose sha1 sorts after fff0a24).

So that is probably the culprit: you ran the test at the exact second
that caused the 1-in-4096 sorting problem. I'll work up a patch.

-Peff
