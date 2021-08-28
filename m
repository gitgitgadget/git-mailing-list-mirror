Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13BDC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 04:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ABC60F6C
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 04:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhH1ENJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Aug 2021 00:13:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:32912 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhH1ENI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Aug 2021 00:13:08 -0400
Received: (qmail 11725 invoked by uid 109); 28 Aug 2021 04:12:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Aug 2021 04:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17973 invoked by uid 111); 28 Aug 2021 04:12:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Aug 2021 00:12:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Aug 2021 00:12:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/5] strvec: add a strvec_pushvec()
Message-ID: <YSm3ofxlRB1ViBf5@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
 <patch-v3-2.5-321b8ba3f0e-20210826T140414Z-avarab@gmail.com>
 <xmqq8s0m9xbl.fsf@gitster.g>
 <xmqq4kba9x1h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4kba9x1h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 06:29:30PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +void strvec_pushvec(struct strvec *array, const struct strvec *items)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < items->nr; i++)
> >> +		strvec_push(array, items->v[i]);
> >> +}
> >
> > This implementation is not wrong per-se, but is somewhat
> > disappointing.  When items->nr is large, especially relative to the
> > original array->alloc, it would incur unnecessary reallocations that
> > we can easily avoid by pre-sizing the array before pushing the
> > elements of items from it.
> >
> > In the original code that became the first user of this helper, it
> > may not have made much difference, but now it is becoming a more
> > generally reusable API function, we should care.
> 
> And if we do not care, you can rewrite the code that became the
> first user of this helper to instead call strvec_pushv() on the
> items->v array that is guaranteed to be NULL terminated, without
> inventing this new helper.

I came here to say that. ;)

I do not mind using pushv() directly, or a pushvec() that is a
convenience wrapper for pushv(). Even better if that wrapper is smart
enough to pre-allocate based on items->nr, as you mentioned, but that
can also come later.

One thing that did surprise me: the use of "int" here for iterating,
rather than size_t. But it seems that strvec is already storing ints,
which is an accident!

I think we'd want the patch below. It can be applied independently
(though if we do take the index-iterating version of Ævar's patch, I
think it should switch to size_t).

-- >8 --
Subject: [PATCH] strvec: use size_t to store nr and alloc

We converted argv_array (which later became strvec) to use size_t in
819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
order to avoid the possibility of integer overflow. But later, commit
d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
converted these back to ints!

Those two commits were part of the same patch series. I'm pretty sure
what happened is that they were originally written in the opposite order
and then cleaned up and re-ordered during an interactive rebase. And
when resolving the inevitable conflict, I mistakenly took the "rename"
patch completely, accidentally dropping the type change.

We can correct it now; better late than never.

Signed-off-by: Jeff King <peff@peff.net>
---
 strvec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strvec.h b/strvec.h
index fdcad75b45..6b3cbd6758 100644
--- a/strvec.h
+++ b/strvec.h
@@ -29,8 +29,8 @@ extern const char *empty_strvec[];
  */
 struct strvec {
 	const char **v;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 #define STRVEC_INIT { empty_strvec, 0, 0 }
-- 
2.33.0.399.g06f2549587

