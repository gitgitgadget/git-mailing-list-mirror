Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE7A1FAE2
	for <e@80x24.org>; Wed, 28 Feb 2018 04:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeB1EHT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 23:07:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43026 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeB1EHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 23:07:19 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B7E1A1F404;
        Wed, 28 Feb 2018 04:07:18 +0000 (UTC)
Date:   Wed, 28 Feb 2018 04:07:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228040718.GA9043@whir>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228001616.GJ174036@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> The fundamental thing is the actual Git commands, not the tests in the
> testsuite, no?

Right.  I've never been picky about exit codes; only that a
non-zero happens on errors.

> In the rest of git, die() makes a command exit with status 128.  The
> trouble here is that our code in Perl is assuming the same meaning for
> die() but using perl's die builtin instead.  That suggests a few
> options:
> 
>  a) We could override the meaning of die() in Git.pm.  This feels
>     ugly but if it works, it would be a very small patch.

Unlikely to work since I think we use eval {} to trap exceptions
from die.

>  b) We could forbid use of die() and use some git_die() instead (but
>     with a better name) for our own error handling.

Call sites may be dual-use: "die" can either be caught by an
eval or used to show an error message to the user.

>  c) We could have a special different exit code convention for
>     commands written in Perl.  And then change expectations whenever a
>     command is rewritten in C.  As you might expect, I don't like this
>     option.

I don't like it, either.

>  d) We could wrap each command in an eval {...} block to convert the
>     result from die() to exit 128.

I prefer option d)
