Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2CF1FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdEICyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:54:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbdEICyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:54:16 -0400
Received: (qmail 11516 invoked by uid 109); 9 May 2017 02:54:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 02:54:16 +0000
Received: (qmail 19019 invoked by uid 111); 9 May 2017 02:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 22:54:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 22:54:13 -0400
Date:   Mon, 8 May 2017 22:54:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection
 options
Message-ID: <20170509025412.6fkrlnbsdk6qmoia@sigill.intra.peff.net>
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
 <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
 <20170508073143.lu73w5b54lvstty2@sigill.intra.peff.net>
 <xmqqd1bi7ta5.fsf@gitster.mtv.corp.google.com>
 <20170509020010.meefcustv7uufard@sigill.intra.peff.net>
 <xmqqfuge6akl.fsf@gitster.mtv.corp.google.com>
 <20170509022114.s3tpxrgtplsopr4x@sigill.intra.peff.net>
 <xmqq4lwu68zy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lwu68zy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 11:48:17AM +0900, Junio C Hamano wrote:

> > I guess what I was asking was: do you still think it was unclear, or do
> > you think you were just being dense?
> >
> > I don't feel like I gave any information in the follow-on explanation
> > that wasn't in the commit message, so I wasn't clear if I worded it
> > better or if it just sunk in better.
> 
> At least, "the current code is buggy when --local and friend are
> given and includes needless objects in the result" was something I
> learned only during the discussion, and would never have guessed by
> reading the log message.  The second paragraph does talk about "This
> bug has been present since...", but the first paragraph does not say
> anything about the current output being broken.

While waiting for your response I took a look to see if I could improve
it and came to the same conclusion. The result is below.

> So, I am not sure if this was a case where I was dense.  I think the
> first paragraph needs a bit more clarity.

Yeah, you were not being dense. I just wrote it badly. Sorry
for the confusion.

-- >8 --
Subject: pack-objects: disable pack reuse for object-selection options

If certain options like --honor-pack-keep, --local, or
--incremental are used with pack-objects, then we need to
feed each potential object to want_object_in_pack() to see
if it should be filtered out. But when the bitmap
reuse_packfile optimization is in effect, we do not call
that function at all, and in fact skip adding the objects to
the to_pack list entirely.  This means we have a bug: for
certain requests we will silently ignore those options and
include objects in that pack that should not be there.

The problem has been present since the inception of the
pack-reuse code in 6b8fda2db (pack-objects: use bitmaps when
packing objects, 2013-12-21), but it was unlikely to come up
in practice.  These options are generally used for on-disk
packing, not transfer packs (which go to stdout), but we've
never allowed pack reuse for non-stdout packs (until
645c432d6, we did not even use bitmaps, which the reuse
optimization relies on; after that, we explicitly turned it
off when not packing to stdout).

We can fix this by just disabling the reuse_packfile
optimization when the options are in use. In theory we could
teach the pack-reuse code to satisfy these checks, but it's
not worth the complexity. The purpose of the optimization is
to keep the amount of per-object work we do to a minimum.
But these options inherently require us to search for other
copies of each object, drowning out any benefit of the
pack-reuse optimization. But note that the optimizations
from 56dfeb626 (pack-objects: compute local/ignore_pack_keep
early, 2016-07-29) happen before pack-reuse, meaning that
specifying "--honor-pack-keep" in a repository with no .keep
files can still follow the fast path.

There are tests in t5310 that check these options with
bitmaps and --stdout, but they didn't catch the bug, and
it's hard to adapt them to do so.

One problem is that they don't use --delta-base-offset;
without that option, we always disable the reuse
optimization entirely. It would be fine to add it in (it
actually makes the test more realistic), but that still
isn't quite enough.

The other problem is that the reuse code is very picky; it
only kicks in when it can reuse most of a pack, starting
from the first byte. So we'd have to start from a fully
repacked and bitmapped state to trigger it. But the tests
for these options use a much more subtle state; they want to
be sure that the want_object_in_pack() code is allowing some
objects but not others. Doing a full repack runs counter to
that.

So this patch adds new tests at the end of the script which
create the fully-packed state and make sure that each option
is not fooled by reusable pack.

Signed-off-by: Jeff King <peff@peff.net>
---
Contents are the same. I decided to leave the "; do" as it
matches the rest of the script. If we're going to fix it, we
should do them all.

 builtin/pack-objects.c  |  6 +++++-
 t/t5310-pack-bitmaps.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fe35d1b5..50e01aa80 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2717,7 +2717,11 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
  */
 static int pack_options_allow_reuse(void)
 {
-	return pack_to_stdout && allow_ofs_delta;
+	return pack_to_stdout &&
+	       allow_ofs_delta &&
+	       !ignore_packed_keep &&
+	       (!local || !have_non_local_packs) &&
+	       !incremental;
 }
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 424bec7d7..c3ddfa217 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -289,4 +289,42 @@ test_expect_success 'splitting packs does not generate bogus bitmaps' '
 	git -C no-bitmaps.git fetch .. HEAD
 '
 
+test_expect_success 'set up reusable pack' '
+	rm -f .git/objects/pack/*.keep &&
+	git repack -adb &&
+	reusable_pack () {
+		git for-each-ref --format="%(objectname)" |
+		git pack-objects --delta-base-offset --revs --stdout "$@"
+	}
+'
+
+test_expect_success 'pack reuse respects --honor-pack-keep' '
+	test_when_finished "rm -f .git/objects/pack/*.keep" &&
+	for i in .git/objects/pack/*.pack; do
+		>${i%.pack}.keep
+	done &&
+	reusable_pack --honor-pack-keep >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack reuse respects --local' '
+	mv .git/objects/pack/* alt.git/objects/pack/ &&
+	test_when_finished "mv alt.git/objects/pack/* .git/objects/pack/" &&
+	reusable_pack --local >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack reuse respects --incremental' '
+	reusable_pack --incremental >empty.pack &&
+	git index-pack empty.pack &&
+	>expect &&
+	git show-index <empty.idx >actual &&
+	test_cmp expect actual
+'
 test_done
-- 
2.13.0.rc2.436.g524cea07c

