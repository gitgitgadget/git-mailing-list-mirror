Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7152027C
	for <e@80x24.org>; Fri,  2 Jun 2017 21:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdFBVzV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 17:55:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:34122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbdFBVzT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 17:55:19 -0400
Received: (qmail 7431 invoked by uid 109); 2 Jun 2017 03:08:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 03:08:28 +0000
Received: (qmail 24849 invoked by uid 111); 2 Jun 2017 03:09:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 23:09:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 23:08:25 -0400
Date:   Thu, 1 Jun 2017 23:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
Message-ID: <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 11:23:30AM +0900, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > Am 27.05.2017 um 23:46 schrieb Jeff King:
> >> On Sat, May 27, 2017 at 06:57:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >>> There's another test which breaks if we just s/gmtime/localtime/g. As
> >>> far as I can tell to make the non-local case work we'd need to do a
> >>> whole dance where we set the TZ variable to e.g. UTC$offset, then call
> >>> strftime(), then call it again. Maybe there's some way to just specify
> >>> the tz offset, but I didn't find any in a quick skimming of time.h.
> >> 
> >> There isn't.
> > Right.  We could handle %z internally, though.  %Z would be harder (left
> > as an exercise for readers..).
> >
> > First we'd have to undo 0a0416a3 (strbuf_expand: convert "%%" to "%"),
> > though, in order to give full control back to strbuf_expand callbacks.
> >
> > 2-pack patch:
> 
> I think the list concensus is that handling %z ourselves like this
> one does is the best we can do portably.

I've actually been turning it over in my head. This feels hacky, but I'm
not sure if we can do better.

In theory the solution is:

  1. Start using localtime() instead of gmtime() with an adjustment when
     we are converting to the local timezone (i.e., format-local). We
     should be able to do this portably.

     This is easy to do, and it's better than handling %z ourselves,
     because it makes %Z work, too.

  2. When showing the author's timezone, do some trickery to set the
     program's timezone, then use localtime(), then restore the program
     timezone.

     I couldn't get this to work reliably. And anyway, we'd still have
     nothing to put in %Z since we don't have a timezone name at all in
     the git objects. We just have "+0400" or whatever.

So I don't see a portable way to make (2) work. But it seems a shame
that %Z does not work for case (1) with René's patch.

I guess we could do (1) for the local cases and then handle "%z"
ourselves otherwise. That sounds even _more_ confusing, but it at least
gets the most cases right.

If we do handle "%z" ourselves (either always or for just the one case),
what should the matching %Z say? Right now (and I think with René's
patch) it says GMT, which is actively misleading. We should probably
replace it with the same text as "%z". That's not quite what the user
wanted, but at least it's accurate.

> > --- >8 ---
> >  builtin/cat-file.c         |  5 +++++
> >  convert.c                  |  1 +
> >  daemon.c                   |  3 +++
> >  date.c                     |  2 +-
> >  ll-merge.c                 |  5 +++--
> >  pretty.c                   |  3 +++
> >  strbuf.c                   | 39 ++++++++++++++++++++++++++++++---------
> >  strbuf.h                   | 11 +++++------
> >  t/t6006-rev-list-format.sh | 12 ++++++++++++
> >  9 files changed, 63 insertions(+), 18 deletions(-)

As far as the patch itself goes, I'm disappointed to lose the automatic
"%" handling for all of the other callers. But I suspect the boilerplate
involved in any solution that lets callers choose whether or not to use
it would end up being longer than just handling it in each caller.

-Peff
