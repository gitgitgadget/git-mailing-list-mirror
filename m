Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63322C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420F161403
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhGAQCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:02:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:38642 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232126AbhGAQCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:02:51 -0400
Received: (qmail 28105 invoked by uid 109); 1 Jul 2021 16:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16555 invoked by uid 111); 1 Jul 2021 16:00:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:00:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:00:19 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YN3mk0LnyJyuQ+9T@coredump.intra.peff.net>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
 <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNzR5ZZDTfcN2Q+s@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 08:19:49PM +0000, brian m. carlson wrote:

> On 2021-06-30 at 17:59:43, Jeff King wrote:
> > One complication we faced is that a lot of Git's data is bag-of-bytes,
> > not utf8. And json technically requires utf8. I don't remember if we
> > simply fudged that and output possibly non-utf8 sequences, or if we
> > actually encode them.
> 
> I think we just emit invalid UTF-8 in that case, which is a problem.
> That's why Git is not well suited to JSON output and why it isn't a good
> choice for structured data here.  I'd like us not to do more JSON in our
> codebase, since it's practically impossible for users to depend on our
> output if we do that due to encoding issues[0].
> 
> We could emit data in a different format, such as YAML, which does have
> encoding for arbitrary byte sequences.  However, in YAML, binary data is
> always base64 encoded, which is less readable, although still
> interchangeable.  CBOR is also a possibility, although it's not human
> readable at all.

I don't love the invalid-utf8-in-json thing in general. But I think it
may be the least-bad solution. I seem to recall that YAML has its own
complexities, and losing human-readability (even to base64) is a pretty
big downside. And the tooling for working with json seems more common
and mature (certainly over something like CBOR, but I think even YAML
doesn't have anything nearly as nice as jq).

Our sloppy json encoding does work correctly if you use utf8 paths, and
I think we could provide options to cover other common cases (e.g., a
single option for "assume my paths are latin1"). I think life is hardest
on somebody writing a script/service which is meant to process arbitrary
repositories (and isn't in control of the strictness of whatever is
parsing the json).

I'm sensitive to the issue of implementing something that works most of
the time, but then fails spectacularly when somebody does something
unusual. But it also sucks for many users not to have that "something
that works most of the time" if it would make their lives easier.

> I'm personally fine with the ad-hoc approach we use now, which is
> actually very convenient to script and, in my view, not to terrible to
> parse in other tools and languages.  Your mileage may vary, though.

There are a lot of gotchas, there, too. When the data gets complex, "-z"
splitting becomes ambiguous (e.g., "git log -z --raw" uses a NUL both to
separate commits from their diffs, diffs from each other, and diffs from
subsequent commits, so you have to pattern-match each type). It's also
context-dependent (e.g., you can't parse a "--raw -z" entry without
interpreting its type character, since "R" and "C" will have multiple
path fields; there are almost certainly a lot of "works most of the
time" parsers out there).

-Peff
