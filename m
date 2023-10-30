Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB98EAC0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HZjJiHLP"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F3C2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:31:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09E3F1F5C0;
	Mon, 30 Oct 2023 19:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=no/33ZZtYfR4Q3X3VgOzzaybtKgaONXa8eLaDS
	5RuZ4=; b=HZjJiHLP7nHG9UpLBiLyMx7c/+8UCpIPTk7mOOtlPokt1Iu01K1n2h
	gNZwsamUQ1nd/yK8qaQoCWEm+Bt3i/xQ7kQRFOpux3rjqfW9NZVytR1AjDiQpwUD
	stnAoQ8RHlumD2ZyvIi/n6invCI/rPmJRg3LGklbdFmQj7qRR/3bs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 00B901F5BF;
	Mon, 30 Oct 2023 19:31:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B5CE1F5BE;
	Mon, 30 Oct 2023 19:31:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  emilyshaffer@google.com,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Sheik
 <sahibzone@gmail.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] bugreport: reject positional arguments
In-Reply-To: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com> (Phillip Wood's
	message of "Mon, 30 Oct 2023 14:11:09 +0000")
References: <20231026005542.872301-1-nasamuffin@google.com>
	<20231026155459.2234929-1-nasamuffin@google.com>
	<CAPig+cTmYtWR=QN3LeN9yw3HmsKEmD2fUiRjKf=eJHhAZyT-yA@mail.gmail.com>
	<3e15f266-c790-4b71-84b6-1328339425c1@gmail.com>
	<xmqqv8apez0o.fsf@gitster.g> <xmqqpm0xeyp9.fsf@gitster.g>
	<xmqqcywwg9am.fsf@gitster.g>
	<881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
Date: Tue, 31 Oct 2023 08:31:28 +0900
Message-ID: <xmqqfs1radrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74385C5E-777C-11EE-AC17-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... it is determining that grep
> failed in the first place that I find annoying. I've also found the
> output from test_i18ngrep is helpful when debugging CI test failures.

Thanks, I agree with you that it is very useful for debugging to
have an explicit "I did not find what I expected to see".  On the
other hand, the other side is not as severe a problem, I think.  If
"grep" expects not to see an error message in the output but the
output has the error we do not want to see, we will see the message
in the "-v" output when we run test.

So, when we retire test_i18ngrep, what we will primarily miss is
this form of its invocation:

    test_i18ngrep ! <arguments>... <file>

We have a bit more than 100 of them in the t/ hierarchy.

I wonder if it is better to drop support for the positive side,
which allows us to lose the '!' and give it a name better than
"grep", e.g.,  with only the negative match support, what we used to
write:

	test_must_fail git rebase -i primary >output 2>&1 &&
	test_i18ngrep "would be overwritten by checkout:" output &&
	test_i18ngrep ! "BUG" output

would become something like:

	test_must_fail git rebase -i primary >output 2>&1 &&
	grep "would be overwritten by checkout:" output &&
	test_missing "BUG" output

But perhaps it is making it too limited for very little gain.  We
could add "test_grep" that does not do anything more than "grep",
to complement, i.e.,

	test_must_fail git rebase -i primary >output 2>&1 &&
	test_grep "would be overwritten by checkout:" output &&
	test_missing "BUG" output

But if we add "test_grep", those who have experience with writing
and reading our tests will expect "test_grep !" to behave like how
test_i18ngrep behaved, so we will have to support its negation
anyway, i.e. test_missing will either become unnecessary or become a
thin wrapper,

	test_missing () { test_grep ! "$@" }

merely for readability.

