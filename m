Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C50C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37B620663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ML2kMSvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgGJCtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40476 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgGJCs4 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 869196048A;
        Fri, 10 Jul 2020 02:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349303;
        bh=Fc6NLkWy7I64ol/B+a+f2LIL9ngfEv3bUF7UuuM6uqM=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ML2kMSvLPjxXvq+ccDs6n1npoz48+E7A9kZBt8NYn62SaD2GQozmLz7yU9F2ISx77
         OBeBQ4wFLPq0kq5CiHjqP1AGdJH4dzexRoL7hQM0ALvIJDITBO0GLOp5uNUrgTY3tI
         3QpNLVi2NvB4BCisz9RZyyl72ShfUbUKrBzik38rB+G5WKfnDmua2U9r9rttog9bGL
         6ZvtJjXgfn9AIaX1BRec/pVoLEUqKHk0CMjnmslOjV24MiNyckJfqwpLRjCZ0QXsrf
         jv925A1u7rB0gV6HmLTbn+AnGBp7G4hgwm/qR35bF2PUCR7dHQ9Y+a+nPB9Y2eJWay
         gc39B3xLn2EEnf+4hDXAb+/gzESKvOtF6XS9fOuuOUY1jP9qBhPmyC+EijT7aYhnVd
         jr6PEITdoUHjcARHBpxpEtq5mkgmlA9FIDRUHH2UHPmX0ruKDM3yM30ZvayrjptvDi
         cLPDaCFmFkufeXJV2Bh0U/6U0qwyNVUunmBOBy5yTHjZXaGMPHK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/38] SHA-256, part 3/3
Date:   Fri, 10 Jul 2020 02:46:50 +0000
Message-Id: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final part required for the stage 4 implementation of
SHA-256.

The beginning part of this series is mostly final test fixes, and should
be straightforward.  Next are two patches that are required to fix the
remaining SHA-256 incompatibilities in our codebase, both of which were
necessitated by recent changes.

After that, the meat of the series: support for reading
extensions.objectFormat, removal of the compile-time option, and some
tests.  We introduce a knob to control the testsuite and a wire-in for
CI so we don't regress things in the future, and at the end, some docs.

The final patch here is the promised cleanup for test_oid_init in
various places in our codebase.

Note that SHA-256 repositories don't currently interoperate with SHA-1
repositories.  I'm working on additional patches for the pieces required
to implement that and full stage 1, 2, and 3 support, which will be in
future series.  However, it is possible to have a full SHA-256
repository that is fully functional after this series.  I refer the
reader to Documentation/technical/hash-function-transition.txt for the
details of the different stages.

I do plan to provide a shell-based tool for easier conversion of
repositories with submodules at some point in the future, but all the
pieces required are already built into fast-import and fast-export.

I would like to thank everyone who's contributed to the SHA-256 work
over the years with patches, review, documentation, suggestions, and
other contributions.  I could not possibly name all of the contributors
here, so I won't try.  None of this work could have been done without
all your help.

I plan to take a brief hiatus from more SHA-256 work after this and work
on some other Git- and non-Git-related projects, but I'll probably
resume at some point before year's end.  I'm happy to provide the
in-progress work for next steps if people are interested.

I fully expect this series won't be picked up until after the release,
so please feel free to focus on release-related activities for the
moment.

Johannes Schindelin (1):
  t3404: prepare 'short SHA-1 collision' tests for SHA-256

