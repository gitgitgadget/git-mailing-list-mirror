Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827AF20958
	for <e@80x24.org>; Fri, 24 Mar 2017 00:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbdCXAxD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 20:53:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50754 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754313AbdCXAxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 20:53:02 -0400
Received: (qmail 2808 invoked by uid 109); 24 Mar 2017 00:52:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 00:52:59 +0000
Received: (qmail 13212 invoked by uid 111); 24 Mar 2017 00:53:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:53:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 20:52:56 -0400
Date:   Thu, 23 Mar 2017 20:52:56 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] completion: offer ctags symbol names for 'git log
 -S', '-G' and '-L:'
Message-ID: <20170324005256.ji2wijhyqnwbpp5t@sigill.intra.peff.net>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
 <20170323153839.24283-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323153839.24283-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:38:39PM +0100, SZEDER Gábor wrote:

> Just like in the case of search patterns for 'git grep', see 29eec71f2
> (completion: match ctags symbol names in grep patterns, 2011-10-21)),
> a common thing to look for using 'git log -S', '-G' and '-L:' is the
> name of a symbol.
> 
> Teach the completion for 'git log' to offer ctags symbol names after
> these options, both in stuck and in unstuck forms.

I think this makes sense and is an improvement over the status quo.

There are two gotchas with completing "-L" like this:

  1. You still have to come up with the filename yourself for "-L".

  2. The function name is actually a regex, so you can get bit when your
     function name is a subset of another.

I have a script (below) which makes this easier (and I complete its
argument using the tags file).  It's probably too gross to even go into
contrib, but I thought I'd share.

"log -S" sometimes benefits from limiting by filename, too, but it
depends what you're doing. I don't have a gross script for that. :)

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
__END__