I haven't made up my mind on the positive side, but the negative
side (aka "retiring use of 'test_i18ngrep !' from everywhere and use
test_missing instead") would look like this:

 t/test-lib-functions.sh             | 18 ++++++++++++++++++
 t/t0041-usage.sh                    | 12 ++++++------
 t/t1060-object-corruption.sh        |  2 +-
 t/t1091-sparse-checkout-builtin.sh  | 14 +++++++-------
 t/t1430-bad-ref-name.sh             |  2 +-
 t/t1450-fsck.sh                     |  4 ++--
 t/t1506-rev-parse-diagnosis.sh      |  2 +-
 t/t2019-checkout-ambiguous-ref.sh   |  4 ++--
 t/t2020-checkout-detach.sh          |  4 ++--
 t/t2024-checkout-dwim.sh            |  4 ++--
 t/t2402-worktree-list.sh            |  2 +-
 t/t3404-rebase-interactive.sh       |  2 +-
 t/t3507-cherry-pick-conflict.sh     |  2 +-
 t/t3600-rm.sh                       |  2 +-
 t/t4001-diff-rename.sh              |  2 +-
 t/t4014-format-patch.sh             |  2 +-
 t/t4018-diff-funcname.sh            | 12 ++++++------
 t/t4153-am-resume-override-opts.sh  |  2 +-
 t/t5324-split-commit-graph.sh       |  2 +-
 t/t5505-remote.sh                   |  2 +-
 t/t5520-pull.sh                     |  2 +-
 t/t5523-push-upstream.sh            |  8 ++++----
 t/t5534-push-signed.sh              |  2 +-
 t/t5541-http-push-smart.sh          |  4 ++--
 t/t5574-fetch-output.sh             |  2 +-
 t/t5580-unc-paths.sh                |  2 +-
 t/t5606-clone-options.sh            |  2 +-
 t/t6001-rev-list-graft.sh           |  2 +-
 t/t6040-tracking-info.sh            |  4 ++--
 t/t6050-replace.sh                  |  2 +-
 t/t6423-merge-rename-directories.sh | 12 ++++++------
 t/t6433-merge-toplevel.sh           |  2 +-
 t/t6437-submodule-merge.sh          |  2 +-
 t/t6500-gc.sh                       |  2 +-
 t/t7400-submodule-basic.sh          | 16 ++++++++--------
 t/t7414-submodule-mistakes.sh       |  6 +++---
 t/t7416-submodule-dash-url.sh       |  2 +-
 t/t7450-bad-git-dotfiles.sh         |  2 +-
 t/t7502-commit-porcelain.sh         | 10 +++++-----
 t/t7508-status.sh                   |  8 ++++----
 t/t7518-ident-corner-cases.sh       |  2 +-
 t/t7519-status-fsmonitor.sh         |  4 ++--
 t/t7520-ignored-hook-warning.sh     |  6 +++---
 t/t7601-merge-pull-config.sh        | 38 ++++++++++++++++++-------------------
 t/t7810-grep.sh                     |  2 +-
 t/t7816-grep-binary-pattern.sh      |  2 +-
 t/t9800-git-p4-basic.sh             |  2 +-
 t/t9807-git-p4-submit.sh            |  2 +-
 48 files changed, 132 insertions(+), 114 deletions(-)

diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
index 2f8868caa1..6cf08f6f7b 100644
--- i/t/test-lib-functions.sh
+++ w/t/test-lib-functions.sh
@@ -1245,6 +1245,24 @@ test_i18ngrep () {
 	return 1
 }
 
+test_missing () {
+	eval "last_arg=\${$#}"
+
+	test -f "$last_arg" ||
+	BUG "test_missing requires a file to read as the last parameter"
+
+	! grep "$@" && return 0
+
+	echo >&4 "error: '! grep $@' did find a match in:"
+	if test -s "$last_arg"
+	then
+		cat >&4 "$last_arg"
+	else
+		echo >&4 "<file '$last_arg' is empty>"
+	fi
+	return 1
+}
+
 # Check if the file expected to be empty is indeed empty, and barfs
 # otherwise.
 
diff --git i/t/t0041-usage.sh w/t/t0041-usage.sh
index 9ea974b0c6..292a79a484 100755
--- i/t/t0041-usage.sh
+++ w/t/t0041-usage.sh
@@ -22,7 +22,7 @@ test_expect_success 'tag --contains <inexistent_tag>' '
 	test_must_fail git tag --contains "notag" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'tag --no-contains <existent_tag>' '
@@ -35,7 +35,7 @@ test_expect_success 'tag --no-contains <inexistent_tag>' '
 	test_must_fail git tag --no-contains "notag" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'tag usage error' '
@@ -54,7 +54,7 @@ test_expect_success 'branch --contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'branch --no-contains <existent_commit>' '
@@ -67,7 +67,7 @@ test_expect_success 'branch --no-contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'branch usage error' '
@@ -86,7 +86,7 @@ test_expect_success 'for-each-ref --contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'for-each-ref --no-contains <existent_object>' '
@@ -99,7 +99,7 @@ test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
 	test_line_count = 0 actual &&
 	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_missing "usage" actual.err
 '
 
 test_expect_success 'for-each-ref usage error' '
diff --git i/t/t1060-object-corruption.sh w/t/t1060-object-corruption.sh
index 35261afc9d..8429990570 100755
--- i/t/t1060-object-corruption.sh
+++ w/t/t1060-object-corruption.sh
@@ -125,7 +125,7 @@ test_expect_success 'fetch into corrupted repo with index-pack' '
 		cd bit-error-cp &&
 		test_must_fail git -c transfer.unpackLimit=1 \
 			fetch ../no-bit-error 2>stderr &&
-		test_i18ngrep ! -i collision stderr
+		test_missing -i collision stderr
 	)
 '
 
diff --git i/t/t1091-sparse-checkout-builtin.sh w/t/t1091-sparse-checkout-builtin.sh
index 9ceb17f911..a1ec29cb16 100755
--- i/t/t1091-sparse-checkout-builtin.sh
+++ w/t/t1091-sparse-checkout-builtin.sh
@@ -230,7 +230,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
 	git -C repo read-tree -mu HEAD 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err &&
+	test_missing "disabling cone patterns" err &&
 	git -C repo reset --hard &&
 	check_files repo a folder1 folder2
 '
@@ -401,8 +401,8 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 		git add file &&
 		git commit -m "test" &&
 		git sparse-checkout set nothing 2>err &&
-		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
-		test_i18ngrep ! ".git/index.lock" err &&
+		test_missing "Sparse checkout leaves no entry on working directory" err &&
+		test_missing ".git/index.lock" err &&
 		git sparse-checkout set --no-cone file
 	)
 '
@@ -418,7 +418,7 @@ test_expect_success '.gitignore should not warn about cone mode' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	echo "**/bin/*" >repo/.gitignore &&
 	git -C repo reset --hard 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err
+	test_missing "disabling cone patterns" err
 '
 
 test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status' '
@@ -495,7 +495,7 @@ test_expect_failure 'sparse-checkout reapply' '
 
 	git -C tweak checkout HEAD deep/deeper2/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_i18ngrep ! "warning.*The following paths are not up to date" err &&
+	test_missing "warning.*The following paths are not up to date" err &&
 	test_path_is_missing tweak/deep/deeper2/a &&
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
@@ -578,7 +578,7 @@ test_expect_success 'check-rules interaction with submodules' '
 	git -C super ls-tree --name-only -r HEAD >all-files &&
 	git -C super sparse-checkout check-rules >check-rules-matches <all-files &&
 
-	test_i18ngrep ! "modules/" check-rules-matches &&
+	test_missing "modules/" check-rules-matches &&
 	test_i18ngrep "folder1/" check-rules-matches
 '
 
