Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5603C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiKNWEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiKNWD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:03:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997A8A193
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:03:58 -0800 (PST)
Received: (qmail 15230 invoked by uid 109); 14 Nov 2022 22:03:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Nov 2022 22:03:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14385 invoked by uid 111); 14 Nov 2022 22:03:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Nov 2022 17:03:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Nov 2022 17:03:56 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 1/2] pack-bitmap.c: remove unnecessary
 "open_pack_index()" calls
Message-ID: <Y3K7TEpB8EzczjTb@coredump.intra.peff.net>
References: <cover.1668063122.git.dyroneteng@gmail.com>
 <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 03:10:11PM +0800, Teng Long wrote:

> It's likely that we'll end up relying on objects in that pack later
> in the process (in which case we're doing the work of opening the
> pack index optimistically), but not guaranteed.
> 
> For instance, consider a repository with a large number of small
> packs, and one large pack with a bitmap. If we see that bitmap pack
> last in our loop which calls open_pack_bitmap_1(), the current code
> will have opened *all* pack index files in the repository. If the
> request can be served out of the bitmapped pack alone, then the time
> spent opening these idx files was wasted.S

By the way, I wondered if it was possible to measure a slowdown in this
case. It is, but you have to try pretty hard. Something like this:

  # one bitmapped pack
  git repack -adb

  # and then a bunch of other packs
  git rev-list HEAD |
  head -10000 |
  while read commit; do
    echo $commit | git pack-objects .git/objects/pack/pack
  done

  # make the bitmapped one newest, since otherwise our non-bitmap lookup
  # of the initial traversal commit causes us to open all the other
  # packs first!
  bitmap=$(echo .git/objects/pack/pack-*.bitmap)
  touch ${bitmap%.bitmap}.*

  hyperfine -L v old,new './git.{v} rev-list --count --use-bitmap-index HEAD'

where "new" and "old" are builds with and without this patch. I get:

  Benchmark 1: ./git.old rev-list --count --use-bitmap-index HEAD
    Time (mean ± σ):     117.9 ms ±   1.8 ms    [User: 26.9 ms, System: 90.0 ms]
    Range (min … max):   113.4 ms … 120.3 ms    25 runs
  
  Benchmark 2: ./git.new rev-list --count --use-bitmap-index HEAD
    Time (mean ± σ):      71.8 ms ±   2.6 ms    [User: 21.2 ms, System: 50.5 ms]
    Range (min … max):    67.0 ms …  75.1 ms    41 runs
  
  Summary
    './git.new rev-list --count --use-bitmap-index HEAD' ran
      1.64 ± 0.06 times faster than './git.old rev-list --count --use-bitmap-index HEAD'

which implies to me two things:

  - this probably isn't helping anybody much in the real world, as
    evidenced by the contortions I had to go through to set up the
    situation (and which would be made much better by repacking, which
    would also speed up non-bitmap operations).

  - it's worth doing anyway. Even if it only shaves off microseconds,
    the existing call is just pointless.

-Peff
