Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DB91F453
	for <e@80x24.org>; Wed,  3 Oct 2018 04:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJCLLT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 07:11:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:39454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726394AbeJCLLT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 07:11:19 -0400
Received: (qmail 1341 invoked by uid 109); 3 Oct 2018 04:24:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 04:24:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9367 invoked by uid 111); 3 Oct 2018 04:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 00:24:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 00:24:37 -0400
Date:   Wed, 3 Oct 2018 00:24:37 -0400
From:   Jeff King <peff@peff.net>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Message-ID: <20181003042437.GA27034@sigill.intra.peff.net>
References: <20160517195136.GB11289@sigill.intra.peff.net>
 <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net>
 <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net>
 <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
 <20180908161316.GA326@sigill.intra.peff.net>
 <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-tV-9N36puQHKQ38JxAxNR5Zen=3jM7pG7vHioYvvGTxLHCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 08:27:47PM -0400, Noam Postavsky wrote:

> > So I think this is doing the right thing. I'm not sure if there's a
> > better way to explain "dashless" or not.
> 
> I've updated the comments and renamed a few variables, see if that helps.

Yeah, I really like your explanations/diagrams in the comments. It makes
the logic very clear.

> > Do you feel comfortable trying to add something to the test suite for
> > this?
> 
> Um, sort of. I managed to recast my script into the framework of the
> other tests (see attached t4299-octopus.sh); it seems like it should
> go into t4202-log.sh, but it's not clear to me how I can do this
> without breaking all the other tests which expect a certain sequence
> of commits.

It's OK to start a new script if you have some tricky or complicated
setup. Probably it ought to be t4214-log-graph-octopus to keep it near
the other log tests. And it should be added in the actual patch, but I
assume you just kept it out here since you weren't sure where to put it
yet.

I'll try to comment on the test script itself.

> #!/bin/sh
> 
> test_description='git log'

This should actually describe what's going on in the test. Usually a
one-sentence is OK, but I think it might be good to specifically mention
that we're handling this special octopus case.

> . ./test-lib.sh
> 
> make_octopus_merge () {
> 	for i ; do
> 		git checkout master -b $i || return $?
> 		# Make tag name different from branch name.
> 		test_commit $i $i $i tag$i || return $?
> 	done

Please use:

  for i in "$@"

which is a bit less subtle (there's also only one caller of this
function, so it could be inlined; note that it's OK to use "return" in a
test_expect block).

Why do we need the tag name to be different?

> 	git checkout 1 -b merge &&

This is assuming we just made a branch called "1", but that's one of the
arguments. Probably this should be "$1" (or the whole thing should just
be inlined so it is clear that what the set of parameters we expect is).

> 	test_tick &&
> 	git merge -m octopus-merge "$@"

Good use of test_tick so that we have predictable traversal ordering.

> test_expect_success 'set up merge history' '
> 	test_commit initial &&
> 	make_octopus_merge 1 2 3 4 &&
> 	git checkout 1 -b L &&
> 	test_commit left
> '

It might actually be worth setting up the uncolored expect file as part
of this, since it so neatly diagrams the graph you're trying to produce.

I.e., something like (completely untested; note that the leading
indentation is all tabs, which will be removed by the "<<-" operator):

test_expect_success 'set up merge history' '
	# This is the graph we expect to generate here.
	cat >expect.uncolored <<-\EOF &&
	* left
	| *---.   octopus-merge
	| |\ \ \
	|/ / / /
	| | | * 4
	| | * | 3
	| | |/
	| * | 2
	| |/
	* | 1
	|/
	* initial
	EOF
	for i in 1 2 3 4; do
		git checkout -b $i $master || return $?
		# Make tag name different from branch name.
		test_commit $i $i $i tag$i || return $?
	done &&
	git checkout -b merge 1 &&
	test_tick &&
	git merge -m octopus-merge 1 2 3 4
'

> cat > expect.colors <<\EOF

A few style bits: we prefer to keep even setup steps like this inside a
test_expect block (though you may see some very old tests which have not
been fixed yet). Also, we omit the space after ">".

> * left
> <RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
> <RED>|<RESET> <RED>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <MAGENTA>\<RESET>
> <RED>|<RESET><RED>/<RESET> <YELLOW>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET>
> <RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
> <RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
> <RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
> <RED>|<RESET> * <MAGENTA>|<RESET> 2
> <RED>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
> * <MAGENTA>|<RESET> 1
> <MAGENTA>|<RESET><MAGENTA>/<RESET>
> * initial

Yikes. :) This one is pretty hard to read. I'm not sure if there's a
good alternative. If you pipe the output of test_decode through
this:

  sed '
	s/<RED>.<RESET>/R/g;
	s/<BLUE>.<RESET>/B/g;
	s/<MAGENTA>.<RESET>/M/g;
	s/<YELLOW>.<RESET>/Y/g;
  '

you get this:

  * left
  R *BBMM   octopus-merge
  R RY B M
  RR Y B M
  R Y B * 4
  R Y * M 3
  R Y MM
  R * M 2
  R MM
  * M 1
  MM
  * initial

which is admittedly pretty horrible, too, but at least resembles a
graph. I dunno.

I'm also not thrilled that we depend on the exact sequence of default
colors, but I suspect it's not the first time. And it wouldn't be too
hard to update it if that default changes.

> test_expect_success 'log --graph with tricky octopus merge' '
> 	git log --color=always --graph --date-order --pretty=tformat:%s --all |
> 		test_decode_color | sed "s/ *\$//" >actual &&

Try not to put "git" on the left-hand side of a pipe, since it means
we'll miss its exit code (and especially we'd miss its death due to ASan
or Valgrind problems, which I think was one of the major ways of
detecting the original problem). So:

  git log ... >actual.raw &&
  test_decode_color <actual.raw | sed ... >actual &&
  test_cmp expect.colors actual

> cat > expect <<\EOF
> * left
> | *---.   octopus-merge
> | |\ \ \
> |/ / / /
> | | | * 4
> | | * | 3
> | | |/
> | * | 2
> | |/
> * | 1
> |/
> * initial
> EOF

This is the expect output that I suggested showing earlier. :)

> test_expect_success 'log --graph with tricky octopus merge' '
> 	debug git log --color=never --graph --date-order --pretty=tformat:%s --all |
> 		sed "s/ *\$//" >actual &&

Leftover "debug" cruft?

The same pipe comment applies as above.

> test_done
> test_done

Two dones; we exit after the first one (so everything after this is
ignored).

I think it's OK to have a dedicated script for even these two tests, if
it makes things easier to read. However, would we also want to test the
octopus without the problematic graph here? I think if we just omit
"left" we get that, don't we?

-Peff