@@ -947,7 +947,7 @@ test_expect_success 'check-rules cone mode' '
 	git -C repo sparse-checkout check-rules >check-rules-default <all-files &&
 
 	test_i18ngrep "deep/deeper1/deepest/a" check-rules-file &&
-	test_i18ngrep ! "deep/deeper2" check-rules-file &&
+	test_missing "deep/deeper2" check-rules-file &&
 
 	test_cmp check-rules-file ls-files &&
 	test_cmp check-rules-file check-rules-default
diff --git i/t/t1430-bad-ref-name.sh w/t/t1430-bad-ref-name.sh
index ff1c967d55..8953b65179 100755
--- i/t/t1430-bad-ref-name.sh
+++ w/t/t1430-bad-ref-name.sh
@@ -173,7 +173,7 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	! grep -e "badname" output &&
 	! grep -e "broken\.\.\.symref" output &&
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
-	test_i18ngrep ! "ignoring broken ref refs/heads/badname" error &&
+	test_missing "ignoring broken ref refs/heads/badname" error &&
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
 '
 
diff --git i/t/t1450-fsck.sh w/t/t1450-fsck.sh
index 10a539158c..e8222bc9de 100755
--- i/t/t1450-fsck.sh
+++ w/t/t1450-fsck.sh
@@ -343,7 +343,7 @@ test_expect_success 'unparseable tree object' '
 	test_must_fail git fsck 2>out &&
 	test_i18ngrep "error: empty filename in tree entry" out &&
 	test_i18ngrep "$tree_sha1" out &&
-	test_i18ngrep ! "fatal: empty filename in tree entry" out
+	test_missing "fatal: empty filename in tree entry" out
 '
 
 test_expect_success 'tree entry with type mismatch' '
@@ -361,7 +361,7 @@ test_expect_success 'tree entry with type mismatch' '
 	git update-ref refs/heads/type_mismatch $commit &&
 	test_must_fail git fsck >out 2>&1 &&
 	test_i18ngrep "is a blob, not a tree" out &&
-	test_i18ngrep ! "dangling blob" out
+	test_missing "dangling blob" out
 '
 
 test_expect_success 'tree entry with bogus mode' '
diff --git i/t/t1506-rev-parse-diagnosis.sh w/t/t1506-rev-parse-diagnosis.sh
index 18688cae17..abd3019504 100755
--- i/t/t1506-rev-parse-diagnosis.sh
+++ w/t/t1506-rev-parse-diagnosis.sh
@@ -171,7 +171,7 @@ test_expect_success 'relative path when cwd is outside worktree' '
 
 test_expect_success '<commit>:file correctly diagnosed after a pathname' '
 	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
-	test_i18ngrep ! "exists on disk" error &&
+	test_missing "exists on disk" error &&
 	test_i18ngrep "no such path in the working tree" error &&
 	cat >expect <<-\EOF &&
 	file.txt
diff --git i/t/t2019-checkout-ambiguous-ref.sh w/t/t2019-checkout-ambiguous-ref.sh
index 9540588664..e87d2a5f13 100755
--- i/t/t2019-checkout-ambiguous-ref.sh
+++ w/t/t2019-checkout-ambiguous-ref.sh
@@ -33,7 +33,7 @@ test_expect_success 'checkout chooses branch over tag' '
 
 test_expect_success 'checkout reports switch to branch' '
 	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	test_missing "^HEAD is now at" stderr
 '
 
 test_expect_success 'checkout vague ref succeeds' '
@@ -55,7 +55,7 @@ test_expect_success VAGUENESS_SUCCESS 'checkout chooses branch over tag' '
 
 test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch' '
 	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	test_missing "^HEAD is now at" stderr
 '
 
 test_done
