Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F4A1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 16:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbcLUQEU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 11:04:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:59338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964835AbcLUQEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 11:04:16 -0500
Received: (qmail 7178 invoked by uid 109); 21 Dec 2016 16:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 16:04:16 +0000
Received: (qmail 12634 invoked by uid 111); 21 Dec 2016 16:04:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Dec 2016 11:04:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Dec 2016 11:04:13 -0500
Date:   Wed, 21 Dec 2016 11:04:13 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161221160412.54d5ozyoxetwl3oy@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
 <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
 <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
 <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
 <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
 <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
 <20161221032221.s7jmgnfrr6tyuyuk@sigill.intra.peff.net>
 <CA+P7+xrMgzFcuqwBg6z2_ZPgAVKwLX2eyK6D4C0v-c3zAMFqUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrMgzFcuqwBg6z2_ZPgAVKwLX2eyK6D4C0v-c3zAMFqUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 11:55:45PM -0800, Jacob Keller wrote:

> > I do wonder if in general it should be the responsibility of skippable
> > tests to make sure we end up with the same state whether they are run or
> > not. That might manage the complexity more. But I certainly don't mind
> > tests being defensive like you have here.
> >
> > -Peff
> 
> That seems like a good idea, but I'm not sure how you would implement
> it in practice? Would we just "rely" on a skipable test having a "do
> this if we skip, instead" block? That would be easier to spot but I
> think still relies on the skip-able tests being careful?

Yes, it definitely means the skip-able tests would have to be careful.
But it's putting the onus on them, rather than on all the other tests.

If the rule is "the on-disk state must be the same whether or not the
test runs", then I suspect many tests could get by with a
test_when_finished, like:

  test_expect_success FOO 'test --foo knob' '
	git commit -m "new commit for test" &&
	test_when_finished "git reset --hard HEAD^" &&
	git log --foo >actual &&
	test_cmp expect actual
  '

It gets harder if you have multiple such tests that rely on intermediate
state. Probably you'd have:

  test_expect_success FOO 'clean up FOO state' '
	git reset --hard HEAD^
  '

at the end of the sequence.

I dunno. It is unclear to me whether such a rule is worth it.
Preemptively fighting these state-based bugs before they occur is a nice
thought, but I think it may end up being more work to write the tests
that way than it is to simply find and fix the bugs when they occur. Of
course it also changes where the work falls (the test writers versus the
bug hunters, and given that !MINGW is our most common prereq, I think
Windows devs are over-represented in the latter case).

-Peff
