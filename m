Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0056E1FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbcL1H3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 02:29:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:60906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbcL1H3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 02:29:48 -0500
Received: (qmail 7474 invoked by uid 109); 28 Dec 2016 07:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 07:23:06 +0000
Received: (qmail 16631 invoked by uid 111); 28 Dec 2016 07:23:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 02:23:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 02:23:03 -0500
Date:   Wed, 28 Dec 2016 02:23:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFH] gpg --import entropy while running tests
Message-ID: <20161228072303.4wbhkwf37fvgpi7h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed a few of our test scripts taking a long time to run, even
though they used to be quick. Here's one:

  $ time ./t7612-merge-verify-signatures.sh 
  ok 1 - create signed commits
  ok 2 - merge unsigned commit with verification
  ok 3 - merge commit with bad signature with verification
  ok 4 - merge commit with untrusted signature with verification
  ok 5 - merge signed commit with verification
  ok 6 - merge commit with bad signature without verification
  # passed all 6 test(s)
  1..6

  real    0m12.285s
  user    0m0.048s
  sys     0m0.044s


That's a lot of time not using any CPU. What's going on? Running with
"sh -x" shows that we spend most of the time in this line from
lib-gpg.sh:

  gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
	  "$TEST_DIRECTORY"/lib-gpg/keyring.gpg

And running gpg with "--debug-level guru" shows that we are blocking
while waiting for entropy. Has anybody else seen this? I feel like I
noticed it starting a few weeks ago, and indeed dropping back to gpg
2.0.26 (from 2.1.17) makes the problem go away.

Is it a bug in gpg (oddly, the kernel reports lots of entropy available,
and generating the signatures themselves is quite fast)? Or is the new
version doing something special in the import process that we need to
work around or disable?

The reason we use --import at all is to handle differences in the .gnupg
format between versions 1 and 2. So the nuclear option would be to just
carry pre-made .gnupg directories for _both_ versions in our test suite,
and pick the appropriate one based on the output of "gpg --version".
That feels like a hack, but it gives us a lot of control.

I'd love it if we could figure out a way of making --import reliably
fast, though.

-Peff
