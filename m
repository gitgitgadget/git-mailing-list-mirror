Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325EC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0248061409
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbhDVAfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDVAfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 20:35:24 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC52C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 17:34:50 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (c-73-229-136-185.hsd1.co.comcast.net [73.229.136.185])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 6D3C880590;
        Wed, 21 Apr 2021 20:34:48 -0400 (EDT)
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
Subject: [PATCH v2 2/3] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
Date:   Wed, 21 Apr 2021 18:27:48 -0600
Message-Id: <20210422002749.2413359-3-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422002749.2413359-1-lukeshu@lukeshu.com>
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

The --signed-tags= option takes one of five arguments specifying how to
handle signed tags during export.  Among these arguments, 'strip' is to
'warn-strip' as 'verbatim' is to 'warn' (the unmentioned argument is
'abort', which stops the fast-export process entirely).  That is,
signatures are either stripped or copied verbatim while exporting, with
or without a warning.

Match the pattern and rename 'warn' to 'warn-verbatim' to make it clear
that it instructs fast-export to copy signatures verbatim.

To maintain backwards compatibility, 'warn' is still recognized as
an undocumented alias.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Reword commit message based on feedback from Taylor.
 - Fix copy-pasto in the test, noticed by Taylor.
 - Add a comment to the tests.
 - Fix whitespace in the tests.

 Documentation/git-fast-export.txt |  6 +++---
 builtin/fast-export.c             |  2 +-
 t/t9350-fast-export.sh            | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index 409b48e244..36b84eff36 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -253,6 +253,24 @@ test_expect_success 'signed-tags=verbatim' '
 
 '
 
+test_expect_success 'signed-tags=warn-verbatim' '
+
+	git fast-export --signed-tags=warn-verbatim sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
+# 'warn' is an undocumented alias for 'warn-verbatim', for backward
+# compatibility; test that it keeps working.
+test_expect_success 'signed-tags=warn' '
+
+	git fast-export --signed-tags=warn sign-your-name >output 2>err &&
+	grep PGP output &&
+	test -s err
+
+'
+
 test_expect_success 'signed-tags=strip' '
 
 	git fast-export --signed-tags=strip sign-your-name > output &&
-- 
2.31.1

