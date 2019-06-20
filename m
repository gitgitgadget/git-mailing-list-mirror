Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0041F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfFTHjy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:39:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:39:54 -0400
Received: (qmail 16384 invoked by uid 109); 20 Jun 2019 07:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:39:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12653 invoked by uid 111); 20 Jun 2019 07:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:40:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:39:52 -0400
Date:   Thu, 20 Jun 2019 03:39:52 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/17] drop non-object_id hashing
Message-ID: <20190620073952.GA1539@sigill.intra.peff.net>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
 <20190619214212.GE6571@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619214212.GE6571@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 05:42:12PM -0400, Jeff King wrote:

> I do think that sha1hash() will eventually go away in favor of
> oidhash(), but we can approach that separately, and convert oidmap along
> with everyone else.
> 
> It looks like we are close to being able to do that now. Grepping for
> sha1hash shows just about everybody dereferencing an oid object, except
> for the call in pack-objects.c. And skimming the callers there,
> they all appear to have an oid object, too.

Here are patches to do that. I decided not to build them on top of
yours, just to keep things simple. When merged with yours, there's no
textual conflict, but the new calls to sha1hash(key->hash) need to
become oidhash(key) instead (the compiler does catch this). It would be
easy to rebase, though.

I ended up with quite a few more patches than I thought I would need,
but I'm actually pretty pleased with the result. A lot of these are
cleanups in the packfile code that I'd been meaning to do for a while.

  [01/17]: describe: fix accidental oid/hash type-punning
  [02/17]: upload-pack: rename a "sha1" variable to "oid"

These first two are small cleanups I noticed in sites I touched later in
the series.

  [03/17]: pack-bitmap-write: convert some helpers to use object_id
  [04/17]: pack-objects: convert packlist_find() to use object_id
  [05/17]: pack-objects: convert locate_object_entry_hash() to object_id
  [06/17]: object: convert lookup_unknown_object() to use object_id
  [07/17]: object: convert lookup_object() to use object_id
  [08/17]: object: convert internal hash_obj() to object_id
  [09/17]: object: convert create_object() to use object_id

These ones are all just about passing object_id structs around more
consistently. In most cases, all of the callers of a particular function
were already passing "oid->hash", so we could just have them pass "oid"
instead.

The big one here is lookup_object(), which shockingly does not seem to
create any conflicts with pu.

  [10/17]: khash: drop broken oid_map typedef
  [11/17]: khash: rename kh_oid_t to kh_oid_set
  [12/17]: delta-islands: convert island_marks khash to use oids
  [13/17]: pack-bitmap: convert khash_sha1 maps into kh_oid_map
  [14/17]: khash: drop sha1-specific map types
  [15/17]: khash: rename oid helper functions

Some khash cleanups and prep to stop using sha1hash() there.

  [16/17]: hash.h: move object_id definition from cache.h
  [17/17]: hashmap: convert sha1hash() to oidhash()

And then finally we can rename the offending function. Ta-da. :)

 blob.c                           |  5 ++---
 builtin/describe.c               |  4 ++--
 builtin/fast-export.c            |  4 ++--
 builtin/fsck.c                   |  8 ++++----
 builtin/name-rev.c               |  3 +--
 builtin/pack-objects.c           | 21 +++++++++++----------
 builtin/prune.c                  |  2 +-
 builtin/unpack-objects.c         |  2 +-
 cache.h                          | 24 ------------------------
 commit-graph.c                   |  2 +-
 commit.c                         |  5 ++---
 decorate.c                       |  2 +-
 delta-islands.c                  | 24 ++++++++++++------------
 diffcore-rename.c                |  2 +-
 fetch-pack.c                     | 12 ++++++------
 fsck.c                           |  2 +-
 hash.h                           | 24 ++++++++++++++++++++++++
 hashmap.h                        |  8 +++++---
 http-push.c                      |  4 ++--
 khash.h                          | 22 ++++++----------------
 object.c                         | 26 +++++++++++++-------------
 object.h                         |  6 +++---
 oidset.c                         | 12 ++++++------
 oidset.h                         |  4 ++--
 pack-bitmap-write.c              | 30 +++++++++++++++---------------
 pack-bitmap.c                    | 16 ++++++++--------
 pack-bitmap.h                    |  2 +-
 pack-objects.c                   | 12 ++++++------
 pack-objects.h                   |  2 +-
 patch-ids.c                      |  2 +-
 reachable.c                      |  4 ++--
 refs.c                           |  2 +-
 t/helper/test-example-decorate.c |  6 +++---
 tag.c                            |  5 ++---
 tree.c                           |  5 ++---
 upload-pack.c                    |  8 ++++----
 walker.c                         |  2 +-
 37 files changed, 156 insertions(+), 168 deletions(-)

-Peff
