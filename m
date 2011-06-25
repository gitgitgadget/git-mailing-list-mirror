From: David Caldwell <david@porkrind.org>
Subject: [PATCH] stash: Add --include-untracked option to stash and remove all untracked files
Date: Fri, 24 Jun 2011 17:56:06 -0700
Message-ID: <1308963366-1697-1-git-send-email-david@porkrind.org>
References: <vpqei2jj7jl.fsf@bauges.imag.fr>
Cc: David Caldwell <david@porkrind.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 02:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaHAa-0004OQ-R3
	for gcvg-git-2@lo.gmane.org; Sat, 25 Jun 2011 02:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1FYA4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 20:56:14 -0400
Received: from kill.porkrind.org ([68.68.97.104]:35989 "EHLO
	david.xen.prgmr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab1FYA4N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 20:56:13 -0400
Received: from porkrind.org (cpe-98-151-185-99.socal.res.rr.com [98.151.185.99])
	by david.xen.prgmr.com (Postfix) with ESMTPS id F10B22C0DF
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 17:56:11 -0700 (PDT)
Authentication-Results: david.xen.prgmr.com; dkim=pass
	(1536-bit key; insecure key) header.i=@porkrind.org
	header.b=ge7GlaYL; dkim-adsp=pass
Received-SPF: pass (porkrind.org: domain of david@porkrind.org designates 127.0.0.1 as permitted sender) receiver=porkrind.org; client-ip=127.0.0.1; helo=porkrind.org; envelope-from=david@porkrind.org; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from porkrind.org (localhost [127.0.0.1])
	by porkrind.org (8.14.4/8.14.4/Debian-2) with ESMTP id p5P0u89k001952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Jun 2011 17:56:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=porkrind.org;
	s=apoptygma; t=1308963369;
	bh=84jnzQWGoe+w26hEwTGDXeUI6+CIRB+QUUyQFOC2AiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
	b=ge7GlaYLW42bzRGG3JuGVl2e3KblA3Ge6Z0ykPL095xFRrBi7MhzovycaNYq4r9QD
	 4yPwprAF1BmjzzpfTQKnHS+bKnzH95ehnbIweRO9Ba0P7KmM0dLVnUEKy1mkgkX21Z
	 mwnYw0rELag6K7yKywHDU7xvk+FT3kcx9+mQwRUfqjh1P6m8eulS5FcYgVwny+PK3Z
	 p5OPo+J5ENHXprChoLJyDvTKTIxAOXnRFEplpjEyNfDFuRitYWTiakuUhm5
Received: (from david@localhost)
	by porkrind.org (8.14.4/8.14.4/Submit) id p5P0u83w001951;
	Fri, 24 Jun 2011 17:56:08 -0700
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <vpqei2jj7jl.fsf@bauges.imag.fr>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_DKIM_INVALID,
	UNPARSEABLE_RELAY autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on kill.porkrind.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176316>

The --include-untracked option acts like the normal "git stash save" but
also adds all untracked files in the working directory to the stash and then
calls "git clean --force --quiet" to restore the working directory to a
pristine state.

This is useful for projects that need to run release scripts. With this
option, the release scripts can be from the main working directory so one
does not have to maintain a "clean" directory in parallel just for
releasing. Basically the work-flow becomes:

   $ git tag release-1.0
   $ git stash --include-untracked
   $ make release
   $ git clean -f
   $ git stash pop

"git stash" alone is not enough in this case--it leaves untracked files
lying around that might mess up a release process that expects everything to
be very clean or might let a release succeed that should actually fail (due
to a new source file being created that hasn't been committed yet).

Signed-off-by: David Caldwell <david@porkrind.org>
---
On 6/24/11 10:31 PM +0200 Matthieu Moy wrote:

> David Caldwell <david@porkrind.org> writes:
> 
>> The --include-untracked option acts like the normal "git stash save" but
>> also adds all untracked files in the working directory to the stash and
>> then calls "git clean --force --quiet"
> 
> Great you did it, that's indeed something I missed with git stash.
> 
>> +    (test -z "$untracked" || test -z $(untracked_files))
> 
> Shouldn't there be double quotes around $(untracked_files)?

Yes there probably should be. It is corrected in this patch.

> I first thought of --all as a complement of --include-untracked, but in
> your proposal, a simple
> 
>   git stash --all
> 
> is accepted. If you go this way, maybe there should be more symetry in
> option naming. For example, --all could be --include-ignored.
> 
> Or you can consider that --all is short and sweet, and go for it ;-).

The problem with --include-ignored is that it doesn't read to me as if the
untracked files are included too. It should technically be
"--include-untracked-and-ignored". "-all" seems like a better alternative to
me.

-David

 Documentation/git-stash.txt        |   10 ++-
 git-stash.sh                       |   68 +++++++++++++++-
 t/t3905-stash-include-untracked.sh |  155 ++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 6 deletions(-)
 create mode 100755 t/t3905-stash-include-untracked.sh

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 15f051f..655aeb7 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+             [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -42,7 +43,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -54,6 +55,11 @@ save [-p|--patch] [--[no-]keep-index] [-q|--quiet] [<message>]::
 If the `--keep-index` option is used, all changes already added to the
 index are left intact.
 +
+If the `--include-untracked` option is used, all untracked files are also
+stashed and then cleaned up with `git clean`, leaving the working directory
+in a very clean state. If the `--all` option is used instead then the
+ignored files are stashed and cleaned in addition to the untracked files.
++
 With `--patch`, you can interactively select hunks from the diff
 between HEAD and the working tree to be stashed.  The stash entry is
 constructed such that its index state is the same as the index state
diff --git a/git-stash.sh b/git-stash.sh
index 0a94036..e6b1ffc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,8 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
+   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+                       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -33,7 +34,14 @@ fi
 
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
-	git diff-files --quiet --ignore-submodules
+	git diff-files --quiet --ignore-submodules &&
+	(test -z "$untracked" || test -z "$(untracked_files)")
+}
+
+untracked_files () {
+	excl_opt=--exclude-standard
+	test "$untracked" = "all" && excl_opt=
+	git ls-files -o -z $excl_opt
 }
 
 clear_stash () {
@@ -49,6 +57,7 @@ clear_stash () {
 
 create_stash () {
 	stash_msg="$1"
+	untracked="$2"
 
 	git update-index -q --refresh
 	if no_changes
@@ -78,6 +87,25 @@ create_stash () {
 		git commit-tree $i_tree -p $b_commit) ||
 		die "Cannot save the current index state"
 
+	if test -n "$untracked"
+	then
+		# Untracked files are stored by themselves in a parentless commit, for
+		# ease of unpacking later.
+		u_commit=$(
+			untracked_files | (
+				export GIT_INDEX_FILE="$TMPindex"
+				rm -f "$TMPindex" &&
+				git update-index -z --add --remove --stdin &&
+				u_tree=$(git write-tree) &&
+				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
+				rm -f "$TMPindex"
+		) ) || die "Cannot save the untracked files"
+
+		untracked_commit_option="-p $u_commit";
+	else
+		untracked_commit_option=
+	fi
+
 	if test -z "$patch_mode"
 	then
 
@@ -122,13 +150,14 @@ create_stash () {
 		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
 	fi
 	w_commit=$(printf '%s\n' "$stash_msg" |
-		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
+		git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
 		die "Cannot record working tree state"
 }
 
 save_stash () {
 	keep_index=
 	patch_mode=
+	untracked=
 	while test $# != 0
 	do
 		case "$1" in
@@ -146,6 +175,12 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		-u|--include-untracked)
+			untracked=untracked
+			;;
+		-a|--all)
+			untracked=all
+			;;
 		--)
 			shift
 			break
@@ -162,6 +197,11 @@ save_stash () {
 		shift
 	done
 
+	if test -n "$patch_mode" && test -n "$untracked"
+	then
+	    die "Can't use --patch and ---include-untracked or --all at the same time"
+	fi
+
 	stash_msg="$*"
 
 	git update-index -q --refresh
@@ -173,7 +213,7 @@ save_stash () {
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "Cannot initialize stash"
 
-	create_stash "$stash_msg"
+	create_stash "$stash_msg" $untracked
 
 	# Make sure the reflog for stash is kept.
 	: >>"$GIT_DIR/logs/$ref_stash"
@@ -185,6 +225,11 @@ save_stash () {
 	if test -z "$patch_mode"
 	then
 		git reset --hard ${GIT_QUIET:+-q}
+		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
+		if test -n "$untracked"
+		then
+		 	git clean --force --quiet $CLEAN_X_OPTION
+		fi
 
 		if test "$keep_index" = "t" && test -n $i_tree
 		then
@@ -234,9 +279,11 @@ show_stash () {
 #   w_commit is set to the commit containing the working tree
 #   b_commit is set to the base commit
 #   i_commit is set to the commit containing the index tree
+#   u_commit is set to the commit containing the untracked files tree
 #   w_tree is set to the working tree
 #   b_tree is set to the base tree
 #   i_tree is set to the index tree
+#   u_tree is set to the untracked files tree
 #
 #   GIT_QUIET is set to t if -q is specified
 #   INDEX_OPTION is set to --index if --index is specified.
@@ -261,9 +308,11 @@ parse_flags_and_rev()
 	w_commit=
 	b_commit=
 	i_commit=
+	u_commit=
 	w_tree=
 	b_tree=
 	i_tree=
+	u_tree=
 
 	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
 
@@ -311,6 +360,9 @@ parse_flags_and_rev()
 	IS_STASH_LIKE=t &&
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
+
+	u_commit=$(git rev-parse --quiet --verify $REV^3 2>/dev/null) &&
+	u_tree=$(git rev-parse $REV^3: 2>/dev/null)
 }
 
 is_stash_like()
@@ -353,6 +405,14 @@ apply_stash () {
 		git reset
 	fi
 
+	if test -n "$u_tree"
+	then
+		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
+		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
+		rm -f "$TMPindex" ||
+		die 'Could not restore untracked files from stash'
+	fi
+
 	eval "
 		GITHEAD_$w_tree='Stashed changes' &&
 		GITHEAD_$c_tree='Updated upstream' &&
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
new file mode 100755
index 0000000..4f2eedf
--- /dev/null
+++ b/t/t3905-stash-include-untracked.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 David Caldwell
+#
+
+test_description='Test git stash --include-untracked'
+
+. ./test-lib.sh
+
+test_expect_success 'stash save --include-untracked some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	echo 1 > file2 &&
+	git stash --include-untracked &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+'
+
+cat > expect <<EOF
+?? expect
+?? output
+EOF
+
+test_expect_success 'stash save --include-untracked cleaned the untracked files' '
+	git status --porcelain > output
+	test_cmp output expect
+'
+
+cat > expect.diff <<EOF
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000..d00491f
+--- /dev/null
++++ b/file2
+@@ -0,0 +1 @@
++1
+EOF
+cat > expect.lstree <<EOF
+file2
+EOF
+
+test_expect_success 'stash save --include-untracked stashed the untracked files' '
+	test "!" -f file2 &&
+	git diff HEAD..stash^3 -- file2 > output &&
+	test_cmp output expect.diff &&
+	git ls-tree --name-only stash^3: > output &&
+	test_cmp output expect.lstree
+'
+test_expect_success 'stash save --patch --include-untracked fails' '
+	test_must_fail git stash --patch --include-untracked
+'
+
+test_expect_success 'stash save --patch --all fails' '
+	test_must_fail git stash --patch --all
+'
+
+git clean --force --quiet
+
+cat > expect <<EOF
+ M file
+?? expect
+?? file2
+?? output
+EOF
+
+test_expect_success 'stash pop after save --include-untracked leaves files untracked again' '
+	git stash pop &&
+	git status --porcelain > output
+	test_cmp output expect
+'
+
+git clean --force --quiet
+
+test_expect_success 'stash save -u dirty index' '
+	echo 4 > file3 &&
+	git add file3 &&
+	test_tick &&
+	git stash -u
+'
+
+cat > expect <<EOF
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..b8626c4
+--- /dev/null
++++ b/file3
+@@ -0,0 +1 @@
++4
+EOF
+
+test_expect_success 'stash save --include-untracked dirty index got stashed' '
+	git stash pop --index &&
+	git diff --cached > output &&
+	test_cmp output expect
+'
+
+git reset > /dev/null
+
+test_expect_success 'stash save --include-untracked -q is quiet' '
+	echo 1 > file5 &&
+	git stash save --include-untracked --quiet > output.out 2>&1 &&
+	test ! -s output.out
+'
+
+test_expect_success 'stash save --include-untracked removed files' '
+	rm -f file &&
+	git stash save --include-untracked &&
+	echo 1 > expect &&
+	test_cmp file expect
+'
+
+rm -f expect
+
+test_expect_success 'stash save --include-untracked removed files got stashed' '
+	git stash pop &&
+	test ! -f file
+'
+
+cat > .gitignore <<EOF
+.gitignore
+ignored
+EOF
+
+test_expect_success 'stash save --include-untracked respects .gitignore' '
+	echo ignored > ignored &&
+	git stash -u &&
+	test -s ignored &&
+	test -s .gitignore
+'
+
+test_expect_success 'stash save -u can stash with only untracked files different' '
+	echo 4 > file4 &&
+	git stash -u
+	test "!" -f file4
+'
+
+test_expect_success 'stash save --all does not respect .gitignore' '
+	git stash -a &&
+	test "!" -f ignored &&
+	test "!" -f .gitignore
+'
+
+test_expect_success 'stash save --all is stash poppable' '
+	git stash pop &&
+	test -s ignored &&
+	test -s .gitignore
+'
+
+test_done
-- 
1.7.5.4
