Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0ABC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C7161131
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhDWQmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhDWQmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 12:42:23 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077CC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 09:41:47 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 3B14980590;
        Fri, 23 Apr 2021 12:41:44 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v3 0/3] fast-export, fast-import: implement signed-commits
Date:   Fri, 23 Apr 2021 10:41:15 -0600
Message-Id: <20210423164118.693197-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422002749.2413359-1-lukeshu@lukeshu.com>
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

(First of all, my apologies for neglecting to set the In-Reply-To on
the v2 patcheset.)

fast-export has an existing --signed-tags= flag that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

So implement a --signed-commits= flag in fast-export, and implement
the receiving side of it in fast-import.

I believe that this revision addresses all of the feedback so far,
with the exception that I have not implemented Elijah's suggestion to
implement a flag on fast-import to validate signatures.  While I agree
that this would be a useful feature, I consider it to be beyond the
scope of this work.

This passes all of the GitHub Actions CI checks, and passes all but
one of the Travis-CI checks; the failing Travis-CI check seems to be
an unrelated 404 from `apt-get`.
https://github.com/LukeShu/git/runs/2405123468

Luke Shumaker (3):
  git-fast-import.txt: add missing LF in the BNF
    v2: no changes
    v3: no changes
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
    v2:
     - Reword commit message, based on feedback from Taylor.
     - Fix copy-pasto in the test, noticed by Taylor.
     - Add a comment to the tests.
     - Fix whitespace in the tests.
    v3:
     - Document that --signed-tags='warn' is a deprecated synonym for
       --signed-tags='warn-verbatim', rather than leaving it
       undocumented, based on feedback from Eric.
  fast-export, fast-import: implement signed-commits
    v2:
     - Remove erroneous remark about ordering from the commit message.
     - Adjust the stream syntax to include the hash algorithm, as
       suggested by brian.
     - Add support for sha256 (based on lots of useful information from
       brian).  It does not support multiply-signed commits.
     - Shorten the documentation, based on feedback from Taylor.
     - Add comments, based on feedback from Taylor.
     - Change the default from `--signed-commits=strip` to
       `--signed-commits=warn-strip`.  This shouldn't break anyone, and
       means that users get useful feedback by default.
    v3: no changes

 Documentation/git-fast-export.txt |  13 +++-
 Documentation/git-fast-import.txt |  20 ++++-
 builtin/fast-export.c             | 123 ++++++++++++++++++++++++++----
 builtin/fast-import.c             |  23 ++++++
 t/t9350-fast-export.sh            |  88 +++++++++++++++++++++
 5 files changed, 247 insertions(+), 20 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
