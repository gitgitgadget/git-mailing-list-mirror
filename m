Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6FC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D1960FD9
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhH0SEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 14:04:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:60796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhH0SEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 14:04:30 -0400
Received: (qmail 8928 invoked by uid 109); 27 Aug 2021 18:03:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 18:03:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15425 invoked by uid 111); 27 Aug 2021 18:03:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Aug 2021 14:03:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Aug 2021 14:03:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        Christopher Yeleighton via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher Yeleighton <ne01026@shark.2a.pl>
Subject: Re: [PATCH v2] pretty-options.txt: describe supported encoding
Message-ID: <YSko++W+QHiDX81X@coredump.intra.peff.net>
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com>
 <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
 <2247912.lYO0ccLKhl@localhost.localdomain>
 <xmqq5yvqbz0j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yvqbz0j.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 10:03:56AM -0700, Junio C Hamano wrote:

> > +       The encoding must be a system encoding supported by iconv(1),
> > +       otherwise this option will be ignored.
> > +       POSIX character maps used by iconv(1p) are not supported.
> 
> This paragraph is a bit hard to grok.
> 
> I think it is saying that the "-f frommap -t tomap" form in [*1*]
> that can use arbitrary character set description file is not
> supported, but "-f fromcode -t tocode" form, which also is what
> iconv_open() takes [*2*], is supported.  Am I reading it correctly?
> 
> Is there an easier-to-read way to explain the distinction to our
> average reader?
> 
> What I am getting at is this.  Imagine average users who need to see
> their commits recoded to iso-8859-2.  They see "git log" has
> "--encoding=<encoding>" option, read the above paragraph and wonder
> if they are on the supported side or unsupported side of the above
> paragraph.  I want to make it easy for them to stop wondering.
> 
> For that purpose, "iconv(1) vs iconv(1p)" would not help them very
> much, especially considering that not all Git users are UNIX users
> (they probably do not even know what (1) and (1p) means).

I likewise found the mention of character maps confusing. If we were to
refer to anything, it would be iconv(3) or iconv_open(3). But really,
all of the discussion that led to this patch seemed to be about the
distinction between "character set conversion" (or "character encoding",
or "codeset conversion", all terms used by the POSIX pages) and the
syntactic encoding of HTML.

Is there any version of iconv that would convert "<" to "&lt;"?

I guess that _conceptually_ one could think of that as a multi-byte
character conversion, but it seems to me that it is generally considered
a layer above (after all, the original "<" and characters in the HTML
entity have to be in some character encoding; generally ASCII, but I
think you could have UTF-16 HTML, too).

What I'm getting it is that maybe we just need to use a less generic
word than "encoding". Perhaps just s/encoding/character &/ or something?
And maybe add something like:

  Conversions are done using the system iconv(3) function. The set of
  available encodings will depend on your system.

You _can_ use "iconv -l" to get such a list on many systems, but it is
not even necessarily the same list.

I also wonder if other mentions of encoding would want to use the same
term (e.g., gitattributes working-tree-encoding), and of course
i18n.commitEncoding (though peeking at the latter, it seems to already
say "Character encoding", so maybe that is sufficient).

-Peff
