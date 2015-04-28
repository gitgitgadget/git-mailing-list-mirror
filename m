From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Tue, 28 Apr 2015 18:55:20 -0400
Message-ID: <1430261720-9051-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com,
	Phil Hord <hordp@cisco.com>, Fabian Ruch <bafain@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 01:05:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnEYq-0001Oy-3z
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 01:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031192AbbD1XE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 19:04:59 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:55595 "EHLO
	alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031086AbbD1XE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 19:04:58 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2015 19:04:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4476; q=dns/txt; s=iport;
  t=1430262298; x=1431471898;
  h=from:to:cc:subject:date:message-id;
  bh=dLi6rRR2oWYUNYuxzLlmzqmQonGmkUntuSYFXPcsFEQ=;
  b=NkV9wdB+HK6DRJ7BBup1ep8r0xnt0kBWhNZ6zDcH1wGVFEq0F39gkSP9
   t1zY/8sBGvHnEDyB/KPTfmHMFo08MdJqOIo0C6YH42mjOZ/g6xQXExDqr
   dHU2NrcDM5qg0hnWWUTLTfBadxtWMcSqALgrUuLDnAgms7WAsmqhAX+Ms
   M=;
X-IronPort-AV: E=Sophos;i="5.11,666,1422921600"; 
   d="scan'208";a="145301731"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-8.cisco.com with ESMTP; 28 Apr 2015 22:55:24 +0000
Received: from hordp-lnx.cisco.com (dhcp-64-100-104-202.cisco.com [64.100.104.202])
	by alln-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id t3SMtNhN004369;
	Tue, 28 Apr 2015 22:55:23 GMT
X-Mailer: git-send-email 2.4.0.rc3.329.gd1f7d3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267948>

When rebase--interactive processes a task, it removes the item from
the todo list and appends it to another list of executed tasks. If a
pick (this includes squash and fixup) fails before the index has
recorded the changes, take the corresponding item and put it on the todo
list again. Otherwise, the changes introduced by the scheduled commit
would be lost.

That kind of decision is possible since the cherry-pick command
signals why it failed to apply the changes of the given commit. Either
the changes are recorded in the index using a conflict (return value 1)
and rebase does not continue until they are resolved or the changes
are not recorded in the index (return value neither 0 nor 1) and
rebase has to try again with the same task.

Add a test cases for regression testing to the "rebase-interactive"
test suite.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: Phil Hord <hordp@cisco.com>
---

Notes:
    Last year in ${gmane}/250126 Fabian Ruch helpfully provided a patch
    to fix a rebase bug I complained about. I have simplified it a bit
    and merged in the tests which had been in a separate commit.
    
    It has bitten me twice since the original discussion and has also
    been reported by others, though I haven't found those emails to
    add them to the CC list yet.
    
    CC: Michael Haggerty <mhagger@alum.mit.edu>

 git-rebase--interactive.sh    | 16 +++++++++++++++
 t/t3404-rebase-interactive.sh | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 08e5d86..bab0dcc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -132,6 +132,16 @@ mark_action_done () {
 	fi
 }
 
+# Put the last action marked done at the beginning of the todo list
+# again. If there has not been an action marked done yet, leave the list of
+# items on the todo list unchanged.
+reschedule_last_action () {
+	tail -n 1 "$done" | cat - "$todo" >"$todo".new
+	sed -e \$d <"$done" >"$done".new
+	mv -f "$todo".new "$todo"
+	mv -f "$done".new "$done"
+}
+
 append_todo_help () {
 	git stripspace --comment-lines >>"$todo" <<\EOF
 
@@ -252,6 +262,12 @@ pick_one () {
 	output eval git cherry-pick \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
 			"$strategy_args" $empty_args $ff "$@"
+
+	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
+	# previous task so this commit is not lost.
+	ret=$?
+	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
+	return $ret
 }
 
 pick_one_preserving_merges () {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index eed76cc..ac429a0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1055,4 +1055,51 @@ test_expect_success 'todo count' '
 	grep "^# Rebase ..* onto ..* ([0-9]" actual
 '
 
+test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
+	git checkout --force branch2 &&
+	git clean -f &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 2" git rebase -i A &&
+	test_cmp_rev HEAD F &&
+	test_path_is_missing file6 &&
+	>file6 &&
+	test_must_fail git rebase --continue &&
+	test_cmp_rev HEAD F &&
+	rm file6 &&
+	git rebase --continue &&
+	test_cmp_rev HEAD I
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (squash)' '
+	git checkout --force branch2 &&
+	git clean -f &&
+	git tag original-branch2 &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 squash 2" git rebase -i A &&
+	test_cmp_rev HEAD F &&
+	test_path_is_missing file6 &&
+	>file6 &&
+	test_must_fail git rebase --continue &&
+	test_cmp_rev HEAD F &&
+	rm file6 &&
+	git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = I &&
+	git reset --hard original-branch2
+'
+
+test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
+	git checkout --force branch2 &&
+	git clean -f &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 2" git rebase -i --no-ff A &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
+	test_path_is_missing file6 &&
+	>file6 &&
+	test_must_fail git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
+	rm file6 &&
+	git rebase --continue &&
+	test $(git cat-file commit HEAD | sed -ne \$p) = I
+'
+
 test_done
-- 
2.4.0.rc3.329.gd1f7d3b
