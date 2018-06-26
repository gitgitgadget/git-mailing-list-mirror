Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6DD1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755025AbeFZURL (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:17:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:55934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754177AbeFZURK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:17:10 -0400
Received: (qmail 3365 invoked by uid 109); 26 Jun 2018 20:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 20:17:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1279 invoked by uid 111); 26 Jun 2018 20:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 16:17:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:17:08 -0400
Date:   Tue, 26 Jun 2018 16:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180626201708.GA2341@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com>
 <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 03:52:54PM -0400, Eric Sunshine wrote:

> The existing --chain-lint already suffers the same shortcoming. Older
> (or even new poorly-written) tests, even without subshells, can fall
> victim already:
> 
>     (exit $sentinel) &&
>     mkdir -p a/b/c &&
>     cd a/b/c
>     rm -fr ../../* &&
>     cd ../../.. &&
>     statement4
> 
> As in your example, 'mkdir' and 'cd' are skipped, but 'rm -fr ../../*' is not.
> 
> This snippet from the commit message of bb79af9d09 (t/test-lib:
> introduce --chain-lint option, 2015-03-20):
> 
>     When we encounter a failure of this check, we abort the test
>     script entirely. For one thing, we have no clue which subset
>     of the commands in the test snippet were actually run.
> 
> suggests that the issue was considered, in some form, even then
> (though, it doesn't say explicitly that Peff had the 'rm -fr' case in
> mind).
>
> So, this isn't a new problem introduced by this series, though this
> series may exacerbate it.

One way this series might be worse in practice is that we tend not to
change process state too much outside of the subshells. So if we skip
some early commands and execute a later "rm", for example, it tends to
be in the same directory (and I think as time goes on we have been
cleaning up old tests which did a "cd foo && bar && cd .." into using a
subshell).

Whereas once you start collapsing subshells into the main logic chain,
there's a very high chance that the subshell is doing a "cd", since
that's typically the main reason for the subshell in the first place.
And with the current --chain-lint logic, that subshell is either
executed or not executed as a unit.

Obviously that's a bit of a hand-waving argument. If you've fixed all of
the existing cases without accidentally deleting your home directory,
then maybe it's not so likely to be a problem after all.

I'm not sure if there's a good solution, though. Even if you retained
the subshells and instead did a chain-lint inside each subshell, like
this:

  (exit 117) &&
  one &&
  (
	(exit 117) &&
	cd foo
	two
  ) &&
  three


that doesn't really help. The fundamental issue is that we may skip the
"cd" inside the subshell. Whether it's in a subshell or not, that's
dangerous. True, we don't run "three" in this case, which is slightly
better. But it didn't expect to be in a different directory anyway. It's
running "two" that is dangerous.

-Peff
