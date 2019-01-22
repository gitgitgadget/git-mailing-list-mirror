Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78BD1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAVS2v (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:28:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:44644 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726741AbfAVS2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:28:51 -0500
Received: (qmail 2134 invoked by uid 109); 22 Jan 2019 18:28:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 18:28:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9076 invoked by uid 111); 22 Jan 2019 18:28:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 13:28:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 13:28:49 -0500
Date:   Tue, 22 Jan 2019 13:28:49 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
Message-ID: <20190122182849.GD4399@sigill.intra.peff.net>
References: <20190107213013.231514-1-brho@google.com>
 <20190117202919.157326-1-brho@google.com>
 <20190117202919.157326-2-brho@google.com>
 <87k1j247ui.fsf@evledraar.gmail.com>
 <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
 <20190118213018.GA28808@sigill.intra.peff.net>
 <87h8e54n6y.fsf@evledraar.gmail.com>
 <20190122071251.GB28555@sigill.intra.peff.net>
 <87ef953tyn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef953tyn.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 10:46:56AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > At which point, I think it might be simpler to just make git more
> > permissive with respect to those minor data errors (and in fact, we are
> > already pretty permissive for the most part in non-fsck operations).
> 
> Yeah it's probably better to make some of these "errors" softer
> warnings.
> 
> The X-Y issue I have is that I turned on transfer.fsckObjects, so then I
> can't clone repos with various minor historical issues in commit headers
> etc., so I maintain a big skip list. But what I was actually after was
> fsck checks like the .gitmodules security check.
>
> Of course I could chase them all down and turn them into
> warn/error/ignore individually, but it would be better if we e.g. had
> some way to say "serious things error, minor things warn", maybe with
> the option of only having the looser version on fetch but not recieve
> with the principle that we should be loose in what we accept from
> existing data but strict with new data #leftoverbits

Yeah, I think the current state here is rather unfortunate. The worst
part is that many of the things _are_ marked as warnings, but we reject
transfers even for warnings. So now we have "info" as well, which is
really just silly.

I think the big blocker to simply loosening "warning" is that the
current severities are pretty arbitrary. MISSING_NAME_BEFORE_EMAIL
probably ought to be warning, but it's an warning. Whereas HAS_DOTGIT is
a warning, but has pretty serious security implications.

So that does not save you from chasing them all down, but if you do, at
least the work could benefit everybody. ;)

-Peff
