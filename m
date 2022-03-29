Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E4C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 21:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiC2Vvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiC2Vvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 17:51:37 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84D4738C
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:49:52 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C40C85A107;
        Tue, 29 Mar 2022 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1648590591;
        bh=Bn3qNhsHb7nm69LLS3WOyQkD86HQgVVnMpWrHqHg/oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=jY1DQfJxlpISKmIgB+PEeCWaE+RwZ43ypGZ4QTxEuqGnhXlTOKHUK2Usu6v2Zjj8M
         ckvzMfcr5q7RaE6/6eqRQgT9xhFCZhsivuCzAVHXgwDBEqnva19+D0MAc2IfmhbqNu
         Yh/5lLHpgJk+7ts19RMk00mTo++FtYy8WIHuE8/IeHupc0TjDFg34uREvZctfUJg0c
         nb3MyoNBDPUt8kSLGHikN2dvrpLidUqCEkJfO89Ct89QfaZ/t2nN0yNeviXwZ1/RAx
         57F+OVO2XgnPVlHyReSkwe9Duhs3IS0HHcd4p7UgYt9IifJ3npE9UBxTt+lweI4pc7
         HOyEgm73Umv5WO6LLl67Onv09G9EK6LJWX7zVok4vFM++IQtTFCC2cmFj/ks6TLTOE
         X+2EyWg2pTGKrpwbtCYe1gamOaNR0M9omoDZLx+66EWwkdAjR7q5EXyPrse9+rdGrM
         4yfIMPEQ++oWZtRYH45DmjJC13BW5xV3f1prt6Bc6ez0e8Jthga
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] Importing and exporting stashes to refs
Date:   Tue, 29 Mar 2022 21:49:37 +0000
Message-Id: <20220329214941.2018609-1-sandals@crustytoothpaste.net>
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

We now produce completely reproducible exports by creating the base
commit with predictable author and committer names and timestamps.
The timestamp is arbitrary but picked to be the same as the one used by
format-patch.

We also now avoid size_t.  Because of the constraints of portability, we
can't have nice things like %zu, so now we use int.  Parties wanting to
import or export more than 2 billion stashes are welcome to send a patch
improving the situation.  While I have many stashes, I'm at least a
billion or so away from that point, so I'm going to punt that to a
future series.

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
 builtin/stash.c             | 324 ++++++++++++++++++++++++++++++++++--
 cache.h                     |   1 +
 object-name.c               |   6 +-
 t/t3903-stash.sh            |  52 ++++++
 5 files changed, 397 insertions(+), 15 deletions(-)

