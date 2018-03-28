Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5171F424
	for <e@80x24.org>; Wed, 28 Mar 2018 01:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeC1B0j (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 21:26:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48804 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeC1B0i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 21:26:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EE3331F404;
        Wed, 28 Mar 2018 01:26:37 +0000 (UTC)
Date:   Wed, 28 Mar 2018 01:26:37 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
Message-ID: <20180328012637.GA12551@whir>
References: <20180325182803.30036-1-avarab@gmail.com>
 <20180325182803.30036-3-avarab@gmail.com>
 <20180325210132.GE74743@genre.crustytoothpaste.net>
 <87605jyfvi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87605jyfvi.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Good point. I also see that (via git log --author=Ævar --grep='^\[PATCH
> ') that this series itself arrived out of order (0 -> 2 -> 1), but I
> don't know to what extent public-inbox itself might be batching things.

public-inbox doesn't batch, aside from when the
public-inbox-watch process gets restarted and needs to catch up
using readdir.  Once it's done catching up with readdir, it
gets into an inotify loop which injects messages in the order
the MTA (or offlineimap) puts them in a Maildir.

Right now, public-inbox only sorts by Date: header in the mail.

The next Xapian schema revision of public-inbox will use
internally sorts search results(*) by the date in the newest
Received: header.  That is analogous to git committer date.  The
displayed message date will still be sorted by the Date: header
(analogous to git author date); since git-send-email already
alters the Date: in a series for sorting.

This allow messages/threads which are actually new get bumped to
the top of the homepage; regardless of how wrong the original
sender's clock was.

It should help prevent kernel developers from crafting message
dates with optimization for classic^Wextra reviews in mind :)


(*) all the look-at-a-bunch-of-messages operations, including
    the landing page (e.g. https://public-inbox.org/git/)
    is a Xapian search query, nowadays; but "git log"
