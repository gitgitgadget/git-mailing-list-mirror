Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F97C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AE161105
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhDISgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:36:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234307AbhDISgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:36:16 -0400
Received: (qmail 1086 invoked by uid 109); 9 Apr 2021 18:36:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15500 invoked by uid 111); 9 Apr 2021 18:36:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:36:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:36:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/6] object-name.c: make dependency on object_type order
 more obvious
Message-ID: <YHCekt1iXjy2NLrP@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-5.6-94e13611f0-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-94e13611f0-20210409T082935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:53AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Add an assert to make it more obvious that we were effectively
> hardcoding OBJ_TAG in sort_ambiguous() as "4".
> 
> I wrote this code in 5cc044e0257 (get_short_oid: sort ambiguous
> objects by type, then SHA-1, 2018-05-10), there was already a comment
> about this magic, but let's make sure that someone doing a potential
> reordering of "enum object_type" in the future would notice it
> breaking this function (and probably a bunch of other things...).

Yeah, those object type values are used for the on-disk formats, so
quite a lot would break.

> @@ -408,6 +408,8 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
>  	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
>  	enum object_type a_type_sort;
>  	enum object_type b_type_sort;
> +	const enum object_type tag_type_offs = OBJ_TAG - OBJ_NONE;
> +	assert(tag_type_offs == 4);

This protects us against shifting of the values or reordering within the
main 4 types, but it doesn't protect against new types, nor reordering
in which the main 4 types are no longer contiguous. E.g.:

  enum object_type {
          OBJ_NONE = 0,
	  OBJ_REF_DELTA = 1,
	  OBJ_OFS_DELTA = 2,
	  OBJ_COMMIT = 3,
	  OBJ_TAG = 4,
	  OBJ_BLOB = 5,
	  OBJ_TREE = 6,
  };

would be wrong. I dunno. I guess in some sense I am glad to see an
attempt at automated enforcement of assumptions. But I think if we are
worried about the object_type enum changing, we'd do better to write
this function in a less-clever way.

  /* sort tags before anything else */
  if (a_type == OBJ_TAG)
          a_type = 0;
  if (b_type == OBJ_TAG)
          b_type = 0;

Of course that is still assuming that normal values are all positive,
but that seems reasonable. If you really wanted to be agnostic, you
could assign the minimum value.  But you can't easily know that for an
enum. So you'd want to store them as ints (reversing your previous
commit!) and using INT_MIN.

The conditional probably performs less well in a tight loop, but I doubt
that matters for the size of array we expect to sort (if we cared about
performance we would not call oid_object_info() twice inside the
comparator!).

-Peff
