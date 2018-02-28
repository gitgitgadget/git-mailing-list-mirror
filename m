Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8971A1FAE2
	for <e@80x24.org>; Wed, 28 Feb 2018 07:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeB1HtV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 02:49:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:40320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750846AbeB1HtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 02:49:20 -0500
Received: (qmail 10371 invoked by uid 109); 28 Feb 2018 07:49:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Feb 2018 07:49:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32343 invoked by uid 111); 28 Feb 2018 07:50:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Feb 2018 02:50:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Feb 2018 02:49:18 -0500
Date:   Wed, 28 Feb 2018 02:49:18 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228074918.GA32127@sigill.intra.peff.net>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
 <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228074251.GA11673@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 07:42:51AM +0000, Eric Wong wrote:

> > > >  a) We could override the meaning of die() in Git.pm.  This feels
> > > >     ugly but if it works, it would be a very small patch.
> > > 
> > > Unlikely to work since I think we use eval {} to trap exceptions
> > > from die.
> > > 
> > > >  b) We could forbid use of die() and use some git_die() instead (but
> > > >     with a better name) for our own error handling.
> > > 
> > > Call sites may be dual-use: "die" can either be caught by an
> > > eval or used to show an error message to the user.
> 
> <snip>
> 
> > > >  d) We could wrap each command in an eval {...} block to convert the
> > > >     result from die() to exit 128.
> > > 
> > > I prefer option d)
> > 
> > FWIW, I agree with all of that. You can do (d) without an enclosing eval
> > block by just hooking the __DIE__ handler, like:
> > 
> > $SIG{__DIE__} = sub {
> >   print STDERR "fatal: @_\n";
> >   exit 128;
> > };
> 
> Looks like it has the same problems I pointed out with a) and b).

You're right. I cut down my example too much and dropped the necessary
eval magic. Try this:

-- >8 --
SIG{__DIE__} = sub {
  CORE::die @_ if $^S || !defined($^S);
  print STDERR "fatal: @_";
  exit 128;
};

eval {
  die "inside eval";
};
print "eval status: $@" if $@;

die "outside eval";
-- 8< --

Running that should produce:

$ perl foo.pl; echo $?
eval status: inside eval at foo.pl line 8.
fatal: outside eval at foo.pl line 12.
128

It may be getting a little too black-magic, though. Embedding in an eval
is at least straightforward, if a bit more invasive.

-Peff
