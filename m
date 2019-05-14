Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EF51F461
	for <e@80x24.org>; Tue, 14 May 2019 00:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfENAXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:23:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfENAXt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 May 2019 20:23:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D7F7860443;
        Tue, 14 May 2019 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557793427;
        bh=hYJXGNq2qZgrtUnI9JQ0+Rn43aYVkHFBBuPjxm8xVqU=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=wj8D/irzjw6gM5x2LPD5G1+qMMuYdlQ5HsWBj6Vl0lLcX76wmZs36tSoqztNiMXbb
         0CtKWwehcst7bTZc+kS0yKL4loUZh7ekO/5B3p8b0qGwSekAKkEq3Be4sPQgyPBQrh
         OTJX4Fck2m+lC1Meejhe1Jooz8pvwiYfRRW3BaYoWdnHMAVAYjLbyU0/4tmLWsr/95
         EZv8liI3aBRiT0GQtMGj0Hh6oY0qKLt0UNZrQNZLxALFYx3DYmuGOna3rcVhoc0N7n
         aI7+qS97Q55oRlv7Y8KBh/3uqvHc2PfMByoEFGYtWX+qHbHaVmzWWRxUTUcLKvyao9
         Taf8Gpsd9w54MLC0+OR0A/MW5gvPbJ5aiGHsPOFp5LYHJknz02GRe1G+jAV8mBQHCN
         5BnjQh5MzI9NtSDdiVIZFf2zOfEcQWlJ8NA9mRhnpx3sQrXUi5HS6YSqKwoepIZwZJ
         0fJgtmcWqk9YqwqzyjUEb6CZDwv8xLtezSl/0A/eV3ORkciEXWF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/7] Multiple hook support
Date:   Tue, 14 May 2019 00:23:24 +0000
Message-Id: <20190514002332.121089-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces multiple hook support.

I've thought a lot about the discussion over whether this series should
use the configuration as the source for multiple hooks. Ultimately, I've
come to the decision that it's not a good idea. Even adopting the empty
entry as a reset marker, the fact that inheritance in the configuration
is in-order and can't be easily modified means that it's not likely to
be very useful, but it is likely to be quite surprising for the average
user. I think a solution that sticks with the existing model and builds
off a design used by other systems people are familiar with, like cron
and run-parts, is going to be a better choice. Moreover, this is the
design that people have already built with outside tooling, which is a
further argument in favor of it.

I have adopted one configuration-based option, which is the per-hook
errorBehavior option that Peff suggested. I think this reduces concerns
over what the best error handling strategy is and is a good thing to
have as part of a minimum viable product. I picked the names that Peff
chose, but if people like different names better, they can be changed.

Just as a preview of what's coming down the line, I plan to build on
this series to notify hooks when --quiet and --dry-run options have been
specified to commands so that they may honor them if they choose.

Changes from v1:
* Adopted several improvements from Duy's series, including an improved
  find_hooks prototype and a helper function.
* Switched to existence checks instead of executability checks for
  determining whether to invoke multiple hooks.
* Adjusted the commit message for patch 3.
* Added error behavior control using the names Peff provided in his
  comment.
* Added documentation.

brian m. carlson (7):
  run-command: add preliminary support for multiple hooks
  builtin/receive-pack: add support for multiple hooks
  rebase: add support for multiple hooks
  builtin/worktree: add support for multiple post-checkout hooks
  transport: add support for multiple pre-push hooks
  config: allow configuration of multiple hook error behavior
  docs: document multiple hooks

 Documentation/config.txt           |   2 +
 Documentation/config/hook.txt      |  19 ++
 Documentation/githooks.txt         |   9 +
 builtin/am.c                       |  20 +--
 builtin/commit.c                   |   2 +-
 builtin/receive-pack.c             |  78 ++++----
 builtin/worktree.c                 |  44 +++--
 config.c                           |  27 +++
 run-command.c                      | 175 +++++++++++++++---
 run-command.h                      |  22 ++-
 sequencer.c                        |  59 ++++---
 sequencer.h                        |   2 +
 t/lib-hooks.sh                     | 274 +++++++++++++++++++++++++++++
 t/t5403-post-checkout-hook.sh      |   8 +
 t/t5407-post-rewrite-hook.sh       |  15 ++
 t/t5516-fetch-push.sh              |  30 ++++
 t/t5571-pre-push-hook.sh           |  19 ++
 t/t7503-pre-commit-hook.sh         |  15 ++
 t/t7505-prepare-commit-msg-hook.sh |   9 +
 transport.c                        |  29 +--
 20 files changed, 730 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 t/lib-hooks.sh

