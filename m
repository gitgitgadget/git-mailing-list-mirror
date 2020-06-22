Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF58C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D939A2073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgFVVaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:30:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:39286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbgFVVav (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:30:51 -0400
Received: (qmail 1788 invoked by uid 109); 22 Jun 2020 21:30:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:30:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8419 invoked by uid 111); 22 Jun 2020 21:30:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:30:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:30:50 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
Message-ID: <20200622213050.GA1376217@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net>
 <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
 <20200619160129.GA1843858@coredump.intra.peff.net>
 <20200619161816.GA9205@flurp.local>
 <20200619174551.GA2123813@coredump.intra.peff.net>
 <CAPig+cQxoz1AcS51qhtBr6oaTs9KTDamofCyN3qy_EARUi7oFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQxoz1AcS51qhtBr6oaTs9KTDamofCyN3qy_EARUi7oFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 02:00:47PM -0400, Eric Sunshine wrote:

> > so the whitespace is eaten not when "wc" is run, but rather when the
> > variable is expanded.
> 
> Not something that should be done by this series (more a
> left-over-bitty thing, perhaps), but this almost suggests that
> test_line_count() deserves a tweak to make it more robust against that
> sort of thing:
> 
>     test_line_count () {
>         if test $# != 3
>         then
>             BUG "not 3 parameters to test_line_count"
>         elif ! test $(wc -l <"$3") "$1" "$2"
>         then
>             echo "test_line_count: line count for $3 !$1 $2"
>             cat "$3"
>             return 1
>         fi
>     }
> 
> If we drop the quotes around $2 from the 'test':
> 
>     elif ! test $(wc -l <"$3") "$1" $2
> 
> then your code would have worked as expected.
> 
> My only worry about that is that a poorly written caller would get a
> weird and unhelpful error message:
> 
>     test_line_count = 4 4
>     --> sh: test: too many arguments

I think your unhelpful-error-message case would happen only if the
length argument contains two non-whitespace tokens separated by a
whitespace (so the shell splits them into two arguments), _and_ the
caller passed that argument in quotes (otherwise the shell would split
it at the function call and we'd hit the BUG message). In which case,
what are they trying to do with passing "4 4" to "test"? And since we're
using "=" and not "-eq", I think "test" would be complaining about that.

So it seems like it might be a reasonable change to make things more
friendly.

-Peff
