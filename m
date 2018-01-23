Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453F91F576
	for <e@80x24.org>; Tue, 23 Jan 2018 10:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeAWKY6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 05:24:58 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:35133 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeAWKY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 05:24:56 -0500
Received: from lindisfarne.localdomain ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id dvkzej0JImITadvl8e8jXz; Tue, 23 Jan 2018 10:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516703095;
        bh=qXBsIeG233tyeIFGXbSPMgUvCt4UrOUfwp+nGYPBOoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=kcryrn70TVXQ6StyFfdrcOIfiImmpufYySlxY1F2uznDzuDWycnor9oF/b3I7XYW8
         WYBfLaSMQ6bxQO0cB6dSCSry6czAY/FwK9GWGPbv/XOCyDLNgGsp3ZlA1czwIccLqF
         qp5MNdfrhgMzxwZTTOSGrbk4hFo+zUhBiWJ0cMg8=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=evINK-nbAAAA:8 a=BCjA09oAAAAA:8
 a=ehN-wHCze1MjmTvGf4MA:9 a=KbQ84HSqNuh3vMnj:21 a=S89-Gtj5zi-DDC5J:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=jYKBPJSq9nmHKCndOPe9:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/2] t7505: Add tests for cherry-pick and rebase -i/-p
Date:   Tue, 23 Jan 2018 10:24:19 +0000
Message-Id: <20180123102420.19911-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180123102420.19911-1-phillip.wood@talktalk.net>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180123102420.19911-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJ7qvo3mr+xsvkkHGq65G8ShVhqlJmkMEWWT6P9V+cQWrP+KsovcfrsukN1n7q7eJiAdn9L0yDAG77drdm7DblbqJtszuVlx2CWNvU6cOfZqQWh94UUn
 6Iq6FuUi4gzBdw8UmnYDBAoVvpO/ERgsaJhgs7YBNHQHmCg/7lM7SL2zBwNKucXDpcP9yCQrtK2W1R3vUm7CexmdSds6qpsW0y2tYB5d1kTi/9YyJ130G23V
 a1oqWAwUtcVY3DkKNJWsBoHLKy8bAvJTsWT4zDSv71AQ6ZYA2VRnGliO0NiMhIpg8KJXhfY2+uw8ver1MsKG8pIs27OGqHysZtZYxyHnpZ0CxwAJjDRcwMSj
 LHHvOQFB931EUi06A1HiXRK4ba1PflRz6XGQ5Y2Y0rrgIg5IgmWtXipnNGfSDawyxyxEs5qm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that cherry-pick and rebase call the 'prepare-commit-msg' hook