diff --git i/t/t2020-checkout-detach.sh w/t/t2020-checkout-detach.sh
index 2eab6474f8..975d17c8a6 100755
--- i/t/t2020-checkout-detach.sh
+++ w/t/t2020-checkout-detach.sh
@@ -18,10 +18,10 @@ check_not_detached () {
 PREV_HEAD_DESC='Previous HEAD position was'
 check_orphan_warning() {
 	test_i18ngrep "you are leaving $2 behind" "$1" &&
-	test_i18ngrep ! "$PREV_HEAD_DESC" "$1"
+	test_missing "$PREV_HEAD_DESC" "$1"
 }
 check_no_orphan_warning() {
-	test_i18ngrep ! "you are leaving .* commit.*behind" "$1" &&
+	test_missing "you are leaving .* commit.*behind" "$1" &&
 	test_i18ngrep "$PREV_HEAD_DESC" "$1"
 }
 
diff --git i/t/t2024-checkout-dwim.sh w/t/t2024-checkout-dwim.sh
index 74049a9812..b66b2baae6 100755
--- i/t/t2024-checkout-dwim.sh
+++ w/t/t2024-checkout-dwim.sh
@@ -110,7 +110,7 @@ test_expect_success 'checkout of branch from multiple remotes fails with advice'
 		checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
-	test_i18ngrep ! "^hint: " stderr
+	test_missing "^hint: " stderr
 '
 
 test_expect_success PERL 'checkout -p with multiple remotes does not print advice' '
@@ -118,7 +118,7 @@ test_expect_success PERL 'checkout -p with multiple remotes does not print advic
 	test_might_fail git branch -D foo &&
 
 	git checkout -p foo 2>stderr &&
-	test_i18ngrep ! "^hint: " stderr &&
+	test_missing "^hint: " stderr &&
 	status_uno_is_clean
 '
 
diff --git i/t/t2402-worktree-list.sh w/t/t2402-worktree-list.sh
index 9ad9be0c20..ee00343ad1 100755
--- i/t/t2402-worktree-list.sh
+++ w/t/t2402-worktree-list.sh
@@ -156,7 +156,7 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
 	! grep "/unprunable  *[0-9a-f].* unprunable$" out &&
 	git worktree prune --verbose 2>out &&
 	test_i18ngrep "^Removing worktrees/prunable" out &&
-	test_i18ngrep ! "^Removing worktrees/unprunable" out
+	test_missing "^Removing worktrees/unprunable" out
 '
 
 test_expect_success '"list" --verbose and --porcelain mutually exclusive' '
diff --git i/t/t3404-rebase-interactive.sh w/t/t3404-rebase-interactive.sh
index 8ea2bf1302..77872cc56b 100755
--- i/t/t3404-rebase-interactive.sh
+++ w/t/t3404-rebase-interactive.sh
@@ -605,7 +605,7 @@ test_expect_success 'clean error after failed "exec"' '
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
 	test_i18ngrep "you have staged changes in your working tree" error &&
-	test_i18ngrep ! "could not open.*for reading" error
+	test_missing "could not open.*for reading" error
 '
 
 test_expect_success 'rebase a detached HEAD' '
diff --git i/t/t3507-cherry-pick-conflict.sh w/t/t3507-cherry-pick-conflict.sh
index f32799e046..e91616ece7 100755
--- i/t/t3507-cherry-pick-conflict.sh
+++ w/t/t3507-cherry-pick-conflict.sh
@@ -563,7 +563,7 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 	echo /unrelated >.git/info/sparse-checkout &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick -Xours picked>actual &&
-	test_i18ngrep ! "Changes not staged for commit:" actual
+	test_missing "Changes not staged for commit:" actual
 '
 
 test_expect_success 'cherry-pick --continue remembers --keep-redundant-commits' '
diff --git i/t/t3600-rm.sh w/t/t3600-rm.sh
index 0e8afe49ed..4de4d99464 100755
--- i/t/t3600-rm.sh
+++ w/t/t3600-rm.sh
@@ -276,7 +276,7 @@ test_expect_success 'Resolving by removal is not a warning-worthy event' '
 	blob=$(echo blob | git hash-object -w --stdin) &&
 	printf "100644 $blob %d\tblob\n" 1 2 3 | git update-index --index-info &&
 	git rm blob >msg 2>&1 &&
-	test_i18ngrep ! "needs merge" msg &&
+	test_missing "needs merge" msg &&
 	test_must_fail git ls-files -s --error-unmatch blob
 '
 
diff --git i/t/t4001-diff-rename.sh w/t/t4001-diff-rename.sh
index 3dc9047044..c0f6e1f242 100755
--- i/t/t4001-diff-rename.sh
+++ w/t/t4001-diff-rename.sh
@@ -145,7 +145,7 @@ test_expect_success 'test diff.renames=true for git status' '
 
 test_expect_success 'test diff.renames=false for git status' '
 	git -c diff.renames=false status >out &&
-	test_i18ngrep ! "renamed: .*path1 -> subdir/path1" out &&
+	test_missing "renamed: .*path1 -> subdir/path1" out &&
 	test_i18ngrep "new file: .*subdir/path1" out &&
 	test_i18ngrep "deleted: .*[^/]path1" out
 '
diff --git i/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 0a4ab36c3a..648992741a 100755
--- i/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -2404,7 +2404,7 @@ test_expect_success 'interdiff: cover-letter' '
 	EOF
 	git format-patch --cover-letter --interdiff=boop~2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
-	test_i18ngrep ! "^Interdiff:$" 0001-fleep.patch &&
+	test_missing "^Interdiff:$" 0001-fleep.patch &&
 	sed "1,/^@@ /d; /^-- $/q" 0000-cover-letter.patch >actual &&
 	test_cmp expect actual
 '
diff --git i/t/t4018-diff-funcname.sh w/t/t4018-diff-funcname.sh
index c8d555771d..35347e10bb 100755
--- i/t/t4018-diff-funcname.sh
+++ w/t/t4018-diff-funcname.sh
@@ -53,15 +53,15 @@ do
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_missing fatal msg &&
+		test_missing error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index --word-diff \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_missing fatal msg &&
+		test_missing error msg
 	'
 
 	test_expect_success "builtin $p pattern compiles on bare repo with --attr-source" '
@@ -79,8 +79,8 @@ do
 		git -C bare.git symbolic-ref HEAD refs/heads/master &&
 		test_expect_code 1 git -C bare.git --attr-source=branchA \
 			diff --exit-code HEAD:A.java HEAD:B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_missing fatal msg &&
+		test_missing error msg
 	'
 done
 
diff --git i/t/t4153-am-resume-override-opts.sh w/t/t4153-am-resume-override-opts.sh
index b7c3861407..664236914c 100755
--- i/t/t4153-am-resume-override-opts.sh
+++ w/t/t4153-am-resume-override-opts.sh
@@ -53,7 +53,7 @@ test_expect_success '--no-quiet overrides --quiet' '
 	# Applying side1 will be quiet.
 	test_must_fail git am --quiet side[123].eml >out &&
 	test_path_is_dir .git/rebase-apply &&
-	test_i18ngrep ! "^Applying: " out &&
+	test_missing "^Applying: " out &&
 	echo side1 >file &&
 	git add file &&
 
diff --git i/t/t5324-split-commit-graph.sh w/t/t5324-split-commit-graph.sh
index 97eb6d2e72..210039d9d5 100755
--- i/t/t5324-split-commit-graph.sh
+++ w/t/t5324-split-commit-graph.sh
@@ -422,7 +422,7 @@ test_expect_success 'add octopus merge' '
 	git commit-graph verify --progress 2>err &&
 	test_line_count = 1 err &&
 	grep "Verifying commits in commit graph: 100% (18/18)" err &&
-	test_i18ngrep ! warning err &&
+	test_missing warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
 '
 
diff --git i/t/t5505-remote.sh w/t/t5505-remote.sh
index 43b7bcd715..8e455d94f4 100755
--- i/t/t5505-remote.sh
+++ w/t/t5505-remote.sh
@@ -1458,7 +1458,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 			test_must_fail git -c advice.pushUnqualifiedRefName=false \
 				push origin $oid:dst 2>err &&
 			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep ! "hint: Did you mean" err ||
+			test_missing "hint: Did you mean" err ||
 			exit 1
 		done
 	)
