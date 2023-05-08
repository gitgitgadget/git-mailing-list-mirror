Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0606C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjEHTFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEHTFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:05:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71730D0
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:04:59 -0700 (PDT)
Received: (qmail 13923 invoked by uid 109); 8 May 2023 19:04:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 May 2023 19:04:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3643 invoked by uid 111); 8 May 2023 19:04:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 May 2023 15:04:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 May 2023 15:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] t: drop "verbose" helper function
Message-ID: <20230508190457.GC2366490@coredump.intra.peff.net>
References: <20230508185953.GA2108869@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508185953.GA2108869@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a small helper function called "verbose", with the idea that you
can write:

  verbose foo

to get a message to stderr when the "foo" command fails, even if it does
not produce any output itself. This goes back to 8ad1652418 (t5304: use
helper to report failure of "test foo = bar", 2014-10-10). It does work,
but overall it has not been a big success for two reasons:

  1. Test writers have to remember to put it there (and the resulting
     test code is longer as a result).

  2. It doesn't handle the opposite case (we expect "foo" to fail, but
     it succeeds), leading to inconsistencies in tests (which you can
     see in many hunks of this patch, e.g. ones involving "has_cr").

Most importantly, we added a136f6d8ff (test-lib.sh: support -x option
for shell-tracing, 2014-10-10) at the same time, and it does roughly the
same thing. The output is not quite as succinct as "verbose", and you
have to watch out for stray shell-traces ending up in stderr. But it
solves both of the problems above, and has clearly become the preferred
tool.

Let's consider the "verbose" function a failed experiment and remove the
last few callers (which are all many years old, and have been dwindling
as we remove them from scripts we touch for other reasons). It will be
one less thing for new test writers to see and wonder if they should be
using themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this should be all calls. Most tests will fail after removing
the function, of course, but it's possible one could be hiding in an
expect_failure or something. I didn't see any after grepping for
'[^-]verbose' in t/, which is not too long to look through.

 t/t0020-crlf.sh            | 38 +++++++++++++++++++-------------------
 t/t1301-shared-repo.sh     |  4 ++--
 t/t3427-rebase-subtree.sh  | 12 ++++++------
 t/t4022-diff-rewrite.sh    |  2 +-
 t/t4062-diff-pickaxe.sh    |  2 +-
 t/t5304-prune.sh           | 16 ++++++++--------
 t/t6006-rev-list-format.sh |  2 +-
 t/t6501-freshen-objects.sh |  2 +-
 t/t7001-mv.sh              |  2 +-
 t/t7300-clean.sh           |  4 ++--
 t/t9902-completion.sh      | 30 +++++++++++++++---------------
 t/test-lib-functions.sh    |  9 ---------
 12 files changed, 57 insertions(+), 66 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 35cc8c3b39..81946e87cc 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -125,7 +125,7 @@ test_expect_success 'update with autocrlf=input' '
 	munge_cr append dir/two &&
 	git update-index -- one dir/two &&
 	differs=$(git diff-index --cached HEAD) &&
-	verbose test -z "$differs"
+	test -z "$differs"
 
 '
 
@@ -138,7 +138,7 @@ test_expect_success 'update with autocrlf=true' '
 	munge_cr append dir/two &&
 	git update-index -- one dir/two &&
 	differs=$(git diff-index --cached HEAD) &&
-	verbose test -z "$differs"
+	test -z "$differs"
 
 '
 
@@ -153,7 +153,7 @@ test_expect_success 'checkout with autocrlf=true' '
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
 	differs=$(git diff-index --cached HEAD) &&
-	verbose test -z "$differs"
+	test -z "$differs"
 '
 
 test_expect_success 'checkout with autocrlf=input' '
@@ -167,7 +167,7 @@ test_expect_success 'checkout with autocrlf=input' '
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
 	differs=$(git diff-index --cached HEAD) &&
-	verbose test -z "$differs"
+	test -z "$differs"
 '
 
 test_expect_success 'apply patch (autocrlf=input)' '
@@ -177,7 +177,7 @@ test_expect_success 'apply patch (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
-	verbose test "$patched" = "$(git hash-object --stdin <one)"
+	test "$patched" = "$(git hash-object --stdin <one)"
 '
 
 test_expect_success 'apply patch --cached (autocrlf=input)' '
