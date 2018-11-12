Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943271F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKMAkE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:40:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:35634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAkE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:40:04 -0500
Received: (qmail 29198 invoked by uid 109); 12 Nov 2018 14:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:46:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11156 invoked by uid 111); 12 Nov 2018 14:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:45:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:46:28 -0500
Date:   Mon, 12 Nov 2018 09:46:28 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 0/9] caching loose objects
Message-ID: <20181112144627.GA2478@sigill.intra.peff.net>
References: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
 <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
 <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com>
 <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com>
 <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com>
 <20181108120256.GA29432@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108120256.GA29432@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the series I mentioned earlier in the thread to cache loose
objects when answering has_object_file(..., OBJECT_INFO_QUICK). For
those just joining us, this makes operations that look up a lot of
missing objects (like "index-pack" looking for collisions) faster. This
is mostly targeted at systems where stat() is slow, like over NFS, but
it seems to give a 2% speedup indexing a full git.git packfile into an
empty repository (i.e., what you'd see on a clone).

I'm adding René Scharfe and Takuto Ikuta to the cc for their previous
work in loose-object caching.

The interesting bit is patch 8. The rest of it is cleanup to let us
treat alternates and the main object directory similarly.

  [1/9]: fsck: do not reuse child_process structs
  [2/9]: submodule--helper: prefer strip_suffix() to ends_with()
  [3/9]: rename "alternate_object_database" to "object_directory"
  [4/9]: sha1_file_name(): overwrite buffer instead of appending
  [5/9]: handle alternates paths the same as the main object dir
  [6/9]: sha1-file: use an object_directory for the main object dir
  [7/9]: object-store: provide helpers for loose_objects_cache
  [8/9]: sha1-file: use loose object cache for quick existence check
  [9/9]: fetch-pack: drop custom loose object cache

 builtin/count-objects.c     |   4 +-
 builtin/fsck.c              |  35 +++---
 builtin/grep.c              |   2 +-
 builtin/submodule--helper.c |   9 +-
 commit-graph.c              |  13 +--
 environment.c               |   4 +-
 fetch-pack.c                |  39 +------
 http-walker.c               |   2 +-
 http.c                      |   4 +-
 object-store.h              |  60 +++++------
 object.c                    |  26 ++---
 packfile.c                  |  20 ++--
 path.c                      |   2 +-
 repository.c                |   8 +-
 sha1-file.c                 | 210 ++++++++++++++++++------------------
 sha1-name.c                 |  42 ++------
 transport.c                 |   2 +-
 17 files changed, 209 insertions(+), 273 deletions(-)

-Peff
