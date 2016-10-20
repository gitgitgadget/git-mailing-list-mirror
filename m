Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D4720229
	for <e@80x24.org>; Thu, 20 Oct 2016 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755926AbcJTVAR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:00:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:60246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755888AbcJTVAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:00:16 -0400
Received: (qmail 2053 invoked by uid 109); 20 Oct 2016 21:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:00:16 +0000
Received: (qmail 29986 invoked by uid 111); 20 Oct 2016 21:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:00:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:00:13 -0400
Date:   Thu, 20 Oct 2016 17:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020210013.57wkyhmf2ism6vt2@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610201154070.3264@virtualbox>
 <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
 <CAGZ79ka_McRkOyKH3diCXJSdCm+4pNZfqAqJW_tQLFdhb26tRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka_McRkOyKH3diCXJSdCm+4pNZfqAqJW_tQLFdhb26tRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 09:30:27AM -0700, Stefan Beller wrote:

> On Thu, Oct 20, 2016 at 5:31 AM, Jeff King <peff@peff.net> wrote:
> 
> >
> > $ perl -lne '/execve\("(.*?)"/ and print $1' /tmp/foo.out | sort | uniq -c | sort -rn | head
> >  152271 /home/peff/compile/git/git
> >   57340 /home/peff/compile/git/t/../bin-wrappers/git
> >   16865 /bin/sed
> >   12650 /bin/rm
> >   11257 /bin/cat
> >    9326 /home/peff/compile/git/git-sh-i18n--envsubst
> >    9079 /usr/bin/diff
> >    8013 /usr/bin/wc
> >    5924 /bin/mv
> >    4566 /bin/grep
> >
> 
> I am not an expert on perl nor tracing, but is it feasible to find out
> how many internal calls there are? i.e. either some shell script (rebase,
> submodule) calling git itself a couple of times or even from compile/git/git
> itself, e.g. some submodule operations use forking in there.

The script below is my attempt, though I think it is not quite right, as
"make" should be the single apex of the graph. You can run it like:

  strace -f -o /tmp/foo.out -e clone,execve make test
  perl graph.pl /tmp/foo.out | less -S

One thing that it counts (that was not counted above) is the number of
forks for subshells, which is considerable. I don't know how expensive
that is versus, say, running "cat" (if your fork() doesn't
copy-on-write, and you implement sub-programs via an efficient spawn()
call, it's possible that the subshells are significantly more
expensive).

-Peff

-- >8 --
#!/usr/bin/perl

my %clone;
my %exec;
my %is_child;
my %counter;
while (<>) {
	# <pid> execve("some-prog", ...
	if (/^(\d+)\s+execve\("(.*?)"/) {
		push @{$exec{node($1)}}, $2;
	}
	# <pid> clone(...) = <child>
	#   or
	# <pid> <... clone resumed> ...) = <child>
	elsif (/^(\d+)\s+.*clone.*\) = (\d+)$/) {
		push @{$clone{node($1)}}, node($2);
		$is_child{node($2)} = 1;
	}
	# <pid> +++ exited with <code> +++
	# We have to keep track of this because pids get recycled,
	# and so are not unique node names in our graph.
	elsif (/^(\d+)\s+.*exited with/) {
		$counter{$1}++;
	}
}

show($_, 0) for grep { !$is_child{$_} } keys(%clone);

sub show {
	my ($pid, $indent) = @_;

	my @progs = @{$exec{$pid}};
	if (!@progs) {
		@progs = ("(fork)");
	}

	print ' ' x $indent;
	print "$pid: ", shift @progs;
	print " => $_" for @progs;
	print "\n";

	show($_, $indent + 2) for @{$clone{$pid}};
}

sub node {
	my $pid = shift;
	my $c = $counter{$pid} || "0";
	return "$pid-$c";
}
