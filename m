Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D136C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 18:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359745AbiDCSYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359738AbiDCSYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 14:24:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90F39153
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 11:22:55 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 737E45A3DE;
        Sun,  3 Apr 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649010174;
        bh=mdJxTmJ5vRzMqvA4QApP+20vfbv+AkDUdOCXelfr9Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=lqc8vvoDPlcnrjTGPoYjF0SsQgbCj6DXy0h7/kpedGqG3HLkT0KDeUoJGS5vt2s5N
         qFwayFx42vUxKLWpUyDvnNZbKKvxhSBAd2sPO6aW1RvkViq2xBHfhQqRhteFB8OXQO
         a6TICdNjJjlVgtQWbWRBvqsKZoau0/dIWhQb/4feipzWU1Nmx/2Lkc9Ft0i9/yeLRv
         dPRNBEg0EWyKiGVLY5qvI5CXK/2VLIBFrJLjjuUawHQjDynuBmK6HzdZu7dG9qZoT/
         MWxNHNM4IDnlzzICswKM2tFQbaabgLOLWSJs4N4HtEO3HS+/gISwq5PTeVSwrGfU01
         59WbMwsLBoW+pDLTF5epo8samfdJqWcNhxi75+vp1jdf+MUHMfhZl6RMVV7QirCb6w
         4VvjqfzUGM/kTIiBwHgN2k4pgDifyjJyyTJuPaD/+XDlGr58FX7GfMRJGYv5a21CKP
         jdRoNH3ZiQm1CiRT997X+jPnxBF203O95F8SsrPJSSUlRrn2aV9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] Importing and exporting stashes to refs
Date:   Sun,  3 Apr 2022 18:22:46 +0000
Message-Id: <20220403182250.904933-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
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

Let's solve this problem by allowing users to import and export stashes
to a chain of commits.  The commits used in a stash export contain two
parents: one which is the pointer to the next exported stash (or to an
empty commit with no parents if there are no more) and the second is the
stash commit that would normally be stored in the reflog.

Changes from v2:
* Fix uninitialized strbuf.
* Avoid C99-style initializations.

Changes from v1:
* Change storage format as suggested by Junio.
* Rename to GIT_OID_GENTLY.
* Remove unnecessary initializations.
* Use ALLOC_GROW_BY.
* Ensure completely reproducible exports.
* Avoid size_t.
* Various other code cleanups.

brian m. carlson (4):
  object-name: make get_oid quietly return an error
  builtin/stash: factor out revision parsing into a function
  builtin/stash: provide a way to export stashes to a ref
  builtin/stash: provide a way to import stashes from a ref

 Documentation/git-stash.txt |  29 +++-
 builtin/stash.c             | 326 ++++++++++++++++++++++++++++++++++--
 cache.h                     |   1 +
 object-name.c               |   6 +-
 t/t3903-stash.sh            |  52 ++++++
 5 files changed, 399 insertions(+), 15 deletions(-)