@@ -187,7 +187,7 @@ test_expect_success 'apply patch --cached (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
-	verbose test "$patched" = $(git rev-parse :one)
+	test "$patched" = $(git rev-parse :one)
 '
 
 test_expect_success 'apply patch --index (autocrlf=input)' '
@@ -197,8 +197,8 @@ test_expect_success 'apply patch --index (autocrlf=input)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
-	verbose test "$patched" = $(git rev-parse :one) &&
-	verbose test "$patched" = $(git hash-object --stdin <one)
+	test "$patched" = $(git rev-parse :one) &&
+	test "$patched" = $(git hash-object --stdin <one)
 '
 
 test_expect_success 'apply patch (autocrlf=true)' '
@@ -208,7 +208,7 @@ test_expect_success 'apply patch (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
-	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
+	test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
 '
 
 test_expect_success 'apply patch --cached (autocrlf=true)' '
@@ -218,7 +218,7 @@ test_expect_success 'apply patch --cached (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --cached patch.file &&
-	verbose test "$patched" = $(git rev-parse :one)
+	test "$patched" = $(git rev-parse :one)
 '
 
 test_expect_success 'apply patch --index (autocrlf=true)' '
@@ -228,8 +228,8 @@ test_expect_success 'apply patch --index (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply --index patch.file &&
-	verbose test "$patched" = $(git rev-parse :one) &&
-	verbose test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
+	test "$patched" = $(git rev-parse :one) &&
+	test "$patched" = "$(remove_cr <one | git hash-object --stdin)"
 '
 
 test_expect_success '.gitattributes says two is binary' '
@@ -240,7 +240,7 @@ test_expect_success '.gitattributes says two is binary' '
 	git read-tree --reset -u HEAD &&
 
 	! has_cr dir/two &&
-	verbose has_cr one &&
+	has_cr one &&
 	! has_cr three
 '
 
@@ -259,8 +259,8 @@ test_expect_success '.gitattributes says two and three are text' '
 	echo "t* crlf" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	verbose has_cr dir/two &&
-	verbose has_cr three
+	has_cr dir/two &&
+	has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (1)' '
@@ -273,7 +273,7 @@ test_expect_success 'in-tree .gitattributes (1)' '
 	git read-tree --reset -u HEAD &&
 
 	! has_cr one &&
-	verbose has_cr three
+	has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (2)' '
@@ -283,7 +283,7 @@ test_expect_success 'in-tree .gitattributes (2)' '
 	git checkout-index -f -q -u -a &&
 
 	! has_cr one &&
-	verbose has_cr three
+	has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (3)' '
@@ -294,7 +294,7 @@ test_expect_success 'in-tree .gitattributes (3)' '
 	git checkout-index -u one dir/two three &&
 
 	! has_cr one &&
-	verbose has_cr three
+	has_cr three
 '
 
 test_expect_success 'in-tree .gitattributes (4)' '
@@ -305,7 +305,7 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	git checkout-index -u .gitattributes &&
 
 	! has_cr one &&
-	verbose has_cr three
+	has_cr three
 '
 
 test_expect_success 'checkout with existing .gitattributes' '
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1b6437ec07..ae5cd3f5a0 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -89,7 +89,7 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(test_modebits .git/info/refs)" &&
-		verbose test "x$actual" = "x-$y"
+		test "x$actual" = "x-$y"
 
 	'
 
@@ -99,7 +99,7 @@ do
 		rm -f .git/info/refs &&
 		git update-server-info &&
 		actual="$(test_modebits .git/info/refs)" &&
-		verbose test "x$actual" = "x-$x"
+		test "x$actual" = "x-$x"
 
 	'
 
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 48b76f8232..1b3e97c875 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -74,9 +74,9 @@ test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-main main &&
 	: first pick results in no changes &&
 	git rebase --skip &&
-	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
-	verbose test "$(commit_message HEAD)" = "Empty commit"
+	test "$(commit_message HEAD~2)" = "topic_4" &&
+	test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
+	test "$(commit_message HEAD)" = "Empty commit"
 '
 
 test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit' '
@@ -85,9 +85,9 @@ test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit'
 	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-main --root &&
 	: first pick results in no changes &&
 	git rebase --skip &&
-	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
-	verbose test "$(commit_message HEAD)" = "Empty commit"
+	test "$(commit_message HEAD~2)" = "topic_4" &&
+	test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
+	test "$(commit_message HEAD)" = "Empty commit"
 '
 
 test_done
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 1c89050a97..6fed993ea0 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 test_expect_success 'detect rewrite' '
 
 	actual=$(git diff-files -B --summary test) &&
