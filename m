Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2FA20286
	for <e@80x24.org>; Sat,  9 Sep 2017 11:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757415AbdIILR4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 07:17:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753471AbdIILRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 07:17:55 -0400
Received: (qmail 32418 invoked by uid 109); 9 Sep 2017 11:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 11:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14256 invoked by uid 111); 9 Sep 2017 11:18:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 07:18:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Sep 2017 07:17:53 -0400
Date:   Sat, 9 Sep 2017 07:17:53 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] t1404: demonstrate two problems with reference
 transactions
Message-ID: <20170909111753.pidf26f5koaewyho@sigill.intra.peff.net>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
 <76d473f62a8c1d6328eb15003c4d0d4dbc8f277d.1504877858.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76d473f62a8c1d6328eb15003c4d0d4dbc8f277d.1504877858.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 03:51:50PM +0200, Michael Haggerty wrote:

> +test_expect_failure 'no bogus intermediate values during delete' '
> +	prefix=refs/slow-transaction &&
> +	# Set up a reference with differing loose and packed versions:
> +	git update-ref $prefix/foo $C &&
> +	git pack-refs --all &&
> +	git update-ref $prefix/foo $D &&
> +	git for-each-ref $prefix >unchanged &&
> +	# Now try to update the reference, but hold the `packed-refs` lock
> +	# for a while to see what happens while the process is blocked:
> +	: >.git/packed-refs.lock &&
> +	test_when_finished "rm -f .git/packed-refs.lock" &&
> +	{
> +		# Note: the following command is intentionally run in the
> +		# background. We increase the timeout so that `update-ref`
> +		# attempts to acquire the `packed-refs` lock for longer than
> +		# it takes for us to do the check then delete it:
> +		git -c core.packedrefstimeout=3000 update-ref -d $prefix/foo &
> +	} &&
> +	pid2=$! &&

There's some timing trickiness in this test, so I want to take a close
look at possible races.

The point of this timeout is just to make sure that we end up blocking
"long enough" that the test code can ensure that we're blocked for a
certain period, during which we can look at the on-disk state.

So this timeout really could be as long as we want, and ideally longer
is better (since we would not want it to exit while we're examining the
state). Later we do a `wait` on this process, but only after removing
the lockfile, which should cause it to exit. So in theory we could make
this something silly like an hour that could not possibly race.

The only downside, I guess, is that if something goes horribly wrong, it
could take an hour to exit (but we put the "rm" into a
test_when_finished, so I think that would cover the test failing early).

> +	# Give update-ref plenty of time to get to the point where it tries
> +	# to lock packed-refs:
> +	sleep 1 &&

Yuck. So this is definitely a potential race. On a busy system it could
take more than a second to try the lock.

But:

  1. Since we're looking for the on-disk state _not_ to change, when we
     lose the race the test still succeeds (it just tests nothing
     useful). So we shouldn't get false positives.

  2. I don't think we can do better. In the corrected state, the
     sub-process makes no externally visible change that we could wait
     on (unless we turned to unportable tools like strace).

So I think it's OK. I'm never excited about using sleep in our tests,
but I don't see a better option.

> +	# Make sure that update-ref did not complete despite the lock:
> +	kill -0 $pid2 &&

I'm not sure if "kill -0" is portable to Windows or not. I have no
specific knowledge that it _isn't_, but signals have been a problem area
for us in the past. I see we use it for some of the p4 tests, but I
wouldn't be surprised if those are already skipped on Windows.

I guess if it produces false positives then Windows folks can report and
mark it to be skipped. If it produces false negatives there, then nobody
will be the wiser, but there's not much we can do.

> +	# Verify that the reference still has its old value:
> +	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
> +	case "$sha1" in
> +	$D)
> +		# This is what we hope for; it means that nothing
> +		# user-visible has changed yet.
> +		: ;;

So if we get what we want, we execute ":" which should be a successful
exit code.

> +	undefined)
> +		# This is not correct; it means the deletion has happened
> +		# already even though update-ref should not have been
> +		# able to acquire the lock yet.
> +		echo "$prefix/foo deleted prematurely" &&
> +		break
> +		;;

But if we don't, we hit a "break". But we're not in a loop, so the break
does nothing. Is the intent to give a false value to the switch so that
we fail the &&-chain? If so, I'd think "false" would be the right thing
to use. It's more to the point, and from a few limited tests, it looks
like "break" will return "0" even outside a loop (bash writes a
complaint to stderr, but dash doesn't).

Or did you just forget that you're not writing C and that ";;" is the
correct way to spell "break" here? :)

> [...]
> +	esac >out &&
> [...]
> +	test_must_be_empty out &&

The return value of "break" _doesn't_ matter, because you end up using
the presence of the error message.

I think we could write this as just:

  case "$sha1" in
  $D)
	# good
	;;
  undefined)
        echo >&2 this is bad
	false
	;;
  esac &&

I'm OK with it either way (testing the exit code or testing the output),
but either way the "break" calls are doing nothing and can be dropped, I
think.

-Peff
