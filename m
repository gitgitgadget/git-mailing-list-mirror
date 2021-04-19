Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF60C43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B27D6113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhDSXFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhDSXFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:05:08 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Apr 2021 16:04:38 PDT
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010D8C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 16:04:37 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [8.42.69.49])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 41DA080592;
        Mon, 19 Apr 2021 18:54:58 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
Date:   Mon, 19 Apr 2021 16:54:40 -0600
Message-Id: <20210419225441.3139048-3-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419225441.3139048-1-lukeshu@lukeshu.com>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

But still keep --signed-tags=warn as an undocumented alias.  This name
is clearer as it has symmetry with warn-strip:

                   action              ->                   action
       +----------------------------+  ->       +----------------------------+
  msg? |      verbatim |      strip |  ->  msg? |      verbatim |      strip |
       |          warn | warn-strip |  ->       | warn-verbatim | warn-strip |
       +----------------------------+  ->       +----------------------------+

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 Documentation/git-fast-export.txt |  6 +++---
 builtin/fast-export.c             |  2 +-
 t/t9350-fast-export.sh            | 12 ++++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6a..d4a2bfe037 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Insert 'progress' statements every <n> objects, to be shown by
 	'git fast-import' during import.
 
---signed-tags=(verbatim|warn|warn-strip|strip|abort)::
+--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
 	after the export can change the tag names (which can also happen
 	when excluding revisions) the signatures will not match.
@@ -36,8 +36,8 @@ When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
-exported and with 'warn', they will be exported, but you will see a
-warning.
+exported and with 'warn-verbatim', they will be exported, but you will
+see a warning.
 
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85a76e0ef8..d121dd2ee6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -55,7 +55,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 		signed_tag_mode = SIGNED_TAG_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
 		signed_tag_mode = VERBATIM;
-	else if (!strcmp(arg, "warn"))
+	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
 		signed_tag_mode = WARN;
 	else if (!strcmp(arg, "warn-strip"))
 		signed_tag_mode = WARN_STRIP;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 409b48e244..db0e58b1e8 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -253,6 +253,18 @@ test_expect_success 'signed-tags=verbatim' '
 
 '
 
+test_expect_success 'signed-tags=warn' '
+	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+'
+
+test_expect_success 'signed-tags=warn-verbatim' '
+	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+'
+
 test_expect_success 'signed-tags=strip' '
 
 	git fast-export --signed-tags=strip sign-your-name > output &&
-- 
2.31.1

