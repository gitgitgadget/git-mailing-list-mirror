Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920BE207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947982AbdDTW1y (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:27:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947977AbdDTW1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:27:52 -0400
Received: (qmail 6942 invoked by uid 109); 20 Apr 2017 22:27:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 22:27:50 +0000
Received: (qmail 11608 invoked by uid 111); 20 Apr 2017 22:28:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 18:28:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:47 -0400
Date:   Thu, 20 Apr 2017 18:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?utf-8?Q?Zolt=C3=A1n?= Herczeg <hzmester@freemail.hu>
Subject: Re: [PATCH v3 03/18] grep: submodule-related case statements should
 die if new fields are added
Message-ID: <20170420222747.ooo5z63tzi6d5ayl@sigill.intra.peff.net>
References: <20170420212345.7408-1-avarab@gmail.com>
 <20170420212345.7408-4-avarab@gmail.com>
 <20170420222016.GJ142567@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420222016.GJ142567@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 03:20:16PM -0700, Brandon Williams wrote:

> On 04/20, Ævar Arnfjörð Bjarmason wrote:
> > Change two case statements added in commit 0281e487fd ("grep:
> > optionally recurse into submodules", 2016-12-16) so that they die if
> > new GREP_PATTERN_* enum fields are added without updating them.
> > 
> > These case statements currently check for an exhaustive list of
> > fields, but if a new field is added it's easy to introduce a bug here
> > where the code will start subtly doing the wrong thing, e.g. if a new
> > pattern type is added we'll fall through to
> > GREP_PATTERN_TYPE_UNSPECIFIED, i.e. the "basic" POSIX regular
> > expressions.
> > 
> > This should arguably be done for the switch(opt->binary)
> > case-statement as well, but isn't trivial to add since that code isn't
> > currently working with an exhaustive list.
> 
> I was under the impression that the code wouldn't compile if there is a
> missing enum field in the switch statement.  Does it instead silently
> fall through?  I would choose not compiling over a die statement that may
> not be caught during the development of a new series.

Usually -Wswitch would catch this, but the variable in question is
declared as an int. The original pattern_type_arg variable is an int
because we pass its address via OPT_SET_INT().

We could make the argument to compile_submodule_options() an enum, but
then we get an implicit cast when we pass the int (which could fail at
runtime). Yech. I'm not sure if there's a good and easy solution.

-Peff
