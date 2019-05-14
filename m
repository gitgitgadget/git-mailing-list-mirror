Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE891F4B6
	for <e@80x24.org>; Tue, 14 May 2019 11:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfENLus (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:50:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38704 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENLus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:50:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B275E1F461;
        Tue, 14 May 2019 11:50:47 +0000 (UTC)
Date:   Tue, 14 May 2019 11:50:47 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190514115047.oncvfq24fhnp64re@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514094729.GA12256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> Yeah, I think there's sort of an open question here of who is calling
> update-server-info when nothing got updated. I think the only place we
> call it automatically is via receive-pack, but I'd guess Eric runs it as
> part of public-inbox scripts.

Correct.  post-update doesn't get run because public-inbox
relies on fast-import.  I have mirrors using "git fetch", which
also doesn't call post-update, either so I was calling
update-server-info in my mirror script.

Since more people have taken an interest in mirroring things,
I figured I'd make "public-inbox-index" (the script which
updates the Xapian and SQLite indices) call update-server-info
itself.

That way, it's simpler to mirror (v1) inboxes:

  git fetch && git update-server-info && public-inbox-index

becomes:

  git fetch && public-inbox-index

That's a huge savings in cognitive overhead.

So, my eventual goal for this is we get to the point where any
git operation which changes refs will automatically update
info/refs if it exists.

Ditto for objects/info/packs on any pack changes.

This, like my bitmap-by-default change is among the things
I'm trying to make it easier for more users to start
self-hosting (including mirroring) any type of git repo.

Anyways, I am far from knowledgeable about the locking
discussion for git, though :x

> That's my reading, too, but I didn't want to be responsible for
> regressing some obscure case. At least Eric seems to _use_
> update-server-info. ;)

I also have something else on my mind for abusing info files with :>
(another email)
