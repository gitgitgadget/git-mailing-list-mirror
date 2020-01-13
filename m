Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C733C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D660421744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="op+Fcc9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMMke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgAMMkd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADC9060735;
        Mon, 13 Jan 2020 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919232;
        bh=EJ9RPNnTsW3koegYqBf1pID/2k316GFMKl8c9AnbbCU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=op+Fcc9UhpkS7oNQLkW5f/KifrGzZGq60+5oADAiXvsLC9HOz1iRe30peDxycAK2t
         qOS5ldbP0+GihauVG6TNA5/iQnbq2kvFKPuI2yMLiWDRGz6kXaRtVCaiNu69lFFvku
         Lj2PjTZ5UMJZztLZdUb2nlRb6q/5DLgzha5ba5dYq/ynG4/4U0iULYpEeiGwTsxdRg
         7/h2ZvXoYhYxKbtKp8dbHysbG5ZZIRnwNKsh68TY2SfFp+1PUt1/+jf472/Vyg+amg
         VO9R1Ec1XaxePm9SSuiggG7kymJXZuOFbOMUgGiG/OPTGF7HsUcPSGw1z2bWHKhFn4
         3DKsUwIPjZnB78dogMJCVhBEZxbXdk67FN5Umqj3IQ+phio1mRglxp1OhxvQpIyED2
         UIhFauAxUC7r4J+rNgkXOLK8HiIu1Y4nqe4jA8J4GqASUMU7xWp0zzY4lh3QO77KQU
         lczk1jYhh723iSHfsiV5sHxgyJgFXHgKXvKBnyoAvHLTwE9/eCN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/24] SHA-256 test fixes, part 8
Date:   Mon, 13 Jan 2020 12:38:33 +0000
Message-Id: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second-to-last series of test fixes for SHA-256.  Most of
them are rather boring, but there are a few notable exceptions.

t3305 appears to fail with SHA-256 due to the fanout not compressing as
expected.  I believe this is a legitimate bug that our transition to
SHA-256 exposes, but it's unclear to me why it happens and I'm not
familiar enough with the code to figure out what's going on[0].  I've
CC'd Dscho, since he seems to be the person most familiar with the notes
code who's still involved in the project.

I suspect that t3404 also has a bug, since the object IDs that are
supposed to collide do not, according to my instrumentation of the test.
I'm unsure what the intended collision was and consequently haven't
fixed it.  However, it does work with SHA-256 as it stands and is no
more or less functional than with SHA-1, so I've removed the
prerequisite.

I believe the fix in t5616 is correct and still supports the intent of
the test, but I'd appreciate any feedback there.  Why it works with
SHA-1 is unclear to me, but my conjecture is that it's due to ordering
of the object IDs.  I've CC'd Jonathan Tan about this issue since he
seems to be most familiar with that test.

t/lib-pack.sh is updated in this commit, but I expect a small number of
additional fixes to come in with part 9 to support t5308.

I fully expect that this series won't be picked up until after the
release, and that's fine.  It is based on master and intentionally does
not require the other in-flight test series.  I expect a reroll due to
the aforementioned suspected bugs.

Of course, feedback on any aspect of this series is welcome.

[0] While working on the transition to SHA-256, I've found myself quite
confused by the notes code in general, mostly due to the way it uses
partial object IDs.  Reading about the feature (which I'd previously
never used) was indeed helpful, though, so thanks to the folks who wrote
the documentation.

brian m. carlson (24):
  t/lib-pack: support SHA-256
  t3206: make hash size independent
  t3305: annotate with SHA1 prerequisite
  t3308: make test work with SHA-256
  t3309: make test work with SHA-256
  t3310: make test work with SHA-256
  t3311: make test work with SHA-256
  t3404: remove SHA1 prerequisite
  t4013: make test hash independent
  t4060: make test work with SHA-256
  t4211: make test hash independent
  t5302: make hash size independent
  t5309: make test hash independent
  t5313: make test hash independent
  t5321: make test hash independent
  t5515: make test hash independent
  t5318: update for SHA-256
  t5616: use correct filter syntax
  t5607: make hash size independent
  t5703: make test work with SHA-256
  t5703: switch tests to use test_oid
  t6000: abstract away SHA-1-specific constants
  t6006: make hash size independent
  t6024: update for SHA-256

 t/lib-pack.sh                                |  35 ++-
 t/t3206-range-diff.sh                        |  14 +-
 t/t3305-notes-fanout.sh                      |   2 +-
 t/t3308-notes-merge.sh                       |  83 ++++---
 t/t3309-notes-merge-auto-resolve.sh          | 228 ++++++++++++-------
 t/t3310-notes-merge-manual-resolve.sh        |  84 ++++---
 t/t3311-notes-merge-fanout.sh                |  60 +++--
 t/t3404-rebase-interactive.sh                |   4 +-
 t/t4013-diff-various.sh                      |  44 +++-
 t/t4060-diff-submodule-option-diff-format.sh | 126 +++++-----
 t/t4211-line-log.sh                          |  14 +-
 t/t5302-pack-index.sh                        |  18 +-
 t/t5309-pack-delta-cycles.sh                 |  10 +-
 t/t5313-pack-bounds-checks.sh                |  19 +-
 t/t5318-commit-graph.sh                      |   4 +-
 t/t5321-pack-large-objects.sh                |   4 +-
 t/t5515-fetch-merge-logic.sh                 |  51 ++++-
 t/t5607-clone-bundle.sh                      |   2 +-
 t/t5616-partial-clone.sh                     |   2 +-
 t/t5703-upload-pack-ref-in-want.sh           |   7 +-
 t/t6000-rev-list-misc.sh                     |  13 +-
 t/t6006-rev-list-format.sh                   |   4 +-
 t/t6024-recursive-merge.sh                   |  15 +-
 23 files changed, 562 insertions(+), 281 deletions(-)