diff --git i/t/t5520-pull.sh w/t/t5520-pull.sh
index 0b72112fb1..22ccf998f9 100755
--- i/t/t5520-pull.sh
+++ w/t/t5520-pull.sh
@@ -530,7 +530,7 @@ test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	echo new >expect &&
 	git show HEAD:file2 >actual &&
 	test_cmp expect actual &&
-	test_i18ngrep ! "verify-signatures" err
+	test_missing "verify-signatures" err
 '
 
 # add a feature branch, keep-merge, that is merged into main, so the
diff --git i/t/t5523-push-upstream.sh w/t/t5523-push-upstream.sh
index 1b8d609879..8e89b279e8 100755
--- i/t/t5523-push-upstream.sh
+++ w/t/t5523-push-upstream.sh
@@ -95,7 +95,7 @@ test_expect_success 'progress messages do not go to non-tty' '
 
 	# skip progress messages, since stderr is non-tty
 	git push -u upstream main >out 2>err &&
-	test_i18ngrep ! "Writing objects" err
+	test_missing "Writing objects" err
 '
 
 test_expect_success 'progress messages go to non-tty (forced)' '
@@ -110,15 +110,15 @@ test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u -q upstream main >out 2>err &&
-	test_i18ngrep ! "Writing objects" err
+	test_missing "Writing objects" err
 '
 
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u --no-progress upstream main >out 2>err &&
-	test_i18ngrep ! "Unpacking objects" err &&
-	test_i18ngrep ! "Writing objects" err
+	test_missing "Unpacking objects" err &&
+	test_missing "Writing objects" err
 '
 
 test_expect_success TTY 'quiet push' '
diff --git i/t/t5534-push-signed.sh w/t/t5534-push-signed.sh
index 7c0a148e73..37870326e1 100755
--- i/t/t5534-push-signed.sh
+++ w/t/t5534-push-signed.sh
@@ -378,7 +378,7 @@ test_expect_success GPG 'failed atomic push does not execute GPG' '
 			--signed --atomic --porcelain \
 			dst noop ff noff >out 2>err &&
 
-	test_i18ngrep ! "gpg failed to sign" err &&
+	test_missing "gpg failed to sign" err &&
 	cat >expect <<-EOF &&
 	To dst
 	=	refs/heads/noop:refs/heads/noop	[up to date]
diff --git i/t/t5541-http-push-smart.sh w/t/t5541-http-push-smart.sh
index d0211cd8be..a3824af91c 100755
--- i/t/t5541-http-push-smart.sh
+++ w/t/t5541-http-push-smart.sh
@@ -312,7 +312,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
 	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects" output
+	test_missing "^Writing objects" output
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
@@ -492,7 +492,7 @@ test_expect_success 'colorize errors/hints' '
 	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
 	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep ! "^hint: " decoded
+	test_missing "^hint: " decoded
 '
 
 test_expect_success 'report error server does not provide ref status' '
diff --git i/t/t5574-fetch-output.sh w/t/t5574-fetch-output.sh
index 90e6dcb9a7..95c105926e 100755
--- i/t/t5574-fetch-output.sh
+++ w/t/t5574-fetch-output.sh
@@ -286,7 +286,7 @@ test_expect_success '--no-show-forced-updates' '
 	(
 		cd no-forced-update-clone &&
 		git fetch --no-show-forced-updates origin 2>output &&
-		test_i18ngrep ! "(forced update)" output
+		test_missing "(forced update)" output
 	)
 '
 
diff --git i/t/t5580-unc-paths.sh w/t/t5580-unc-paths.sh
index cd7604fff9..07c24a463d 100755
--- i/t/t5580-unc-paths.sh
+++ w/t/t5580-unc-paths.sh
@@ -75,7 +75,7 @@ test_expect_success push '
 test_expect_success MINGW 'remote nick cannot contain backslashes' '
 	BACKSLASHED="$(winpwd | tr / \\\\)" &&
 	git ls-remote "$BACKSLASHED" 2>err &&
-	test_i18ngrep ! "unable to access" err
+	test_missing "unable to access" err
 '
 
 test_expect_success 'unc alternates' '
diff --git i/t/t5606-clone-options.sh w/t/t5606-clone-options.sh
index 5890319b97..9c480c7734 100755
--- i/t/t5606-clone-options.sh
+++ w/t/t5606-clone-options.sh
@@ -149,7 +149,7 @@ test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	test_missing "Checking connectivity" err
 
 '
 
diff --git i/t/t6001-rev-list-graft.sh w/t/t6001-rev-list-graft.sh
index 16635ecc33..38565e68ff 100755
--- i/t/t6001-rev-list-graft.sh
+++ w/t/t6001-rev-list-graft.sh
@@ -121,7 +121,7 @@ test_expect_success 'show advice that grafts are deprecated' '
 	test_i18ngrep "git replace" err &&
 	test_config advice.graftFileDeprecated false &&
 	git show HEAD 2>err &&
-	test_i18ngrep ! "git replace" err
+	test_missing "git replace" err
 '
 
 test_done
