Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762BA1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 00:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfDXAyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 20:54:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728730AbfDXAyY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 20:54:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1097B60FF7;
        Wed, 24 Apr 2019 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556067261;
        bh=M1U0W6Nkrnnlz+VH+2kJIYbGpz8S29eUoGyeHjPYnLo=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KmJeQolTp5EzoPM6qntYs6BVAZdQkpvkzoicdwGxQVp9Pa8uz2sjII5ktM8Z8YdfM
         B8ebOdTlYLLsjHNsDIbYz2MAECU9Ya4aYi2XNmzzXkhuH0x9gWjsyG3p8cfZpYMXUG
         EGLqjWyWKxd8+wUrrfXs4yVw2EG6ZdJ31sXF0jnGcYoxJGesJVdSl6qetiAB07yWpW
         29RCB3EkgaaQW0B9BAn9a5parZfQ+4ubCblGWbn7kXysoBciMqWIHwYOQFy4wJ9o4h
         pTuD8AXmaRJyj2Xr6PM2fKT/ppMxab0KwlWsU9o8ZMA+TZLCYj5eYZUrwBqKVuYJPS
         vEfz9bWKByA3ye0bY4KNZBcoSVuSwJK228MyaxtRqFlSrDQ4vvEeYMrERMZqPJlbwF
         AvrcCMYjfsg8yFfGZ/JQt4ayhN+nWgzfV+nkxMli6tE6wONNEjqYtFnPY9zXpTZQ6k
         Ma8YnRBVVaHLOodfruNq6pgpl2cO17x7HWgnS93h4sdZvtOJnZT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/5] Multiple hook support
Date:   Wed, 24 Apr 2019 00:49:43 +0000
Message-Id: <20190424004948.728326-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oftentimes, people want to use multiple of the same kind of hook. This
may be because software or a project they use requires a given hook, but
they would also like to have a custom hook, or because they're using
multiple pieces of software that both require involvement with the same
hook.

This series introduces support for multiple hooks by using a ".d"
directory. For example, instead of using a single
".git/hooks/post-checkout" file, you'd use multiple files within
".git/hooks/post-checkout.d". This is the standard Unix paradigm for
multiple files and should be familiar to most people. Hooks are executed
in sorted order.

To preserve backwards compatibility, we don't run the hooks in the ".d"
directory if the single file is a valid hook (i.e. it exists and is
executable). This is because some people already have multiple hook
scripts configured, and if we ran them both, we'd run the hooks twice.
This would be bad for e.g. the prepare-commit-msg hook. This is also the
least surprising behavior.

We check each hook for its exit status, even if the hook normally
ignores exit status, and if it fails, we abort executing further hooks.
This provides an easy way to reason about what the exit status is when a
hook fails; we need not consider how to handle multiple failing hooks.
It's also consistent among all hooks, whether they care about exit
status or not.

This series uses a test library to verify that we run the hooks for each
command instead of writing the same tests multiple times. If there are
other cases you'd like to see, please let me know.

I've talked with some people about this approach, and they've indicated
they would prefer a configuration-based approach. I've tried to make the
series such that it can be replaced with such an approach if that's the
decision we make. It should be easy enough to simply replace find_hooks
with an appropriate implementation and update the test framework.

brian m. carlson (5):
  run-command: add preliminary support for multiple hooks
  builtin/receive-pack: add support for multiple hooks
  sequencer: add support for multiple hooks
  builtin/worktree: add support for multiple post-checkout hooks
  transport: add support for multiple pre-push hooks

 builtin/am.c                       |  28 ++--
 builtin/commit.c                   |   5 +-
 builtin/receive-pack.c             | 212 +++++++++++++++++------------
 builtin/worktree.c                 |  40 ++++--
 run-command.c                      | 117 ++++++++++++----
 run-command.h                      |   9 +-
 sequencer.c                        |  96 ++++++++-----
 t/lib-hooks.sh                     | 156 +++++++++++++++++++++
 t/t5403-post-checkout-hook.sh      |   8 ++
 t/t5407-post-rewrite-hook.sh       |  15 ++
 t/t5516-fetch-push.sh              |  29 ++++
 t/t5571-pre-push-hook.sh           |  19 +++
 t/t7503-pre-commit-hook.sh         |  15 ++
 t/t7505-prepare-commit-msg-hook.sh |   9 ++
 transport.c                        |  98 +++++++------
 15 files changed, 636 insertions(+), 220 deletions(-)
 create mode 100644 t/lib-hooks.sh

