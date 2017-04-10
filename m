Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873BC20966
	for <e@80x24.org>; Mon, 10 Apr 2017 13:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbdDJNjA (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 09:39:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59157 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdDJNi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 09:38:59 -0400
Received: (qmail 31245 invoked by uid 109); 10 Apr 2017 13:38:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 13:38:59 +0000
Received: (qmail 24909 invoked by uid 111); 10 Apr 2017 13:39:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 09:39:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 09:38:57 -0400
Date:   Mon, 10 Apr 2017 09:38:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
Message-ID: <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
References: <20170409191117.25175-3-avarab@gmail.com>
 <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
 <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 01:40:13PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > A few other failures are triggered by the ':' in the trash directory's
> > name, breaking the following commonly used pattern:
> >
> >   export GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY" &&
> >   cd subdir &&
> >   test-git-pretending-it's-run-outside-of-a-repository
> 
> Does GIT_CEILING_DIRECTORIES support escaping somehow? E.g.
> "foo\:bar". If so maybe we could use a wrapper to set it, if not
> that's a bug in the ceiling dir feature, surely.

I don't think it does. But nor does $PATH (which is almost certainly
another source of breakage). And neither does info/alternates allow
pathnames with newline in them (that is the likely cause of a large
number of failures, as it hits anywhere we use "clone -s").

Are those bugs? Maybe. Certainly they are limitations. But are they ones
anybody _cares_ about?  I think this may fall under "if it hurts, don't
do it". If there are security bugs where a malicious input can cause us
to do something bad, that's something to care about. But that's very
different than asking "do these tests run to completion with a funny
input".

  As an aside, I'd also question whether your patch might actually
  _hide_ bugs. It's applying a blanket change to the on-disk state that
  is obviously breaking some features. How many of those breakages are
  things that show up as a test failure, and how many of them quietly
  cause a test to do something else entirely, like failing its setup in
  a way that makes the rest of the test a noop?

So given the pain this will cause to people actually looking at tests,
and given that it's not clear to me if it has or will find any actual
bugs, it seems premature to flip it on by default. If somebody wants to
actually dig into these cases and look for actual bugs, I'm all for it.

But flipping the default and marking a bunch of tests blindly as "well,
this fails" hasn't made the world a better place. It's made it slightly
worse.

-Peff

PS If you want to test various characters, I think the simplest way is
   just:

     make GIT_TEST_OPTS=--root=/tmp/look-a-col:on test
