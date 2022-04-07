Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B83C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiDGWKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiDGWKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E5140FC
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:54:00 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D93C95A0EC;
        Thu,  7 Apr 2022 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649368439;
        bh=yJTWw9tvFYua+6PdJ4af7Xj6hWutQi46AiKn/G2At8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=bGDSjJoaxGa5UowZViOoAS4V5PriH4fZMKf8JcbEc/3uDLpezON99ptRXPxfiPFXJ
         tX6sB1KvshCkiNukK3YSegCeLnzIgrpyOyf3ERg+vmvWADCei4/3lgEAitWqv8VYoR
         r8KG9wo5YMBXYa5Vb+/ac4+NaZoSANrthKIwdM+L4gglUK8HB+HwRAL/G9Cy2Z3oST
         bQC1X3VFll9H9vjzDYxQJxc5GVGN8c1XCLpJXOWrq+fkTZUFzfMAAi0wW3oaId2oPg
         ZT7aqprGxfd5opoquL3QayPy4/KTTKKUte3Ox+wwBhVu5lo/6d95dQWN1S7Ys6GF61
         0uWCIi5jKML//TRm4yjJHzY9VmDyFb57t1AAH0Gnx0nGmVyr+dFz5L59GmMGgiHBmA
         ZklHYXR+chPoeZIE74eyqb7mu7roNotpnOpfRDPwzNNjgFbwLHf/dKP4zOTPJKTGz7
         nvaux0FLQY2ArPb8IEQnT1dgOg4n6Szj0J4Eafv2WpxR5DJMJeH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] Importing and exporting stashes to refs
Date:   Thu,  7 Apr 2022 21:53:48 +0000
Message-Id: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
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

Changes from v3:
* Fix strbuf handling to avoid leaks and generally be more sensible.
* Make use of the error return code more often.
* Use oid_array.
* Tidy various parts of the code and fix long lines.
* Simplify tests using git tag.
* Shorten and tidy tests.
* Add an additional test covering the base commit OID and importing and
  exporting empty stashes.

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
 builtin/stash.c             | 321 ++++++++++++++++++++++++++++++++++--
 cache.h                     |   1 +
 object-name.c               |   6 +-
 t/t3903-stash.sh            |  63 +++++++
 5 files changed, 406 insertions(+), 14 deletions(-)

