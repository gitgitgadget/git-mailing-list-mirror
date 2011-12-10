From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] revert: allow cherry-pick --continue to commit before
 resuming
Date: Sat, 10 Dec 2011 06:49:25 -0600
Message-ID: <20111210124925.GC22035@elie.hsd1.il.comcast.net>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 13:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMMx-0001RZ-FF
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab1LJMtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 07:49:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55412 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab1LJMta (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:49:30 -0500
Received: by iaeh11 with SMTP id h11so190446iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SCZSOURK0MYvJsJysWx1Ei5vRXcOliZX/P2H34FRsfQ=;
        b=cg6+6pqNTqPvXv+8FwRdLufqZL/gtF5WErMt0SBiE+7CNZp63/WgC7I/apMe1Y1rZV
         OEqWK01JRMZad/czpdNJJWzmBP6+9xWr5qan5jJ9bjVUjZBtpKtiouQ8G+L7F2b2PHUS
         NNymK5jwYIYQt7SJ7YnYj1FYgNK7v8YrW7MXA=
Received: by 10.50.51.234 with SMTP id n10mr7572769igo.10.1323521369502;
        Sat, 10 Dec 2011 04:49:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mb4sm24853782igc.1.2011.12.10.04.49.28
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:49:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186768>

When "git cherry-pick ..bar" encounters conflicts, permit the operator
to use cherry-pick --continue after resolving them as a shortcut for
"git commit && git cherry-pick --continue" to record the resolution
and carry on with the rest of the sequence.

This improves the analogy with "git rebase" (in olden days --continue
was the way to preserve authorship when a rebase encountered
conflicts) and fits well with a general UI goal of making "git cmd
--continue" save humans the trouble of deciding what to do next.

Example: after encountering a conflict from running "git cherry-pick
foo bar baz":

	CONFLICT (content): Merge conflict in main.c
	error: could not apply f78a8d98c... bar!
	hint: after resolving the conflicts, mark the corrected paths
	hint: with 'git add <paths>' or 'git rm <paths>'
	hint: and commit the result with 'git commit'

We edit main.c to resolve the conflict, mark it acceptable with "git
add main.c", and can run "cherry-pick --continue" to resume the
sequence.

	$ git cherry-pick --continue
	[editor opens to confirm commit message]
	[master 78c8a8c98] bar!
	 1 files changed, 1 insertions(+), 1 deletions(-)
	[master 87ca8798c] baz!
	 1 files changed, 1 insertions(+), 1 deletions(-)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |   23 ++++++-
 t/t3510-cherry-pick-sequence.sh |  139 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9f6c85c1..a43b4d85 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1038,18 +1038,35 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	return 0;
 }
 
+static int continue_single_pick(void)
+{
+	const char *argv[] = { "commit", NULL };
+
+	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
+	    !file_exists(git_path("REVERT_HEAD")))
+		return error(_("no cherry-pick or revert in progress"));
+	return run_command_v_opt(argv, RUN_GIT_CMD);
+}
+
 static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
 	if (!file_exists(git_path(SEQ_TODO_FILE)))
-		return error(_("No %s in progress"), action_name(opts));
+		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
 
 	/* Verify that the conflict has been resolved */
-	if (!index_differs_from("HEAD", 0))
-		todo_list = todo_list->next;
+	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
+	    file_exists(git_path("REVERT_HEAD"))) {
+		int ret = continue_single_pick();
+		if (ret)
+			return ret;
+	}
+	if (index_differs_from("HEAD", 0))
+		return error_dirty_index(opts);
+	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
 }
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 2c4c1c85..4d1883b7 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -2,6 +2,7 @@
 
 test_description='Test cherry-pick continuation features
 
+ +  conflicting: rewrites unrelated to conflicting
   + yetanotherpick: rewrites foo to e
   + anotherpick: rewrites foo to d
   + picked: rewrites foo to c
@@ -27,6 +28,7 @@ test_cmp_rev () {
 }
 
 test_expect_success setup '
+	git config advice.detachedhead false
 	echo unrelated >unrelated &&
 	git add unrelated &&
 	test_commit initial foo a &&
@@ -35,8 +37,8 @@ test_expect_success setup '
 	test_commit picked foo c &&
 	test_commit anotherpick foo d &&
 	test_commit yetanotherpick foo e &&
