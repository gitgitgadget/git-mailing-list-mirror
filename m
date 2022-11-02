Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815ADC4321E
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 09:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKBJPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKBJOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 05:14:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59027CCB
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 02:13:23 -0700 (PDT)
Received: (qmail 9780 invoked by uid 109); 2 Nov 2022 09:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 09:13:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4065 invoked by uid 111); 2 Nov 2022 09:13:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 05:13:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 05:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: gigantic commit messages, was Re: Git Bug Report: out of memory
 using git tag
Message-ID: <Y2I0siBlVOngNUtK@coredump.intra.peff.net>
References: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
 <Y2EPgICMsmzKvCC8@coredump.intra.peff.net>
 <38d50c30-c6a3-5989-6e01-47c5467d9d6b@gmail.com>
 <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
 <CABPp-BGmNqV5H5meMggKYTcTJDxxt5dRT3rZRnRPz496OJn3Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGmNqV5H5meMggKYTcTJDxxt5dRT3rZRnRPz496OJn3Vg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 01:14:59AM -0700, Elijah Newren wrote:

> On Wed, Nov 2, 2022 at 12:51 AM Jeff King <peff@peff.net> wrote:
> >
> > Here are patches which fix them both. I may be setting a new record for
> > the ratio of commit message lines to changed code
> 
> It looks like the first patch is 72 lines of commit message for a
> one-line fix, and the second patch is 61 lines of commit message for a
> two line fix.
> 
> I don't know what the record ratio is, but it's at least 96[1], so
> clearly you'll need to figure out how to pad your first commit message
> with at least another 25 lines before this series can be accepted.
> ;-)

Well, if we want to start digging things up... ;)

Try this:

  git log --no-merges --no-renames --format='%H %B' -z --numstat '*.c' |
  perl -0ne '
    chomp;
    if (s/^([0-9a-f]{40}) //) {
      if (defined $commit && $diff) {
        my $ratio = $body / $diff;
        print "$ratio $body $diff $commit\n";
      }
      $commit = $1;
      $body = () = /\n/g;
      $diff = 0;
    } elsif (/^\s*(\d+)\t/) {
      # this counts only added lines, under the assumption that
      # small commits generally remove/add in proportion. Of course
      # ones that _only_ remove lines have infinite ratios.
      $diff += $1;
    } else {
      die "confusing record: $_\n";
    }
  ' |
  sort -rn |
  head

which shows there are a few in the 100's. Pipe through:

  awk '{print $4}' |
  git log --stdin --no-walk=unsorted --stat

for a nicer view. I'm rejecting the top one on the grounds that it's
mostly cut-and-paste output, and also that #2 is mine. ;)

-Peff
