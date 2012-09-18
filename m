From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [RFC PATCH] add t3420-rebase-topology
Date: Mon, 17 Sep 2012 23:31:18 -0700
Message-ID: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 08:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrLL-0002uH-0y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab2IRGb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:31:26 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:45186 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2IRGbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:31:25 -0400
Received: by eaac1 with SMTP id c1so438635eaa.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 23:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=o2F0sO+aQgiJsBLj5pnZHREN8FZyY30RJ2vTry0x/SA=;
        b=Lg0U33SnoziAYXm9Gf+tfYtRFa/RtexMR25yWtjktrJPVO8JXdUgaM0UcokQvEWbjb
         p6kivulrcvIbBtV3ATg2TwUz6ivKwCmeXRIeURXwifSwo4SkD9BiIQA7NbZSggqPT/Be
         cX5ey+mjVO/PtzBkCdqqLLzqdooQ5XhYP/xiw5mf3YsY9zQjWi58/wX1tKRe2vvf9bsp
         lbbeZ6KPbz8oySX4xCQSaZFCeBT7pD8D7/ERGmHj9IpTepg5sTRjpbOd45QZNeynXYc3
         jI+M8dftxRfCPTWGaYOFZIQHaCCHhCdRjzMFNaQjU0H/ZyOs54HkpSW4kX32A8y+XQyf
         cvwA==
Received: by 10.180.107.167 with SMTP id hd7mr2239377wib.0.1347949882812;
        Mon, 17 Sep 2012 23:31:22 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id hm1si2142758wib.3.2012.09.17.23.31.22
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 17 Sep 2012 23:31:22 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 42E1D20004E;
	Mon, 17 Sep 2012 23:31:22 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A220EC2AC0; Mon, 17 Sep 2012 23:31:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
X-Gm-Message-State: ALoCoQnQ19AKrvQ2YWx7cOO4kr82nb+5CCpPR528gRQlCFgCqpgzA1VdqUKhUbsIBVpE6edAmsac1VmfJiwKVeJGJZLrlue2aAgq7VnlY2UbJX8nKLHBlye6DYMz2thpCbZuiTMM+TKcNEQecq5LhnRckjrnII+IJBvBeyj84ntDhCj7whTxJ1o3O6fhqHjv7bJHZNMkpsq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205796>

Add more test cases to check that the topology after a rebase is as
expected. Conflicts are not considered, but patch-equivalence is.
---

Tests pass and fail as indicated by the suffix
(_success/_failure). Your input especially appreciated on whether you
agree with the intent of the test cases. For example, do you agree
that 'rebase --onto does not re-apply patches in onto' is desirable?
And if you do, then do you also agree that 'rebase --root --onto
ignores patch in onto' is desirable? How about 'rebase --root is not a
no-op'? One might think that --force would be necessary, but on the
other hand, if that was the case, the only point (AFAICT) of "git
rebase --root <branch>" without --force would be to linearize history,
so I instead made the test case confirm that --root without --onto
effectively behaves as if --force was also passed.

Feedback on the structure/setup and style is of course also
appreciated.

 t/t3420-rebase-topology.sh | 348 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 348 insertions(+)
 create mode 100755 t/t3420-rebase-topology.sh

