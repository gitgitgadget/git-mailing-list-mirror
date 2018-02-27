Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3981F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeB0WPu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:15:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:39586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751590AbeB0WPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:15:50 -0500
Received: (qmail 10406 invoked by uid 109); 27 Feb 2018 22:15:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:15:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28326 invoked by uid 111); 27 Feb 2018 22:16:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:16:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:15:48 -0500
Date:   Tue, 27 Feb 2018 17:15:48 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] sequencer: always roll back lock in
 `do_recursive_merge()`
Message-ID: <20180227221547.GD11187@sigill.intra.peff.net>
References: <cover.1519763396.git.martin.agren@gmail.com>
 <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519763396.git.martin.agren@gmail.com>
 <20180227214430.GC6899@sigill.intra.peff.net>
 <CAN0heSr_4Sd5-yAUQ-SG+=NZrwFrAFqY66aYk0DgMEZ_s53iGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSr_4Sd5-yAUQ-SG+=NZrwFrAFqY66aYk0DgMEZ_s53iGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 11:08:12PM +0100, Martin Ågren wrote:

> > So I think it's correct as-is, but I wonder if writing it as:
> >
> >   if (!active_cache_changed)
> >         rollback_lock_file(&index_lock);
> >   else if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> >         return error(...);
> >
> > might be easier to follow. I'm OK with leaving it, too, but thought I'd
> > mention it in case it confused other reviewers.
> 
> I also hesitated at that one. There are some similar instances elsewhere, e.g.,
> in builtin/merge.c. There's also rerere.c, which does a variant of your
> suggestion.

Hmm, yeah, grepping shows quite a few of various forms.

I wonder if it is worth a helper like:

  /* like write_locked_index(), but optimize out unchanged writes */
  static int maybe_write_locked_index(struct index *index,
                                      struct lock_file *lock,
				      unsigned flags)
  {
	if (!index->cached_changed) {
		if (flags & COMMIT_LOCK)
			rollback_lock_file(lock);
		return 0;
	}
	return write_locked_index(index, lock, flags);
  }

Alternatively, it could just be a flag to write_locked_index() to enable
the optimization.

I actually suspect that most callers would prefer to have it kick in by
default (with an optional flag to disable it if some caller really needs
to), but that would possibly be a subtle breakage for the caller that
needs the flag.

-Peff
