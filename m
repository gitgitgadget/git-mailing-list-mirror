Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2512055E
	for <e@80x24.org>; Sat, 28 Oct 2017 18:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdJ1SP5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 14:15:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751327AbdJ1SP5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 14:15:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5F636044A;
        Sat, 28 Oct 2017 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509214556;
        bh=Fx49jvBn7vDRXj355qcPvJSSNxOKqz1Xqp2liB1QvnY=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y27428KCvh4DWF3do8hvbKNtVUhl0ciikXlgeUHVBXziT8fZOnUlcKWXMzTvfCOGY
         SwU2Sjwpkfx4IWb9LjQPvKLoTC+Cj7MQUD17d7AJJa1JPD8cJql1lqrhYex6pFQicK
         jvNhLxzt7jgNnISX2/8ZdZg+bXODj0iF8nF0snQPKyBjM07eUEDP3vohZ2zr8k4LFE
         Hi8xAnv+lSMxtX7c8qDcNLrZHvA7ZtEarT/UsYN033vyXjbjgK5B8k+4DEBoyUh1ta
         sjEGaYiLKGssjuckUZ4bAhpxbc1/+NjcWXdMfxEAxm3k4YoJiHbbWjIa0ChvN7RfO5
         8UicJgjJp9E2Sp4yaodn7+afGj2AiU8IGmXeavaObslrIdCfJXYb7QstAhGWGAWOFr
         eEqdPdpV9l4Xzd1HwMOs4yyRZaXtVtwcnrCXF/Kxu/4JLK/bRqudHEhevC+QE2KnZ5
         npQqzd8EX7sDqcVAPMMPqRqpL2aw/XGne3kcKsc87QofQ/di6Of
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/4] Hash Abstraction
Date:   Sat, 28 Oct 2017 18:12:35 +0000
Message-Id: <20171028181239.59458-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc2
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series proposing a basic abstraction for hash functions.

As we get closer to converting the remainder of the codebase to use
struct object_id, we should think about the design we want our hash
function abstraction to take.  This series is a proposal for one idea.
Input on any aspect of this proposal is welcome.

This series exposes a struct git_hash_algo that contains basic
information about a given hash algorithm that distinguishes it from
other algorithms: name, identifiers, lengths, implementing functions,
and empty tree and blob constants.  It also exposes an array of hash
algorithms, and a constant for indexing them.

The series also demonstrates a simple conversion using the abstraction
over empty blob and tree values.

In order to avoid conflicting with the struct repository work and with
the goal of avoiding global variables as much as possible, I've pushed
the hash algorithm into struct repository and exposed it via a #define.

I propose this series now as it will inform the way we go about
converting other parts of the codebase, especially some of the pack
algorithms.  Because we share some hash computation code between pack
checksums and object hashing, we need to decide whether to expose pack
checksums as struct object_id, even though they are technically not
object IDs.  Furthermore, if we end up needing to stuff an algorithm
value into struct object_id, we'll no longer be able to directly
reference object IDs in a pack without a copy.

I've updated this series in some significant ways to reflect and better
implement the transition plan as it's developed.  If there are ways
in which this series (or future series) can converge better on the
transition plan, that input would be valuable.

This series is available from the usual places as branch hash-struct,
based against master as of 2.15-rc2.

Changes from v1:
* Rebase onto 2.15-rc2.
* Fix the uninitialized value that Peff pointed out.  This fixes the
  error, but leaves the code in the same place, since I think it's where
  it should be.
* Improve commit message to explain the meaning of current_hash WRT the
  transition plan.
* Added an unknown hash algorithm constant and value to better implement
  the transition plan.
* Explain in the commit message why hex size and binary size are both
  provided.
* Add a format_id field to the struct, in coordination with the
  transition plan.
* Improve comments for struct fields and constants.

brian m. carlson (4):
  setup: expose enumerated repo info
  Add structure representing hash algorithm
  Integrate hash algorithm support with repo setup
  Switch empty tree and blob lookups to use hash abstraction

 builtin/am.c       |  2 +-
 builtin/checkout.c |  2 +-
 builtin/diff.c     |  2 +-
 builtin/pull.c     |  2 +-
 cache.h            | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 diff-lib.c         |  2 +-
 merge-recursive.c  |  2 +-
 notes-merge.c      |  2 +-
 repository.c       |  7 ++++++
 repository.h       |  5 ++++
 sequencer.c        |  6 ++---
 setup.c            | 49 ++++++++++++++++++++++-----------------
 sha1_file.c        | 43 +++++++++++++++++++++++++++++++++++
 submodule.c        |  2 +-
 14 files changed, 157 insertions(+), 36 deletions(-)

-- 
2.15.0.rc2