-	git config advice.detachedhead false
-
+	pristine_detach initial &&
+	test_commit conflicting unrelated
 '
 
 test_expect_success 'cherry-pick persists data on failure' '
@@ -243,7 +245,66 @@ test_expect_success '--continue complains when there are unresolved conflicts' '
 	test_must_fail git cherry-pick --continue
 '
 
-test_expect_success '--continue continues after conflicts are resolved' '
+test_expect_success '--continue of single cherry-pick' '
+	pristine_detach initial &&
+	echo c >expect &&
+	test_must_fail git cherry-pick picked &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+
+	test_cmp expect foo &&
+	test_cmp_rev initial HEAD^ &&
+	git diff --exit-code HEAD &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success '--continue of single revert' '
+	pristine_detach initial &&
+	echo resolved >expect &&
+	echo "Revert \"picked\"" >expect.msg &&
+	test_must_fail git revert picked &&
+	echo resolved >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+
+	git diff --exit-code HEAD &&
+	test_cmp expect foo &&
+	test_cmp_rev initial HEAD^ &&
+	git diff-tree -s --pretty=tformat:%s HEAD >msg &&
+	test_cmp expect.msg msg &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD &&
+	test_must_fail git rev-parse --verify REVERT_HEAD
+'
+
+test_expect_success '--continue after resolving conflicts' '
+	pristine_detach initial &&
+	echo d >expect &&
+	cat >expect.log <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	foo
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual.log &&
+	test_cmp expect foo &&
+	test_cmp expect.log actual.log
+'
+
+test_expect_success '--continue after resolving conflicts and committing' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
 	echo "c" >foo &&
@@ -270,6 +331,29 @@ test_expect_success '--continue continues after conflicts are resolved' '
 	test_cmp expect actual
 '
 
+test_expect_success '--continue asks for help after resolving patch to nil' '
+	pristine_detach conflicting &&
+	test_must_fail git cherry-pick initial..picked &&
+
+	test_cmp_rev unrelatedpick CHERRY_PICK_HEAD &&
+	git checkout HEAD -- unrelated &&
+	test_must_fail git cherry-pick --continue 2>msg &&
+	test_i18ngrep "The previous cherry-pick is now empty" msg
+'
+
+test_expect_failure 'follow advice and skip nil patch' '
+	pristine_detach conflicting &&
+	test_must_fail git cherry-pick initial..picked &&
+
+	git checkout HEAD -- unrelated &&
+	test_must_fail git cherry-pick --continue &&
+	git reset &&
+	git cherry-pick --continue &&
+
+	git rev-list initial..HEAD >commits &&
+	test_line_count = 3 commits
+'
+
 test_expect_success '--continue respects opts' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -x base..anotherpick &&
@@ -288,6 +372,29 @@ test_expect_success '--continue respects opts' '
 	grep "cherry picked from" anotherpick_msg
 '
 
+test_expect_success '--continue of single-pick respects -x' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -x picked &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD >msg &&
+	grep "cherry picked from" msg
+'
+
+test_expect_success '--continue respects -x in first commit in multi-pick' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -x picked anotherpick &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+	test_path_is_missing .git/sequencer &&
+	git cat-file commit HEAD^ >msg &&
+	picked=$(git rev-parse --verify picked) &&
+	grep "cherry picked from.*$picked" msg
+'
+
 test_expect_success '--signoff is not automatically propagated to resolved conflict' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick --signoff base..anotherpick &&
@@ -306,6 +413,32 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 	grep "Signed-off-by:" anotherpick_msg
 '
 
+test_expect_success '--signoff dropped for implicit commit of resolution, multi-pick case' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s picked anotherpick &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+
+	git diff --exit-code HEAD &&
+	test_cmp_rev initial HEAD^^ &&
+	git cat-file commit HEAD^ >msg &&
+	! grep Signed-off-by: msg
+'
+
+test_expect_success 'sign-off needs to be reaffirmed after conflict resolution, single-pick case' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s picked &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue &&
+
+	git diff --exit-code HEAD &&
+	test_cmp_rev initial HEAD^ &&
+	git cat-file commit HEAD >msg &&
+	! grep Signed-off-by: msg
+'
+
 test_expect_success 'malformed instruction sheet 1' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..anotherpick &&
-- 
1.7.8.rc3
