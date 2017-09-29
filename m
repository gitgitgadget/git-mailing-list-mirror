Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E1220281
	for <e@80x24.org>; Fri, 29 Sep 2017 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdI2Xh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 19:37:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752505AbdI2Xh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 19:37:26 -0400
Received: (qmail 12296 invoked by uid 109); 29 Sep 2017 23:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 23:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9298 invoked by uid 111); 29 Sep 2017 23:38:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 19:38:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Sep 2017 19:37:23 -0400
Date:   Fri, 29 Sep 2017 19:37:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, gitster@pobox.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170929233723.c7ixg5fb3flbgaom@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
 <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
 <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
 <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 07:08:28PM +0300, Оля Тележная wrote:

> Many thanks to all of you, I am interested in every opinion. Sorry
> that I wasn't in the discussion, unfortunately I got sick, that's why
> I skipped all the process.

No problem. It's often reasonable to let review comments come in and
think about them as a whole before responding or re-posting anyway.

> > An overlong line (I can locally wrap it, so the patch does not have
> > to be re-sent only to fix this alone).
> I've read only about 50 characters max in commit head (and
> highlighting repeats it), but there's nothing about max length of line
> in commit message. Sorry, next time I will make it shorter.

Usually we shoot for making things look good in an 80-column terminal,
including both code and commit messages. For commit message bodies, we
tend to make them a little shorter, since "git log" will indent them. 72
characters is reasonable there. And we tend to make subject lines a
little shorter than that, even since they often appear with "Subject:"
and "[PATCH]" prefixed. I usually go for about 60 characters, but will
go over if it helps make the subject more clear.

> > I had envisioned leaving mru_mark() as a wrapper for "move to the front"
> > that could operate on any list. But seeing how Olga's patch takes it
> > down to two trivial lines, I'd also be fine with an endgame that just
> > eliminates it.
> Let's add needed function to list.h directly?

Yes, I think we could just call this "list_move_to_front()" or
something. The fact that it's operating on a list called
"packed_git_mru" is probably sufficient to make it clear that the
purpose is managing recentness.

> I also wanted to add
> list_for_each_entry function to list.h as it's in Linux kernel.
> https://www.kernel.org/doc/htmldocs/kernel-api/API-list-for-each-entry.html
> It will simplify the code even more, guess that not only in MRU
> related code. Maybe we need to do that in separate patch.

It would be nice to have list_for_each_entry(), but unfortunately it's
not portable. It relies on having a typeof operator, and we build on
platforms that lack it. It was omitted in 94e99012fc (http-walker:
reduce O(n) ops with doubly-linked list, 2016-07-11) for that reason.

> About minor issues ( "tmp" vs "p2", variable scope, space indentation)
> - fully agree, I will fix it.

Thanks.

> So finally I think that I need to fix that minor issues and that's
> all. I have plans to rewrite (with --amend) my current commit (I think
> so because I will add no new features, so it's better to have single
> commit for all changes).
> As I understand, Submitgit will send an update in a new thread. And I
> need to say there [PATCH v2].
> Please correct me if I am wrong in any of the moments mentioned earlier.

Correct. Until a patch is merged to Junio's "next" branch (at which
point it is set in stone), we generally prefer to rewrite it with
"--amend" (or git-rebase) to fix anything that comes up during the
review.

> By the way, other contributors write smth like "[PATCH v6 0/3]". What
> does mean "0/3"? It's about editing separate commits in a single
> patch, am I right?

Right, it means multiple commits in a logical series that are meant to
be applied together. Your patch is small enough that it makes as a
single patch. If we wanted to do the second step of dropping mru.[ch]
entirely now, then you'd probably have at least a 2-patch series.

(I'm OK with not doing that second step for now, though if we are not
going to polish up the mru_for_each() interface, it may make sense to
make the final step sooner rather than later).

-Peff
