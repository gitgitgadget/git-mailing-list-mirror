Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C44A1F462
	for <e@80x24.org>; Tue, 28 May 2019 06:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfE1GGo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:06:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726789AbfE1GGo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:06:44 -0400
Received: (qmail 27220 invoked by uid 109); 28 May 2019 06:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 06:06:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10337 invoked by uid 111); 28 May 2019 06:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 02:07:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 02:06:42 -0400
Date:   Tue, 28 May 2019 02:06:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally
 promises
Message-ID: <20190528060641.GC7946@sigill.intra.peff.net>
References: <20190520215312.10363-1-avarab@gmail.com>
 <20190520215312.10363-3-avarab@gmail.com>
 <20190522050839.GB29933@sigill.intra.peff.net>
 <86woigp3ro.fsf@gmail.com>
 <87lfywf9fp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfywf9fp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 12:12:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I thik that this implemetation detail of `--literally` is here to stay;
> > how would you otherwise fix the issue if garbage object makes Git crash?
> >
> > However, I would prefer to have options state _intent_; if there is
> > legitimate need for a tool that creates loose objects, it would be
> > better to have separate `--loose` option to `git hash-object` (which
> > would imply `-w`, otherwise it doesn't have sense).
> 
> I wonder if we can just remove this option and replace it with a
> GIT_TEST_* env variable, or even a test-tool helper. I can't see why
> anyone other than our own test suite wants this, and that's why it was
> added. So why document it & expose it in a plumbing tool?

I can think of a few reasons you might want it in the general toolbox:

  - you could be recreating a known-buggy history and want to overcome
    consistency checks (e.g., imagine a tool that imports or modifies
    git history, and needs to recreate objects literally, warts and
    all). I think we don't do a lot of quality checks in hash-object
    now, but we have discussed it (and --literally would be the obvious
    escape hatch).

  - folks like security researchers who are poking at Git and want to
    see how it reacts to various almost-correct inputs. They _could_ use
    the test-tool helper, but being able to demonstrate bugs with the
    standard toolbox is helpful for communication.

  - likewise for general non-security debugging ("it behaves in this
    funny way if I violate this constraint...")

So I actually think it's nice to have it as part of the plumbing, as
long as it's buried and documented sufficiently that unsuspecting users
do not stumble onto it.

And at any rate, now that it has been in the wild for a while, we risk
breaking somebody who has come to depend on it.

-Peff
