Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2811C1F45F
	for <e@80x24.org>; Wed,  1 May 2019 21:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAVP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 17:15:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:46366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726088AbfEAVP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 17:15:27 -0400
Received: (qmail 25096 invoked by uid 109); 1 May 2019 21:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 21:15:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22818 invoked by uid 111); 1 May 2019 21:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 17:16:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 17:15:25 -0400
Date:   Wed, 1 May 2019 17:15:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
Message-ID: <20190501211525.GB15902@sigill.intra.peff.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com>
 <20190425143614.GA91608@google.com>
 <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
 <20190430211415.GB16290@sigill.intra.peff.net>
 <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
 <87r29iqsf9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r29iqsf9.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 02:18:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> We can make it fancier, but we already deal with this, e.g. if you do
> "git config -l" we'll show "include{,if}" directives at the same "level"
> as other "normal" keys.

We show them, but we _do_ interpret them if the caller asks for it with
--includes (which defaults to on when doing the usual "look in all
files").

I think we'd have something similar here, where the caller can ask to
apply excludes or not.

> We also provide no way in "git config" to properly interpret a
> value. E.g. does a "user.email" showing up twice for me mean I have two
> E-Mails at the same time, or does the last one win? We both know the
> answer, but git-config itself doesn't, and that information lives in
> docs/code outside of it.
> 
> Similarly we'd just print a sequence of:
> 
>     user.name=foo
>     user.email=bar
>     exclude.key=user.*
>     user.name=baz
> 
> And it would be up to some "smarter" reader of the config data to
> realize that the end result is one where we have no "user.email" set,
> and "user.name=baz".
> 
> But yeah, optionally having some new --list-normalized or
> --list-after-excludes or whatever would be great, and presumably not
> hard if we had some central "excludes" mechanism...

I think that is all because "--list" really is just about dumping all
values, not about interpreting. If we had an exclude mechanism, then I'd
expect:

  git config user.name

to apply it just like git_config_get_string() would.

Because of its lack of interpretation, I don't think --list is actually
good for much besides debugging. Some scripts do use it to avoid making
a bunch of individual git-config calls, but they'd be much better served
by a --stdin mode which let you feed in a sequence of operations ("I want
x.y.z, as a single last-one-wins value, and interpreted as a bool") and
get a sequence of outputs.

-Peff
