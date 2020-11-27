Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B4DC63777
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 23:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3D2223D
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 23:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgK0XUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 18:20:35 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49190 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730213AbgK0XTb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Nov 2020 18:19:31 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F37C6045A;
        Fri, 27 Nov 2020 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606519166;
        bh=DN3oR7+mz7uK5EK9Cp+S95Nh3iykl0x9gyiBOI/5ZAU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AXH3fdDKhK8TDKN2LCxHd/ch/ewdBFYuWTgqbvRPiGtqvQPc6cTyDB4Ca44CV9C2e
         ftzhtHoWFfc9tIEQ0DX0yVmiLWjnbOF9uJZHKS/K3Lnqy5xe6sCCYNLz7v6SOZTq0e
         8c56gXqsp0xSSjDkV7QpNIAae4y9eaD8dRYyN6HxyURkP5zEMRRi78rME6e1t8om5x
         rNQPCtJHKHWstXw0iZkOzaqFQh1qAT9HoTEsxmCxRj1zR29hDWtvpqFsOfTD558Hll
         Ve/gDQgb8oP7ha14IYf2RKRXQ/YxTfIHZpb9Ay55cIugIos/MV04HtFIw2FrhoFH9s
         8P/co0Hs5BkorCx8CCUvm8rFlgm2CVakvk5BQP/Wd3Zg4SALKhD9phxnwaMHsHNvP4
         IXQM760M5DX9fRUi+zx/XhzKZ7iqXXQh6X5RI7ZKpbxwgbydn07U4Ev4QkkRIJtMRZ
         EYe3s2AAzuQFWTY4w0svrKOeNI2GV/ZEX755UzqDPpu++PpfzSa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3 0/2] rev-parse options for absolute or relative paths
Date:   Fri, 27 Nov 2020 23:19:14 +0000
Message-Id: <20201127231916.609852-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a bunch of different situations in which one would like to
have an absolute and canonical or a relative path from Git.  In many of
these cases, these values are already available from git rev-parse, but
some values only come in one form or another.

Many operating systems, such as macOS, lack a built-in realpath command
that can canonicalize paths properly, and additionally some programming
languages, like Go, currently do as well.  It's therefore helpful for us
to provide a generic way to request that a path is fully canonicalized
before using it.  Since users may wish for a relative path, we can
provide one of those as well.

The primary impetus for this was Git LFS, which needs paths to be
canonicalized in the same way as Git in order to function correctly.
See https://github.com/git-lfs/git-lfs/issues/4012 for more details.

Changes from v2:

* Incorporate multiple missing segment support into the strbuf_realpath
  code.
* Switch some invocations to use DEFAULT_UNMODIFIED, which should not
  result in a change in behavior.
* Rebase, resolving some conflicts.

Changes from v1:

* Add a function to handle missing trailing components when
  canonicalizing paths and use it.
* Improve commit messages.
* Fix broken && chain.
* Fix situation where relative paths are not relative.

brian m. carlson (2):
  abspath: add a function to resolve paths with missing components
  rev-parse: add option for absolute or relative path formatting

 Documentation/git-rev-parse.txt |  71 +++++++++++++---------
 abspath.c                       |  33 +++++++++-
 builtin/rev-parse.c             | 104 ++++++++++++++++++++++++++++----
 cache.h                         |   2 +
 t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
 5 files changed, 223 insertions(+), 44 deletions(-)

