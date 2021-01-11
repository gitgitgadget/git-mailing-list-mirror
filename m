Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2BC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 03:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228AB22472
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbhAKD7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 22:59:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50672 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbhAKD7a (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 22:59:30 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5926660781;
        Mon, 11 Jan 2021 03:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610337528;
        bh=AvnZskkL6l8P+z2Iqt9cDWt2JZswLP1Gjj3ad1FEy5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UY1CmOBWht25SRsoIrTlRejRV6zqCQmMLzUmuIFJq5rzsAN9pgfem9E9l+83HyWSy
         w9Qn6/4gITm8NpWCNNZKezWST8Va0jfdazyswQdRcXmPgosOKoIYgVB3kyMd8o72xw
         v8sp7O/X6y3ziCg4sIMtUjg7EDTTnW8sghoXjnIGmPym9UyNG/+Fx9HIMqq3CqHF05
         w07oXZPpk5GdQp96g3SyeCGA9cJoyjtC+YiqcQl/KewUC8gSv2CNZQOoZPxO2Kv6MC
         lOBx3mDYyIEOSjQRYmbkA8hj+OjSdE5tmFfNFxBGJInSMzxWO3wSQmSiq6Q2TFwdcQ
         nw9I+J/PiMlhfCrMOCsFYPgDEpODzCO/2MSv6MZKKYEF8x5WhSGQk/9ryAJx+VR9Yu
         nclNQqFId5U/uSNuvetCYlNLY5BLp8dCcZ1/DAKSq680mYNgf8RicwEMSrB2e54NFC
         xbnfpXnMCwlxgkgscKHr7PwIsCbYlmwRIGvGiYJ9irYZ44yBHYJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] Support for commits signed by multiple algorithms
Date:   Mon, 11 Jan 2021 03:58:35 +0000
Message-Id: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces support for verifying commits and tags signed by
multiple algorithms.

Originally, we had planned for SHA-256 tags to stuff the signature in a
header instead of using a trailing signature, and a patch to do that was
sent out in part 1/3.  Unfortunately, for whatever reason, that patch
didn't make it into the master branch, and so we use trailing signatures
there.

We can't change this now, because otherwise it would be ambiguous
whether the trailing signature on a SHA-256 object was for the SHA-256
contents or whether the contents were a rewritten SHA-1 object with no
SHA-256 signature at all.  To do the next best thing, let's use the
trailing signature for the preferred hash algorithm and use a header for
the other variant.  This permits round-tripping, but has the downside
that tags signed with multiple algorithms can't be verified with older
versions of Git.  However, signatures created with older versions of Git
continue to be accepted.

For commits, let's accept a commit that has two signatures.  We
previously created the commits correctly but didn't strip the extra
header off when verifying, so our verification indicated the signature
was bad.

Both these situations allow for signing commits and tags that can be
round-tripped through both SHA-1 and SHA-256.  We verify only the
signature using the current hash algorithm, since we currently don't
rewrite objects.

Changes from v1:
* Fix brown paper bag bug where some tests failed due to a bad rebase.

brian m. carlson (5):
  commit: ignore additional signatures when parsing signed commits
  gpg-interface: improve interface for parsing tags
  commit: allow parsing arbitrary buffers with headers
  ref-filter: hoist signature parsing
  gpg-interface: remove other signature headers before verifying

 builtin/receive-pack.c   |  4 +-
 builtin/tag.c            | 16 ++++++--
 commit.c                 | 83 ++++++++++++++++++++++++++--------------
 commit.h                 | 12 +++++-
 fmt-merge-msg.c          | 29 ++++++++------
 gpg-interface.c          | 15 +++++++-
 gpg-interface.h          |  9 ++++-
 log-tree.c               | 15 ++++----
 ref-filter.c             | 23 +++++++----
 t/t7004-tag.sh           | 25 ++++++++++++
 t/t7510-signed-commit.sh | 43 ++++++++++++++++++++-
 tag.c                    | 15 ++++----
 12 files changed, 219 insertions(+), 70 deletions(-)

