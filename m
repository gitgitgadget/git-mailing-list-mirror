Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64A320986
	for <e@80x24.org>; Fri, 21 Oct 2016 08:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbcJUIUl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 04:20:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:60512 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbcJUIUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 04:20:38 -0400
Received: (qmail 9833 invoked by uid 109); 21 Oct 2016 08:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 08:20:37 +0000
Received: (qmail 929 invoked by uid 111); 21 Oct 2016 08:21:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 04:21:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 04:20:35 -0400
Date:   Fri, 21 Oct 2016 04:20:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Prove "Tests out of sequence" Error
Message-ID: <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:10:39PM -0700, Stefan Beller wrote:

> > on TravisCI I see these weird "Tests out of sequence" errors with prove
> > and they seem to not go away. I assume the reason that they not go away
> > is that the ".prove" file is carried over from on build to another (but I can't
> > look into this file on TravisCI).
> >
> > Has anyone an idea where these errors might come from?
> >
> > ------------------------------------------------------------------------
> > t5547-push-quarantine.sh                         (Wstat: 0 Tests: 5 Failed: 0)
> 
> push quarantine is a new thing made by Jeff 2 weeks ago, IIRC.

Yes, but I do not see how it can trigger this:

> >   Parse errors: Tests out of sequence.  Found (2) but expected (3)
> >                 Tests out of sequence.  Found (3) but expected (4)
> >                 Tests out of sequence.  Found (4) but expected (5)
> >                 Bad plan.  You planned 4 tests but ran 5.

The TAP output from one of our tests should look something like:

  ok 1 - subject one
  ok 2 - subject two
  ok 3 - subject three
  ok 4 - subject four
  # passed all 4 test(s)
  1..4

the "plan" is the bit at the end. That looks like $test_count
accidentally got incremented by one and we generated something like:

  ok 1 - subject one
  ok 3 - subject two
  ok 4 - subject three
  ok 5 - subject four
  1..4

which would explain the "out of sequence" errors as well as the "planned
4 but ran 5".

But I do not see how the test script could screw that up. The counting
is handled entirely by the harness in test-lib.sh.

Nor do I see how a stale .prove file could matter. It does not store
information about the test plan at all. E.g., here is the entry from
mine for t5547:

  t5547-push-quarantine.sh:
    elapsed: 0.0762169361114502
    gen: 1
    last_pass_time: 1477037708.741
    last_result: 0
    last_run_time: 1477037708.741
    last_todo: 0
    seq: 437
    total_passes: 1

Puzzling.

-Peff
