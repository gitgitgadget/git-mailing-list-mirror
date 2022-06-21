Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD9CC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 06:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiFUGrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 02:47:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC11C139
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 23:47:36 -0700 (PDT)
Received: (qmail 30487 invoked by uid 109); 21 Jun 2022 06:47:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jun 2022 06:47:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Tue, 21 Jun 2022 02:47:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb" without
 NOOP run slowdowns
Message-ID: <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
 <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
 <xmqqa6ap8z55.fsf@gitster.g>
 <20220620083202.GB1689@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620083202.GB1689@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 10:32:02AM +0200, SZEDER Gábor wrote:

> On Mon, Jun 06, 2022 at 10:44:54AM -0700, Junio C Hamano wrote:
> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > 
> > > The $subject is a proposed re-roll of SZEDER's
> > > https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.com;
> > > As noted downthread of that fix having the Makefile invoke "make -C
> > > gitweb" again would slow us down on NOOP runs by quite a bit.
> > 
> > It would be nice to hear comments SZEDER and others, even if the
> > comments are clear negative or positive.
> 
> Well, my itch is scratched, so I'm fine with it :)
> 
> I think Peff has a point by questioning whether we should build and
> install gitweb by default...  I don't have an opinion about that, but
> if we do want to build it by default, then IMO doing it in the main
> Makefile is the way to go, so I think in that case this patch series
> goes in the right direction.

I hadn't realized the full situation when I was arguing earlier that "we
have not been building it for several years". You raised the point that
we do auto-build it in "make install", so it would be a change of
behavior to stop doing so.

I still find it hard to care too much about backwards compatibility for
building gitweb (or really gitweb at all, for that matter). But my main
complaint was foisting another recursive Makefile and its performance
and troubles on developers at large, and I think Ævar's patches deal
with it. So I'm OK with the direction.

I admit I didn't look _too_ closely at them, but they overall seemed
sensible to me. Two things I noted:

  - I wondered if "make NO_PERL=1" would complain about "gitweb" being
    in the default targets. It doesn't, but it does actually build
    gitweb, which seems a little weird. I don't think we actually rely
    on perl during the build (e.g., no "perl -c" checks or anything),
    and the t950x tests seem to respect NO_PERL and avoid running the
    generated file. So maybe it's OK?

  - Speaking of backwards compatibility: after this series, "cd gitweb
    && make" yields an error. It's got a nice message telling you what
    to do, but it's likely breaking distro scripts. Again, I'm not sure
    I care, but if the point of the exercise was to avoid breaking
    things, well...

-Peff
