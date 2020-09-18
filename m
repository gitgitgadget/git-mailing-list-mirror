Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D9AC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E19F21741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRRTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:19:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:33408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:19:52 -0400
Received: (qmail 11036 invoked by uid 109); 18 Sep 2020 17:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 17:19:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23000 invoked by uid 111); 18 Sep 2020 17:19:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 13:19:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 13:19:50 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918171950.GA183026@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 12:34:48PM -0400, Thomas Guyot-Sionnest wrote:

> Hi Taylor,
> 
> On Fri, 18 Sep 2020 at 10:36, Taylor Blau <me@ttaylorr.com> wrote:
> > On Fri, Sep 18, 2020 at 07:32:56AM -0400, Thomas Guyot-Sionnest wrote:
> > > A very handy way to pass data to applications is to use the <() process
> > > substitution syntax in bash variants. It allow comparing files streamed
> > > from a remote server or doing on-the-fly stream processing to alter the
> > > diff. These are usually implemented as a symlink that points to a bogus
> > > name (ex "pipe:[209326419]") but opens as a pipe.
> >
> > This is true in bash, but sh does not support process substitution with
> > <().
> 
> Bash, ksh, zsh and likely any more moden shell. Other programming
> languages also setup such pipes. It's much cleaner than creating temp
> files and cleaning them up and in some cases faster too (I've ran
> diff's like this over GB's of test data, it's very handy to remove
> known patterns that would cause needless diffs).

Yeah, it's definitely a reasonable thing to want (see below). And from a
portability perspective, it is outside of Git's scope; users with those
shells can use the feature, and people on other shells don't have to
care.

But we do have to account for this in the test suite, which must be able
to run under a vanilla POSIX shell. So you'd probably want to set up a
prerequisite that lets us skip these tests on other shells, like:

  test_lazy_prereq PROCESS_SUBSTITUTION '
	echo foo >expect &&
	cat >actual <(echo foo) &&
	test_cmp expect actual
  '

  test_expect_success PROCESS_SUBSTITUTION 'some test...' '
	# safe because we skip this test on shells that do not support it
	git diff --no-index <(cat whatever)
  '

Though it is a little sad that people running the suite with a vanilla
/bin/sh like dash wouldn't ever run the tests. I wonder if there's a
more portable way to formulate it.

Getting back to the overall feature, this is definitely something that
has come up before. The last I know of is:

  https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/

which everybody seemed to like the direction of; I suspect the original
author (cc'd) just never got around to it again. Compared to this
approach, it uses a command-line option to avoid dereferencing symlinks.
That puts an extra burden on the caller to pass the option, but it's way
less magical; you could drop all of the "does this look like a symlink
to a pipe" heuristics. It would also be much easier to test. ;)

-Peff