-	verbose expr "$actual" : " rewrite test ([0-9]*%)$"
+	expr "$actual" : " rewrite test ([0-9]*%)$"
 
 '
 
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 9aaa068ed9..a90b46b678 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -24,7 +24,7 @@ test_expect_success '-G matches' '
 
 test_expect_success '-S --pickaxe-regex' '
 	git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
-	verbose test 4096-zeroes.txt = "$(cat out)"
+	test 4096-zeroes.txt = "$(cat out)"
 '
 
 test_done
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 662ae9b152..f367327441 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -16,7 +16,7 @@ add_blob() {
 	before=$(git count-objects | sed "s/ .*//") &&
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
-	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-tool chmtime =+0 $BLOB_FILE
 }
@@ -51,23 +51,23 @@ test_expect_success 'prune stale packs' '
 test_expect_success 'prune --expire' '
 	add_blob &&
 	git prune --expire=1.hour.ago &&
-	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-tool chmtime =-86500 $BLOB_FILE &&
 	git prune --expire 1.day &&
-	verbose test $before = $(git count-objects | sed "s/ .*//") &&
+	test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc: implicit prune --expire' '
 	add_blob &&
 	test-tool chmtime =-$((2*$week-30)) $BLOB_FILE &&
 	git gc --no-cruft &&
-	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
+	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-tool chmtime =-$((2*$week+1)) $BLOB_FILE &&
 	git gc --no-cruft &&
-	verbose test $before = $(git count-objects | sed "s/ .*//") &&
+	test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 '
 
@@ -138,7 +138,7 @@ test_expect_success 'gc --no-prune' '
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
 	git gc --no-prune --no-cruft &&
-	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
+	test 1 = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
 '
 
@@ -192,10 +192,10 @@ test_expect_success 'gc: prune old objects after local clone' '
 	git clone --no-hardlinks . aclone &&
 	(
 		cd aclone &&
-		verbose test 1 = $(git count-objects | sed "s/ .*//") &&
+		test 1 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_file $BLOB_FILE &&
 		git gc --prune --no-cruft &&
-		verbose test 0 = $(git count-objects | sed "s/ .*//") &&
+		test 0 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_missing $BLOB_FILE
 	)
 '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 41d0ca00b1..573eb97a0f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -493,7 +493,7 @@ test_expect_success 'empty email' '
 	test_tick &&
 	C=$(GIT_AUTHOR_EMAIL= git commit-tree HEAD^{tree} </dev/null) &&
 	A=$(git show --pretty=format:%an,%ae,%ad%n -s $C) &&
-	verbose test "$A" = "$GIT_AUTHOR_NAME,,Thu Apr 7 15:14:13 2005 -0700"
+	test "$A" = "$GIT_AUTHOR_NAME,,Thu Apr 7 15:14:13 2005 -0700"
 '
 
 test_expect_success 'del LF before empty (1)' '
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index dbfa8a4d4c..4521508b83 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -152,7 +152,7 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 	EOF
 	commit=$(git hash-object -t commit -w broken-commit) &&
 	git gc --no-cruft -q 2>stderr &&
-	verbose git cat-file -e $commit &&
+	git cat-file -e $commit &&
 	test_must_be_empty stderr
 '
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 2e6a3c0a54..898a920532 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -192,7 +192,7 @@ test_expect_success "Michael Cassar's test case" '
 
 	T=$(git write-tree) &&
 	git ls-tree -r $T >out &&
-	verbose grep partA/outline.txt out
+	grep partA/outline.txt out
 '
 
 rm -fr papers partA path?
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index c975eb54d2..0ef7b78457 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -120,7 +120,7 @@ test_expect_success 'git clean with relative prefix' '
 		grep part3 |
 		sed -n -e "s|^Would remove ||p"
 	) &&
-	verbose test "$would_clean" = ../src/part3.c
+	test "$would_clean" = ../src/part3.c
 '
 
 test_expect_success 'git clean with absolute path' '
@@ -133,7 +133,7 @@ test_expect_success 'git clean with absolute path' '
 		grep part3 |
 		sed -n -e "s|^Would remove ||p"
 	) &&
-	verbose test "$would_clean" = ../src/part3.c
+	test "$would_clean" = ../src/part3.c
 '
 
 test_expect_success 'git clean with out of work tree relative path' '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d6c0478d98..8835e16e81 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -405,40 +405,40 @@ test_expect_success '__gitdir - remote as argument' '
 
 test_expect_success '__git_dequote - plain unquoted word' '
 	__git_dequote unquoted-word &&
