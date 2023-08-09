Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC3FC04A94
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHIRPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHIRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:37 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5098D1FEF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:35 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D6F2E24311;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lE1-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/2] sequencer: beautify subject of reverts of reverts
Date:   Wed,  9 Aug 2023 19:15:30 +0200
Message-Id: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of generating a silly-looking `Revert "Revert "foo""`, make it
a more humane `Reapply "foo"`.

This is done for two reasons:
- To cover the actually common case of just a double revert.
- To encourage people to rewrite summaries of recursive reverts by
  setting an example (a subsequent commit will also do this explicitly
  in the documentation).

To achieve these goals, the mechanism does not need to be particularly
sophisticated. Therefore, more complicated alternatives which would
"compress more efficiently" have not been implemented.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v3:
- capitulate at first sight of a pre-existing recursive reversion, as
  handling the edge cases is a bottomless pit
- reworked commit message again
- moved test into existing file
- generalized docu change and factored it out

v2:
- add discussion to commit message
- add paragraph to docu
- add test
- use skip_prefix() instead of starts_with()
- catch pre-existing double reverts

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 sequencer.c                   | 11 +++++++++++
 t/t3501-revert-cherry-pick.sh | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index cc9821ece2..12ec158922 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2249,13 +2249,24 @@ static int do_pick_commit(struct repository *r,
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
+		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
+			   /*
+			    * We don't touch pre-existing repeated reverts, because
+			    * theoretically these can be nested arbitrarily deeply,
+			    * thus requiring excessive complexity to deal with.
+			    */
+			   !starts_with(orig_subject, "Revert \"")) {
+			strbuf_addstr(&msgbuf, "Reapply \"");
+			strbuf_addstr(&msgbuf, orig_subject);
 		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index e2ef619323..7011e3a421 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -176,6 +176,31 @@ test_expect_success 'advice from failed revert' '
 	test_cmp expected actual
 '
 
+test_expect_success 'title of fresh reverts' '
+	test_commit --no-tag A file1 &&
+	test_commit --no-tag B file1 &&
+	git revert --no-edit HEAD &&
+	echo "Revert \"B\"" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual &&
+	git revert --no-edit HEAD &&
+	echo "Reapply \"B\"" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual &&
+	git revert --no-edit HEAD &&
+	echo "Revert \"Reapply \"B\"\"" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'title of legacy double revert' '
+	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
+	git revert --no-edit HEAD &&
+	echo "Revert \"Revert \"Revert \"B\"\"\"" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'identification of reverted commit (default)' '
 	test_commit to-ident &&
 	test_when_finished "git reset --hard to-ident" &&
-- 
2.40.0.152.g15d061e6df

