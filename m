Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FECC43460
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5075661428
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhDVBIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 21:08:07 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:60124 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233982AbhDVBIB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 21:08:01 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:527b:9dff:fe2b:180a])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 9777F80590;
        Wed, 21 Apr 2021 21:07:25 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 0/3] fast-export, fast-import: let tags specify a different refname
Date:   Wed, 21 Apr 2021 19:06:56 -0600
Message-Id: <20210422010659.2498280-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

After receiving positive feedback on the RFC, here's the polished-up
v1.

This patchset adds an optional "refname" sub-command to fast-import's "tag"
top-level-command; the stream

    tag foo
    refname refs/tags/bar
    ...

will create a tag at "refs/tags/bar" that says "tag foo" internally.
If there is no "refname" line, it will continue with the existing
behavior of using "refs/tags/<tagname>" as the refname.

This makes it now-possible for fast-export/fast-import to represent
tags for which the internal tagname and the refname disagree.  It also
adds support for tags with refnames that do not begin with
"refs/tags/".  I discuss the motivation for supporting this in the
commit message of the 3rd patch.

Changes from the RFC:

 - I've flipped it around; the existing `tag` line now specifices the
   tagname, and the added `refname` line now specifies the refname
   (rather than having the `tag` line specify the suffix of the
   refname, and the added `name` line specify the tagname).  This
   allows for tags whose refnames to not begin with "refs/tags/".
 - I've added prose documentation, rather than just updating the BNF.
   (The wording is based on what Junio suggested on the RFC.)
 - I added tests.
 - After responding to feedback, I ended up with just enough "moving
   and renaming things" noise that in the single commit that for v1 I
   split that out in to a econd commit.
 - While implementing the tests, I discovered a pre-existing bug with
   nested tags, so I added a separate third commit to fix that.

This passes all of the GitHub Actions CI checks, and passes all but
one of the Travis-CI checks; the failing Travis-CI check seems to be
an unrelated 404 from `apt-get`.
https://github.com/LukeShu/git/runs/2405478827

[1]: https://lore.kernel.org/git/Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org/

Luke Shumaker (3):
  fast-export, fast-import: make stylistic changes
  fast-export: fix bug with nested tags
  fast-export, fast-import: let tags specify a different refname

 Documentation/git-fast-import.txt | 22 +++++++++------
 builtin/fast-export.c             | 47 ++++++++++++++++++++++++++-----
 builtin/fast-import.c             | 47 +++++++++++++++++++------------
 t/t9350-fast-export.sh            | 20 ++++++++++---
 4 files changed, 98 insertions(+), 38 deletions(-)

-- 
2.31.1

Happy hacking,
~ Luke Shumaker
