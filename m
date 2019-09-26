Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABAE1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfIZHzh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:55:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:60648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726874AbfIZHzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:55:36 -0400
Received: (qmail 8054 invoked by uid 109); 26 Sep 2019 07:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Sep 2019 07:55:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26006 invoked by uid 111); 26 Sep 2019 07:58:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2019 03:58:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Sep 2019 03:55:35 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] promisor-remote: skip move_to_tail when n=1
Message-ID: <20190926075535.GC20653@sigill.intra.peff.net>
References: <20190925213718.231231-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925213718.231231-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 02:37:18PM -0700, Emily Shaffer wrote:

> Previously, when promisor_remote_move_to_tail() is called for a
> promisor_remote which is currently the *only* element in promisors, a
> cycle is created in the promisors linked list. This cycle leads to a
> double free later on in promisor_remote_clear(): promisors is set to
> promisors->next (a no-op, as promisors->next == promisors); the previous
> value of promisors is free()'d; then the new value of promisors (which
> is equal to the previous value of promisors) is also free()'d. This
> double-free error was unrecoverable for the user without removing the
> filter or re-cloning the repo and hoping to miss this edge case.

Nice clear description.

Is the problem only when the remote is the only element of the list, or
would it also happen when it's at the end?

I think the problematic lines are:

  r->next = NULL;
  *promisors_tail = r;

If our "r" is already the tail, then promisors_tail points to &r->next,
and we create a cycle in the linked list.

I think if you swap those two lines, the problem goes away. That said,
it's subtle enough that I think covering the noop case at the start of
the function is much clearer.

Using that strategy, I think this:

> +	if (promisors == r && promisors->next == NULL)
> +		return;

should probably just see if we're already at the end, which also covers
the single-element case. Like:

  if (!r->next)
	return; /* we're already at the end */

or possibly:

  if (promisors_tail == &r->next)
	return; /* we're already at the end */

I also can't help but think this would all be a lot simpler using the
implementation in list.h. Then we don't have to pass this weird
"previous" pointer around (because it's a doubly-linked list). And
functions like this one could go away in favor of list_move(). But
that's obviously a bigger change.

> This change showed up for us in a user bugreport; I'm actually fairly
> unfamiliar with the codebase here but given the drastic nature of the
> failure, I wanted to get a fix up quickly. I'm still working on how to
> reproduce this exact case in the test suite (and actually would
> appreciate any pointers). Specifically, it looks like we only really
> break if we have a single promisor_remote in the linked list, call
> move_to_tail() on it at least once, and then call clear() on it without
> adding another promisor_remote first.

The only call is in promisor_remote_init(), where we try to move
whatever promisor we get from looking up repository_format_partial_clone.
That name in turn comes from the extensions.partialclone config.

The init function also creates elements in the list from any remotes
marked with remote.XYZ.promisor in the config.

So this is enough to create the cycle in the linked list:

  git init
  git remote add foo /wherever
  git config remote.foo.promisor true
  git config extensions.partialclone foo
  git fetch foo

but it doesn't trigger the double-free because we don't ever free
anything. We only call the clear() function during reinit(). And that
only happens in partial_clone_register(). So if we take the commands
above, and then try to actually do a partial clone with it (causing it
to re-register), I get (building with ASan, but vanilla glibc seems to
detect the double-free too):

  $ git fetch --filter=blob:none foo
  ==30356==ERROR: AddressSanitizer: heap-use-after-free on address 0x603000001f90 at pc 0x559adb9a0919 bp 0x7ffeb7a52b30 sp 0x7ffeb7a52b28
  READ of size 8 at 0x603000001f90 thread T0
    #0 0x559adb9a0918 in promisor_remote_clear /home/peff/compile/git/promisor-remote.c:173
    #1 0x559adb9a0918 in promisor_remote_reinit /home/peff/compile/git/promisor-remote.c:183
    #2 0x559adb5856c0 in fetch_one_setup_partial builtin/fetch.c:1570
    #3 0x559adb5856c0 in cmd_fetch builtin/fetch.c:1736
    [...etc...]

Another way to manifest the error:

  git remote add bar /does-not-matter
  git fetch --filter=blob:none bar

Now we'll try to register "bar". But since it's _not_ already in the
linked list, our search will go on forever, since the list loops back on
itself.

-Peff
