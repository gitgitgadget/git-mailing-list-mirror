Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9602C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96EE20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Moav7DcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgEMAzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731938AbgEMAzK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96FC960427;
        Wed, 13 May 2020 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331277;
        bh=jN/GXuU3O+EGezax4HZIl1WADtpi29v+HgufQwjeiBs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Moav7DcCXwWp24crc5W3M6Fn1V8wXUf5vXpb5aTCdTa7N+RUOcguRZ1TvYhHXKHwQ
         kvqLLR5YohfxXoal9adr2/TW5YGGx7n3Rm0Fq44yugMk5VnhFooHhBHINMPAfFGgWv
         fxsEyQJsO/6JJtv4hZm1nCEE0MDcASZ8a33fobT2jOw8OIrmluLrbAgE5DUUeOk3l6
         c9KJ9NrNk4lG1Ne41eH40snnt/WVfkuba+6hbzIdvbj/35o4I+siCc89kVVwzJTDYl
         fheY3wb3jnHI2cHkBpySez0TgT7ZpdvOv82Lb8rjmDZ1fvZrS1q7cFw5CUbm90caR/
         /Ae/9psU6qjGAWxC5XywzLMC6JfzHKn4wOkI2uCtWuJK7zFp6WkOHgdkzKMFPuUaP5
         6sIRj+U6jRgR0cVfLNdXGC/v5cKYyXu7FU8el/hx+CXPhT7RrLMpC6C5rqEsqALE0i
         J2QD6hMgeD6XqwHy3qDV7c4Gp/7aPnkFTAh4Ik6STTd9hm0BipT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 00/44] SHA-256 part 2/3: protocol functionality
Date:   Wed, 13 May 2020 00:53:40 +0000
Message-Id: <20200513005424.81369-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part 2 of 3 of the SHA-256 work.  This series, which is
unfortunately longer than I'd like, adds all of the protocol logic to
work with SHA-256 repositories.

It was originally planned that we would not upgrade the protocol and
would use SHA-1 for all protocol functionality until some point in the
future.  However, doing that requires a huge amount of additional work
(probably incorporating several hundred more patches which are not yet
written) and it's not possible to get the test suite to even come close
to passing without a way to fetch and push repositories.  I therefore
decided that implementing an object-format extension was the best way
forward.

This series provides object-format extensions for both the original and
v2 protocols, including full documentation.  Helpers, such as
git-remote-https, also learn capabilities to pass the object-format
extension back and forth, and to query its state.  The code is designed
to allow multiple object-format extensions to be provided if the server
supports multiple algorithms for one repo and to default to SHA-1 if no
object-format extension is provided.

The other two cases are the dumb HTTP protocol and bundles, both of
which have no object-format extension (because they provide no
capabilities) and are therefore distinguished solely by their hash
length.  We will have problems if in the future we need to use another
256-bit algorithm, but I plan to be improvident and hope that we'll move
to longer algorithms in the future to cover ourselves for post-quantum
security.

Clone support is necessarily a little tricky because we are initializing
a repository and then fetching refs, at which point we learn what hash
algorithm the remote side supports.  We work around this by calling the
code that updates the hash algorithm and repository version a second
time to rewrite that data once we know what version we're using.  This
is the most robust way I could approach this problem, but it is still a
little ugly.

As mentioned, this series is longer than I'd like, but it is complete:
this is all the SHA-256 protocol work.  Additional future series include
one last series of test fixes (28 patches) plus six final patches in the
series that enables SHA-256 support.

