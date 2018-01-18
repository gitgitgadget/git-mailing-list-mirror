Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B91C1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeARPgD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:36:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:62652 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932640AbeARPgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:36:01 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEKZg-1eZw732g2a-00FX4o; Thu, 18
 Jan 2018 16:35:57 +0100
Date:   Thu, 18 Jan 2018 16:35:57 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 6/8] sequencer: handle autosquash and post-rewrite for merge
 commands
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
Message-ID: <219dbf95a8069190abe0986ca66b65a8ae3e670d.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JPm+n4k0dr75RPnycoW4PnqqqsO65slCiUa8gbP/Z/q7YrkZg4C
 UdUjd7MZUcMwtqnMJLgdFizSeuFJuLaO2BtMoTuCvHXv869VlnUrHLAnusYbYmwmdxja0eG
 cTRpqMMYoyvuBwK7+qI/Q/Exy5D/w6S++u3W8grVsFx/zP/Axb14WXFGJqN0aFnjXCzc6At
 pQrhmqPzCziH+jY5DRWtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a6BjaRvsaa8=:jUDeXyXUhzzMB2bPDk1l+S
 XFkipivykNZ/gWUgwHqFNsXMZ4WwiLyBLYwWU+owxMBEAHWsxMyit7PvXrKgzyFkW3uvygnU7
 obK6OO6KV7Pb3b0IyPG3BxtYO1CDwfS9CIIzjq2cu1+cLgZOdA6fy/fAfhJ+5WT5aj7OkR77o
 zrWrrOkKSdbl4iM5kTYxXGvJ9L0JNURvc3zG6TJeyCQa8v/RknOfG4bhJXjPAB9KKUh9ASGtj
 wNbdpSrIZkDgVR3Zio5+OKiNE1Tuif5DWpl7EYn/mL5R2l7dATzxc4IVB1ZGAM6W5ppkXkdtt
 /PP1KkejYtNdYDZBGqQztA5wUAbhVdNsth8jg+eLjgza0x9S0FkuQ1vzd3d/JBkgO43jwyw+G
 dGMVk5sSXIN0Dif3Sb0GLPqkcOg6oq/5wiTbJppzKpS40ZGR9kzX70tQlHTaMxCT6f77U4QQb
 SGCyi+mEOFnWQhMp1xux9ZIusRzA9xjjbbJOvB8Ofes2JkGiI7tJT8tnJ/QG5i7g59x8ivU4Y
 6BG3htPzjRzeLbkr7u3kIw36XjlVID4c7hrxJzLREyfW9FHBYzZ2tUU4bHZIsBPmkcNkZgpHU
 pX9QjLG6pjzsx2wE9DKp2IXG9rU3gr+bfvuWs89LNoHoCDg3fn8w2SEYdL7/LCT+WnAZJniRe
 BUMWbCWpwigNeRHZMrlViJNwV45ytnMXELurfeC0eS5hfLIxTBBvvQd0tZXNmA2Sacg3gUUpN
 V8xNtuF3w+p2LTg2A/sPEMuPEwBT8XdRX+RG5njti1ORXhPqd4/lGM10W2V6RCWwGMZ2JqtWe
 UZZWfTDval+k7PLSto8ndfRZ+Ku2Je5/Gn4eAQenbBljCPaVMI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, we implemented the basic functionality of the
`git rebase -i --recreate-merges` command, in particular the `merge`
command to create merge commits in the sequencer.

The interactive rebase is a lot more these days, though, than a simple
cherry-pick in a loop. For example, it calls the post-rewrite hook (if
any) after rebasing with a mapping of the old->new commits. And the
interactive rebase also supports the autosquash mode, where commits
whose oneline is of the form `fixup! <oneline>` or `squash! <oneline>`
are rearranged to amend commits whose oneline they match.

This patch implements the post-rewrite and autosquash handling for the
`merge` command we just introduced. The other commands that were added
recently (`label`, `reset` and `bud`) do not create new commits,
therefore post-rewrite & autosquash do not need to handle them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs.c                            |  3 ++-
 sequencer.c                       | 10 +++++++---
 t/t3430-rebase-recreate-merges.sh | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 20ba82b4343..e8b84c189ff 100644
--- a/refs.c
+++ b/refs.c
@@ -600,7 +600,8 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 static int is_per_worktree_ref(const char *refname)
 {
 	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
+		starts_with(refname, "refs/bisect/") ||
+		starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
diff --git a/sequencer.c b/sequencer.c
index 1bef16647b4..b63bfb9a141 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2413,10 +2413,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_reset(item->arg, item->arg_len);
 		else if (item->command == TODO_BUD)
 			res = do_reset("onto", 4);
-		else if (item->command == TODO_MERGE)
+		else if (item->command == TODO_MERGE) {
 			res = do_merge(item->commit,
 				       item->arg, item->arg_len, opts);
-		else if (!is_noop(item->command))
+			if (item->commit)
+				record_in_rewritten(&item->commit->object.oid,
+						    peek_command(todo_list, 1));
+		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
@@ -3556,7 +3559,8 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (item->command >= TODO_EXEC &&
+		    (item->command != TODO_MERGE || !item->commit)) {
 			subjects[i] = NULL;
 			continue;
 		}
diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
index 46ae52f88b3..76e615bd7c1 100755
--- a/t/t3430-rebase-recreate-merges.sh
+++ b/t/t3430-rebase-recreate-merges.sh
@@ -143,4 +143,43 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success 'refs/rewritten/* is worktree-local' '
+	git worktree add wt &&
+	cat >wt/script-from-scratch <<-\EOF &&
+	label xyz
+	exec GIT_DIR=../.git git rev-parse --verify refs/rewritten/xyz >a || :
+	exec git rev-parse --verify refs/rewritten/xyz >b
+	EOF
+
+	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
+	git -C wt rebase -i HEAD &&
+	test_must_be_empty wt/a &&
+	test_cmp_rev HEAD "$(cat wt/b)"
+'
+
+test_expect_success 'post-rewrite hook and fixups work for merges' '
+	git checkout -b post-rewrite &&
+	test_commit same1 &&
+	git reset --hard HEAD^ &&
+	test_commit same2 &&
+	git merge -m "to fix up" same1 &&
+	echo same old same old >same2.t &&
+	test_tick &&
+	git commit --fixup HEAD same2.t &&
+	fixup="$(git rev-parse HEAD)" &&
+
+	mkdir -p .git/hooks &&
+	test_when_finished "rm .git/hooks/post-rewrite" &&
+	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
+
+	test_tick &&
+	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
+	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
+		$fixup^^2 HEAD^2 \
+		$fixup^^ HEAD^ \
+		$fixup^ HEAD \
+		$fixup HEAD) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9


