Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638CC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B8760FDB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhDMHNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:13:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:50736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237383AbhDMHNO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:13:14 -0400
Received: (qmail 28487 invoked by uid 109); 13 Apr 2021 07:12:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22966 invoked by uid 111); 13 Apr 2021 07:12:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:12:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:12:54 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] low-hanging performance fruit with promisor packs
Message-ID: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 07:47:41PM -0400, Jeff King wrote:

> The patch below drops the peak heap to 165MB. Still quite a bit more,
> but I think it's a combination of delta-base cache (96MB) plus extra
> structs for all the non-commit objects whose flags we marked.

I think we can do even better than that, after looking into the "do we
really need to parse the objects?" comment I left (spoiler: the answer
is no, we do not need to, at least for that caller).

Here are some cleaned-up patches that I think improve the situation
quite a bit. This is just the low-hanging fruit from this part of the
discussion; I'm sure there's more to do to make using partial clones
pleasant. In particular:

  - this does nothing for the "oops, we turned all of the promisor
    objects loose and then deleted them" problem. Hopefully Rafael
    will produce a nice patch for that

  - In is_promisor_object(), we still call parse_object(), because it
    really does look at the contents. But doing so for blobs is wasteful
    (it's a lot of bytes we push through sha1, and we don't even look at
    them). It might be worth using oid_object_info() to avoid this. This
    introduces a little overhead, but I think would be a net win (it
    would be really nice if we could amortize the object lookup work;
    i.e., if there was a way to call oid_object_info_extended() and say
    "open the object and look at the type; only return the contents if
    it's a non-blob").

  - I still think it's probably worth having a mode where we store the
    set of pointed-to objects we don't have, rather than parsing on the
    fly. This could easily be made optional (it's a good thing if you
    _have_ a lot of objects that point to a small or moderate number of
    missing objects, like a blob:limit or blob:none filter; it's a bad
    thing if you have very few objects but they point to a very large
    number).

I didn't explore any of those here, and I don't plan to look into them
anytime soon. I'm just documenting my findings for later.

Anyway, here are the patches.

  [1/3]: is_promisor_object(): free tree buffer after parsing
  [2/3]: lookup_unknown_object(): take a repository argument
  [3/3]: revision: avoid parsing with --exclude-promisor-objects

 builtin/fsck.c                   |  2 +-
 builtin/pack-objects.c           |  2 +-
 http-push.c                      |  2 +-
 object.c                         |  7 +++----
 object.h                         |  2 +-
 packfile.c                       |  1 +
 refs.c                           |  2 +-
 revision.c                       |  2 +-
 t/helper/test-example-decorate.c |  6 +++---
 t/perf/p5600-partial-clone.sh    | 12 ++++++++++++
 upload-pack.c                    |  2 +-
 walker.c                         |  2 +-
 12 files changed, 27 insertions(+), 15 deletions(-)

-Peff
