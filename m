Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D0C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD7461444
	for <git@archiver.kernel.org>; Thu, 13 May 2021 10:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhEMKyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 06:54:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhEMKyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 06:54:49 -0400
Received: (qmail 4240 invoked by uid 109); 13 May 2021 10:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 10:53:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15542 invoked by uid 111); 13 May 2021 10:53:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 06:53:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 06:53:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Patrick, who also worked in this area recently and is probably
interested to hear about this bug]

On Thu, May 13, 2021 at 05:57:57AM -0400, Jeff King wrote:

> I think it is actually a bug with pack-objects not sending the object,
> but it only seems to trigger with bitmaps. This works:
> 
>   git init repo
>   cd repo
> 
>   echo content >file
>   git add file
>   git commit -m base
> 
>   git config uploadpack.allowfilter true
>   git clone --no-local --bare --filter=blob:none . clone
> 
>   cd clone
>   git fetch origin $(git rev-parse HEAD:file)
> 
> But if I add a "git repack -adb" in the parent repository before the "cd
> clone", then I get:
> 
>   remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
>   fatal: bad revision 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
>   error: /home/peff/tmp/repo/. did not send all necessary objects
> 
> So presumably this is a bug in the bitmap-aware filtering code that is
> not present in the regular filter-traversing code. But what really
> puzzles me is that the result seems totally broken. Yet the test
> coverage in t5310 passes, and nobody has noticed on major sites like
> GitHub (which supports partial clones and most certainly has bitmaps
> enabled).
> 
> So I think it will require some digging. My _guess_ is that it has to do
> with the "never filter out an object that was explicitly requested" rule
> not being consistently followed. But we'll see.

OK, I think I've unraveled the mysteries.

It is indeed a problem with the "never filter out an object that was
explicitly requested" rule. But really, that rule is stronger: it is
"always include an explicitly requested object". I.e., it must override
even the usual "you said commit X was uninteresting, so we did not
include objects reachable from X" logic.

And that is what was happening here. In that final fetch, the client
says: "I have the commit pointed to by HEAD, but I need the blob from
HEAD:file". So the server's bitmap traversal, even before we hit the
blob:none filtering, has cleared the bit for HEAD:file's object! So
there is nothing to filter, but the filtering code must _add it back in_
to the result.

And indeed, if we are adding it back in anyway, we do not need to
exclude it when filtering in the first place. So I think the fix looks
something like this:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d90e1d9d8c..8458eedbdb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -797,8 +797,6 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
 	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
 	     i++) {
-		if (i < tips->word_alloc)
-			mask &= ~tips->words[i];
 		to_filter->words[i] &= ~mask;
 	}
 
@@ -810,11 +808,18 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_git->pack->num_objects;
 		if (eindex->objects[i]->type == type &&
-		    bitmap_get(to_filter, pos) &&
-		    !bitmap_get(tips, pos))
+		    bitmap_get(to_filter, pos))
 			bitmap_unset(to_filter, pos);
 	}
 
+	/*
+	 * Add back in any bits that were explicitly asked for (we may have
+	 * cleared them as part of our filtering just now, or they may
+	 * have been dropped by because they were reachable from the "have"
+	 * side of the bitmap).
+	 */
+	bitmap_or(to_filter, tips);
+
 	bitmap_free(tips);
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b02838750e..d34f086228 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -214,6 +214,16 @@ test_expect_success 'partial clone from bitmapped repository' '
 	)
 '
 
+test_expect_success 'follow-up fetch from bitmapped repository' '
+	test_config uploadpack.allowfilter true &&
+	(
+		cd partial-clone.git &&
+		blob=$(git rev-parse HEAD:file-1.t) &&
+		git fetch origin "$blob" &&
+		git cat-file -t "$blob"
+	)
+'
+
 test_expect_success 'setup further non-bitmapped commits' '
 	test_commit_bulk --id=further 10
 '

That fixes the example I showed above, as well as the included test in
t5310. Some follow-on thoughts:

  - this covers blob:none, and indeed any type-exclusion filter, as they
    share this code. But we probably need a similar fix for other
    filters (like the blob-limit filter). I think this could even be
    hoisted out to the filter_bitmap() function, and then we only have
    to do it in one place.

  - alternatively, the actual bitmap traversal could be smart enough to
    say "this is an explicitly-requested tip object; make sure we
    _don't_ mark it as uninteresting". Which is exactly what the
    non-bitmap traversal code does (I think this is the USER_GIVEN
    stuff). And we even try to build on that code by passing the
    list_objects_filter struct along, but:

      - that is only for fill-in traversal; an on-disk bitmap means we
	might touch those bits without calling into the list-objects
	code at all.

      - we don't feed the list-objects code all the information it needs
	anyway. We do two separate traversals, one for the "haves"
	bitmap and one for the "wants", and then AND-NOT the former into
	the latter. So when we do that "haves" traversal, those objects
	are _not_ being marked as UNINTERESTING. They are considered
	positive tips from the perspective of the traversal code.

     So I think we really do need to manipulate the bits in the bitmap
     to get the right answer. But it seems like there's a big
     optimization opportunity we're missing here. If the other side says
     "I don't have this commit, but I need this blob" (as our examples
     do), then there is no point in figuring out the "haves" bitmap at
     all! We know that it will not be used. In practice I'm not sure how
     big a deal this is (if the other side asked for any commit, we'd
     need it, and in theory it's quick to compute because of the on-disk
     bitmaps). At any rate, I think we should focus on correctness first
     here.

  - as to the mystery of why nobody has noticed this breakage: it's
    because the usual code to fetch-on-demand an object that we are
    missing _doesn't_ send any other "we already have this commit" tips.
    It just says "hey, give me these objects". So a workaround in the
    meantime is:

      git -c fetch.negotiationAlgorithm=noop fetch origin ...

I'm going to sleep on it, but I think the fix above is the right
direction. I just need to look at the other filters, and add a bit of
polish.

-Peff