-	verbose test unquoted-word = "$dequoted_word"
+	test unquoted-word = "$dequoted_word"
 '
 
 # input:    b\a\c\k\'\\\"s\l\a\s\h\es
 # expected: back'\"slashes
 test_expect_success '__git_dequote - backslash escaped' '
 	__git_dequote "b\a\c\k\\'\''\\\\\\\"s\l\a\s\h\es" &&
-	verbose test "back'\''\\\"slashes" = "$dequoted_word"
+	test "back'\''\\\"slashes" = "$dequoted_word"
 '
 
 # input:    sin'gle\' '"quo'ted
 # expected: single\ "quoted
 test_expect_success '__git_dequote - single quoted' '
 	__git_dequote "'"sin'gle\\\\' '\\\"quo'ted"'" &&
-	verbose test '\''single\ "quoted'\'' = "$dequoted_word"
+	test '\''single\ "quoted'\'' = "$dequoted_word"
 '
 
 # input:    dou"ble\\" "\"\quot"ed
 # expected: double\ "\quoted
 test_expect_success '__git_dequote - double quoted' '
 	__git_dequote '\''dou"ble\\" "\"\quot"ed'\'' &&
-	verbose test '\''double\ "\quoted'\'' = "$dequoted_word"
+	test '\''double\ "\quoted'\'' = "$dequoted_word"
 '
 
 # input: 'open single quote
 test_expect_success '__git_dequote - open single quote' '
 	__git_dequote "'\''open single quote" &&
-	verbose test "open single quote" = "$dequoted_word"
+	test "open single quote" = "$dequoted_word"
 '
 
 # input: "open double quote
 test_expect_success '__git_dequote - open double quote' '
 	__git_dequote "\"open double quote" &&
-	verbose test "open double quote" = "$dequoted_word"
+	test "open double quote" = "$dequoted_word"
 '
 
 
@@ -616,7 +616,7 @@ test_expect_success '__git_is_configured_remote' '
 	test_when_finished "git remote remove remote_2" &&
 	git remote add remote_2 git://remote_2 &&
 	(
-		verbose __git_is_configured_remote remote_2 &&
+		__git_is_configured_remote remote_2 &&
 		test_must_fail __git_is_configured_remote non-existent
 	)
 '
@@ -2596,30 +2596,30 @@ test_expect_success 'options with value' '
 test_expect_success 'sourcing the completion script clears cached commands' '
 	(
 		__git_compute_all_commands &&
-		verbose test -n "$__git_all_commands" &&
+		test -n "$__git_all_commands" &&
 		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-		verbose test -z "$__git_all_commands"
+		test -z "$__git_all_commands"
 	)
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
 	(
 		__git_compute_merge_strategies &&
-		verbose test -n "$__git_merge_strategies" &&
+		test -n "$__git_merge_strategies" &&
 		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-		verbose test -z "$__git_merge_strategies"
+		test -z "$__git_merge_strategies"
 	)
 '
 
 test_expect_success 'sourcing the completion script clears cached --options' '
 	(
 		__gitcomp_builtin checkout &&
-		verbose test -n "$__gitcomp_builtin_checkout" &&
+		test -n "$__gitcomp_builtin_checkout" &&
 		__gitcomp_builtin notes_edit &&
-		verbose test -n "$__gitcomp_builtin_notes_edit" &&
+		test -n "$__gitcomp_builtin_notes_edit" &&
 		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-		verbose test -z "$__gitcomp_builtin_checkout" &&
-		verbose test -z "$__gitcomp_builtin_notes_edit"
+		test -z "$__gitcomp_builtin_checkout" &&
+		test -z "$__gitcomp_builtin_notes_edit"
 	)
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999d46fafe..6e19ebc922 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1227,15 +1227,6 @@ test_i18ngrep () {
 	return 1
 }
 
-# Call any command "$@" but be more verbose about its
-# failure. This is handy for commands like "test" which do
-# not output anything when they fail.
-verbose () {
-	"$@" && return 0
-	echo >&4 "command failed: $(git rev-parse --sq-quote "$@")"
-	return 1
-}
-
 # Check if the file expected to be empty is indeed empty, and barfs
 # otherwise.
 
-- 
2.40.1.802.gdef2a8734a
