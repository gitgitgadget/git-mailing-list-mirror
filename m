Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6331FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 22:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762174AbcLPWQS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 17:16:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:57825 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758055AbcLPWQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 17:16:16 -0500
Received: (qmail 13201 invoked by uid 109); 16 Dec 2016 22:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 22:16:16 +0000
Received: (qmail 15229 invoked by uid 111); 16 Dec 2016 22:16:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 17:16:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 17:16:12 -0500
Date:   Fri, 16 Dec 2016 17:16:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
        stefan.naewe@atlas-elektronik.com, gitter.spiros@gmail.com
Subject: Re: [RFC/PATCH] Makefile: suppress some cppcheck false-positives
Message-ID: <20161216221612.whxm3z3clhi4xcha@sigill.intra.peff.net>
References: <20161214112401.mq3n5kui5eeebdtk@sigill.intra.peff.net>
 <20161215232240.19427-1-judge.packham@gmail.com>
 <xmqqshpnsoij.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshpnsoij.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 10:43:48AM -0800, Junio C Hamano wrote:

> > diff --git a/nedmalloc.supp b/nedmalloc.supp
> [...]
> > diff --git a/regcomp.supp b/regcomp.supp
> 
> Yuck for both files for multiple reasons.
> 
> I do not think it is a good idea to allow these files to clutter the
> top-level of tree.  How often do we expect that we may have to add
> more of these files?  Every time we start borrowing code from third
> parties?
> 
> What is the goal we want to achieve by running cppcheck?  
> 
>  a. Our code must be clean but we do not bother "fixing" [*1*] the
>     code we borrow from third parties and squelch output instead?
> 
>  b. Both our own code and third party code we borrow need to be free
>     of errors and misdetections from cppcheck?
> 
>  c. Something else?
> 
> If a. is what we aim for, perhaps a better option may be not to run
> cppcheck for the code we borrowed from third-party at all in the
> first place.  
> 
> If b. is our goal, we need to make sure that the false positive rate
> of cppcheck is acceptably low.

I think (b) is the goal; we'd hope that both our code and third party
code would be bug-free. I think it's a fact of life with a static
analysis tool that we're going to have to silence some false positives.

I think Chris started with the ones in compat because we are pretty sure
they won't change much, so suppressing them by line number is easy. But
we'd need to revisit this for our code, too. So just turning it off for
compat/ is only punting on the problem for a little while. :)

I do think it would be less gross if we could put these files into
compat/nedmalloc, etc. I don't know if you can specify
--suppressions-list multiple times, but certainly we could do some
pre-processing like:

  find . -name '*.cppcheck' |
  while read suppfile; do
	dir=$(dirname $suppfile)
	sed "s{^}{$dir/}" <$suppfile
  done >master-suppfile
  cppcheck --suppressions-file=master-suppfile

That would at least let us drop individual suppression files into their
respective directories.

I do wonder, though, if the "inline" suppressions would be less painful.
It looks like doing:

  // cppcheck-suppress uninitialized
  int var = var;

would work. I'm not sure if it understands non-C99 comments, though
maybe it is time for us to loosen that rule. And suppressing the false
positives that way does avoid fighting with gcc's analyzer, since we're
not changing the code.

The real question is how often we'd have to sprinkle those comments, and
how painful it would be. I see only 4 false positives that need
suppressed in our code, but 2 of them rub me the wrong way. They are due
to the tool failing to realize that die() is marked with NORETURN.
Marking some site as "no, this isn't a double-free, the other code path
would have died" feels like the wrong spot. The tool failure isn't where
we're marking, but rather 10 lines above.

-Peff
