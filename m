Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1442C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B218D613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhGNQe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:34:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:49496 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGNQe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:34:29 -0400
Received: (qmail 28669 invoked by uid 109); 14 Jul 2021 16:31:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 16:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25712 invoked by uid 111); 14 Jul 2021 16:31:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 12:31:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 12:31:36 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3] load_ref_decorations(): fix decoration with tags
Message-ID: <YO8RaMj7sN4ABe5d@coredump.intra.peff.net>
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
 <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
 <xmqqpmvl29ry.fsf@gitster.g>
 <YO4FObgRvpt1nVr0@coredump.intra.peff.net>
 <xmqqlf6928qv.fsf@gitster.g>
 <CAN0heSqCFVqC9Ncn5r3b4dKOE80byDt_XRM3pnswixX4jFcLFA@mail.gmail.com>
 <YO4SEp/B4826sc+j@coredump.intra.peff.net>
 <CAN0heSp1eJmeMTq-ECMUVh=hBPRTEkQeU0-3YXvtaDdZtU1sSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp1eJmeMTq-ECMUVh=hBPRTEkQeU0-3YXvtaDdZtU1sSA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:13:38AM +0200, Martin Ågren wrote:

> > From: Martin Ågren <martin.agren@gmail.com>
> 
> At this point, I think it's fair to say that you've done most of the
> authoring here. I wouldn't be at all offended if you took the credit for
> this patch. It's your code diff, it's your test, and now it's even your
> *updated* test, plus half the commit message. :)

Yeah, that occurred to me, too. Let's swap it, then. When the fix
inevitably turns out to be wrong, I can take the blame. ;)

Here's an updated patch for Junio's convenience (same as what I posted
before, but with author/trailers tweaked). Thanks again for finding and
working on this!

-- >8 --
Subject: [PATCH] load_ref_decorations(): fix decoration with tags

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
allowing us to keep most of the possible speedup from 88473c8bae.

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

Reported-by: Martin Ågren <martin.agren@gmail.com>
Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Martin Ågren <martin.agren@gmail.com>
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
index 39e746fbcb..9dfead936b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1915,6 +1915,20 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
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
2.32.0.689.gbb74d99cdd