diff --git i/t/t6040-tracking-info.sh w/t/t6040-tracking-info.sh
index 7ddbd96e58..9034fd4b1e 100755
--- i/t/t6040-tracking-info.sh
+++ w/t/t6040-tracking-info.sh
@@ -253,7 +253,7 @@ test_expect_success 'fail to track lightweight tags' '
 	git checkout main &&
 	git tag light &&
 	test_must_fail git branch --track lighttrack light >actual &&
-	test_i18ngrep ! "set up to track" actual &&
+	test_missing "set up to track" actual &&
 	test_must_fail git checkout lighttrack
 '
 
@@ -261,7 +261,7 @@ test_expect_success 'fail to track annotated tags' '
 	git checkout main &&
 	git tag -m heavy heavy &&
 	test_must_fail git branch --track heavytrack heavy >actual &&
-	test_i18ngrep ! "set up to track" actual &&
+	test_missing "set up to track" actual &&
 	test_must_fail git checkout heavytrack
 '
 
diff --git i/t/t6050-replace.sh w/t/t6050-replace.sh
index c9925edf20..f71812ed14 100755
--- i/t/t6050-replace.sh
+++ w/t/t6050-replace.sh
@@ -492,7 +492,7 @@ test_expect_success '--convert-graft-file' '
 	git status 2>stderr &&
 	test_i18ngrep "hint:.*grafts is deprecated" stderr &&
 	git replace --convert-graft-file 2>stderr &&
-	test_i18ngrep ! "hint:.*grafts is deprecated" stderr &&
+	test_missing "hint:.*grafts is deprecated" stderr &&
 	test_path_is_missing .git/info/grafts &&
 
 	: verify that the history is now "grafted" &&
diff --git i/t/t6423-merge-rename-directories.sh w/t/t6423-merge-rename-directories.sh
index 944de75b80..bff2690b98 100755
--- i/t/t6423-merge-rename-directories.sh
+++ w/t/t6423-merge-rename-directories.sh
@@ -591,7 +591,7 @@ test_expect_success '2b: Directory split into two on one side, with equal number
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:x/d &&
 		test_cmp expect actual &&
-		test_i18ngrep ! "CONFLICT.*directory rename split" out
+		test_missing "CONFLICT.*directory rename split" out
 	)
 '
 
@@ -727,7 +727,7 @@ test_expect_success '3b: Avoid implicit rename if involved as source on current
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
-		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
+		test_missing CONFLICT.*rename/rename.*y/d out &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
@@ -3606,7 +3606,7 @@ test_expect_merge_algorithm failure success '10e: Does git complain about untrac
 		echo random >z/c &&
 
 		git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep ! "following untracked working tree files would be overwritten by merge" err &&
+		test_missing "following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
 		test_line_count = 3 out &&
@@ -5821,9 +5821,9 @@ test_expect_success '13e: directory rename detection in recursive case' '
 
 		git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&
 
-		test_i18ngrep ! CONFLICT out &&
-		test_i18ngrep ! BUG: err &&
-		test_i18ngrep ! core.dumped err &&
+		test_missing CONFLICT out &&
+		test_missing BUG: err &&
+		test_missing core.dumped err &&
 		test_must_be_empty err &&
 
 		git ls-files >paths &&
diff --git i/t/t6433-merge-toplevel.sh w/t/t6433-merge-toplevel.sh
index 2b42f095dc..393d127006 100755
--- i/t/t6433-merge-toplevel.sh
+++ w/t/t6433-merge-toplevel.sh
@@ -152,7 +152,7 @@ test_expect_success 'refuse two-project merge by default, quit before --autostas
 	echo change >>one.t &&
 	git diff >expect &&
 	test_must_fail git merge --autostash five 2>err &&
-	test_i18ngrep ! "stash" err &&
+	test_missing "stash" err &&
 	git diff >actual &&
 	test_cmp expect actual
 '
diff --git i/t/t6437-submodule-merge.sh w/t/t6437-submodule-merge.sh
index daa507862c..b675e15a11 100755
--- i/t/t6437-submodule-merge.sh
+++ w/t/t6437-submodule-merge.sh
@@ -480,7 +480,7 @@ test_expect_merge_algorithm failure success !FAIL_PREREQS 'directory/submodule c
 		# We do not want files within the submodule to prevent the
 		# merge from starting; we should not be writing to such paths
 		# anyway.
-		test_i18ngrep ! "refusing to lose untracked file at" err
+		test_missing "refusing to lose untracked file at" err
 	)
 '
 
diff --git i/t/t6500-gc.sh w/t/t6500-gc.sh
index 04acf22d93..5f48720d9a 100755
--- i/t/t6500-gc.sh
+++ w/t/t6500-gc.sh
@@ -155,7 +155,7 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_commit "$(test_oid obj4)" &&
 
 	git gc --auto 2>err &&
-	test_i18ngrep ! "^warning:" err &&
+	test_missing "^warning:" err &&
 	ls .git/objects/pack/pack-*.pack | sort >post_packs &&
 	comm -1 -3 existing_packs post_packs >new &&
 	comm -2 -3 existing_packs post_packs >del &&
diff --git i/t/t7400-submodule-basic.sh w/t/t7400-submodule-basic.sh
index d9fbabb2b9..23038b3321 100755
--- i/t/t7400-submodule-basic.sh
+++ w/t/t7400-submodule-basic.sh
@@ -196,7 +196,7 @@ test_expect_success 'redirected submodule add does not show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
 		2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	test_missing "Checking connectivity" err
 '
 
 test_expect_success 'redirected submodule add --progress does show progress' '
@@ -1160,7 +1160,7 @@ test_expect_success 'submodule deinit deinits a submodule when its work tree is
 	git submodule deinit init example2 >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-	test_i18ngrep ! "Cleared directory .init" actual &&
