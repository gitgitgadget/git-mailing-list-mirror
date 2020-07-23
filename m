Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7263C433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC6520792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGWSZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:25:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:36426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgGWSZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 14:25:50 -0400
Received: (qmail 16313 invoked by uid 109); 23 Jul 2020 18:25:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2020 18:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14385 invoked by uid 111); 23 Jul 2020 18:25:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2020 14:25:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Jul 2020 14:25:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
Message-ID: <20200723182549.GB3975154@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
 <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 10:26:04AM -0700, Junio C Hamano wrote:

> > The big downside here, of course, is that it's showing the diff for the
> > whole file, not just one hunk (on the other hand, I often find the
> > trickiest conflicts are ones where the changes unexpectedly span
> > multiple hunks).
> 
> Yup, I often find myself comparing the base part (lines between |||
> and ===) with our part (lines between <<< and |||) and their part
> (lines between === and >>>) while looking at the diff3 output to see
> what unique change each side did, in order to come up with a
> conflict resolution.
> 
> I do this often enough to wonder if I should write a small "filter"
> that I can pipe a whole "diff3" <<< ... ||| ... === ... >>> region
> to and convert it into to diffs, but not often enough to motivate
> me to actually write one ;-).

I would definitely have found that useful before (usually when one side
made a tiny one-line change and the other side deleted or drastically
changed a huge chunk).

It might even be possible to stuff it into xdiff's fill_conflict_hunk().
We have all of the data there, and xdiff in theory can make diffs. :) It
might be easier to prototype it as an external filter, though.

Something like the script below seems to work; you can run whole files
through it, or do something like ":10,20r!perl foo.pl" in vim to filter
a snippet. I won't be at all surprised if somebody more familiar with
vim tells me that you can already do something way better than this
(I've always found vimdiff pretty confusing).

-- >8 --
#!/usr/bin/perl

use File::Temp;
use strict;

my (@base, @ours, @theirs);
my $state;

sub flush {
  print @ours;
  print "|||||||\n";
  show_diff(base => \@base, ours => \@ours);
  print "|||||||\n";
  show_diff(base => \@base, theirs => \@theirs);
  print "=======\n";
  print @theirs;
  @ours = @base = @theirs = ();
}

sub show_diff {
  my ($pre_name, $pre_data, $post_name, $post_data) = @_;

  my $pre = File::Temp->new;
  print $pre @$pre_data;
  $pre->flush;

  my $post = File::Temp->new;
  print $post @$post_data;
  $post->flush;

  open(my $diff, '-|', qw(diff -u), $pre->filename, $post->filename);
  # throw away file header, which just mentions tempfiles, and replace
  # it with our own
  <$diff>; <$diff>;
  print "--- $pre_name\n";
  print "+++ $post_name\n";
  while (<$diff>) {
    print;
  }
}

sub state_none {
  if (/^<{7}/) { $state = \&state_ours }
  print
}

sub state_ours {
  if (/^\|{7}/) { $state = \&state_base }
  else { push @ours, $_ }
}

sub state_base {
  if (/^={7}/) { $state = \&state_theirs }
  else { push @base, $_ }
}

sub state_theirs {
  if (/^>{7}/) { flush(); print; $state = \&state_none }
  else { push @theirs, $_ }
}

$state = \&state_none;
while (<>) {
  $state->();
}
