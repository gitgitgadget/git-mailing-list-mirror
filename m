Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81311C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIGUg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGUgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:36:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED727FF87
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:36:23 -0700 (PDT)
Received: (qmail 23231 invoked by uid 109); 7 Sep 2022 20:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 20:36:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14565 invoked by uid 111); 7 Sep 2022 20:36:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 16:36:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 16:36:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Message-ID: <YxkAxutS+B8//0WF@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
 <xmqq1qsnugsu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qsnugsu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 12:26:41PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The exception for both is if --verify-objects is used. In that case,
> > we'll skip this optimization, and the new test makes sure we do this
> > correctly.
> 
> I wondered if we want to test the change on the "upload-pack" side
> by going in to the swapped-commits repository, running upload-pack
> manually and seeing that it spews unusable output without failing,
> but it probably is not worth the effort.  We have plenty of tests
> that exercises upload-pack in "good" cases.  What might be a good
> test is to try fetching from swapped-commits repository and make
> sure that index-pack on the receiving end notices, but I suspect we
> already have such a "fetch/clone from a corrupt repository" test,
> in which case we do not have to add one.

There are some tests in t1060 that cover transfer of corrupted objects.
But one of the tricky things about corruption is that it can be somewhat
arbitrary where and when we notice. I.e., whether upload-pack notices
the problem and bails or whether it spews an invalid result, we're OK
with either outcome, and a test for it can end up rather fragile.

What we do care about is that _somebody_ notices the problem. t1060
covers that for some cases, though of course there's no partial clone
there. If we add one like this:

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 5b8e47e346..fd18a8b29e 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -139,4 +139,11 @@ test_expect_success 'internal tree objects are not "missing"' '
 	)
 '
 
+test_expect_success 'partial clone of corrupted reository' '
+	test_config -C bit-error uploadpack.allowFilter true &&
+	git clone --no-local --no-checkout --filter=blob:none \
+		bit-error corrupt-partial && \
+	test_must_fail git -C corrupt-partial checkout --force
+'
+
 test_done

we can see that the initial blob:none clone is OK (since neither side
looks at the corrupted blob at all). And then the checkout does barf as
expected. But it looks like we catch the error in upload-pack, probably
because the loose object is so corrupted that we cannot even access its
type header. I tried moving the corruption to further in the file, but I
think it's simply so small that zlib will read the whole input and
complain about the bogus crc.

Hmm. Looks like that script has another corrupted repo where an object
is misnamed. So if we s/bit-error/misnamed/ in the test above, then we
do trigger the new code. Before we get:

  error: hash mismatch d95f3ad14dee633a758d2e331151e950dd13e4ed
  fatal: git upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed
  fatal: remote error: upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed

(the error is a bit misleading, but I guess the inability to create the
object struct means our "is it our ref" code gets confused). After my
patches, we get:

  remote: Enumerating objects: 1, done.
  remote: Counting objects: 100% (1/1), done.
  remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
  Receiving objects: 100% (1/1), 49 bytes | 49.00 KiB/s, done.
  fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
  error: [...]/misnamed did not send all necessary objects

Is that worth having? I dunno. It's kind of brittle in that a later
change could mean we're finding the corruption elsewhere, and not
checking exactly what we think we are. OTOH, it probably doesn't hurt to
cover more cases here, and it's not a very expensive test.

-Peff
