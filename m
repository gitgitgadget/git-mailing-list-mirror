Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A2EC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjD1Ifg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD1Iff (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 04:35:35 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE46B210B
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 01:35:30 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C5564241BC;
        Fri, 28 Apr 2023 04:35:28 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psJZg-82w-00; Fri, 28 Apr 2023 10:35:28 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] sequencer: beautify subject of reverts of reverts
Date:   Fri, 28 Apr 2023 10:35:28 +0200
Message-Id: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of generating a silly-looking `Revert "Revert "foo""`, make it
a more humane `Reapply "foo"`.

The alternative `Revert^2 "foo"`, etc. was considered, but it was deemed
over-engineered and "too nerdy". Instead, people should get creative
with the subjects when they recurse reverts that deeply. The proposed
change encourages that by example and explicit recommendation.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
v2:
- add discussion to commit message
- add paragraph to docu
- add test
- use skip_prefix() instead of starts_with()
- catch pre-existing double reverts
---
 Documentation/git-revert.txt |  6 ++++++
 sequencer.c                  | 14 ++++++++++++++
 t/t3515-revert-subjects.sh   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100755 t/t3515-revert-subjects.sh

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index d2e10d3dce..e8fa513607 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -31,6 +31,12 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+The command generates the subject 'Revert "<title>"' for the resulting
+commit, assuming the original commit's subject is '<title>'.  Reverting
+such a reversion commit in turn yields the subject 'Reapply "<title>"'.
+These can of course be modified in the editor when the reason for
+reverting is described.
+
 OPTIONS
 -------
 <commit>...::
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..61e466470e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2227,13 +2227,27 @@ static int do_pick_commit(struct repository *r,
 	 */
 
 	if (command == TODO_REVERT) {
+		const char *orig_subject;
+
 		base = commit;
 		base_label = msg.label;
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
 			strbuf_addstr(&msgbuf,
 				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject)) {
+			if (skip_prefix(orig_subject, "Revert \"", &orig_subject)) {
+				/*
+				 * This prevents the generation of somewhat unintuitive (even if
+				 * not incorrect) 'Reapply "Revert "' titles from legacy double
+				 * reverts. Fixing up deeper recursions is left to the user.
+				 */
+				strbuf_addstr(&msgbuf, "Revert \"Reapply \"");
+			} else {
+				strbuf_addstr(&msgbuf, "Reapply \"");
+			}
+			strbuf_addstr(&msgbuf, orig_subject);
 		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
diff --git a/t/t3515-revert-subjects.sh b/t/t3515-revert-subjects.sh
new file mode 100755
index 0000000000..ea4319fd15
--- /dev/null
+++ b/t/t3515-revert-subjects.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git revert produces the expected subject'
+
+. ./test-lib.sh
+
+test_expect_success 'fresh reverts' '
+    test_commit --no-tag A file1 &&
+    test_commit --no-tag B file1 &&
+    git revert --no-edit HEAD &&
+    echo "Revert \"B\"" > expect &&
+    git log -1 --pretty=%s > actual &&
+    test_cmp expect actual &&
+    git revert --no-edit HEAD &&
+    echo "Reapply \"B\"" > expect &&
+    git log -1 --pretty=%s > actual &&
+    test_cmp expect actual &&
+    git revert --no-edit HEAD &&
+    echo "Revert \"Reapply \"B\"\"" > expect &&
+    git log -1 --pretty=%s > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'legacy double revert' '
+    test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
+    git revert --no-edit HEAD &&
+    echo "Revert \"Reapply \"B\"\"" > expect &&
+    git log -1 --pretty=%s > actual &&
+    test_cmp expect actual
+'
+
+test_done
-- 
2.40.0.152.g15d061e6df

