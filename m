Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4DD20964
	for <e@80x24.org>; Mon,  3 Apr 2017 08:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdDCIEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 04:04:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51720 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751841AbdDCIDF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2017 04:03:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B873C207C7;
        Mon,  3 Apr 2017 04:03:03 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 03 Apr 2017 04:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=aroqyE
        NZPUPaiI0hCXam6ohBFPXrYJOTMCozeWiHiiA=; b=rWEgP5MfSnVWK7VPgcJ7om
        FxLbU03B3LOyEmNk/uwiHg/7JssIJU8v9VBk0UiAviwZ/3w1wtMbSc1IY+f4rqtM
        R1OFDKyrksGZQhYlJaw+7tEwUkOE4J6MqYNvdckpedEgvAOK0rxCeOyuuvS8lV33
        /oeVbMqeokaY/WF6gePfkU41xSMLB8moEA3asyclEp+ad7JrwruCuJC79pRP1Jkg
        j6hnuDGFQDKYyrWLI2gXCk+xllEtU8fcTJ4c9YVlsTiFIBKIYpgnXIoRW0PAaTSu
        5PmNVgaLJcTozikHJa8k1f0vytDkEm9U6jT2a50dVlxPFHuDhxDoThACLKVws6dQ
        ==
X-ME-Sender: <xms:twHiWHCmM47MUUhMv_dO-lwM_jX6CJHTgJnfAr3FAHkWH1Ac1BDJVA>
X-Sasl-enc: UMEqJSVMWOTI/s8d4voV0/ek8UbO07aZxgbQV9V2VGbC 1491206583
Received: from localhost (x4e3446a7.dyn.telefonica.de [78.52.70.167])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F26E240B2;
        Mon,  3 Apr 2017 04:03:03 -0400 (EDT)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH] pathspec: always honor `PATHSPEC_PREFIX_ORIGIN` flag
Date:   Mon,  3 Apr 2017 10:03:02 +0200
Message-Id: <1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous to commit 5d8f084a5 (pathspec: simpler logic to prefix original
pathspec elements, 2017-01-04), we were always using the computed
`match` variable to perform pathspec matching whenever
`PATHSPEC_PREFIX_ORIGIN` is set. This is for example useful when passing
the parsed pathspecs to other commands, as the computed `match` may
contain a pathspec relative to the repository root. The commit changed
this logic to only do so when we do have an actual prefix and when
literal pathspecs are deactivated.

But this change may actually break some commands which expect passed
pathspecs to be relative to the repository root. One such case is `git
add --patch`, which now fails when using relative paths from a
subdirectory. For example if executing "git add -p ../foo.c" in a
subdirectory, the `git-add--interactive` command will directly pass
"../foo.c" to `git-ls-files`. As ls-files is executed at the
repository's root, the command will notice that "../foo.c" is outside
the repository and fail.

Fix the issue by again using the computed `match` variable whenever
`PATHSPEC_PREFIX_ORIGIN` is set. This restores behavior previous to
5d8f084a5 and fixes interactive add.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pathspec.c                 |  6 +++---
 t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 303efda83..3193e45a6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -504,12 +504,12 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
 	 */
-	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
-	    prefixlen && !get_literal_global()) {
+	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb = STRBUF_INIT;
 
 		/* Preserve the actual prefix length of each pattern */
-		prefix_magic(&sb, prefixlen, element_magic);
+		if (prefixlen && !get_literal_global())
+			prefix_magic(&sb, prefixlen, element_magic);
 
 		strbuf_addstr(&sb, match);
 		item->original = strbuf_detach(&sb, NULL);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f9528fa00..640088dd6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -436,6 +436,26 @@ test_expect_success 'add -p handles globs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p handles relative paths' '
+	git reset --hard &&
+
+	echo base >root.c &&
+	git add "*.c" &&
+	git commit -m base &&
+
+	echo change >root.c &&
+	mkdir -p subdir &&
+	git -C subdir add -p "../root.c" <<-\EOF &&
+	y
+	EOF
+
+	cat >expect <<-\EOF &&
+	root.c
+	EOF
+	git diff --cached --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'add -p does not expand argument lists' '
 	git reset --hard &&
 
-- 
2.12.2

