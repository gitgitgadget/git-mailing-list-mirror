Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC3C43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FA361001
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 08:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhDAIdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 04:33:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:39586 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhDAIc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 04:32:26 -0400
Received: (qmail 7452 invoked by uid 109); 1 Apr 2021 08:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Apr 2021 08:32:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12274 invoked by uid 111); 1 Apr 2021 08:32:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Apr 2021 04:32:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Apr 2021 04:32:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] ref-filter: fix NULL check for parse object failure
Message-ID: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g>
 <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
 <87k0pnkwej.fsf@evledraar.gmail.com>
 <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
 <87eefvkq5d.fsf@evledraar.gmail.com>
 <YGV8UOsYUQt7Lpto@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGV8UOsYUQt7Lpto@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01, 2021 at 03:54:56AM -0400, Jeff King wrote:

> On Wed, Mar 31, 2021 at 10:46:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > Neither of those types is the correct one. And the segfault is just a
> > > bonus! :)
> > >
> > > I'd expect similar cases with parsing commit parents and tree pointers.
> > > And probably tree entries whose modes are wrong.
> > 
> > So the segfault happens without my patches,
> 
> Yeah, sorry if that was unclear. It is definitely a pre-existing bug.

Here's a patch to fix it. This is mostly orthogonal to your patch
series. It happens to use a similar recipe to reproduce, but that is not
the only way to do it, and the fix and the test shouldn't conflict
textually or semantically.

-- >8 --
Subject: [PATCH] ref-filter: fix NULL check for parse object failure

After we run parse_object_buffer() to get an object's contents, we try
to check that the return value wasn't NULL. However, since our "struct
object" is a pointer-to-pointer, and we assign like:

  *obj = parse_object_buffer(...);

it's not correct to check:

  if (!obj)

That will always be true, since our double pointer will continue to
point to the single pointer (which is itself NULL). This is a regression
that was introduced by aa46a0da30 (ref-filter: use oid_object_info() to
get object, 2018-07-17); since that commit we'll segfault on a parse
failure, as we try to look at the NULL object pointer.

There are many ways a parse could fail, but most of them are hard to set
up in the tests (it's easy to make a bogus object, but update-ref will
refuse to point to it). The test here uses a tag which points to a wrong
object type. A parse of just the broken tag object will succeed, but
seeing both tag objects in the same process will lead to a parse error
(since we'll see the pointed-to object as both types).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f714..a0adb4551d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1608,7 +1608,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 
 	if (oi->info.contentp) {
 		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
-		if (!obj) {
+		if (!*obj) {
 			if (!eaten)
 				free(oi->content);
 			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index cac7f443d0..2e7c32d50c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1134,4 +1134,14 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	test_cmp expect actual
 '
 
+test_expect_success 'for-each-ref reports broken tags' '
+	git tag -m "good tag" broken-tag-good HEAD &&
+	git cat-file tag broken-tag-good >good &&
+	sed s/commit/blob/ <good >bad &&
+	bad=$(git hash-object -w -t tag bad) &&
+	git update-ref refs/tags/broken-tag-bad $bad &&
+	test_must_fail git for-each-ref --format="%(*objectname)" \
+		refs/tags/broken-tag-*
+'
+
 test_done
-- 
2.31.1.478.g72c5357f0d

