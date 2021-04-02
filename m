Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F0C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CC3610CC
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhDBPj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:39:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:40602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235304AbhDBPjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 11:39:55 -0400
Received: (qmail 15591 invoked by uid 109); 2 Apr 2021 15:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Apr 2021 15:39:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26413 invoked by uid 111); 2 Apr 2021 15:39:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Apr 2021 11:39:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Apr 2021 11:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        olyatelezhnaya@gmail.com
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
Message-ID: <YGc6ybE1wD1ck0uB@coredump.intra.peff.net>
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 02, 2021 at 05:03:17PM +0800, ZheNing Hu wrote:

> * Because part of the feature of `git for-each-ref` is very similar to
> that of `git cat-file`, I think `git cat-file` can learn some feasible
> solutions from it.
> 
> #### My possible solutions:
> 
> 1. Same [solution](https://github.com/git/git/pull/568/commits/cc40c464e813fc7a6bd93a01661646114d694d76)
> as Olga, add member `struct ref_format format` in `struct
> batch_options`.
> 2. Use the function
> [`verify_ref_format()`](https://github.com/gitgitgadget/git/blob/84d06cdc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L904)
> to replace the first `expand_format()` for parsing format strings.
> 3. Write a function like
> [`format_ref_array_item()`](https://github.com/gitgitgadget/git/blob/84d06cdc06389ae7c462434cb7b1db0980f63860/ref-filter.c#L2392),
> get information about objects, and use `get_object()` to grub the
> information which we prefer (or just use `grab_common_value()`).
> 4. The migration of `%(rest)` may require learning the handling of
> `%(if)` ,`%(else)`.

I think one thing to keep an eye on here is the performance of cat-file.
The formatting code used by for-each-ref is rather slow (it may load
more of the object details than is necessary, it is too eager to
allocate intermediate strings, and so on). That's usually not _too_ big
a problem for ref-filter, because the number of refs tends to be much
smaller than the number of total objects. But I'd expect that moving to
the ref-filter code would make something like:

 git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype)'

measurably slower.

IMHO the right path forward is not to try porting cat-file to use the
ref-filter code, but to start first with writing a universal formatting
module that takes the best of both implementations (and the commit
pretty-printer):

  - separate the format-parsing stage from formatting actual items, as
    ref-filter does. This lets us have more complex formats without
    paying a per-item runtime cost while formatting. This should also
    allow us to handle multiple syntaxes for the same thing (e.g.,
    ref-filter %(authorname) vs pretty.c %an).

  - figure out which data will be needed for each item based on the
    parsed format, and then do the minimum amount of work to get that
    data (using "oid_object_info_extended()" helps here, because it
    likewise tries to do as little work as possible to satisfy the
    request, but there are many elements that it doesn't know about)

  - likewise avoid doing any intermediate work we can; as much as
    possible, format the result directly into a result strbuf, rather
    than allocating many sub-strings and assembling them (as cat-file
    does).

  - handle formats where the necessary item data may or may not be
    present. E.g., if we're given a refname, then "%(refname)" makes
    sense. But in cat-file we'd not have a refname, and just an object.
    We should still be able to use the same formatting code to handle
    "%(objecttype)", etc. Likewise for formats which require a specific
    type (say %(authorname) for a commit, but the object is a blob).
    Ref-filter does this to some degree for things like authorname, but
    we'd be extending it to the case that we don't even have a refname.

-Peff
