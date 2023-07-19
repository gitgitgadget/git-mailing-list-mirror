Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535FC001DC
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 11:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGSLi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 07:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSLi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 07:38:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B61FCD
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 04:38:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 821DD1A9BF;
        Wed, 19 Jul 2023 07:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=i
        wS9c50Eitdt+FoMgXCTw/pNxJx2LptKR6ehDm3fCy4=; b=YK22mv86DiJQqF/v4
        fcNblVWOnguTNlR+oIoV6R1yAMG21e/r7jMW0PNrYEk92rO+tNRYETkvtq+Ma7T7
        SsUCYfF2SSY5xCknHCdeDd1VUxIK2X0+YXauh89GiTmhuZCOyNqRTO90mzAvlWS3
        I7/Q0rE5UIezORGv+lwzBBYM+k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AB791A9BE;
        Wed, 19 Jul 2023 07:37:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F19741A9BC;
        Wed, 19 Jul 2023 07:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] show-branch: --no-sparse should give dense output
Date:   Wed, 19 Jul 2023 04:37:39 -0700
Message-ID: <xmqq7cqwcet8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB54894C-2628-11EE-98A6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git show-branch --no-sparse" behaved exactly the same way as "git
show-branch --sparse", which did not make any sense.  This was
because it used a variable "dense" initialized to 1 by default to
give "non sparse" behaviour, and OPT_SET_INT() to set the varilable
to 0 in response to the "--sparse" option.  Unfortunately,
OPT_SET_INT() sets 0 to the given variable when the option is
negated.

Flip the polarity of the variable "dense" by renaming it to "sparse"
and initializing it to 0, and have OPT_SET_INT() set the variable to
1 when "--sparse" is given.  This way, "--no-sparse" would set 0 to
the variable and would give us the "dense" behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/show-branch.c  |  8 ++++----
 t/t3202-show-branch.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7ef4a642c1..67f3ef0639 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -645,7 +645,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int with_current_branch = 0;
 	int head_at = -1;
 	int topics = 0;
-	int dense = 1;
+	int sparse = 0;
 	const char *reflog_base = NULL;
 	struct option builtin_show_branch_options[] = {
 		OPT_BOOL('a', "all", &all_heads,
@@ -672,8 +672,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    REV_SORT_IN_GRAPH_ORDER),
 		OPT_BOOL(0, "topics", &topics,
 			 N_("show only commits not on the first branch")),
-		OPT_SET_INT(0, "sparse", &dense,
-			    N_("show merges reachable from only one tip"), 0),
+		OPT_SET_INT(0, "sparse", &sparse,
+			    N_("show merges reachable from only one tip"), 1),
 		OPT_SET_INT(0, "date-order", &sort_order,
 			    N_("topologically sort, maintaining date order "
 			       "where possible"),
@@ -936,7 +936,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    !is_merge_point &&
 			    (this_flag & (1u << REV_SHIFT)))
 				continue;
-			if (dense && is_merge &&
+			if (!sparse && is_merge &&
 			    omit_in_dense(commit, rev, num_rev))
 				continue;
 			for (i = 0; i < num_rev; i++) {
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index be20ebe1d5..ca7c44f0f7 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -119,6 +119,22 @@ test_expect_success 'show branch --remotes' '
 	test_must_be_empty actual.out
 '
 
+test_expect_success 'show-branch --sparse' '
+	test_when_finished "git checkout branch10 && git branch -D branchA" &&
+	git checkout -b branchA branch10 &&
+	git merge -s ours -m "merge 1 and 10 to make A" branch1 &&
+	git commit --allow-empty -m "another" &&
+
+	git show-branch --sparse >out &&
+	grep "merge 1 and 10 to make A" out &&
+
+	git show-branch >out &&
+	! grep "merge 1 and 10 to make A" out &&
+
+	git show-branch --no-sparse >out &&
+	! grep "merge 1 and 10 to make A" out
+'
+
 test_expect_success 'setup show branch --list' '
 	sed "s/^> //" >expect <<-\EOF
 	>   [branch1] branch1
-- 
2.41.0-376-gcba07a324d

