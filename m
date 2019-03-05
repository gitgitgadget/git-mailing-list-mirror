Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A22F20248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCEEzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:55:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:38876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEEzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:55:37 -0500
Received: (qmail 851 invoked by uid 109); 5 Mar 2019 04:55:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:55:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28759 invoked by uid 111); 5 Mar 2019 04:55:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:55:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:55:35 -0500
Date:   Mon, 4 Mar 2019 23:55:35 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190305045535.GI19800@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
 <20190226193912.GD19739@szeder.dev>
 <20190226210101.GA27914@sigill.intra.peff.net>
 <20190303160459.GB28939@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190303160459.GB28939@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 03, 2019 at 05:04:59PM +0100, SZEDER Gábor wrote:

> > >   - && chains in test helper functions; we must make sure that the
> > >     tracing is restored even in case of a failure.
> 
> Actually, the && chain is not really an issue, because we can simply
> break the && chain at the very end:
> 
>   test_func () {
>         { disable_tracing ; } 2>/dev/null 4>&2
>         do this &&
>         do that
>         restore_tracing
>   }
> 
> and make restore_tracing exit with $? (like you did above in pop_x()).

Yeah, good point.

> > Yeah, there is no "goto out" to help give a common exit point from the
> > function. You could probably do it with a wrapper, like:
> 
> Yeah, the wrapper works.
> There are only a few test helper functions with multiple 'return'
> statements, and refactoring them to have a single 'return $ret' at the
> end worked, too.

Yeah, that might be less sneaky than this wrapper business. Or we could
just do a few basic wrappers. The non-portable bit in my wrapper
suggestion was the renaming of the old function. But if we accept just:

  real_foo() {
	... do stuff with multiple returns ...
  }
  disable_function_tracing real_foo foo

then that is pretty trivial to do with an eval. It does disallow your
"wrap all functions at once", but I think that is OK. We might want to
only do a subset anyway.

> We should also be careful and don't switch on tracing when returning
> from test helper functions invoked outside of tests, e.g.
> 'test_create_repo' while initializing the trash directory or
> 'test_set_port' while sourcing a daemon-specific lib.

Yeah, it would probably make sense in the "push" half to check that we
are actually tracing at that moment.

> On a mostly unrelated note, but I just noticed it while playing around
> with this: 't0000'-basic.sh' runs its internal tests with $SHELL_PATH
> instead of $TEST_SHELL_PATH.  I'm not sure whether that's right or
> wrong.

I'd say probably wrong, though it likely doesn't matter that much in
practice.

-Peff
