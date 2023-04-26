Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEEC77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 20:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjDZUxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjDZUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 16:53:36 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC44198C
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 13:53:34 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8FB425A569;
        Wed, 26 Apr 2023 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682542413;
        bh=8fZV3BDs289gB93Su3smjoRHn0cftWlQOrhbr/kD2v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0tNPooWq7srjxnpMpcr4voBfCm2dnYwf25+Zq8ZZiE+D3nQLi1XqxopU819ELsbVC
         MNMVKRjZehJFv3ibD4R0zGGiq7Au1sF6vEJHnuzj3QX8lahGCjY5tkMPh7N5/JZeIm
         JgwGhRo13GcabTk3L1iqNqyZ9cIQU7svFrojnsgkqX5Tsy+RTRjXtL/3/TVuipDg6m
         tUL38ZeQIgLVGZge18laSkXHqKQYV3qZwwd81gPmCSzL8McreR+MfIH79K8zW2Gbpz
         16tuGyaBg3l66NBUuL/P7xhzYnT1hnzS6meS2x6kmsTWsYgXalGZ/v7QmtWMTMXfmf
         50L0ZXv6F/oH0U+wMkA8xxxAx1NvI5nH+qHN61pKfvFZOYRPTkFDoqCuysw7mf55jQ
         UummnROENMluyFdDmj/Y6MJvv0EozdRTgYkpR6o7wqhHupa/LJA8BgFfrHbgEAQFBn
         jEKt4xUSO7JtesaiZ9cpp9Sbr5X9240+kEJsYTvX0WYTyq6ibHS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>
Subject: [PATCH 0/2] Fix empty SHA-256 clones with v0 and v1
Date:   Wed, 26 Apr 2023 20:53:22 +0000
Message-Id: <20230426205324.326501-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently fixed empty clones with SHA-256 over protocol v2 by
honouring the hash algorithm specified even when no refs are present.
However, in doing so, we made it impossible to set up a v0 or v1
repository by cloning from an empty SHA-256 repository.  In doing so, we
also broke the Git LFS testsuite for SHA-256 repositories.

This series consists of two patches.  The first introduces the dummy
`capabilities^{}` entry for fetches and clones from an empty repository
for v0 and v1, just as we do for clones.  This is already supported by
older versions of Git, as well as libgit2 and JGit.

The second introduces some backwards compatibility to avoid regressing
the old behaviour of using GIT_DEFAULT_HASH to initialize the proper
hash in this case.  We add a flag to see if we explicitly obtained a
hash algorithm from the remote side, and if not, we honour
GIT_DEFAULT_HASH, as before.

brian m. carlson (2):
  http: advertise capabilities when cloning empty repos
  Honor GIT_DEFAULT_HASH for empty clones without remote algo

 Documentation/git.txt       | 10 +++++++---
 builtin/clone.c             |  8 +++++---
 connect.c                   |  5 ++++-
 pkt-line.h                  |  2 ++
 t/t5551-http-fetch-smart.sh | 27 +++++++++++++++++++++++++++
 t/t5700-protocol-v1.sh      | 32 ++++++++++++++++++++++++++++++--
 transport-helper.c          |  1 +
 transport.c                 | 14 ++++++++++++++
 transport.h                 | 14 ++++++++++++++
 upload-pack.c               |  4 ++++
 10 files changed, 108 insertions(+), 9 deletions(-)