+	test_missing "Cleared directory .init" actual &&
 	test_i18ngrep "Cleared directory .example2" actual &&
 	rmdir init
 '
@@ -1210,19 +1210,19 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit init >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_missing "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_missing "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_missing "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_missing "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	git submodule deinit --all >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_missing "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_missing "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init example2
 '
diff --git i/t/t7414-submodule-mistakes.sh w/t/t7414-submodule-mistakes.sh
index 101afff30f..7c0bd0bc28 100755
--- i/t/t7414-submodule-mistakes.sh
+++ w/t/t7414-submodule-mistakes.sh
@@ -19,7 +19,7 @@ test_expect_success 'git-add on embedded repository warns' '
 test_expect_success '--no-warn-embedded-repo suppresses warning' '
 	test_when_finished "git rm --cached -f embed" &&
 	git add --no-warn-embedded-repo embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_missing warning stderr
 '
 
 test_expect_success 'no warning when updating entry' '
@@ -27,14 +27,14 @@ test_expect_success 'no warning when updating entry' '
 	git add embed &&
 	git -C embed commit --allow-empty -m two &&
 	git add embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_missing warning stderr
 '
 
 test_expect_success 'submodule add does not warn' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
 	git -c protocol.file.allow=always \
 		submodule add ./embed submodule 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_missing warning stderr
 '
 
 test_done
diff --git i/t/t7416-submodule-dash-url.sh w/t/t7416-submodule-dash-url.sh
index 7cf72b9a07..d8a08f4852 100755
--- i/t/t7416-submodule-dash-url.sh
+++ w/t/t7416-submodule-dash-url.sh
@@ -63,7 +63,7 @@ test_expect_success 'trailing backslash is handled correctly' '
 	mv .new .gitmodules &&
 	git commit -am "Add testmodule" &&
 	test_must_fail git clone --verbose --recurse-submodules . dolly 2>err &&
-	test_i18ngrep ! "unknown option" err
+	test_missing "unknown option" err
 '
 
 test_expect_success 'fsck rejects missing URL scheme' '
diff --git i/t/t7450-bad-git-dotfiles.sh w/t/t7450-bad-git-dotfiles.sh
index 0d0c3f2c68..59a4c8f8e8 100755
--- i/t/t7450-bad-git-dotfiles.sh
+++ w/t/t7450-bad-git-dotfiles.sh
@@ -253,7 +253,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 
 		git fsck 2>output &&
 		test_i18ngrep gitmodulesParse output &&
-		test_i18ngrep ! "bad config" output
+		test_missing "bad config" output
 	)
 '
 
diff --git i/t/t7502-commit-porcelain.sh w/t/t7502-commit-porcelain.sh
index b5bf7de7cd..21436fc957 100755
--- i/t/t7502-commit-porcelain.sh
+++ w/t/t7502-commit-porcelain.sh
@@ -860,7 +860,7 @@ try_commit () {
 	GIT_EDITOR=.git/FAKE_EDITOR git commit -a $* $use_template &&
 	case "$use_template" in
 	'')
-		test_i18ngrep ! "^## Custom template" .git/COMMIT_EDITMSG ;;
+		test_missing "^## Custom template" .git/COMMIT_EDITMSG ;;
 	*)
 		test_i18ngrep "^## Custom template" .git/COMMIT_EDITMSG ;;
 	esac
@@ -880,7 +880,7 @@ try_commit_status_combo () {
 
 	test_expect_success 'commit --no-status' '
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_missing "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit with commit.status = yes' '
@@ -892,7 +892,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit with commit.status = no' '
 		test_config commit.status no &&
 		try_commit "" &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_missing "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = yes' '
@@ -904,7 +904,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit --no-status with commit.status = yes' '
 		test_config commit.status yes &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_missing "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 	test_expect_success 'commit --status with commit.status = no' '
@@ -916,7 +916,7 @@ try_commit_status_combo () {
 	test_expect_success 'commit --no-status with commit.status = no' '
 		test_config commit.status no &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_missing "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
 }
diff --git i/t/t7508-status.sh w/t/t7508-status.sh
index 6c46648e11..c8c107825e 100755
--- i/t/t7508-status.sh
+++ w/t/t7508-status.sh
@@ -1547,7 +1547,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 	export GIT_EDITOR &&
 	git commit -uno &&
 	git status -s --ignore-submodules=dirty >output &&
-	test_i18ngrep ! "^M. sm" output
+	test_missing "^M. sm" output
 '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
@@ -1578,7 +1578,7 @@ EOF
 test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
-	test_i18ngrep ! "^M. sm" output &&
+	test_missing "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1625,7 +1625,7 @@ test_expect_success '"No commits yet" should not be noted in status output' '
 	git checkout --orphan empty-branch-2 &&
 	test_commit test-commit-1 &&
 	git status >output &&
-	test_i18ngrep ! "No commits yet" output
+	test_missing "No commits yet" output
 '
 
 test_expect_success '"Initial commit" should be noted in commit template' '
@@ -1642,7 +1642,7 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 	touch to_be_committed_2 &&
 	git add to_be_committed_2 &&
 	git commit --dry-run >output &&
-	test_i18ngrep ! "Initial commit" output
+	test_missing "Initial commit" output
 '
 
 test_expect_success '--no-optional-locks prevents index update' '
diff --git i/t/t7518-ident-corner-cases.sh w/t/t7518-ident-corner-cases.sh
index 9ab2ae2f3b..99543c9770 100755
--- i/t/t7518-ident-corner-cases.sh
+++ w/t/t7518-ident-corner-cases.sh
@@ -15,7 +15,7 @@ test_expect_success 'empty name and missing email' '
 		sane_unset GIT_AUTHOR_EMAIL &&
 		GIT_AUTHOR_NAME= &&
 		test_must_fail git commit --allow-empty -m foo 2>err &&
-		test_i18ngrep ! "(null)" err
+		test_missing "(null)" err
 	)
 '
 
