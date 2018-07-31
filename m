Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47D71F597
	for <e@80x24.org>; Tue, 31 Jul 2018 12:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeGaOaj (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:30:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:36764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731988AbeGaOaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:30:39 -0400
Received: (qmail 19279 invoked by uid 109); 31 Jul 2018 12:50:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 12:50:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31967 invoked by uid 111); 31 Jul 2018 12:50:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 08:50:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 08:50:27 -0400
Date:   Tue, 31 Jul 2018 08:50:27 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180731125026.GA8072@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
 <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
 <20180730205914.GE156463@aiede.svl.corp.google.com>
 <CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRTgh6DStUdmXqvhbL_7sQY6wu21h27rjq_i=kZ_d+LAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 05:38:06PM -0400, Eric Sunshine wrote:

> > I wonder if it should look for something like [A-Z][A-Z_]* to catch
> > all of these.
> 
> I considered that, but it doesn't handle nested here-docs, which we
> actually have in the test suite. For instance, from t9300-fast-import:
> 
>     cat >input <<-INPUT_END &&
>     mark :2
>     data <<EOF
>     $file2_data
>     EOF
>     ...
>     INPUT_END
> 
> Nesting could be handled easily enough either by stashing away the
> opening tag and matching against it later _or_ by doing recursive
> here-doc folding, however, 'sed' isn't a proper programming language
> and can't be coerced into doing either of those. (And, it was tricky
> enough just getting it to handle the nested case with a limited set of
> recognized tag names, without having to explicitly handle every
> combination of those names nested inside one another.)

I hesitate to make any suggestion here, as I think we may have passed
a point of useful cost/benefit in sinking more time into this script.
But...is switching to awk or perl an option? Our test suite already
depends on having a vanilla perl, so I don't think it would be a new
dependency. And it would give you actual data structures.

But like I said, it may not be worth it. I'd be OK just adjusting the
false positive and moving on.

> I am, for a couple reasons, somewhat hesitant to tweak the heuristic.
> 
> First, each tweak has the potential of causing more false-positives or
> (perhaps worse) false-negatives. The linter's own test-suite is
> supposed to protect against that, but test suite coverage is never
> perfect.
> 
> Second, ideally, the linter should protect against new broken
> &&-chains from entering the codebase, so poorly coded historic tests
> such as these aren't necessarily good motivation for tweaking, _and_
> it is (hopefully) unlikely that we would allow this sort of ugly shell
> code to enter the codebase going forward. (The counterargument is that
> this false-positive doesn't help someone coding up a new test who
> hasn't yet submitted the patch to the mailing list where more seasoned
> eyes would suggest better coding style.)

Right, I think the real cost is somebody who adds "<<CUSTOM_END_TAG"
later and is confused when they see the breakage. I.e., I don't mind
saying "we have a couple of style rules that you must follow to appease
the linter". But if the error message is not clear, it can send somebody
down the wrong rabbit hole trying to figure out what is going on.

-Peff
