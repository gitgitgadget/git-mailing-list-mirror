Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA7A20248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCEE6x (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:58:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:38894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEE6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:58:53 -0500
Received: (qmail 872 invoked by uid 109); 5 Mar 2019 04:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:58:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28786 invoked by uid 111); 5 Mar 2019 04:59:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:59:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:58:51 -0500
Date:   Mon, 4 Mar 2019 23:58:51 -0500
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
Message-ID: <20190305045851.GJ19800@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
 <20190226193912.GD19739@szeder.dev>
 <20190226210101.GA27914@sigill.intra.peff.net>
 <20190304143633.GC28939@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190304143633.GC28939@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 03:36:33PM +0100, SZEDER Gábor wrote:

> On Tue, Feb 26, 2019 at 04:01:01PM -0500, Jeff King wrote:
> > > +	{ set +x ; } 2>/dev/null 4>/dev/null
> > 
> > Ah, this is the magic. Doing:
> > 
> >   set +x 2>/dev/null
> > 
> > will still show it, but doing the redirection in a wrapping block means
> > that it is applied before the command inside the block is run. Clever.
> 
> Yeah, clever, but unfortunately (and to me suprisingly) unportable:
> 
>   $ ksh
>   $ set -x
>   $ echo foo
>   + echo foo
>   foo
>   $ set +x
>   $ 
> 
> It doesn't show 'set +x', how convenient! :)
> However:
> 
>   $ set -x
>   $ echo foo 2>/dev/null
>   + echo foo
>   + 2> /dev/null
>   foo
>   $ { set +x; } 2>/dev/null
>   + 2> /dev/null
>   $ 

Hmph. Good find. As you note, this is already a problem with "-x". I'm
not sure if there's an easy way to fix this. We can't wrap it in a
conditional function easily. I guess we could do something like:

  if test "$SOMEHOW_WE_DETECT_KSH"
  then
	eval "set -x; run_the_test; set +x"
  else
	eval "set -x; run_the_test; { set +x; } 2>/dev/null"
  fi

but I wonder if just ignoring it is a viable option here. We're talking
about debugging output from the test suite, after all. As long as the
test suite still _works_ on those shells, and as long as there are no
developers on ksh-primary systems who can't bear to use another
$TEST_SHELL_PATH, it's really not hurting anybody. The worst case is
somebody reporting a test failure on NetBSD might have a slightly more
verbose "-x" output.

-Peff
