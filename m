Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920A420756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdATTZn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:25:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:42263 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbdATTZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:25:42 -0500
Received: (qmail 11486 invoked by uid 109); 20 Jan 2017 19:25:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 19:25:41 +0000
Received: (qmail 18073 invoked by uid 111); 20 Jan 2017 19:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:26:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 14:25:39 -0500
Date:   Fri, 20 Jan 2017 14:25:39 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with
 keyboard
Message-ID: <20170120192539.7jts6xqzx46unn7y@sigill.intra.peff.net>
References: <20170120102249.15572-1-pclouds@gmail.com>
 <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
 <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 11:16:15AM -0800, Jacob Keller wrote:

> > I recently taught urxvt to recognize sha1s and grab them via keyboard
> > hints, and I'm finding it quite useful. Here's what it looks like if
> > you're interested:
> >
> >   http://peff.net/git-hints.gif
> >
> > The hints technique is taken from pentadactyl (which I also use), but
> > the urxvt port is mine. I'm happy to share the code.
> [...]
> 
> I would be interested in the code for this.. I'm curious if I can
> adapt it to my use of tmux.

See below. You can drop it into ~/.urxvt/ext/urlmatch and put something
like this into your Xresources:

  URxvt.keysym.C-b: urlmatch:list
  URxvt.keysym.C-semicolon: urlmatch:hint

I think the interesting bits if you're adapting it to another system
will be the regexes in find_commits(), and the key-at-a-time state
machine in handle_select_key().

Note that there's a sort-of bug in find_commits(). If you have:

  1234abcd..5678abcd

it finds three matches: one for each sha1, and one for the whole range.
But the range hint is covered up by the first sha1's hint.

And probably other bugs, too. I've only been using it for about a week,
and I did a bunch of cleanups this morning (after foolishly offering to
let other people see it ;) ).

-- >8 --
#!/usr/bin/perl

use warnings qw(all FATAL);
use strict;

sub on_action {
	my ($self, $action) = @_;
	($action, my @args) = split /:/, $action;
	if ($action eq 'list') {
		$self->matchlist(@args);
	} elsif ($action eq 'hint') {
		$self->open_hints(@args);
	}
	();
}

sub d { print STDERR "debug: " . join(' ', @_) . "\n"; }

sub handle_select_key {
	my ($self, $event, $keysym, $octets) = @_;

	my $input = $self->{input};

	my $escape;
	if (48 <= $keysym && $keysym <= 57) {
		$input->{number} .= ($keysym - 48);
	} elsif (97 <= $keysym && $keysym <= 122) {
		$input->{text} .= chr($keysym);
	} elsif ($self->XKeysymToString($keysym) eq 'Return') {
		$input->{number} .= '$';
	} elsif ($keysym == 59) {
		$input->{action} = 'yank';
		return 1;
	} else {
		$escape = 1;
	}

	if (!$escape) {
		my $min = 0;
		my $max = scalar(@{$input->{array}});

		my $nr_re = qr/^$input->{number}/;
		my $text_re = qr/$input->{text}/;
		my @matches;
		for (my $i = $min; $i < $max; $i++) {
			my $item = $input->{array}->[$i];
			if ($i =~ /$nr_re/ && $item->{text} =~ /$text_re/) {
				push @matches, $i;
			} elsif ($input->{unmatch}) {
				my $item = $input->{array}->[$i];
				$input->{unmatch}->($self, $item);
			}
		}
		if (@matches > 1) {
			# not enough data yet
			return 1;
		}
		if (@matches == 1) {
			my $item = $input->{array}->[$matches[0]];
			my $action = $input->{action} ||
			             $item->{action} ||
				     'activate';
			if ($action eq 'activate') {
				$self->exec_async(qw(webview), $item->{text});
			} elsif ($action eq 'yank') {
				$self->selection($item->{text});
				$self->selection_grab(urxvt::CurrentTime);
			}
		}
	}

	delete $self->{input};
	$self->disable('key_press');
	1;
}

