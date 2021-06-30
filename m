Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AFC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F4C61D85
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 01:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhF3Be3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 21:34:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:36898 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhF3Be3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 21:34:29 -0400
Received: (qmail 22088 invoked by uid 109); 30 Jun 2021 01:32:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 01:32:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 761 invoked by uid 111); 30 Jun 2021 01:32:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 21:32:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 21:31:59 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] receive-pack: skip connectivity checks on
 delete-only commands
Message-ID: <YNvJj42ALg4/t+0l@coredump.intra.peff.net>
References: <cover.1624858240.git.ps@pks.im>
 <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 07:33:11AM +0200, Patrick Steinhardt wrote:

> Fix this by not doing a connectivity check in case there were no pushed
> objects. Given that git-rev-walk(1) with only negative references will
> not do any graph walk, no performance improvements are to be expected.
> Conceptionally, it is still the right thing to do though.

Even though it's not producing any exciting results, I agree this is
still a reasonable thing to do.

I'm actually surprised it didn't help in your many-ref cases, just
because I think the traversal machinery is pretty eager to parse tags
and commits which are fed as tips.

If I run "git rev-list --not --all --stdin </dev/null" in linux.git, it
takes about 35ms. But if I make a ton of refs, like:

  git rev-list HEAD |
  perl -lpe 's{.*}{update refs/foo/commit$. $&}' |
  git update-ref --stdin
  git pack-refs --all --prune

then it takes about 2000ms (if you don't pack it's even worse, as you
might expect).

So how come we don't see that improvement in your "extrarefs" cases?
Looking at patch 1, they also seem to make one ref for every commit.

I think the answer may be below...

> +	/*
> +	 * If received commands only consist of deletions, then the client MUST
> +	 * NOT send a packfile because there cannot be any new objects in the
> +	 * first place. As a result, we do not set up a quarantine environment
> +	 * because we know no new objects will be received. And that in turn
> +	 * means that we can skip connectivity checks here.
> +	 */
> +	if (tmp_objdir) {

I think this will work, but we're now making assumptions about how
tmp_objdir will be initialized by the rest of the code.

Could we make a more direct check of: skip calling rev-list if we have
no positive tips to feed? If we call iterate_receive_command() and it
returns end-of-list on the first call, then we know there is nothing to
feed (and as a bonus, this catches some more noop cases around shallow
repos; see iterate_receive_command).

But that made me think that check_connected() could be doing this
itself. And indeed, it seems to already. At the top of that function is:

          if (fn(cb_data, &oid)) {
                  if (opt->err_fd)
                          close(opt->err_fd);
                  return err;
          }

So before we even spawn rev-list, if there's nothing to feed it, we'll
return right away ("err" will be "0" at this point). And I think that
has been there since the beginning of the function (it is even in the
old versions in builtin/fetch.c before it was factored out).

And that explains why you didn't see any performance improvement. We're
already doing this optimization. :)

-Peff
