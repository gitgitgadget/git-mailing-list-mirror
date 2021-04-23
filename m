Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E19C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBFB61131
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 16:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhDWQme (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:42:34 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:34798 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhDWQme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 12:42:34 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 106E780590;
        Fri, 23 Apr 2021 12:41:57 -0400 (EDT)
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
Subject: [PATCH v3 2/3] fast-export: rename --signed-tags='warn' to 'warn-verbatim'
Date:   Fri, 23 Apr 2021 10:41:17 -0600
Message-Id: <20210423164118.693197-3-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423164118.693197-1-lukeshu@lukeshu.com>
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
 <20210423164118.693197-1-lukeshu@lukeshu.com>
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
deprecated synonym of 'warn-verbatim'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Reword commit message based on feedback from Taylor.
 - Fix copy-pasto in the test, noticed by Taylor.
 - Add a comment to the tests.
 - Fix whitespace in the tests.
v3:
 - Document that --signed-tags='warn' is a deprecated synonym for
   --signed-tags='warn-verbatim', rather than leaving it
   undocumented, based on feedback from Eric.

 Documentation/git-fast-export.txt |  8 +++++---
 builtin/fast-export.c             |  2 +-
 t/t9350-fast-export.sh            | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 1978dbdc6a..c307839e81 100644
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
@@ -36,8 +36,10 @@ When asking to 'abort' (which is the default), this program will die
 when encountering a signed tag.  With 'strip', the tags will silently
 be made unsigned, with 'warn-strip' they will be made unsigned but a
 warning will be displayed, with 'verbatim', they will be silently
-exported and with 'warn', they will be exported, but you will see a
-warning.
+exported and with 'warn-verbatim', they will be exported, but you will
+see a warning.
++
+`warn` is a deprecated synonym of `warn-verbatim`.
 
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
index 409b48e244..892737439b 100755
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
+# 'warn' is an backward-compatibility alias for 'warn-verbatim'; test
+# that it keeps working.
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

