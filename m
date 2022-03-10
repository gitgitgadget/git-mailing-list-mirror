Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BEC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbiCJRgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243214AbiCJRgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0218C79E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6D4305A104;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=hc7EPCnRaJJpCg8hglT/sHj4w0r0wYf3gzMudFrGj5U=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=xvNvSgntm+jHuB62wA/+5dqDlc3P/750gJ+PjmlMJvpM27CipbRDdhKJU00yH3osX
         Iqhu3HTQb1Za2ZM7RgKjdD39T+f5iFCczhg5e7aHOM1yxf+gAKPhN2L6soWoUlQsVn
         z+QA7aWmoVB9cOuXewQNy2w6lfEBfyfWSdWFvJ0MQ1lgYYpihOKNMAjNotNujSkKse
         AqLn1pHU3nzscG7itS4PSRS8XShJTgDnOv5RXBdx2iSIXteEqvQbVv8WECWvbM/CXt
         B9IP8FFJKxew14lNd0CLZPiAQYS0xcUjUj8WLTaTleQiJbi4uBPFkOo+wXyugdmDP1
         7MysZBfOBfDO3z1MaWBWILcSsfloQCLxnHD+CtcjsTOXYvmV3kOWwYcDOMY3ktrawy
         FgG47bHbHeQc/An3gDO8MCKjeU759fdMTv5+SJIIBSLOpgKdiHP1wCQaZOk6qMzLTv
         u+lKz+m8WCuCO6LdE/SuoJ8EA8Q+skuzRwB1XWNw5KP9uOfywKZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/6] Importing and exporting stashes to refs
Date:   Thu, 10 Mar 2022 17:32:30 +0000
Message-Id: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stashes are currently stored using the reflog in a given repository.
This is an interesting and novel way to handle them, but there is no way
to easily move a stash across machines.  For example, stashes cannot be
bundled, pushed, or fetched.

This is suboptimal for a lot of reasons.  First, there is a recent push
towards ephemeral development environments, but many users make heavy
use of their stashes and wish to persist them long term[0].  Additionally,
it would be convenient to share a snapshot of in-progress work with a
colleague or a collaborator on a project.  And finally, many users wish
to sync their in-progress state across machines, and we currently have
no good way to do so, so they often do dangerous things like using cloud
syncing services for their repositories.

Let's solve this problem by allowing users to import and export stashes
to a chain of commits.  The commits used in a stash export are nearly
identical to those used in the stashes, with one notable change: the
first parent of a stash is a pointer to the previous stash, or an empty
commit if there is no previous stash.  All of the other parents used in
the stash commit are present following it in their normal order.

This allows users to write their exported stashes to a single ref and
then push that ref to a remote or to bundle it for easy transport, and
then fetch it on the receiving side.  It also permits saving the index
and even untracked files and syncing them across machines, unlike
temporary commits.

We intentionally attempt to exactly round-trip commits between stashes,
although we don't do so for the exported data due to the base commit not
having identical timestamps.  Preserving the commits exactly lets us
more efficiently test our code and it also permits users to more easily
determine if they have the same data.

The tooling here is intentionally plumbing.  It's designed to be simple
and functional and get the basic job done.  If we want additional
features, we can add them in the future, but this should be a simple,
basic feature set that can support additional uses.

[0] For example, the present author has 124 stash entries in his
repository for this project.

brian m. carlson (6):
  builtin/stash: factor out generic function to look up stash info
  builtin/stash: fill in all commit data
  object-name: make get_oid quietly return an error
  builtin/stash: provide a way to export stashes to a ref
  builtin/stash: provide a way to import stashes from a ref
  doc: add stash export and import to docs

 Documentation/git-stash.txt |  27 +++
 builtin/stash.c             | 359 +++++++++++++++++++++++++++++++++---
 cache.h                     |  21 ++-
 object-name.c               |   6 +-
 t/t3903-stash.sh            |  52 ++++++
 5 files changed, 431 insertions(+), 34 deletions(-)