diff --git a/t/t3420-rebase-topology.sh b/t/t3420-rebase-topology.sh
new file mode 100755
index 0000000..024a2b4
--- /dev/null
+++ b/t/t3420-rebase-topology.sh
@@ -0,0 +1,348 @@
+#!/bin/sh
+
+test_description='effect of rebase on topology'
+. ./test-lib.sh
+
+
+#       q---C---r
+#      /
+# a---b---c---d!--e---p
+#      \
+#       f---g!--h
+#        \
+#         j-------E---k
+#          \       \
+#           n---H---w
+#
+# x---y---B
+#
+#
+# ! = empty
+# uppercase = cherry-picked
+# p = reverted e
+#
+# TODO:
+# prune graph to what's needed
+
+empty () {
+	git commit --allow-empty -m $1 &&
+	git tag $1
+}
+
+cherry_pick () {
+	git cherry-pick -n $1 &&
+	git commit -m $2 &&
+	git tag $2
+}
+
+revert () {
+	git revert -n $1 &&
+	git commit -m $2 &&
+	git tag $2
+}
+
+
+test_expect_success 'setup' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	empty d &&
+	test_commit e &&
+	revert e p &&
+	git checkout b &&
+	test_commit f &&
+	empty g &&
+	test_commit h &&
+	git checkout f &&
+	test_commit j &&
+	cherry_pick e E &&
+	test_commit k &&
+	git checkout j &&
+	test_commit n &&
+	cherry_pick h H &&
+	git merge -m w E &&
+	git tag w &&
+	git checkout b &&
+	test_commit q &&
+	cherry_pick c C &&
+	test_commit r &&
+	git checkout --orphan disjoint &&
+	git rm -rf . &&
+	test_commit x &&
+	test_commit y &&
+	cherry_pick b B
+'
+
+reset () {
+	git rebase --abort
+	git reset --hard
+}
+
+test_range () {
+	test "$(git log --reverse --topo-order --format=%s "$1" | xargs)" = "$2"
+}
+
+test_revisions () {
+	expected="$1"
+	shift
+	test "$(git log --format=%s --no-walk=unsorted "$@" | xargs)" = "$expected"
+}
+
+same_revision () {
+	test "$(git rev-parse $1)" = "$(git rev-parse $2)"
+}
+
+# the following 5 (?) tests copy t3400 tests, but check the history rather than status code and/or stdout
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' c j &&
+	same_revision HEAD~2 c &&
+	test_range c.. "f j"
+'
+}
+test_expect_success 'simple rebase' "$(run)"
+test_expect_success 'simple rebase -m' "$(run -m)"
+test_expect_success 'simple rebase -i' "$(run -i)"
+test_expect_success 'simple rebase -p' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' b j &&
+	same_revision HEAD j
+'
+}
+test_expect_success 'rebase is no-op if upstream is an ancestor' "$(run)"
+test_expect_success 'rebase -m is no-op if upstream is an ancestor' "$(run -m)"
+test_expect_success 'rebase -i is no-op if upstream is an ancestor' "$(run -i)"
+test_expect_success 'rebase -p is no-op if upstream is an ancestor' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --force b j &&
+	! same_revision HEAD j &&
+	test_range b.. "f j"
+'
+}
+test_expect_success 'rebase --force' "$(run)"
+test_expect_success 'rebase -m --force' "$(run -m)"
+test_expect_success 'rebase -i --force' "$(run -i)"
+test_expect_failure 'rebase -p --force' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' j b &&
+	same_revision HEAD j
+'
+}
+test_expect_success 'rebase fast-forwards if an ancestor of upstream' "$(run)"
+test_expect_success 'rebase -m fast-forwards if an ancestor of upstream' "$(run -m)"
+test_expect_success 'rebase -i fast-forwards if an ancestor of upstream' "$(run -i)"
+test_expect_success 'rebase -p fast-forwards if an ancestor of upstream' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' p k &&
+	test_range p.. "f j k"
+'
+}
+test_expect_success 'rebase ignores patch in upstream' "$(run)"
+test_expect_failure 'rebase -m ignores patch in upstream' "$(run -m)"
+test_expect_success 'rebase -i ignores patch in upstream' "$(run -i)"
+test_expect_success 'rebase -p ignores patch in upstream' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' c h &&
+	test_range c.. "f h"
+'
+}
+test_expect_success 'rebase ignores empty commit' "$(run)"
+test_expect_success 'rebase -m ignores empty commit' "$(run -m)"
+test_expect_success 'rebase -i ignores empty commit' "$(run -i)"
+test_expect_success 'rebase -p ignores empty commit' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --keep-empty c h &&
+	test_range c.. "f g h"
+'
+}
+test_expect_success 'rebase --keep-empty' "$(run)"
+test_expect_failure 'rebase -m --keep-empty' "$(run -m)"
+test_expect_success 'rebase -i --keep-empty' "$(run -i)"
+test_expect_failure 'rebase -p --keep-empty' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --keep-empty p h &&
+	test_range p.. "f g h"
+'
+}
+test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' "$(run)"
+test_expect_failure 'rebase -m --keep-empty keeps empty even if already in upstream' "$(run -m)"
+test_expect_failure 'rebase -i --keep-empty keeps empty even if already in upstream' "$(run -i)"
+test_expect_failure 'rebase -p --keep-empty keeps empty even if already in upstream' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' E w &&
+	test_range E.. "n H"
+'
+}
+test_expect_success 'rebase after merge' "$(run)"
+test_expect_success 'rebase -m after merge' "$(run -m)"
+test_expect_success 'rebase -i after merge' "$(run -i)"
+
+test_expect_success 'rebase -p is no-op in history with merges' '
+	reset &&
+	git rebase -p j w &&
+	same_revision HEAD w
+'
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' j w &&
+	test_range j.. "E n H" || test_range j.. "n H E"
+'
+}
+test_expect_success 'rebase of history with merges is linearized' "$(run)"
+test_expect_success 'rebase -m of history with merges is linearized' "$(run -m)"
+test_expect_success 'rebase -i of history with merges is linearized' "$(run -i)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --onto p h k &&
+	test_range p.. "j k"
+'
+}
+test_expect_failure 'rebase --onto does not re-apply patches in onto' "$(run)"
+test_expect_failure 'rebase -m --onto does not re-apply patches in onto' "$(run -m)"
+test_expect_failure 'rebase -i --onto does not re-apply patches in onto' "$(run -i)"
+test_expect_failure 'rebase -p --onto does not re-apply patches in onto' "$(run -p)"
+
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --onto f d r &&
+	test_range f.. "q C r"
+'
+}
+test_expect_failure 'rebase --onto does not lose patches in upstream' "$(run)"
+test_expect_success 'rebase -m --onto does not lose patches in upstream' "$(run -m)"
+test_expect_failure 'rebase -i --onto does not lose patches in upstream' "$(run -i)"
+test_expect_failure 'rebase -p --onto does not lose patches in upstream' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --root c &&
+	! same_revision HEAD c &&
+	test_range c "a b c"
+'
+}
+test_expect_success 'rebase --root is not a no-op' "$(run)"
+test_expect_success 'rebase -m --root is not a no-op' "$(run -m)"
+test_expect_success 'rebase -i --root is not a no-op' "$(run -i)"
+test_expect_success 'rebase -p --root is not a no-op' "$(run -p)"
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --root --onto e y &&
+	test_range e.. "x y"
+'
+}
+test_expect_success 'rebase --root --onto' "$(run)"
+test_expect_failure 'rebase -m --root --onto' "$(run -m)"
+test_expect_success 'rebase -i --root --onto' "$(run -i)"
+test_expect_success 'rebase -p --root --onto' "$(run -p)"
+
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --root --onto e B &&
+	test_range e.. "x y"
+'
+}
+test_expect_success 'rebase --root --onto ignores patch in onto' "$(run)"
+test_expect_failure 'rebase -m --root --onto ignores patch in onto' "$(run -m)"
+test_expect_success 'rebase -i --root --onto ignores patch in onto' "$(run -i)"
+test_expect_success 'rebase -p --root --onto ignores patch in onto' "$(run -p)"
+
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' e y &&
+	test_range e.. "x y"
+'
+}
+test_expect_success 'rebase without --root works on disjoint history' "$(run)"
+test_expect_failure 'rebase -m without --root works on disjoint history' "$(run -m)"
+test_expect_success 'rebase -i without --root works on disjoint history' "$(run -i)"
+test_expect_failure 'rebase -p without --root works on disjoint history' "$(run -p)"
+
+
+run () {
+echo '
+	reset &&
+	git rebase '"$@"' --root --onto p k &&
+	test_range p.. "f j k"
+'
+}
+test_expect_success 'rebase --root --onto with merge-base ignores --root' "$(run)"
+test_expect_failure 'rebase -m --root --onto with merge-base ignores --root' "$(run -m)"
+test_expect_success 'rebase -i --root --onto with merge-base ignores --root' "$(run -i)"
+test_expect_success 'rebase -p --root --onto with merge-base ignores --root' "$(run -p)"
+
+test_expect_success 'rebase -p re-creates merge from upstream' '
+	reset &&
+	git rebase -p k w &&
+	same_revision HEAD^ H &&
+	same_revision HEAD^2 k
+'
+
+test_expect_success 'rebase -p re-creates internal merge' '
+	reset &&
+	git rebase -p c w &&
+	test_revisions "f j n E H w" HEAD~4 HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
+'
+
+test_expect_success 'rebase -p rebuilds history around dropped commit matching upstream' '
+	reset &&
+	git rebase -p h w &&
+	test_revisions "j E n w" HEAD~2 HEAD^2 HEAD^ HEAD
+'
+
+test_expect_success 'rebase -p drops merge commit when one entire side is dropped' '
+	reset &&
+	git rebase -p p w &&
+	test_range p.. "f j n H"
+'
+
+test_expect_failure 'rebase -p --onto drops commit in <onto>' '
+	reset &&
+	git rebase -p --onto p f w &&
+	test_range p.. "j n H"
+'
+
+test_expect_success 'rebase -p with two paths to $from' '
+	reset &&
+	git rebase -p --onto c j w &&
+	test_revisions "c n E H w" HEAD~3 HEAD~2 HEAD^2 HEAD^ HEAD
+'
+
+test_done
-- 
1.7.11.1.104.ge7b44f1
