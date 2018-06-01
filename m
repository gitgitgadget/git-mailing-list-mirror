Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6391F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbeFAFx6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:53:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:58894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750919AbeFAFx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:53:58 -0400
Received: (qmail 9933 invoked by uid 109); 1 Jun 2018 05:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Jun 2018 05:53:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21242 invoked by uid 111); 1 Jun 2018 05:54:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Jun 2018 01:54:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2018 01:53:55 -0400
Date:   Fri, 1 Jun 2018 01:53:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 3/4] color.ui config: don't die on unknown values
Message-ID: <20180601055355.GC8292@sigill.intra.peff.net>
References: <20180530210641.19771-1-avarab@gmail.com>
 <20180530210641.19771-4-avarab@gmail.com>
 <xmqqin74d9rh.fsf@gitster-ct.c.googlers.com>
 <87h8mo9tuy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8mo9tuy.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 09:17:41AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> >
> >> Before this change git will die on any unknown color.ui values:
> >>
> >>     $ git -c color.ui=doesnotexist show
> >>     fatal: bad numeric config value 'doesnotexist' for 'color.ui': invalid unit
> >
> > I do not think "unit" is correct, so there may be some room for
> > improvement.  For _this_ particular case, I agree that it is not the
> > end of the world if we did not color the output (because we do not
> > know what the 'doesnotyetexist' token from the future is trying to
> > tell us), but as a general principle, we should diagnose and die, if
> > a misconfiguration is easy to correct.
> 
> Many users (including myself) use the same ~/.gitconfig on many
> different machines with different git versions. Maybe at some point I'm
> willing to set the new setting to a value I know is supported on most of
> them, but it sucks at that point if I logging into 1-3% of old machines
> ends up killing git on any invocation.

One way I've dealt with this in the past is by breaking my config into
multiple files, and using an "[include]" for the relevant ones in each
environment. That's not quite turn-key, because you need some way to
decide which to include and which not to, and there's no good way to
have Git invoke that.

Some options I've pondered:

  - we could add [includeIf "version:2.18.0"] for a minimum-version
    check

  - we could add [includeIf "env:FOO"] to check "$FOO" as a boolean.
    That punts the work to your shell environment, but it's flexible
    enough to let you decide however you like (checking git version,
    machine name, etc)

  - similarly, we could add [includeIf "sh:test -f /etc/foo"], but
    running actual shell is nasty for a lot of reasons. Relying on the
    environment punts on that.

You can actually do the environment thing today, but it's a bit hacky.
E.g., with this in your .profile or similar:

  git version |
  perl -ne '
    my $ok = /git version (\d+\.\d+)/ && $1 >= 2.15;
    exit !$ok;
  ' &&
  export GIT_CONFIG_PARAMETERS="'include.path=$HOME/.gitconfig-2.15'"

I know that's more work than just having Git ignore config it doesn't
understand, but it's also a lot more flexible (instead of just ignoring
and using the defaults, you can say "for this version do X, for that one
do Y").

-Peff
