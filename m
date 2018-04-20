Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756051F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeDTIjg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:39:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57586 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753918AbeDTIjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:39:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CAA1B1F424;
        Fri, 20 Apr 2018 08:39:34 +0000 (UTC)
Date:   Fri, 20 Apr 2018 08:39:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: commit -> public-inbox link helper
Message-ID: <20180420083934.GA696@dcvr>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi team,
> 
> I found myself in dear need to quickly look up mails in the public-inbox
> mail archive corresponding to any given commit in git.git. Some time ago,
> I wrote a shell script to help me with that, and I found myself using it a
> couple of times, so I think it might be useful for others, too.

Hello, I think you can dump all the info you need more quickly
without cloning 1G of data by dumping NNTP OVER(view)
information instead.

I've attached a short Perl script which dumps the tab-delimited
file to stdout so you can process it with whatever.  Columns
relevant to you would probably be 2-5:

	NUM	Subject	From	Date	Message-ID

On public-inbox-nntpd, Dates are normalized to UTC in the OVER
response right now, so you'd need to use TZ=UTC with --date=rfc-local

It works with both nntp://news.gmane.org/gmane.comp.version-control.git
nntp://news.public-inbox.org/inbox.comp.version-control.git

> Note: the way mails are matched is by timestamp. In practice, this works
> amazingly often (although not always, I reported findings short after
> GitMerge 2017). My plan was to work on this when/as needed.

Thanks for that.  I've added dt: (date-time) searching to public-inbox
(d: (date-only) has been there forever):

        d:       date range as YYYYMMDD  e.g. d:19931002..20101002
                 Open-ended ranges such as d:19931002.. and d:..20101002
                 are also supported
        dt:      date-time range as YYYYMMDDhhmmss (e.g. dt:19931002011000..19931002011200)

To match an exact timestamp, both the begining and end range should
be the same.

(It'd be nice if Xapian + Perl bindings could get date parsing as
 good as git's.  Too bad C++ / XS overwhelms my tiny brain and
 waiting for builds overwhelm my patience)

> git rev-parse --quiet --verify \
> 	b60d038730d2c2bb8ab2b48c117db917ad529cf7 >/dev/null 2>&1 ||
> die "Not a public-inbox directory: $(pwd)"

Eep.  I'd don't think it's good to put such a hard dependency on
a particular mirror I started.  Somebody could start another one
which wasn't sourced from gmane and the Received: headers would
be different.

...And I'm pondering a conversion of what's running on
https://public-inbox.org/git/ to the new v2 repository format:

	https://public-inbox.org/meta/20180419015813.GA20051@dcvr/
	https://public-inbox.org/meta/20180209205140.GA11047@dcvr/
	https://public-inbox.org/meta/20180215105509.GA22409@dcvr/

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="over.perl"

#!/usr/bin/perl -w
use strict;
use warnings;
use IO::Socket::INET;
my $usage = "$0 news://example.com/group.name [MIN] [MAX]\n";
my $url = shift or die $usage;
my $umin = shift;
my $umax = shift;
my ($host, $port, $group) = ($url =~ m!://([^/]+)?(?::(\d+))?/(.+)!);
$port ||= 119;
defined $group or die "missing group in $url\n";
my %opts = ( Proto => 'tcp', PeerHost => $host, PeerPort => $port );
my $s = IO::Socket::INET->new(%opts) or die "connect to $host:$port: $!\n";
my $l = $s->getline;
$l =~ /\A2\d\d / or die "bad greeting: $l\n";

$s->print("GROUP $group\n") or die "print $!";
$l = $s->getline;
$l =~ /\A211 \d+ (\d+) (\d+) / or die "bad GROUP response: $l\n";
my ($min, $max) = ($1, $2);
$min = $umin if $umin;
$max = $umax if $umax;

$s->print("OVER $min-$max\n") or die "print $!";
$l = $s->getline;
$l =~ /\A224 / or die "bad OVER response: $l\n";

while ($l = $s->getline) {
	last if $l eq ".\r\n";
	print $l;
}

--YiEDa0DAkWCtVeE4--
