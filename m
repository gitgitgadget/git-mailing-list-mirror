Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68461207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934101AbcI2VAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50543 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933604AbcI2VAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A775A42978;
        Thu, 29 Sep 2016 17:00:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=EcPSoPIlHPCWtzjMOdq4BCvh/Zo
        =; b=PKzh4gsW9HFTI67z6LFZgi4C8e2BJk6rB4cuVt9QXe5rgyrEUEKeRxtmGNt
        Gox+fDVhxl9sPDBXkZ6RAvgqEGIBMIm5bW3GiUYWJ6lUb5DvFiLxdeZIinnvK285
        nAfyAozbHOcecFMiQcNm4TSBAhWWoPRQw4hb3DGCkJ9ETJgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=Jamfhm615aRCDJMRgr4TP/CDbW5hY
        y0VgkfKY2IRXXvVlBmEaVMweT94F0ZVn7dkNFVezn2/QnVQnUlE1L9qd45xiqe8N
        Iz1rDpTkzkCwFMp7MkltCvjRXBQ+oI4pFh1NG7veTPfKSFrsrP3TBiexzPwMkqsM
        TSeTE6t+8O7zvs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FCBC42977;
        Thu, 29 Sep 2016 17:00:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E54842976;
        Thu, 29 Sep 2016 17:00:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/9] allow customizing /etc/gitconfig location with an environment
Date:   Thu, 29 Sep 2016 14:00:05 -0700
Message-Id: <20160929210014.3874-1-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
X-Pobox-Relay-ID: B8D9B896-8687-11E6-97E3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ended up growing quite a bit, and I mostly hate it.

 - Patch 1 introduces GIT_CONFIG_SYSTEM_PATH environment variable
   that lets you point at a file other than /etc/gitconfig to
   pretend that your file is the system-wide configuration.

 - Patch 2 is a small bugfix.

 - Patches 3-7 are updates to 1300 and 1308, i.e. tests for "git
   config", to make them more robust, in preparation for using
   GIT_CONFIG_SYSTEM_PATH mechanism to point at a file during the
   test.  It protects them a bit more than necessary in that the
   variables some of the tests they use when they try to see the
   output from "git config --get" are unlikely to appear in the fake
   system-wide configuration during the test (hence disabling the
   fake system-wide configuration has no practical effect), but
   nevertheless the calls are protected by explicitly telling them
   to read only from --local configuration file to future-proof
   them.

 - Patch 8 is queued elsewhere already.

 - Patch 9 raises the default core.abbrev to 12 and countermands it
   by setting it to 7 in a fake system-wide configuration file
   during our test.  The unconditional widening of the default
   abbreviation size in this patch will have to be discarded,
   preferring the approach Linus is taking to auto-size it based on
   the number of objects in the repository, but the part that
   updates the test script may still be necessary.

Jeff King (1):
  t1300: check also system-wide configuration file in --show-origin
    tests

Junio C Hamano (8):
  config: allow customizing /etc/gitconfig location with an environment
  t1300: always compare expect to actual
  t1308: ignore system-wide config in the iteration test
  t1300: disable system-wide config for tests that wants to read from -c
  t1300: take contents of system-wide configuration into account in
    "--list" test
  t1300: be explicit in local configuration tests
  worktree: honor configuration variables
  core.abbrev: raise the default abbreviation to 12 hexdigits

 builtin/worktree.c     |   2 +
 cache.h                |   1 +
 config.c               |   2 +
 environment.c          |   2 +-
 t/gitconfig-for-test   |   9 ++++
 t/t1300-repo-config.sh | 120 ++++++++++++++++++++++++++++++-------------------
 t/t1308-config-set.sh  |   1 +
 t/test-lib.sh          |   4 +-
 8 files changed, 93 insertions(+), 48 deletions(-)
 create mode 100644 t/gitconfig-for-test

-- 
2.10.0-589-g5adf4e1