brian m. carlson (44):
  t1050: match object ID paths in a hash-insensitive way
  Documentation: document v1 protocol object-format capability
  connect: have ref processing code take struct packet_reader
  wrapper: add function to compare strings with different NUL
    termination
  remote: advertise the object-format capability on the server side
  connect: add function to parse multiple v1 capability values
  connect: add function to fetch value of a v2 server capability
  pkt-line: add a member for hash algorithm
  transport: add a hash algorithm member
  connect: add function to detect supported v1 hash functions
  send-pack: detect when the server doesn't support our hash
  connect: make parse_feature_value extern
  fetch-pack: detect when the server doesn't support our hash
  connect: detect algorithm when fetching refs
  builtin/receive-pack: detect when the server doesn't support our hash
  docs: update remote helper docs for object-format extensions
  transport-helper: implement object-format extensions
  remote-curl: implement object-format extensions
  builtin/clone: initialize hash algorithm properly
  t5562: pass object-format in synthesized test data
  t5704: send object-format capability with SHA-256
  fetch-pack: parse and advertise the object-format capability
  setup: set the_repository's hash algo when checking format
  t3200: mark assertion with SHA1 prerequisite
  packfile: compute and use the index CRC offset
  t5302: modernize test formatting
  builtin/show-index: provide options to determine hash algo
  t1302: expect repo format version 1 for SHA-256
  Documentation/technical: document object-format for protocol v2
  connect: pass full packet reader when parsing v2 refs
  connect: parse v2 refs with correct hash algorithm
  serve: advertise object-format capability for protocol v2
  t5500: make hash independent
  builtin/ls-remote: initialize repository based on fetch
  remote-curl: detect algorithm for dumb HTTP by size
  builtin/index-pack: add option to specify hash algorithm
  t1050: pass algorithm to index-pack when outside repo
  remote-curl: avoid truncating refs with ls-remote
  t/helper: initialize the repository for test-sha1-array
  t5702: offer an object-format capability in the test
  t5703: use object-format serve option
  t5300: pass --object-format to git index-pack
  bundle: detect hash algorithm when reading refs
  remote-testgit: adapt for object-format

 Documentation/gitremote-helpers.txt           |  33 +-
 .../technical/protocol-capabilities.txt       |  16 +-
 Documentation/technical/protocol-v2.txt       |   9 +
 builtin/clone.c                               |   9 +
 builtin/index-pack.c                          |  11 +-
 builtin/ls-remote.c                           |   4 +
 builtin/receive-pack.c                        |  10 +
 builtin/show-index.c                          |  29 +-
 bundle.c                                      |  22 +-
 bundle.h                                      |   1 +
 connect.c                                     | 136 +++++--
 connect.h                                     |   3 +
 fetch-pack.c                                  |  14 +
 git-compat-util.h                             |   2 +
 git.c                                         |   2 +-
 object-store.h                                |   1 +
 packfile.c                                    |   1 +
 pkt-line.c                                    |   1 +
 pkt-line.h                                    |   3 +
 remote-curl.c                                 |  46 ++-
 send-pack.c                                   |   6 +
 serve.c                                       |  27 ++
 setup.c                                       |   1 +
 t/helper/test-oid-array.c                     |   3 +
 t/t1050-large.sh                              |   6 +-
 t/t1302-repo-version.sh                       |   6 +-
 t/t3200-branch.sh                             |   2 +-
 t/t5300-pack-object.sh                        |   9 +-
 t/t5302-pack-index.sh                         | 360 +++++++++---------
 t/t5500-fetch-pack.sh                         |   5 +-
 t/t5562-http-backend-content-length.sh        |  14 +-
 t/t5701-git-serve.sh                          |  28 +-
 t/t5702-protocol-v2.sh                        |   2 +
 t/t5703-upload-pack-ref-in-want.sh            |  19 +-
 t/t5704-protocol-violations.sh                |  12 +
 t/t5801/git-remote-testgit                    |   6 +
 t/test-lib.sh                                 |   1 +
 transport-helper.c                            |  24 +-
 transport.c                                   |  18 +-
 transport.h                                   |   8 +
 upload-pack.c                                 |   3 +-
 wrapper.c                                     |  12 +
 42 files changed, 670 insertions(+), 255 deletions(-)

