Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E658C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2639320DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbgFSRpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:45:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbgFSRpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:45:53 -0400
Received: (qmail 4180 invoked by uid 109); 19 Jun 2020 17:45:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 17:45:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16531 invoked by uid 111); 19 Jun 2020 17:45:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 13:45:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 13:45:51 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
Message-ID: <20200619174551.GA2123813@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net>
 <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
 <20200619160129.GA1843858@coredump.intra.peff.net>
 <20200619161816.GA9205@flurp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619161816.GA9205@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 12:18:16PM -0400, Eric Sunshine wrote:

> > That's exactly what I wrote originally, but it failed on macos due to
> > extra spaces in the "wc" output.
> 
> Hmph, that shouldn't have failed. Did you quote the $(wc -l refs)
> invocation? Quoting it would cause it to fail.

Nope (and indeed, I was wary of the issue and made sure I didn't use
quotes). My original was:

test_expect_success 'refname mapping can be dumped' '
       git fast-export --anonymize --all \
               --dump-anonymized-refnames=refs.out >/dev/null &&
       # we make no guarantees of the exact anonymized names,
       # so just check that we have the right number and
       # that a sample line looks sane.
       expected_count=$(git for-each-ref | wc -l) &&
       # Note that master is not anonymized, and so not included
       # in the mapping.
       expected_count=$((expected_count - 1)) &&
       test_line_count = "$expected_count" refs.out &&
       grep "^refs/heads/other refs/heads/" refs.out
'

So I guess I did quote the variable later.  It works fine on Linux, but
one of the osx ci jobs failed:

  https://github.com/peff/git/runs/787911270

The relevant log is:

++ git fast-export --anonymize --all --dump-anonymized-refnames=refs.out
+++ git for-each-ref
+++ wc -l
++ expected_count='       7'
++ test_line_count = '       7' refs.out
++ test 3 '!=' 3
+++ wc -l
++ test 7 = '       7'
++ echo 'test_line_count: line count for refs.out !=        7'
test_line_count: line count for refs.out !=        7

so the whitespace is eaten not when "wc" is run, but rather when the
variable is expanded.

-Peff
