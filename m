Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E25C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 21:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIGVCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiIGVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 17:02:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF63CB72A7
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 14:02:21 -0700 (PDT)
Received: (qmail 23469 invoked by uid 109); 7 Sep 2022 21:02:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Sep 2022 21:02:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14717 invoked by uid 111); 7 Sep 2022 21:02:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Sep 2022 17:02:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Sep 2022 17:02:20 -0400
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
Message-ID: <YxkG3A30vNfu55Sx@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
 <xmqq1qsnugsu.fsf@gitster.g>
 <YxkAxutS+B8//0WF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxkAxutS+B8//0WF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2022 at 04:36:22PM -0400, Jeff King wrote:

> Is that worth having? I dunno. It's kind of brittle in that a later
> change could mean we're finding the corruption elsewhere, and not
> checking exactly what we think we are. OTOH, it probably doesn't hurt to
> cover more cases here, and it's not a very expensive test.

So here's what it would look like as a patch on top.

It could also be squashed in, of course, which saves the vague reference
to "a recent commit...". OTOH, it's sufficiently complicated to discuss
the testing that it's nice not to overwhelm the already-long commit
message of the original. ;)

-- >8 --
Subject: [PATCH] t1060: check partial clone of misnamed blob

A recent commit (upload-pack: skip parse-object re-hashing of "want"
objects, 2022-09-06) loosened the behavior of upload-pack so that it
does not verify the sha1 of objects it receives directly via "want"
requests. The existing corruption tests in t1060 aren't affected by
this: the corruptions are blobs reachable from commits, and the client
requests the commits.

The more interesting case here is a partial clone, where the client will
directly ask for the corrupted blob when it does an on-demand fetch of
the filtered object. And that is not covered at all, so let's add a
test.

It's important here that we use the "misnamed" corruption and not
"bit-error". The latter is sufficiently corrupted that upload-pack
cannot even figure out the type of the object, so it bails identically
both before and after the recent change. But with "misnamed", with the
hash-checks enabled it sees the problem (though the error messages are a
bit confusing because of the inability to create a "struct object" to
store the flags):

  error: hash mismatch d95f3ad14dee633a758d2e331151e950dd13e4ed
  fatal: git upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed
  fatal: remote error: upload-pack: not our ref d95f3ad14dee633a758d2e331151e950dd13e4ed

After the change to skip the hash check, the server side happily sends
the bogus object, but the client correctly realizes that it did not get
the necessary data:

  remote: Enumerating objects: 1, done.
  remote: Counting objects: 100% (1/1), done.
  remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
  Receiving objects: 100% (1/1), 49 bytes | 49.00 KiB/s, done.
  fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
  error: [...]/misnamed did not send all necessary objects

which is exactly what we expect to happen.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1060-object-corruption.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 5b8e47e346..35261afc9d 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -139,4 +139,11 @@ test_expect_success 'internal tree objects are not "missing"' '
 	)
 '
 
+test_expect_success 'partial clone of corrupted repository' '
+	test_config -C misnamed uploadpack.allowFilter true &&
+	git clone --no-local --no-checkout --filter=blob:none \
+		misnamed corrupt-partial && \
+	test_must_fail git -C corrupt-partial checkout --force
+'
+
 test_done
-- 
2.37.3.1138.gedcf976b26