sub enable_select {
	my $self = shift;
	$self->{input} = {text => '', number => '', @_};
	$self->enable(key_press => \&handle_select_key);
}

sub matchlist {
	my $self = shift;

	my @items = $self->find_matches(@_)
		or return;

	my $max_width = 0;
	for (my $i = 0; $i < @items; $i++) {
		my $item = $items[$i];

		$item->{number} = $i;
		$item->{menu} = "$i. $item->{text}";

		my $width = $self->strwidth($item->{menu});
		$max_width = $width if $width > $max_width;
	}

	my $rend = urxvt::SET_COLOR(urxvt::OVERLAY_RSTYLE, 0, 3);

	my $o = $self->overlay(0, 0, $max_width, scalar(@items), $rend, 0);
	for (my $i = 0; $i < @items; $i++) {
		$o->set(0, $i, $items[$i]->{menu});
	}
	$self->enable_select(
		array => \@items,
		overlay => $o,
		unmatch => sub {
			my ($self, $item) = @_;
			my $o = $self->{input}->{overlay};
			$o->set(0, $item->{number}, ' ' x length($item->{menu}));
		},
	);
}

sub open_hints {
	my $self = shift;

	my @items = $self->find_matches(@_)
		or return;

	for (my $i = 0; $i < @items; $i++) {
		my $item = $items[$i];

		$item->{overlay} = $self->overlay($item->{col}, $item->{row},
						  length($i), 1,
						  urxvt::OVERLAY_RSTYLE, 0);
		$item->{overlay}->set(0, 0, $i);
	}

	$self->enable_select(
		array => \@items,
		unmatch => sub {
			my ($self, $item) = @_;
			$item->{overlay} = undef;
		},
	);
}

my $URLCHAR = qr![-a-zA-Z:0-9./\#%+~_?=&()@;,]!;
my $URLEND = qr![a-zA-Z0-9/]!;
#my $URLLINE = qr!$URLCHAR{60,}$URLEND\n|$URLCHAR*$URLEND!;
my $URL = qr!$URLCHAR*$URLEND!;

sub find_urls {
	local $_ = shift;
	my @urls;

	while (m!(http|https|ftp|file)://$URL!g) {
		push @urls, [$-[0], $&];
	}
	while (m!^ *([a-zA-Z0-9]$URL\.(?:com|net|org)/$URL)!mg) {
		push @urls, [$-[0], "http://$&"];
	}
	while (m!(?:^|(?<=\s))(www|ftp)\.$URL!g) {
		push @urls, [$-[0], ($1 eq 'www' ? 'http://' : 'ftp://') . $&];
	}

	return map { {
		offset => $_->[0],
		text => $_->[1],
	} } @urls;
}

sub find_commits {
	local $_ = shift;

	my @items;
	while (m/(?:^|[^0-9a-f])
		 ([0-9a-f]{7,40})
		 (?![0-9a-f])/gx) {
		push @items, { offset => $-[1], text => $1, action => 'yank' };
	}
	while (m/(?:^|\s)
		 ([0-9a-f]{7,} \.{2,3} [0-9a-f]{7,})
		 (?:$|\s)/gx) {
		push @items, { offset => $-[1], text => $1, action => 'yank' };
	}
	return @items;
}

sub find_matches {
	my $self = shift;

	my @ret;
	my $row = 0;
	while ($row < $self->nrow) {
		my $line = $self->line($row);
		for my $item (find_line_matches($line->t)) {
			@$item{qw(row col)} = $line->coord_of($item->{offset});
			push @ret, $item;
		}
		$row = 1 + $line->end;
	}
	return @ret;
}

sub find_line_matches {
	my $buf = shift;
	return map {
		if ($_ eq 'url') { find_urls($buf) }
		elsif ($_ eq 'commit') { find_commits($buf) }
		else { d("unknown type: $_"); () }
	} @_ ? @_ : qw(url commit);
}
