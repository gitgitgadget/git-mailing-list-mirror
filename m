Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED65A1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbfHHKDT (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 06:03:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37578 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389786AbfHHKDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 06:03:19 -0400
Received: (qmail 11379 invoked by uid 109); 8 Aug 2019 10:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 10:03:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18809 invoked by uid 111); 8 Aug 2019 10:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 06:05:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 06:03:18 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190808100318.GC12257@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <xmqqa7cml0s9.fsf@gitster-ct.c.googlers.com>
 <000f01d54c75$1a8fe460$4fafad20$@nexbridge.com>
 <20190806173817.GB4961@sigill.intra.peff.net>
 <20190806181459.GG20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806181459.GG20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 08:14:59PM +0200, SZEDER Gábor wrote:

> On Tue, Aug 06, 2019 at 01:38:17PM -0400, Jeff King wrote:
> > Nothing about "--" is changed by my series; it will still stop option
> > interpretation in rev-list and in other commands. But as before,
> > rev-list (and other Git commands that use the revision.c parser) use it
> > to separate revisions and pathspecs.  That's unlike how most other
> > programs use "--", but that ship sailed for Git in 2005.
> 
> I'd like to draw attention to the oddball 'git filter-branch' command,
> which uses '--' as a separator between 'filter-branch' and 'rev-list'
> options.  Will it still work with this new option?  I think it will,
> but not sure.

Good question.

Certainly "--" will work as it did before, since the code here only
changes behavior when it sees --end-of-options.

filter-branch doesn't use any of our parseopt infrastructure itself, so
it won't understand the new option itself. I.e., this won't work[1]:

  git filter-branch --end-of-options -this-is-a-branch-name

But since it passes rev-list options as-is, this does successfully pass
the name to rev-list:

  git filter-branch -- --end-of-options -this-is-a-branch-name

However, filter-branch itself seems to do some magic of its own with the
rev-list options, and will try to filter HEAD in that case. So I think
it needs further work to cover all cases correctly.

-Peff

[1] I think the first one there would work if filter-branch actually
    used "rev-parse --parseopt". E.g.:

      git rev-parse --parseopt -- --foo --end-of-options --bar <<-\EOF
      cmd
      --
      foo    an option
      bar    another option
      EOF

    yields:

      set -- --foo -- '--bar'
