Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B510EC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BE36101B
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhGMWZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:25:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48348 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhGMWZC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:25:02 -0400
Received: (qmail 13241 invoked by uid 109); 13 Jul 2021 22:22:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 22:22:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15115 invoked by uid 111); 13 Jul 2021 22:22:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 18:22:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 18:22:10 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
Message-ID: <YO4SEp/B4826sc+j@coredump.intra.peff.net>
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
 <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
 <xmqqpmvl29ry.fsf@gitster.g>
 <YO4FObgRvpt1nVr0@coredump.intra.peff.net>
 <xmqqlf6928qv.fsf@gitster.g>
 <CAN0heSqCFVqC9Ncn5r3b4dKOE80byDt_XRM3pnswixX4jFcLFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqCFVqC9Ncn5r3b4dKOE80byDt_XRM3pnswixX4jFcLFA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 11:52:53PM +0200, Martin Ågren wrote:

> > >> Puzzled.
> > >
> > > ...and the answer is that we don't need to parse it. The tag object
> > > mentions the type of what it points to, and we use lookup_commit(), etc,
> > > to create the object pointed to by its "tagged" field.
> >
> > Ahh, parse_object() on the outer tag, when instantiating the in-core
> > obj, allocated an in-core object and that instance is already given
> > a type from the tag object and .taggeed member points at that
> > object, so it is not an "unknown" object (tag.c::parse_tag_buffer()).
> >
> > Totally forgot about that one; thanks.
> 
> Do you have any suggestions for how this could be explained better? I
> waffled on whether to add that paragraph to the commit message and when
> I finally did, it seems it got a little bit too succinct.
> 
> I'm about to check out for today. Maybe in the morning I can think of
> some clarification.

My attempt is below. Most of the new explanation is near the end, but I
tweaked a few other things.

Your original said:

  The reason this happens is in the loop where we try to peel the tags,
  we won't necessarily have parsed that first object. If we haven't, its
  `tag` will be NULL, so nothing will be displayed, and its `tagged`
  will also be NULL, so we won't peel any further.

and my earlier explanations were not thinking of the "tag" field at all,
which made me worried there was another subtle bug in not parsing the
tag earlier. But I don't think so. We don't look at the "tag" field for
setting the annotation; it always comes from the refname. So the
paragraph above should not mention "tag" at all.

I also beefed up the test a bit. All this talk of parsing made me want
to make sure we were covering tags-of-tags correctly (which I think we
are both before and after the patch). After adding that, the expected
decoration output was getting quite cluttered. So I tweaked the test to
make a new commit, give the tags sensible names, and just look at that
one commit.

Here it is.

-- >8 --
From: Martin Ågren <martin.agren@gmail.com>
Subject: load_ref_decorations(): fix decoration with tags

Commit 88473c8bae ("load_ref_decorations(): avoid parsing non-tag
objects", 2021-06-22) introduced a shortcut to `add_ref_decoration()`:
Rather than calling `parse_object()`, we go for `oid_object_info()` and
then `lookup_object_by_type()` using the type just discovered. As
detailed in the commit message, this provides a significant time saving.

Unfortunately, it also changes the behavior: We lose all annotated tags
from the decoration.

The reason this happens is in the loop where we try to peel the tags, we
won't necessarily have parsed that first object. If we haven't, its
`tagged` field will be NULL, so we won't actually add a decoration for
the pointed-to object.

Make sure to parse the tag object at the top of the peeling loop. This
effectively restores the pre-88473c8bae parsing -- but only of tags,
allowing us to keep most of the possible speedup from 88473c8bae. Jeff
King reports:

  On my big ~220k ref test case (where it's mostly non-tags), the
  timings [using "git log -1 --decorate"] are:

    - before either patch: 2.945s
    - with my broken patch: 0.707s
    - with [this patch]: 0.788s

The simplest way to do this is to just conditionally parse before the
loop:

  if (obj->type == OBJ_TAG)
          parse_object(&obj->oid);

But we can observe that our tag-peeling loop needs to peel already, to
examine recursive tags-of-tags. So instead of introducing a new call to
parse_object(), we can simply move the parsing higher in the loop:
instead of parsing the new object before we loop, parse each tag object
before we look at its "tagged" field.

This has another beneficial side effect: if a tag points at a commit (or
other non-tag type), we do not bother to parse the commit at all now.
And we know it is a commit without calling oid_object_info(), because
parsing the surrounding tag object will have created the correct in-core
object based on the "type" field of the tag.

Our test coverage for --decorate was obviously not good, since we missed
this quite-basic regression. The new tests covers an annotated tag
(showing the fix), but also that we correctly show annotations for
lightweight tags and double-annotated tag-of-tags.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c     |  4 ++--
 t/t4202-log.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4f69ed176d..6dc4412268 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -174,11 +174,11 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
+		if (!obj->parsed)
+			parse_object(the_repository, &obj->oid);
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		if (!obj->parsed)
-			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa3593..fe8f5e2067 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1905,6 +1905,20 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git log --exclude-promisor-objects source-a
 '
 
+test_expect_success 'log --decorate includes all levels of tag annotated tags' '
+	git checkout -b branch &&
+	git commit --allow-empty -m "new commit" &&
+	git tag lightweight HEAD &&
+	git tag -m annotated annotated HEAD &&
+	git tag -m double-0 double-0 HEAD &&
+	git tag -m double-1 double-1 double-0 &&
+	cat >expect <<-\EOF &&
+	HEAD -> branch, tag: lightweight, tag: double-1, tag: double-0, tag: annotated
+	EOF
+	git log -1 --format="%D" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
2.32.0.663.g932e3f012f

