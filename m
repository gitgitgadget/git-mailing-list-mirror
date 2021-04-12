Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D7C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 03:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E046120D
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 03:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhDLDlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:41:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:48708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhDLDlt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 23:41:49 -0400
Received: (qmail 20850 invoked by uid 109); 12 Apr 2021 03:41:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Apr 2021 03:41:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6898 invoked by uid 111); 12 Apr 2021 03:41:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Apr 2021 23:41:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Apr 2021 23:41:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] pack-objects: update "nr_seen" progress based on pack-reused
 count
Message-ID: <YHPBXu9R/7i1jZhy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When serving a clone or fetch with bitmaps, after deciding which objects
need to be sent our "pack reuse" mechanism kicks in: we try to send
more-or-less verbatim a bunch of objects from the beginning of the
bitmapped packfile without even adding them to the to_pack.objects
array.

After deciding which objects will be in the "reused" portion, we update
nr_result to account for those, and then trigger display_progress() to
show the user (who is undoubtedly dazzled that we managed to enumerate
so many objects so quickly).

But then something confusing happens: the "Enumerating objects" progress
meter jumps _backwards_, counting up from zero the number of objects we
actually add into to_pack.objects.

This worked correctly once upon a time, but was broken in 5af050437a
(pack-objects: show some progress when counting kept objects,
2018-04-15), when the latter half of that progress meter switched to
using a separate nr_seen counter, rather than nr_result. Nobody noticed
for two reasons:

  - prior to the pack-reuse fixes from a14aebeac3 (Merge branch
    'jk/packfile-reuse-cleanup', 2020-02-14), the reuse code almost
    never kicked in anyway

  - the output looks _kind of_ correct. The "backwards" moment is hard
    to catch, because we overwrite the old progress number with the new
    one, and the larger number is displayed only for a second. So unless
    you look at that exact second, you just see the much smaller value,
    counting up to the number of non-reused objects (though of course if
    you catch it in stderr, or look at GIT_TRACE_PACKET from a server
    with bitmaps, you can see both values).

This smaller output isn't wrong per se, but isn't counting what we ever
intended to. We should give the user the whole number of objects we
considered (which, as per 5af050437a's original purpose, is already
_not_ a count of what goes into to_pack.objects). The follow-on
"Counting objects" meter shows the actual number of objects we feed into
that array.

We can easily fix this by bumping (and showing) nr_seen for the
pack-reused objects. When the included test is run without this patch,
the second pack-objects invocation produces "Enumerating objects: 1" to
show the one loose object, even though the resulting pack has hundreds
of objects in it. With it, we jump to "Enumerating objects: 674" after
deciding on reuse, and then "675" when we add in the loose object.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c  |  3 ++-
 t/t5310-pack-bitmaps.sh | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..faee5a5c76 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3527,7 +3527,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 			&reuse_packfile_bitmap)) {
 		assert(reuse_packfile_objects);
 		nr_result += reuse_packfile_objects;
-		display_progress(progress_state, nr_result);
+		nr_seen += reuse_packfile_objects;
+		display_progress(progress_state, nr_seen);
 	}
 
 	traverse_bitmap_commit_list(bitmap_git, revs,
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 40b9f63244..8d0933b6e5 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -461,6 +461,29 @@ test_expect_success 'truncated bitmap fails gracefully (cache)' '
 	test_i18ngrep corrupted.bitmap.index stderr
 '
 
+test_expect_success 'enumerating progress counts pack-reused objects' '
+	count=$(git rev-list --objects --all --count) &&
+	git repack -adb &&
+
+	# check first with only reused objects; confirm that our progress
+	# showed the right number, and also that we did pack-reuse as expected.
+	# Check only the final "done" line of the meter (there may be an
+	# arbitrary number of intermediate lines ending with CR).
+	GIT_PROGRESS_DELAY=0 \
+		git pack-objects --all --stdout --progress \
+		</dev/null >/dev/null 2>stderr &&
+	grep "Enumerating objects: $count, done" stderr &&
+	grep "pack-reused $count" stderr &&
+
+	# now the same but with one non-reused object
+	git commit --allow-empty -m "an extra commit object" &&
+	GIT_PROGRESS_DELAY=0 \
+		git pack-objects --all --stdout --progress \
+		</dev/null >/dev/null 2>stderr &&
+	grep "Enumerating objects: $((count+1)), done" stderr &&
+	grep "pack-reused $count" stderr
+'
+
 # have_delta <obj> <expected_base>
 #
 # Note that because this relies on cat-file, it might find _any_ copy of an
-- 
2.31.1.657.gecf191e18d
