Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068641F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJBV12 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:27:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726861AbeJBV12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:27:28 -0400
Received: (qmail 780 invoked by uid 109); 2 Oct 2018 14:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 14:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28720 invoked by uid 111); 2 Oct 2018 14:43:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 10:43:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 10:43:42 -0400
Date:   Tue, 2 Oct 2018 10:43:42 -0400
From:   Jeff King <peff@peff.net>
To:     Peter.Dolland@mt.com
Cc:     git@vger.kernel.org, notifications@github.com
Subject: Re: WG: [git-for-windows/git] log -L/<regex>/,+1 not accepted (#1856)
Message-ID: <20181002144342.GB24480@sigill.intra.peff.net>
References: <git-for-windows/git/issues/1856@github.com>
 <git-for-windows/git/issues/1856/426092877@github.com>
 <C19A54411B361046A786B5FA02D5689FE3B01FF9@ch00sem22.mt.mtnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C19A54411B361046A786B5FA02D5689FE3B01FF9@ch00sem22.mt.mtnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 06:56:29AM +0000, Peter.Dolland@mt.com wrote:

> Please see my original observation below.
> Is it possible, to extend the git-log syntax in the way, that it
> accepts the short -L option (without :file) of blame in unique cases
> (only one file is logged or respectively the -L expression may be
> valid for all logged files)? It would be nice for command line users!

That would be nice, but I suspect in many cases the regex will be less
unique than you might hope. E.g., if you're looking for the log of a
particular function, you care about where it's defined. But unless you
write your regex very carefully, you're going to also match places where
it's called.

I have a hacky script (included below) that uses an already-built ctags
index to pick the correct file.

> Alternatively I could also imagine the extension of the blame
> functionality in the direction to see a whole history instead of only
> the last modification.

Have you tried using a blame interface that supports parent-reblaming
(i.e., once you blame a line to a particular commit, you can restart the
blame from that commit's parent, digging further into history each
time)? I use "tig blame" for this, and I find that I very rarely
actually turn to "log -L".

-Peff

-- >8 --
#!/usr/bin/env perl

if (!@ARGV) {
  print STDERR "usage: git flog [options] <function>\n";
  exit 1;
}

my $func = pop @ARGV;
my $file = get_file_from_tags($func);
my $regex = '[^A-Za-z_]' . $func . '[^A-Za-z0-9_]';
exec qw(git log), "-L:$regex:$file", @ARGV;
exit 1;

sub get_file_from_tags {
  my $token = shift;

  open(my $fh, '<', 'tags')
    or die "unable to open tags: $!\n";
  while (<$fh>) {
    chomp;

    # this isn't exactly right, as the Ex command may contain
    # embedded tabs, but it's accurate for the token and filename,
    # which come before, and probably good enough to match extension fields
    # which come after
    my @fields = split /\t/;

    next unless $fields[0] eq $token;

    # only look for functions; assumes your ctags uses the "kind"
    # extension field. Note also that some implementations write the "kind:"
    # header and some do not. This handles both.
    next unless grep { /^(kind:\s*)?f$/ } @fields;

    # there may be more, but we don't have any way of disambiguating,
    # so just return the first match
    return $fields[1];
  }

  die "unknown token: $token\n";
}
