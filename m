Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CC0EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 18:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGRS2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGRS1w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 14:27:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4FF4
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 11:27:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 048DB199A86;
        Tue, 18 Jul 2023 14:27:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=x
        lvH2dS0gD79Pp14SO9/0Xuq0afpwtam9+BJKL0W2TA=; b=M5/ArysgnZ08i16M1
        t1o2vygcBAARq2ydyqmAfTq6CyB+NBT9GkHTUafktC6Ip+OF1yTLSuRjoUf/wAcX
        e/K68H+3jVOcNpCHBovLmOq3nDNIUJO5566u55fKFdPzsZ06X74emOWQq6u+9PMu
        oQuWFyHp70r3Y7pqvUDtVL1z4Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0795199A85;
        Tue, 18 Jul 2023 14:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60067199A84;
        Tue, 18 Jul 2023 14:27:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] branch: reject "--no-all" and "--no-remotes" early
Date:   Tue, 18 Jul 2023 11:27:49 -0700
Message-ID: <xmqqjzuxgjmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD439038-2598-11EE-9E52-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the command line parser for "git branch --all" forgets to use
PARSE_OPT_NONEG, it accepted "git branch --no-all", and then passed
a nonsense value to the underlying machinery, leading to a fatal
error "filter_refs: invalid type".  The "--remotes" option had
exactly the same issue.

Catch the unsupported options early in the option parser.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/branch.c         | 10 ++++++----
 t/t3203-branch-output.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a27bc0a3df..518be060c5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -720,8 +720,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
-		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
-			FILTER_REFS_REMOTES),
+		OPT_SET_INT_F('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
+			      FILTER_REFS_REMOTES,
+			      PARSE_OPT_NONEG),
 		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only branches that don't contain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only branches that contain the commit")),
@@ -729,8 +730,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&filter.abbrev),
 
 		OPT_GROUP(N_("Specific git-branch actions:")),
-		OPT_SET_INT('a', "all", &filter.kind, N_("list both remote-tracking and local branches"),
-			FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES),
+		OPT_SET_INT_F('a', "all", &filter.kind, N_("list both remote-tracking and local branches"),
+			      FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES,
+			      PARSE_OPT_NONEG),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 93f8295339..758963b189 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -55,9 +55,17 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'git branch -r shows remote branches' '
 	git branch -r >actual &&
+	test_cmp expect actual &&
+
+	git branch --remotes >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --no-remotes is rejected' '
+	test_must_fail git branch --no-remotes 2>err &&
+	grep "unknown option .no-remotes." err
+'
+
 cat >expect <<'EOF'
   branch-one
   branch-two
@@ -68,9 +76,17 @@ cat >expect <<'EOF'
 EOF
 test_expect_success 'git branch -a shows local and remote branches' '
 	git branch -a >actual &&
+	test_cmp expect actual &&
+
+	git branch --all >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --no-all is rejected' '
+	test_must_fail git branch --no-all 2>err &&
+	grep "unknown option .no-all." err
+'
+
 cat >expect <<'EOF'
 two
 one
-- 
2.41.0-376-gcba07a324d

