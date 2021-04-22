Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33993C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C1161445
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbhDVAbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:31:02 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:60042 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhDVAbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 20:31:02 -0400
Received: from lukeshu-dw-thinkpad (c-73-229-136-185.hsd1.co.comcast.net [73.229.136.185])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 8361A80590;
        Wed, 21 Apr 2021 20:30:27 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 0/3] fast-export, fast-import: implement signed-commits
Date:   Wed, 21 Apr 2021 18:27:46 -0600
Message-Id: <20210422002749.2413359-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

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

This passes all of the GitHub actions CI checks, and passes all but
one of the Travis-CI checks; the failing Travis-CI check seems to be
an unrelated 404 from `apt-get`.
https://github.com/LukeShu/git/runs/2405123468

Luke Shumaker (3):
  git-fast-import.txt: add missing LF in the BNF
    v2: no changes
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
    v2:
     - Reword commit message, based on feedback from Taylor.
     - Fix copy-pasto in the test, noticed by Taylor.
     - Add a comment to the tests.
     - Fix whitespace in the tests.
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

 Documentation/git-fast-export.txt |  11 ++-
 Documentation/git-fast-import.txt |  20 ++++-
 builtin/fast-export.c             | 123 ++++++++++++++++++++++++++----
 builtin/fast-import.c             |  23 ++++++
 t/t9350-fast-export.sh            |  88 +++++++++++++++++++++
 5 files changed, 245 insertions(+), 20 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