correctly. The expected values for the hook arguments are taken to
match the current master branch. I think there is scope for improving
the arguments passed so they make a bit more sense - for instance
cherry-pick currently passes different arguments depending on whether
the commit message is being edited. Also the arguments for rebase
could be improved. Commit 7c4188360ac ("rebase -i: proper
prepare-commit-msg hook argument when squashing", 2008-10-3) apparently
changed things so that when squashing rebase would pass 'squash' as
the argument to the hook but that has been lost.

I think that it would make more sense to pass 'message' for revert and
cherry-pick -x/-s (i.e. cases where there is a new message or the
current message in modified by the command), 'squash' when squashing
with a new message and 'commit HEAD/CHERRY_PICK_HEAD'
otherwise (picking and squashing without a new message).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    Changes since v1
      - use test_seq for portability (Thanks to Eric Sunshine)

 t/t7505-prepare-commit-msg-hook.sh | 127 +++++++++++++++++++++++++++++++++++--
 t/t7505/expected-rebase-i          |  17 +++++
 t/t7505/expected-rebase-p          |  18 ++++++
 3 files changed, 158 insertions(+), 4 deletions(-)
 create mode 100644 t/t7505/expected-rebase-i
 create mode 100644 t/t7505/expected-rebase-p

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index b13f72975ecce17887c4c8275c6935d78d4b09a0..a3dd3545030c2a29a1ca4502f26b412f92f0375a 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -4,6 +4,38 @@ test_description='prepare-commit-msg hook'
 
 . ./test-lib.sh
 
+test_expect_success 'set up commits for rebasing' '
+	test_commit root &&
+	test_commit a a a &&
+	test_commit b b b &&
+	git checkout -b rebase-me root &&
+	test_commit rebase-a a aa &&
+	test_commit rebase-b b bb &&
+	for i in $(test_seq 1 13)
+	do
+		test_commit rebase-$i c $i
+	done &&
+	git checkout master &&
+
+	cat >rebase-todo <<-EOF
+	pick $(git rev-parse rebase-a)
+	pick $(git rev-parse rebase-b)
+	fixup $(git rev-parse rebase-1)
+	fixup $(git rev-parse rebase-2)
+	pick $(git rev-parse rebase-3)
+	fixup $(git rev-parse rebase-4)
+	squash $(git rev-parse rebase-5)
+	reword $(git rev-parse rebase-6)
+	squash $(git rev-parse rebase-7)
+	fixup $(git rev-parse rebase-8)
+	fixup $(git rev-parse rebase-9)
+	edit $(git rev-parse rebase-10)
+	squash $(git rev-parse rebase-11)
+	squash $(git rev-parse rebase-12)
+	edit $(git rev-parse rebase-13)
+	EOF
+'
+
 test_expect_success 'with no hook' '
 
 	echo "foo" > file &&
@@ -31,17 +63,40 @@ mkdir -p "$HOOKDIR"
 echo "#!$SHELL_PATH" > "$HOOK"
 cat >> "$HOOK" <<'EOF'
 
+GIT_DIR=$(git rev-parse --git-dir)
+if test -d "$GIT_DIR/rebase-merge"
+then
+  rebasing=1
+else
+  rebasing=0
+fi
+
+get_last_cmd () {
+  tail -n1 "$GIT_DIR/rebase-merge/done" | {
+    read cmd id _
+    git log --pretty="[$cmd %s]" -n1 $id
+  }
+}
+
 if test "$2" = commit; then
-  source=$(git rev-parse "$3")
+  if test $rebasing = 1
+  then
+    source="$3"
+  else
+    source=$(git rev-parse "$3")
+  fi
 else
   source=${2-default}
 fi
-if test "$GIT_EDITOR" = :; then
-  sed -e "1s/.*/$source (no editor)/" "$1" > msg.tmp
+test "$GIT_EDITOR" = : && source="$source (no editor)"
+
+if test $rebasing = 1
+then
+  echo "$source $(get_last_cmd)" >"$1"
 else
   sed -e "1s/.*/$source/" "$1" > msg.tmp
+  mv msg.tmp "$1"
 fi
-mv msg.tmp "$1"
 exit 0
 EOF
 chmod +x "$HOOK"
@@ -156,6 +211,63 @@ test_expect_success 'with hook and editor (merge)' '
 	test "$(git log -1 --pretty=format:%s)" = "merge"
 '
 
+test_rebase () {
+	expect=$1 &&
+	mode=$2 &&
+	test_expect_$expect C_LOCALE_OUTPUT "with hook (rebase $mode)" '
+		test_when_finished "\
+			git rebase --abort
+			git checkout -f master
+			git branch -D tmp" &&
+		git checkout -b tmp rebase-me &&
+		GIT_SEQUENCE_EDITOR="cp rebase-todo" &&
+		GIT_EDITOR="\"$FAKE_EDITOR\"" &&
+		(
+			export GIT_SEQUENCE_EDITOR GIT_EDITOR &&
+			test_must_fail git rebase $mode b &&
+			echo x>a &&
+			git add a &&
+			test_must_fail git rebase --continue &&
+			echo x>b &&
+			git add b &&
+			git commit &&
+			git rebase --continue &&
+			echo y>a &&
+			git add a &&
+			git commit &&
+			git rebase --continue &&
+			echo y>b &&
+			git add b &&
+			git rebase --continue
+		) &&
+		if test $mode = -p # reword amended after pick
+		then
+			n=18
+		else
+			n=17
+		fi &&
+		git log --pretty=%s -g -n$n HEAD@{1} >actual &&
+		test_cmp "$TEST_DIRECTORY/t7505/expected-rebase$mode" actual
+	'
+}
+
+test_rebase failure -i
+test_rebase failure -p
+
+test_expect_failure 'with hook (cherry-pick)' '
+	test_when_finished "git checkout -f master" &&
+	git checkout -B other b &&
+	git cherry-pick rebase-1 &&
+	test "$(git log -1 --pretty=format:%s)" = "message (no editor)"
+'
+
+test_expect_success 'with hook and editor (cherry-pick)' '
+	test_when_finished "git checkout -f master" &&
+	git checkout -B other b &&
+	git cherry-pick -e rebase-1 &&
+	test "$(git log -1 --pretty=format:%s)" = merge
+'
+
 cat > "$HOOK" <<'EOF'
 #!/bin/sh
 exit 1
@@ -197,4 +309,11 @@ test_expect_success 'with failing hook (merge)' '
 
 '
 
+test_expect_failure C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
+	test_when_finished "git checkout -f master" &&
+	git checkout -B other b &&
+	test_must_fail git cherry-pick rebase-1 2>actual &&
+	test $(grep -c prepare-commit-msg actual) = 1
+'
+
 test_done
diff --git a/t/t7505/expected-rebase-i b/t/t7505/expected-rebase-i
new file mode 100644
index 0000000000000000000000000000000000000000..c514bdbb9422c0f699a3e1c1514b41e0796214a5
--- /dev/null
+++ b/t/t7505/expected-rebase-i
@@ -0,0 +1,17 @@
+message [edit rebase-13]
+message (no editor) [edit rebase-13]
+message [squash rebase-12]
+message (no editor) [squash rebase-11]
+default [edit rebase-10]
+message (no editor) [edit rebase-10]
+message [fixup rebase-9]
+message (no editor) [fixup rebase-8]
+message (no editor) [squash rebase-7]
+message [reword rebase-6]
+message [squash rebase-5]
+message (no editor) [fixup rebase-4]
+message (no editor) [pick rebase-3]
+message (no editor) [fixup rebase-2]
+message (no editor) [fixup rebase-1]
+merge [pick rebase-b]
+message [pick rebase-a]
diff --git a/t/t7505/expected-rebase-p b/t/t7505/expected-rebase-p
new file mode 100644
index 0000000000000000000000000000000000000000..93bada596e25f7148fdf0b955211cedfc0fbdba3
--- /dev/null
+++ b/t/t7505/expected-rebase-p
@@ -0,0 +1,18 @@
+message [edit rebase-13]
+message (no editor) [edit rebase-13]
+message [squash rebase-12]
+message (no editor) [squash rebase-11]
+default [edit rebase-10]
+message (no editor) [edit rebase-10]
+message [fixup rebase-9]
+message (no editor) [fixup rebase-8]
+message (no editor) [squash rebase-7]
+HEAD [reword rebase-6]
+message (no editor) [reword rebase-6]
+message [squash rebase-5]
+message (no editor) [fixup rebase-4]
+message (no editor) [pick rebase-3]
+message (no editor) [fixup rebase-2]
+message (no editor) [fixup rebase-1]
+merge [pick rebase-b]
+message [pick rebase-a]
-- 
2.15.1