brian m. carlson (37):
  t: make test-bloom initialize repository
  t1001: use $ZERO_OID
  t3305: make hash agnostic
  t6100: make hash size independent
  t6101: make hash size independent
  t6301: make hash size independent
  t6500: specify test values for SHA-256
  t6501: avoid hard-coded objects
  t7003: compute appropriate length constant
  t7063: make hash size independent
  t7201: abstract away SHA-1-specific constants
  t7102: abstract away SHA-1-specific constants
  t7400: make hash size independent
  t7405: make hash size independent
  t7506: avoid checking for SHA-1-specific constants
  t7508: use $ZERO_OID instead of hard-coded constant
  t8002: make hash size independent
  t8003: make hash size independent
  t8011: make hash size independent
  t9300: abstract away SHA-1-specific constants
  t9300: use $ZERO_OID instead of hard-coded object ID
  t9301: make hash size independent
  t9350: make hash size independent
  t9500: ensure that algorithm info is preserved in config
  t9700: make hash size independent
  t5308: make test work with SHA-256
  t0410: mark test with SHA1 prerequisite
  http-fetch: set up git directory before parsing pack hashes
  builtin/verify-pack: implement an --object-format option
  setup: add support for reading extensions.objectformat
  Enable SHA-256 support by default
  t: add test_oid option to select hash algorithm
  t: allow testing different hash algorithms via environment
  t: make SHA1 prerequisite depend on default hash
  ci: run tests with SHA-256
  docs: add documentation for extensions.objectFormat
  t: remove test_oid_init in tests

 Documentation/config.txt               |   2 +
 Documentation/config/extensions.txt    |   7 ++
 builtin/init-db.c                      |   5 -
 builtin/verify-pack.c                  |  25 ++--
 ci/run-build-and-tests.sh              |   1 +
 config.mak.dev                         |   2 -
 http-fetch.c                           |   4 +-
 repository.c                           |   4 -
 setup.c                                |  12 +-
 t/helper/test-bloom.c                  |   2 +
 t/lib-pack.sh                          |  11 +-
 t/lib-submodule-update.sh              |   1 -
 t/t0000-basic.sh                       |  15 ++-
 t/t0001-init.sh                        |  31 +++++
 t/t0410-partial-clone.sh               |   2 +-
 t/t1006-cat-file.sh                    |   2 -
 t/t1050-large.sh                       |   1 -
 t/t1091-sparse-checkout-builtin.sh     |   4 +-
 t/t1410-reflog.sh                      |   1 -
 t/t1450-fsck.sh                        |   1 -
 t/t1500-rev-parse.sh                   |   1 -
 t/t3305-notes-fanout.sh                |   2 +-
 t/t3308-notes-merge.sh                 |   1 -
 t/t3404-rebase-interactive.sh          |  49 ++++++--
 t/t3600-rm.sh                          |   1 -
 t/t3800-mktag.sh                       |   1 -
 t/t4002-diff-basic.sh                  |   2 -
 t/t4027-diff-submodule.sh              |   1 -
 t/t4134-apply-submodule.sh             |   1 -
 t/t4200-rerere.sh                      |   1 -
 t/t4211-line-log.sh                    |   1 -
 t/t5300-pack-object.sh                 |   3 +-
 t/t5302-pack-index.sh                  |   1 -
 t/t5308-pack-detect-duplicates.sh      |  20 ++--
 t/t5313-pack-bounds-checks.sh          |   1 -
 t/t5318-commit-graph.sh                |   3 +-
 t/t5319-multi-pack-index.sh            |   1 -
 t/t5324-split-commit-graph.sh          |   1 -
 t/t5504-fetch-receive-strict.sh        |   1 -
 t/t5530-upload-pack-error.sh           |   1 -
 t/t5562-http-backend-content-length.sh |   1 -
 t/t5702-protocol-v2.sh                 |   3 +-
 t/t5703-upload-pack-ref-in-want.sh     |   1 -
 t/t6006-rev-list-format.sh             |   1 -
 t/t6100-rev-list-in-order.sh           |   4 +-
 t/t6101-rev-parse-parents.sh           |   2 +-
 t/t6301-for-each-ref-errors.sh         |   2 +-
 t/t6500-gc.sh                          |  27 ++++-
 t/t6501-freshen-objects.sh             |  14 +--
 t/t7003-filter-branch.sh               |   3 +-
 t/t7063-status-untracked-cache.sh      | 155 +++++++++++++------------
 t/t7102-reset.sh                       |  93 ++++++++-------
 t/t7201-co.sh                          |   5 +-
 t/t7400-submodule-basic.sh             |  26 ++---
 t/t7405-submodule-merge.sh             |   4 +-
 t/t7506-status-submodule.sh            |  12 +-
 t/t7508-status.sh                      |   2 +-
 t/t8002-blame.sh                       |  15 +--
 t/t8003-blame-corner-cases.sh          |   3 +-
 t/t8011-blame-split-file.sh            |   2 +-
 t/t9300-fast-import.sh                 | 117 ++++++++++---------
 t/t9301-fast-import-notes.sh           |  13 +--
 t/t9350-fast-export.sh                 |  15 ++-
 t/t9500-gitweb-standalone-no-errors.sh |  22 +++-
 t/t9700/test.pl                        |   6 +-
 t/test-lib-functions.sh                |  16 ++-
 t/test-lib.sh                          |   6 +-
 67 files changed, 472 insertions(+), 324 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

