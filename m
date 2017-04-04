Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E9920966
	for <e@80x24.org>; Tue,  4 Apr 2017 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbdDDJQF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 05:16:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60286 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbdDDJQE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2017 05:16:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A484F2075C;
        Tue,  4 Apr 2017 05:16:03 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 04 Apr 2017 05:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=u/hClw
        aEdymSc+dP0RyRBYTc0hbegtMAr1h1S4YjUCI=; b=P/xsNl+ZgjXspjJWa6Qp+Z
        3n+eJtY70g2+7qZydgzoAFOr5iNzTJqJVcv1zqEHRkkZEfjcaSYzW7d9lKxnfLoO
        jXVV/MIvUvs862gCs6OwrmpeNjnggr8vxImDaUwXadtJrNCjq8+jIo7IQWnpPjdE
        Dk2POQPqHIisYoi//AGtdoCp6ofngeQ7EIM62VKttMDxAE5cxVtGdcX1piexnygU
        X2zb5r8QJBeKUp/ywTXRjY/wuE41BgYCe2DLVlXT9fhf+aK4VDi1R/w47a+oF+ht
        tk9aiQ84v6Npz8ldj70tUA4bFCFo3lixpNoeNPSuI3zD2UJjCAiEfnZhmlISKfyw
        ==
X-ME-Sender: <xms:U2TjWPF7JrwIKXTWpyfamLuILDh9LAWfXUjS5A3_StN4dnvnMxm_ng>
X-Sasl-enc: 0IMcn0RDsHkcPm/21s1sC4TR51c0LNBcRLHgUnzUWSnL 1491297363
Received: from localhost (unknown [46.189.27.162])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44A572436B;
        Tue,  4 Apr 2017 05:16:03 -0400 (EDT)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix
Date:   Tue,  4 Apr 2017 11:16:56 +0200
Message-Id: <4650e1396a5ad006b2b4f355685e3c59efd554d6.1491297393.git.ps@pks.im>
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

Fix the issue by again using the computed `match` variable when
`PATHSPEC_PREFIX_ORIGIN` is set and global literal pathspecs are
deactivated. Note that in contrast to previous behavior, we will now
always call `prefix_magic` regardless of whether a prefix is actually
set. But this is the right thing to do: when the `match` variable has
been resolved to the repository's root, it will be set to an empty
string. When passing the empty string directly to other commands, it
will result in a warning regarding deprecated empty pathspecs. By always
adding the prefix magic, we will end up with at least the string
":(prefix:0)" and thus avoid the warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This is the second version of [1]. It fixes a bug catched by
Brandon when the pathspec is resolved to the empty string and
improves the test a bit to actually catch this issue.

[1]: http://public-inbox.org/git/1556910880cfce391bdca2d8f0cbcb8c71371691.1491206540.git.ps@pks.im/T/#u


 pathspec.c                 |  2 +-
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 303efda83..3079a817a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -505,7 +505,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	 * original. Useful for passing to another command.
 	 */
 	if ((flags & PATHSPEC_PREFIX_ORIGIN) &&
-	    prefixlen && !get_literal_global()) {
+	    !get_literal_global()) {
 		struct strbuf sb = STRBUF_INIT;
 
 		/* Preserve the actual prefix length of each pattern */
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f9528fa00..2ecb43a61 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -436,6 +436,28 @@ test_expect_success 'add -p handles globs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p handles relative paths' '
+	git reset --hard &&
+
+	echo base >relpath.c &&
+	git add "*.c" &&
+	git commit -m relpath &&
+
+	echo change >relpath.c &&
+	mkdir -p subdir &&
+	git -C subdir add -p .. 2>error <<-\EOF &&
+	y
+	EOF
+
+	test_must_be_empty error &&
+
+	cat >expect <<-\EOF &&
+	relpath.c
+	EOF
+	git diff --cached --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'add -p does not expand argument lists' '
 	git reset --hard &&
 
-- 
2.12.2