diff --git i/t/t7519-status-fsmonitor.sh w/t/t7519-status-fsmonitor.sh
index 8348e3ae7d..a6e4f16da4 100755
--- i/t/t7519-status-fsmonitor.sh
+++ w/t/t7519-status-fsmonitor.sh
@@ -322,10 +322,10 @@ do
 			rm -f marker &&
 			git status >actual &&
 			test_path_is_file marker &&
-			test_i18ngrep ! "Changes not staged for commit:" actual &&
+			test_missing "Changes not staged for commit:" actual &&
 			if test $uc_val = true
 			then
-				test_i18ngrep ! "Untracked files:" actual
+				test_missing "Untracked files:" actual
 			fi &&
 			if test $uc_val = false
 			then
diff --git i/t/t7520-ignored-hook-warning.sh w/t/t7520-ignored-hook-warning.sh
index 184b258989..936528ff33 100755
--- i/t/t7520-ignored-hook-warning.sh
+++ w/t/t7520-ignored-hook-warning.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 
 test_expect_success 'no warning if hook is not ignored' '
 	git commit --allow-empty -m "more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_missing -e "hook was ignored" message
 '
 
 test_expect_success POSIXPERM 'warning if hook is ignored' '
@@ -26,14 +26,14 @@ test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to false' '
 	test_config advice.ignoredHook false &&
 	test_hook --disable pre-commit &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_missing -e "hook was ignored" message
 '
 
 test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
 	test_hook --remove pre-commit &&
 	test_unconfig advice.ignoredHook &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_missing -e "hook was ignored" message
 '
 
 test_done
diff --git i/t/t7601-merge-pull-config.sh w/t/t7601-merge-pull-config.sh
index e08767df66..0c49c752b0 100755
--- i/t/t7601-merge-pull-config.sh
+++ w/t/t7601-merge-pull-config.sh
@@ -30,58 +30,58 @@ test_expect_success 'setup' '
 test_expect_success 'pull.rebase not set, ff possible' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only' '
 	git reset --hard c0 &&
 	test_config pull.ff only &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c0 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
@@ -96,51 +96,51 @@ test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_missing "You have divergent branches" err
 '
 
 test_does_rebase () {
@@ -334,7 +334,7 @@ test_expect_success 'Multiple heads warns about inability to fast forward' '
 test_expect_success 'Multiple can never be fast forwarded' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "You have divergent branches" err &&
+	test_missing "You have divergent branches" err &&
 	# In addition to calling out "cannot fast-forward", we very much
 	# want the "multiple branches" piece to be called out to users.
 	test_i18ngrep "Cannot fast-forward to multiple branches" err
@@ -343,7 +343,7 @@ test_expect_success 'Multiple can never be fast forwarded' '
 test_expect_success 'Cannot rebase with multiple heads' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "You have divergent branches" err &&
+	test_missing "You have divergent branches" err &&
 	test_i18ngrep "Cannot rebase onto multiple branches." err
 '
 
diff --git i/t/t7810-grep.sh w/t/t7810-grep.sh
index 84838c0fe1..a9610e1b08 100755
--- i/t/t7810-grep.sh
+++ w/t/t7810-grep.sh
@@ -1426,7 +1426,7 @@ test_expect_success 'grep --no-index prefers paths to revs' '
 
 test_expect_success 'grep --no-index does not "diagnose" revs' '
 	test_must_fail git grep --no-index o :1:hello.c 2>err &&
-	test_i18ngrep ! -i "did you mean" err
+	test_missing -i "did you mean" err
 '
 
 cat >expected <<EOF
diff --git i/t/t7816-grep-binary-pattern.sh w/t/t7816-grep-binary-pattern.sh
index fdb2355649..a22c88c8b3 100755
--- i/t/t7816-grep-binary-pattern.sh
+++ w/t/t7816-grep-binary-pattern.sh
@@ -26,7 +26,7 @@ nul_match_internal () {
 			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail env LC_ALL=\"$lc_all\" git grep $extra_flags -f f $flags a 2>stderr &&
-			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr
+			test_missing 'This is only supported with -P under PCRE v2' stderr
 		"
 	elif test "$matches" = P
 	then
diff --git i/t/t9800-git-p4-basic.sh w/t/t9800-git-p4-basic.sh
index a4b3cb9492..b44aa84b08 100755
--- i/t/t9800-git-p4-basic.sh
+++ w/t/t9800-git-p4-basic.sh
@@ -290,7 +290,7 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 		export PATH &&
 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
 	) &&
-	test_i18ngrep ! Traceback errs
+	test_missing Traceback errs
 '
 
 # Hide a file from p4d, make sure we catch its complaint.  This won't fail in
diff --git i/t/t9807-git-p4-submit.sh w/t/t9807-git-p4-submit.sh
index 7d4109f29d..dd0badd7f9 100755
--- i/t/t9807-git-p4-submit.sh
+++ w/t/t9807-git-p4-submit.sh
@@ -463,7 +463,7 @@ test_expect_success 'submit --prepare-p4-only' '
 		git p4 submit --prepare-p4-only >out &&
 		test_i18ngrep "prepared for submission" out &&
 		test_i18ngrep "must be deleted" out &&
-		test_i18ngrep ! "everything below this line is just the diff" out
+		test_missing "everything below this line is just the diff" out
 	) &&
 	(
 		cd "$cli" &&
