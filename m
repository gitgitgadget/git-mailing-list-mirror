Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D932EEB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjGSNho (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGSNhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 09:37:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C5E5
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 06:37:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF86C191D2B;
        Wed, 19 Jul 2023 09:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=P
        x3dFrXqlgyDCjsJrpF3FOce/Dpsepz2oazjamOYkns=; b=hY1hKfCnCwgYbpWbR
        wyjGQedEkC1Mt+RmwiK85LmkqY1gpiC9o9wONQ30ah6p/nFNOL1M9HFqBwliJ7mG
        4XEJUa0VfT5SEV3ttdqKcJ0j7F+PMIcTnkBy+HUqkckMvgTANXpJLw5mxQbxTiXr
        HOM9CdgAHvPHYgMHHK5SaRNT5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A86F7191D2A;
        Wed, 19 Jul 2023 09:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1534B191D28;
        Wed, 19 Jul 2023 09:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] reset: reject --no-(mixed|soft|hard|merge|keep) option
Date:   Wed, 19 Jul 2023 06:37:39 -0700
Message-ID: <xmqq1qh4c998.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EEC3D04-2639-11EE-BF5D-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git reset --no-mixed" behaved exactly like "git reset --mixed",
which was nonsense.

If there were only two kinds, e.g. "mixed" vs "separate", it might
have made sense to make "git reset --no-mixed" behave identically to
"git reset --separate" and vice-versa, but because we have many
types of reset, lets just forbid "--no-mixed" and negated form of
other types.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reset.c  | 29 ++++++++++++++++++-----------
 t/t7102-reset.sh | 10 ++++++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index f99f32d580..ac4901e003 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -334,18 +334,25 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "no-refresh", &no_refresh,
 				N_("skip refreshing the index after reset")),
-		OPT_SET_INT(0, "mixed", &reset_type,
-						N_("reset HEAD and index"), MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
-		OPT_SET_INT(0, "hard", &reset_type,
-				N_("reset HEAD, index and working tree"), HARD),
-		OPT_SET_INT(0, "merge", &reset_type,
-				N_("reset HEAD, index and working tree"), MERGE),
-		OPT_SET_INT(0, "keep", &reset_type,
-				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_SET_INT_F(0, "mixed", &reset_type,
+			      N_("reset HEAD and index"),
+			      MIXED, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "soft", &reset_type,
+			      N_("reset only HEAD"),
+			      SOFT, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "hard", &reset_type,
+			      N_("reset HEAD, index and working tree"),
+			      HARD, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "merge", &reset_type,
+			      N_("reset HEAD, index and working tree"),
+			      MERGE, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "keep", &reset_type,
+			      N_("reset HEAD but keep local changes"),
+			      KEEP, PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "reset", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+			       "reset", "control recursive updating of submodules",
+			       PARSE_OPT_OPTARG,
+			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 22477f3a31..4287863ae6 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -71,6 +71,16 @@ check_changes () {
	done | test_cmp .cat_expect -
 }
 
+# no negated form for various type of resets
+for opt in soft mixed hard merge keep
+do
+	test_expect_success "no 'git reset --no-$opt'" '
+		test_when_finished "rm -f err" &&
+		test_must_fail git reset --no-$opt 2>err &&
+		grep "error: unknown option .no-$opt." err
+	'
+done
+
 test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard >.actual &&
-- 
2.41.0-376-gcba07a324d

