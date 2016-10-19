Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87D720986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941680AbcJSU4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:56:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59661 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941094AbcJSU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:56:41 -0400
Received: (qmail 17945 invoked by uid 109); 19 Oct 2016 20:56:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 20:56:41 +0000
Received: (qmail 17497 invoked by uid 111); 19 Oct 2016 20:57:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 16:57:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 16:56:39 -0400
Date:   Wed, 19 Oct 2016 16:56:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 10:32:12AM -0700, Junio C Hamano wrote:

> > Maybe we should start optimizing the tests...
> 
> Yup, two things that come to mind are to identify long ones and see
> if each of them can be split into two halves that can be run in
> parallel, and to go through the tests with fine toothed comb and
> remove the ones that test exactly the same thing as another test.
> The latter would be very time consuming, though.

FWIW, I have made attempts at "split long ones into two" before, and
didn't come up with much. There _are_ some tests that are much longer
than others[1], but they are not longer than the whole suite takes to
run. So running in slow-to-fast order means they start first, are run in
parallel with the other tests, and the CPUs stay relatively full through
the whole run.

Of course YMMV; the long tests on Windows may be different, or
proportionally much longer (I note the worst cases almost all involve
rebase, which as a shell script is presumably worse on Windows than
elsewhere). And of course any reasoning about slow-to-fast order does
not apply if you are not using a tool to do that for you. :)

-Peff

[1] After running "make prove" (time are in seconds):

    $ perl -MYAML -e '
        $_ = do { local $/; <> };
        # prove puts this non-YAML cruft at the end
        s/\.\.\.$//s;

        my $t = YAML::Load($_)->{tests};
        print "$_->[1] $_->[0]\n" for
          sort { $b->[1] <=> $a->[1] }
          map { [$_, $t->{$_}->{elapsed}] }
          keys(%$t);
      ' .prove | head

    43.216765165329 t3404-rebase-interactive.sh
    30.6568658351898 t3421-rebase-topology-linear.sh
    27.92564702034 t9001-send-email.sh
    15.5906939506531 t9500-gitweb-standalone-no-errors.sh
    15.4882569313049 t6030-bisect-porcelain.sh
    14.487174987793 t7610-mergetool.sh
    13.8276169300079 t3425-rebase-topology-merges.sh
    12.7450480461121 t3426-rebase-submodule.sh
    12.4915001392365 t3415-rebase-autosquash.sh
    11.8122401237488 t5572-pull-submodule.sh
