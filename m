Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43EA1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 10:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdFGKYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 06:24:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35823 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdFGKYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 06:24:51 -0400
Received: (qmail 17070 invoked by uid 109); 7 Jun 2017 10:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 10:24:50 +0000
Received: (qmail 32698 invoked by uid 111); 7 Jun 2017 10:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 06:24:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jun 2017 06:24:48 -0400
Date:   Wed, 7 Jun 2017 06:24:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
Message-ID: <20170607102448.bpgxce4kduzxf7a2@sigill.intra.peff.net>
References: <20170603221335.3038-1-avarab@gmail.com>
 <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
 <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 10:55:42AM +0900, Junio C Hamano wrote:

> I do not expect any single person to tackle the splitting.  I just
> wished that a patch inspired by this patch (or better yet, a new
> version of this patch) made the tail end of "make test" output to
> read like this:
> 
>    ...
>    [18:32:44] t9400-git-cvsserver-server.sh ...... ok    18331 ms
>    [18:32:49] t9402-git-cvsserver-refs.sh ........ ok    22902 ms
>    [18:32:49] t9200-git-cvsexportcommit.sh ....... ok    25163 ms
>    [18:32:51]
>    All tests successful.
>    Files=785, Tests=16928, 122 wallclock secs ( ...
>    Result: PASS
> 
>    * The following tests took longer than 15 seconds to run.  We
>      may want to look into splitting them into smaller files.
> 
>    t3404-rebase-interactive.sh ...    19 secs
>    t9001-send-email.sh ...........    22 secs
>    t9402-git-cvsserver-refs.sh ...    22 secs
>    t9200-git-cvsexportcommit.sh ..    25 secs
> 
> when the hidden feature is _not_ used, so that wider set of people
> will be forced to see that some tests take inordinate amount of
> time, and entice at least some of them to look into it.

If you use "prove", it already records this information, and it can
print it with "--timer".

I don't use that myself, though. What's much more interesting (but which
I haven't found a way to get prove to do out-of-the-box) is to show the
longest tests after the fact. I gave a perl snippet to do so in

  http://public-inbox.org/git/20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net/

I've actually played with this splitting before, but on my quad-core
(plus hyperthreading) box, I could never get it to make any improvement
once --state=slow was used. The longest test for me is 28s, but the
whole suite takes 50s to run. The slow tests get front-loaded, and then
by the end we have lots of little tests to hand out to each processor
and they all stay busy.

The main difference with Ævar's run is that he has a huge number of
processors. So I'm in favor of more splitting, but I also doubt that
even most Git developers would see any improvement. Or maybe people
really do have monstrous boxes. I dunno.

The biggest changes I've seen in my runs are:

  1. Use "prove --state=slow,save"; even with a few processors it makes
     a big difference.

  2. Point --root at a RAM disk.

  3. I started using Michael's git-test[1], which I have testing each
     commit on the current branch in the background[2]. That gives me an
     early warning when there's a failure (I have it play a sad trombone
     sound, since it's in a minimized terminal), and when I do ask the
     tests to run, quite often it can answer "all tests pass" out of
     the cache.

-Peff

[1] https://github.com/mhagger/git-test

[2] My hacky script is at https://github.com/peff/git/blob/meta/ci
